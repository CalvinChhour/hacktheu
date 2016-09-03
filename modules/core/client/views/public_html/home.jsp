<%@ page language="java" import="cs5530.*,java.util.*, java.sql.*, java.io.*" %>
<!DOCTYPE html>
<html lang="en">

<%

UTrackMain main = new UTrackMain();
Connector con = new Connector();
User user = new User();


String choice;
String chosenName;
String username=null;
String password=null;
String fullname;
String address;
String pnumber;
String point;
String cost;
String partySize;
String date;
String website;
String year;
String hours;
String keywords;
String categories;
String price;
String score;
String thoughts;
String reviewID;
String sql;
String category = null;
String user1 = null;
String user2 = null;

ResultSet rs;
ResultSetMetaData rsmd;
int numCols;
int count;

String select;
String from;
String where;
String groupBy;
String orderBy;

String value1;
String value2;

Stack<String> visits= new Stack<String>();
Stack<String> visitNames = new Stack<String>();

Boolean loggedIn = false;
Boolean visiting = false;
Boolean admin = false;
Boolean adminAccess = false;
Boolean validSearch = false;
Boolean categorized = false;

HashSet<String> admins = new HashSet<String>();
admins.add("WildTurtle");
admins.add("wildturtle");
admins.add("WILDTURTLE");
admins.add("Foodie");
admins.add("foodie");
admins.add("FOODIE");

username = request.getParameter("usernameAttribute");
password = request.getParameter("passwordAttribute");

if (!visits.isEmpty() && !visitNames.isEmpty())
{
    session.setAttribute("visitsAtt", visits);
    session.setAttribute("visitNamesAtt", visitNames);
}
else
{
    visits = (Stack<String>) session.getAttribute("visitsAtt");
    visitNames = (Stack<String>) session.getAttribute("visitNames");
}

if (username != null && password != null)
{
    session.setAttribute("usernameAtt", username);
    session.setAttribute("passwordAtt", password);
}
else
{
    username = (String) session.getAttribute("usernameAtt");
    password = (String) session.getAttribute("passwordAtt");
}

loggedIn = user.login(username, password, con.stmt);

if (loggedIn)
{

    if(admins.contains(username))
    {
        admin = true;
    }

%>



<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>UTrack</title>

    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="css/agency2.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700' rel='stylesheet' type='text/css'>

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

    <script LANGUAGE="javascript">
    function check_all_fields(form_obj){
        alert(form_obj.searchAttribute.value+"='"+form_obj.attributeValue.value+"'");
        if( form_obj.attributeValue.value == ""){
            alert("Search field should be nonempty");
            return false;
        }
        return true;
    }

    </script> 

</head>

<body id="page-top" class="index">

    <!-- Navigation -->
    <nav class="navbar navbar-default navbar-fixed-top">
        <div class="container">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header page-scroll">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand page-scroll" href="#page-top">UTrack</a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav navbar-right">
                    <li class="hidden">
                        <a href="#page-top"></a>
                    </li>
                    <li>
                        <a class="page-scroll" href="#search">Search</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="#feedbacks">Feedbacks</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="#visits">Visits</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="#ratings">User Ratings</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="#stats">Statistics</a>
                    </li>
                    <%

                    if (admin)
                    {
                    %>

                    <li>
                        <a class="page-scroll" href="#admin">Admin</a>
                    </li>

                    <%
                    }
                    %>



                    <li>
                        <a class="page-scroll" href="http://georgia.eng.utah.edu:8080/~cs5530u96/index.jsp">Logout</a>
                    </li>
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container-fluid -->
    </nav>

    <!-- Header -->
    <header>
        <div class="container">
            <div class="intro-text">
                <div class="intro-lead-in">Welcome <%=username%>!</div>
                <a href="#search" class="page-scroll btn btn-xl">Search</a>
            </div>
        </div>
    </header>

    <!-- Search Section -->
    <section id="search">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <h2 class="section-heading">Search</h2>
                    <h3 class="section-subheading text-muted">Please enter your search criteria below.</h3>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <form name="sentMessage" id="contactForm" method=post onsubmit="return check_all_fields(this)" action="home.jsp#search" novalidate>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <input type="text" name="address" class="form-control" placeholder="City or State (No Abbreviations)" id="address">
                                    <p class="help-block text-danger"></p>
                                </div>
                                <div class="form-group">
                                    <input type="text" name="keywords" class="form-control" placeholder="Keywords? (keyword1, keyword2...)" id="keywords">
                                    <p class="help-block text-danger"></p>
                                </div>
                                <div class="form-group">
                                    <input type="text" name="categories" class="form-control" placeholder="Categories? (category1, category2...)" id="categories">
                                    <p class="help-block text-danger"></p>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <input type="text" name="value1" class="form-control" placeholder="What is your minimum price? (Integer)" id="value1">
                                    <p class="help-block text-danger"></p>
                                </div>
                                <div class="form-group">
                                    <input type="text" name="value2" class="form-control" placeholder="What is your maximum price? (Integer)" id="value2">
                                    <p class="help-block text-danger"></p>
                                </div>
                                <div class="form-group">
                                   <select name="choice" required data-validation-required-message="Please select a choice.">
                                        <option value="1">Price</option>
                                        <option value="2">Score</option>
                                        <option value="3">Trusted Scores</option>
                                    <p class="help-block text-danger"></p>
                                    </select>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                            <div class="col-lg-12 text-center">
                                <div id="success"></div>
                                <button type="submit" class="btn btn-xl">Enter</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

<%

                                int d = 0;

                                address = request.getParameter("address");
                                keywords = request.getParameter("keywords");
                                categories = request.getParameter("categories");
                                value1 = request.getParameter("value1");
                                value2 = request.getParameter("value2");
                                choice = request.getParameter("choice");

                                if (address != null || keywords != null || categories != null || value1 != null || value2 != null)
                                {
                                    validSearch = true;
                                }

                                try{
                                     d = Integer.parseInt(choice);
                                    if (d<1 || d>3)
                                    {
                                        d=1;
                                    }
                                }catch (Exception e)
                                {
                                     validSearch = false;
                                }


                                 
                                 if (validSearch)
                                 {
                                     select = "select name, price ";
                                     from = "FROM POI, Trust, Review ";
                                     where = "WHERE Review.ID=POI.ID ";
                                     groupBy = "Group By ";
                                     
                                     String str = categories;
                                     String categoryList[] = str.split(",");
                                     
                                     String str2 = keywords;
                                     String keywordList[] = str2.split(",");
                                     
                                     if (address.length() != 0)
                                     {
                                         where += "AND Address Like '%" + address + "%' ";
                                     }
                                     if (keywords.length() != 0)
                                     {
                                         for (int i= 0; i < keywordList.length; i++)
                                         {
                                             where += "AND Keywords Like '%" + keywordList[i] + "%' ";
                                         }
                                     }
                                     if (categories.length() != 0)
                                     {
                                         for (int i= 0; i < categoryList.length; i++)
                                         {
                                             where += "AND Categories Like '%" + categoryList[i] + "%' ";
                                         }
                                     }
                                     if (value1.length() != 0)
                                     {
                                         where += "AND Price>=" + value1 + " ";
                                     }
                                     if (value2.length() != 0)
                                     {
                                         where += "AND Price<=" + value2 + " ";
                                     }
                                     
                                     if (d==1) //Price
                                     {
                                         groupBy = "Group By Price;";
                                     }
                                     else if (d==2) //Score
                                     {
                                         select += ", score ";
                                         groupBy = "Group By Score;";
                                     }
                                     else //Trusted Scores
                                     {
                                         select += ", score, Trust.Trusted ";
                                         where += "AND Review.Login=Trust.Login2 ";
                                         groupBy = "Group By Score, Trust.Trusted HAVING Trust.Trusted='trusted';";
                                     }
                                     
                                     sql = select+from+where+groupBy;

                                     rs=con.stmt.executeQuery(sql);
                                     rsmd = rs.getMetaData();
                                     numCols = rsmd.getColumnCount();
                                     while (rs.next())
                                     {
                                         for (int i=1; i<=numCols;i++)
                                             out.print("<h3 align=\"center\">" + rs.getString(i)+"  </h3>");
                                         out.println("<center>---------------</center>");
                                     }
                                     out.println(" ");
                                     rs.close();
                                 }

%>

        </div>
    </section>

    <!-- Feedback Section -->
    <section id="feedbacks" class="bg-light-gray">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <h2 class="section-heading">Feedbacks</h2>
                    <h3 class="section-subheading text-muted">The top 5 most useful reviews are displayed below.</h3>
                </div>
            </div>

<%


                                 select = "select Thoughts, DateTime, Score, ID, Review.Login, Usefulness ";
                                 from = "FROM Review, Feedback ";
                                 where = "WHERE Review.RID=Feedback.RID ";
                                 groupBy = "Order By Usefulness DESC;";
                                 
                                 
                                 sql = select+from+where+groupBy;
                                 
                                 rs=con.stmt.executeQuery(sql);
                                 rsmd = rs.getMetaData();
                                 numCols = rsmd.getColumnCount();
                                 count = 0;
                                 while (rs.next())
                                 {
                                     for (int i=1; i<=numCols;i++)
                                         out.print("<h3 align=\"center\">" + rs.getString(i)+"  </h3>");
                                     out.println("<center>----------------------</center>");
                                     count++;
                                     if (count == 5)
                                     {
                                         break;
                                     }
                                 }
                                 out.println("  ");
                                 rs.close();

%>

        </div>
    </section>

    <!-- Visits Section -->
    <section id="visits">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <h2 class="section-heading">Visits</h2>
                    <h3 class="section-subheading text-muted">These are your visits.</h3>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4 col-sm-6 portfolio-item">
                    <a href="#portfolioModal1" class="portfolio-link" data-toggle="modal">
                        <div class="portfolio-hover">
                            <div class="portfolio-hover-content">
                                <i class="fa fa-plus fa-3x"></i>
                            </div>
                        </div>
                        <img src="img/portfolio/roundicons.png" class="img-responsive" alt="">
                    </a>
                    <div class="portfolio-caption">
                        <h4>Existing POIs</h4>
                        <p class="text-muted">Check Here for Existing POIs</p>
                    </div>
                </div>
                <div class="col-md-4 col-sm-6 portfolio-item">
                    <a href="#portfolioModal2" class="portfolio-link" data-toggle="modal">
                        <div class="portfolio-hover">
                            <div class="portfolio-hover-content">
                                <i class="fa fa-plus fa-3x"></i>
                            </div>
                        </div>
                        <img src="img/portfolio/startup-framework.png" class="img-responsive" alt="">
                    </a>
                    <div class="portfolio-caption">
                        <h4>Provide Feedback</h4>
                        <p class="text-muted">Review a Point of Interest</p>
                    </div>
                </div>
                <div class="col-md-4 col-sm-6 portfolio-item">
                    <a href="#portfolioModal3" class="portfolio-link" data-toggle="modal">
                        <div class="portfolio-hover">
                            <div class="portfolio-hover-content">
                                <i class="fa fa-plus fa-3x"></i>
                            </div>
                        </div>
                        <img src="img/portfolio/treehouse.png" class="img-responsive" alt="">
                    </a>
                    <div class="portfolio-caption">
                        <h4>Rate a Review</h4>
                        <p class="text-muted">View and Rate</p>
                    </div>
                </div>
                <div class="col-md-4 col-sm-6 portfolio-item">
                    <a href="#portfolioModal4" class="portfolio-link" data-toggle="modal">
                        <div class="portfolio-hover">
                            <div class="portfolio-hover-content">
                                <i class="fa fa-plus fa-3x"></i>
                            </div>
                        </div>
                        <img src="img/portfolio/golden.png" class="img-responsive" alt="">
                    </a>
                    <div class="portfolio-caption">
                        <h4>Declare Favorites</h4>
                        <p class="text-muted">Your Top Picks!</p>
                    </div>
                </div>
                <div class="col-md-4 col-sm-6 portfolio-item">
                    <a href="#portfolioModal5" class="portfolio-link" data-toggle="modal">
                        <div class="portfolio-hover">
                            <div class="portfolio-hover-content">
                                <i class="fa fa-plus fa-3x"></i>
                            </div>
                        </div>
                        <img src="img/portfolio/escape.png" class="img-responsive" alt="">
                    </a>
                    <div class="portfolio-caption">
                        <h4>Add to Visited</h4>
                        <p class="text-muted">Been There?</p>
                    </div>
                </div>
                <div class="col-md-4 col-sm-6 portfolio-item">
                    <a href="#portfolioModal6" class="portfolio-link" data-toggle="modal">
                        <div class="portfolio-hover">
                            <div class="portfolio-hover-content">
                                <i class="fa fa-plus fa-3x"></i>
                            </div>
                        </div>
                        <img src="img/portfolio/dreams.png" class="img-responsive" alt="">
                    </a>
                    <div class="portfolio-caption">
                        <h4>Confirm and Submit</h4>
                        <p class="text-muted">Check Prior to Submission</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- User Ratings Section -->
    <section id="ratings" class="bg-light-gray">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <h2 class="section-heading">User Ratings</h2>
                    <h3 class="section-subheading text-muted">Give feedback on a user here!</h3>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <form name="sentMessage" id="contactForm" method=post onsubmit="return check_all_fields(this)" action="home.jsp" novalidate>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <input type="text" name="chosen" class="form-control" placeholder="Username of User" id="chosen" required data-validation-required-message="Please enter a username.">
                                    <p class="help-block text-danger"></p>
                                </div>
                                <div class="form-group">
                                    <select name="trustLevel" required data-validation-required-message="Please enter a trustlevel.">
                                        <option value="Trust">Trust</option>
                                        <option value="Not-Trusted">Not-Trusted</option>
                                    <p class="help-block text-danger"></p>
                                    </select>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                            <div class="col-lg-12 text-center">
                                <div id="success"></div>
                                <button type="submit" class="btn btn-xl">Submit</button>
                            </div>
                        </div>
                    </form>

<%

                                 chosenName = request.getParameter("chosen");
                                 score = request.getParameter("trustLevel");

                                if (chosenName != null && score != null)
                                {
                                     if(user.isUser(chosenName, con.stmt))
                                     {                                                                                   
                                         String feedback = "";
                                         
                                         if (user.feedBackExists(username, chosenName, con.stmt))
                                         {
                                             feedback = "update Feedback "
                                                    + "SET Trusted=" + score +" WHERE Login='"+username+"' AND Login2='"+chosenName+"'";
                                         }
                                         else
                                         {
                                             feedback = "insert into (Login, Login2, Trusted)"
                                                    + "VALUES ('" + username + "','" + chosenName + "'," + score + ");";
                                         }                                                              
                                         
                                         Stack<String> tempStack = new Stack<String>();
                                         
                                         tempStack.add(feedback);
                                         
                                         if (user.addStack(username, tempStack, con.stmt))
                                         {
                                             tempStack.clear();
                                         }
                                         
                                         out.println("<h3 style=\"color: gold\" align=\"center\">Trust Recorded.</h3>");
                                     }
                                     else
                                     {
                                         out.println("<h3 style=\"color: red\" align=\"center\">User does not exist.</h3>");
                                     }
                                }

%>

                </div>
            </div>
            <div class="row">
                <div class="col-sm-4">
                    <div class="team-member">
                        <img src="img/team/1.jpg" class="img-responsive img-circle" alt="">
                        <h4>Feifei</h4>
                        <p class="text-muted">Alter Ego</p>
                        <ul class="list-inline social-buttons">
                            <li><a href="#"><i class="fa fa-twitter"></i></a>
                            </li>
                            <li><a href="#"><i class="fa fa-facebook"></i></a>
                            </li>
                            <li><a href="#"><i class="fa fa-linkedin"></i></a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="team-member">
                        <img src="img/team/2.jpg" class="img-responsive img-circle" alt="">
                        <h4>Feifei</h4>
                        <p class="text-muted">Database Professor</p>
                        <ul class="list-inline social-buttons">
                            <li><a href="#"><i class="fa fa-twitter"></i></a>
                            </li>
                            <li><a href="#"><i class="fa fa-facebook"></i></a>
                            </li>
                            <li><a href="#"><i class="fa fa-linkedin"></i></a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="team-member">
                        <img src="img/team/3.jpg" class="img-responsive img-circle" alt="">
                        <h4>Trung Le</h4>
                        <p class="text-muted">Undergraduate Student</p>
                        <ul class="list-inline social-buttons">
                            <li><a href="#"><i class="fa fa-twitter"></i></a>
                            </li>
                            <li><a href="#"><i class="fa fa-facebook"></i></a>
                            </li>
                            <li><a href="#"><i class="fa fa-linkedin"></i></a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-8 col-lg-offset-2 text-center">
                    <p class="large text-muted">Please Be Reasonable in Reviewing Others.</p>
                </div>
            </div>
        </div>
    </section>

    
    <!-- Statistics Section -->
    <section id="stats">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <h2 class="section-heading">Statistics</h2>
                    <h3 class="section-subheading text-muted">Various Stats Based on Category.</h3>
                </div>
            </div>

<%

            category = request.getParameter("category");
            if (category != null)
            {
                categorized = true;
            }

%>


            <form name="sentMessage" id="contactForm" method=post onsubmit="return check_all_fields(this)" action="home.jsp" novalidate>
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <input type="text" name="category" class="form-control" placeholder="Category *" id="category">
                            <p class="help-block text-danger"></p>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                    <div class="col-lg-12 text-center">
                        <div id="success"></div>
                        <button type="submit" class="btn btn-xl">Enter</button>
                    </div>
                </div>
            </form>

<%
            if (categorized)
            {
%>


            <div class="row">
                <div class="col-md-4 col-sm-6 portfolio-item">
                    <a href="#portfolioModal13" class="portfolio-link" data-toggle="modal">
                        <div class="portfolio-hover">
                            <div class="portfolio-hover-content">
                                <i class="fa fa-plus fa-3x"></i>
                            </div>
                        </div>
                        <img src="img/portfolio/roundicons.png" class="img-responsive" alt="">
                    </a>
                    <div class="portfolio-caption">
                        <h4>Most Popular POIs</h4>
                        <p class="text-muted">By <%=category%></p>
                    </div>
                </div>
                <div class="col-md-4 col-sm-6 portfolio-item">
                    <a href="#portfolioModal14" class="portfolio-link" data-toggle="modal">
                        <div class="portfolio-hover">
                            <div class="portfolio-hover-content">
                                <i class="fa fa-plus fa-3x"></i>
                            </div>
                        </div>
                        <img src="img/portfolio/startup-framework.png" class="img-responsive" alt="">
                    </a>
                    <div class="portfolio-caption">
                        <h4>Most Expensive</h4>
                        <p class="text-muted">By <%=category%></p>
                    </div>
                </div>
                <div class="col-md-4 col-sm-6 portfolio-item">
                    <a href="#portfolioModal15" class="portfolio-link" data-toggle="modal">
                        <div class="portfolio-hover">
                            <div class="portfolio-hover-content">
                                <i class="fa fa-plus fa-3x"></i>
                            </div>
                        </div>
                        <img src="img/portfolio/treehouse.png" class="img-responsive" alt="">
                    </a>
                    <div class="portfolio-caption">
                        <h4>Most Highly Rated POIs</h4>
                        <p class="text-muted">By <%=category%></p>
                    </div>
                </div>
            </div>

<%
        }
%>

        </div>
    </section>



    <%

    if (admin)
    {
    %>
    <!-- Admin Grid Section -->
    <section id="admin" class="bg-light-gray">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <h2 class="section-heading">Admin Tools</h2>
                    <h3 class="section-subheading text-muted">For all your adminstrative needs.</h3>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4 col-sm-6 portfolio-item">
                    <a href="#portfolioModal7" class="portfolio-link" data-toggle="modal">
                        <div class="portfolio-hover">
                            <div class="portfolio-hover-content">
                                <i class="fa fa-plus fa-3x"></i>
                            </div>
                        </div>
                        <img src="img/portfolio/roundicons.png" class="img-responsive" alt="">
                    </a>
                    <div class="portfolio-caption">
                        <h4>All Current POIs</h4>
                        <p class="text-muted">Click to View</p>
                    </div>
                </div>
                <div class="col-md-4 col-sm-6 portfolio-item">
                    <a href="#portfolioModal8" class="portfolio-link" data-toggle="modal">
                        <div class="portfolio-hover">
                            <div class="portfolio-hover-content">
                                <i class="fa fa-plus fa-3x"></i>
                            </div>
                        </div>
                        <img src="img/portfolio/startup-framework.png" class="img-responsive" alt="">
                    </a>
                    <div class="portfolio-caption">
                        <h4>Update POI</h4>
                        <p class="text-muted">For Existing POIs</p>
                    </div>
                </div>
                <div class="col-md-4 col-sm-6 portfolio-item">
                    <a href="#portfolioModal9" class="portfolio-link" data-toggle="modal">
                        <div class="portfolio-hover">
                            <div class="portfolio-hover-content">
                                <i class="fa fa-plus fa-3x"></i>
                            </div>
                        </div>
                        <img src="img/portfolio/treehouse.png" class="img-responsive" alt="">
                    </a>
                    <div class="portfolio-caption">
                        <h4>Add New POI</h4>
                        <p class="text-muted">For New POIs</p>
                    </div>
                </div>
                <div class="col-md-4 col-sm-6 portfolio-item">
                    <a href="#portfolioModal10" class="portfolio-link" data-toggle="modal">
                        <div class="portfolio-hover">
                            <div class="portfolio-hover-content">
                                <i class="fa fa-plus fa-3x"></i>
                            </div>
                        </div>
                        <img src="img/portfolio/golden.png" class="img-responsive" alt="">
                    </a>
                    <div class="portfolio-caption">
                        <h4>Most Trusted Users</h4>
                        <p class="text-muted">See Who Has High Reputations!</p>
                    </div>
                </div>
                <div class="col-md-4 col-sm-6 portfolio-item">
                    <a href="#portfolioModal11" class="portfolio-link" data-toggle="modal">
                        <div class="portfolio-hover">
                            <div class="portfolio-hover-content">
                                <i class="fa fa-plus fa-3x"></i>
                            </div>
                        </div>
                        <img src="img/portfolio/escape.png" class="img-responsive" alt="">
                    </a>
                    <div class="portfolio-caption">
                        <h4>Most Useful Users</h4>
                        <p class="text-muted">See Who Has Given the Best Feedbacks!</p>
                    </div>
                </div>
                <div class="col-md-4 col-sm-6 portfolio-item">
                    <a href="#portfolioModal12" class="portfolio-link" data-toggle="modal">
                        <div class="portfolio-hover">
                            <div class="portfolio-hover-content">
                                <i class="fa fa-plus fa-3x"></i>
                            </div>
                        </div>
                        <img src="img/portfolio/escape.png" class="img-responsive" alt="">
                    </a>
                    <div class="portfolio-caption">
                        <h4>Degrees of Separation</h4>
                        <p class="text-muted">See How Close Users are From Each Other!</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <%
    }

    %>

    <footer>
        <div class="container">
            <div class="row">
                <div class="col-md-4">
                    <span class="copyright">Copyright &copy; Johnny Le 2016</span>
                </div>
                <div class="col-md-4">
                    <ul class="list-inline social-buttons">
                        <li><a href="#"><i class="fa fa-twitter"></i></a>
                        </li>
                        <li><a href="#"><i class="fa fa-facebook"></i></a>
                        </li>
                        <li><a href="#"><i class="fa fa-linkedin"></i></a>
                        </li>
                    </ul>
                </div>
                <div class="col-md-4">
                    <ul class="list-inline quicklinks">
                        <li><a href="#">Privacy Policy</a>
                        </li>
                        <li><a href="#">Terms of Use</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </footer>

    <!-- Portfolio Modals -->
    <!-- Use the modals below to showcase details about your portfolio projects! -->

    <!-- Portfolio Modal 1 -->
    <div class="portfolio-modal modal fade" id="portfolioModal1" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-content">
            <div class="close-modal" data-dismiss="modal">
                <div class="lr">
                    <div class="rl">
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 col-lg-offset-2">
                        <div class="modal-body">
                            <!-- Project Details Go Here -->
                            <h2>Existing POIs</h2>
                            <p class="item-intro text-muted">Check them all out!</p>
                            <img class="img-responsive img-centered" src="img/portfolio/roundicons-free.png" alt="">
                            <%

                                out.println("Generating current points of interest...");
                                sql= "select Name from POI";
                                rs=con.stmt.executeQuery(sql);
                                rsmd = rs.getMetaData();
                                numCols = rsmd.getColumnCount();
                                 while (rs.next())
                                 {
                                     for (int i=1; i<=numCols;i++)
                                         out.print("<h3 align=\"center\">" + rs.getString(i)+"  ");
                                     out.println("---------------------");
                                 }
                                 rs.close();

                            %>
                            <button type="button" class="btn btn-primary" data-dismiss="modal"><i class="fa fa-times"></i> Close </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Portfolio Modal 2 -->
    <div class="portfolio-modal modal fade" id="portfolioModal2" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-content">
            <div class="close-modal" data-dismiss="modal">
                <div class="lr">
                    <div class="rl">
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 col-lg-offset-2">
                        <div class="modal-body">
                            <h2>Provide Feedback</h2>
                            <p class="item-intro text-muted">Review a Point!</p>
                            <img class="img-responsive img-centered" src="img/portfolio/startup-framework-preview.png" alt="">
                            <form name="sentMessage" id="contactForm" method=post onsubmit="return check_all_fields(this)" action="home.jsp#visits" novalidate>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <input type="text" name="point" class="form-control" placeholder="POI Name" id="point" required data-validation-required-message="Please Fill in the Box.">
                                        <p class="help-block text-danger"></p>
                                    </div>
                                    <div class="form-group">
                                        <textarea class="form-control" name="thoughts" placeholder="Your Thoughts *" id="thoughts" required data-validation-required-message="Please enter a message."></textarea>
                                        <p class="help-block text-danger"></p>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <input type="text" name="date" class="form-control" placeholder="Date (YYYY-MM-DD HH:MM:SS)" id="date" required data-validation-required-message="Please Fill in the Box.">
                                        <p class="help-block text-danger"></p>
                                    </div>
                                    <div class="form-group">
                                        <input type="text" name="score" class="form-control" placeholder="Score? (0-10)" id="score" required data-validation-required-message="Please Fill in the Box.">
                                        <p class="help-block text-danger"></p>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                                <div class="col-lg-12 text-center">
                                    <div id="success"></div>
                                    <button type="submit" class="btn btn-xl">Enter</button>
                                </div>
                            </div>
                            </form>

                            <%


                                point = request.getParameter("point");
                                thoughts = request.getParameter("thoughts");
                                date = request.getParameter("date");
                                score = request.getParameter("score");

                                if (point != null && thoughts != null && date != null && score != null)
                                {
                                     String pointID = user.isPOI(username, point, con.stmt);
                                     String name = point;
                                     if(pointID.length() > 0 && !user.hasBeenReviewed(username, pointID, con.stmt))
                                     {                            
                                         
                                         String point2 = "insert into Review (";
                                         
                                         String values = "VALUES (";                                                                                     
                                         
                                         if (thoughts.length() != 0)
                                         {
                                             point2 += "Thoughts,";
                                             values += "'" + thoughts + "',";
                                         }
                                         
                                         point2 += "DateTime, Score, ID, Login) ";
                                         values += "'" + date + "'," + score + "," + pointID + ",'" + username + "')";
                                         
                                         point2 += values;
                                         
                                         Stack<String> tempStack = new Stack<String>();
                                         
                                         tempStack.add(point2);
                                         
                                         if (user.addStack(username, tempStack, con.stmt))
                                         {
                                             tempStack.clear();
                                         }
                                         
                                        out.println("<h3>POI has been reviewed by you.</h3>");

                                         
                                     }
                                     else
                                     {
                                         out.println("<h3>Not a valid POI name or you've already reviewed this point.</h3>");
                                     }
                                }

                            %>

                            <button type="button" class="btn btn-primary" data-dismiss="modal"><i class="fa fa-times"></i> Close </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Portfolio Modal 3 -->
    <div class="portfolio-modal modal fade" id="portfolioModal3" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-content">
            <div class="close-modal" data-dismiss="modal">
                <div class="lr">
                    <div class="rl">
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 col-lg-offset-2">
                        <div class="modal-body">
                            <!-- Project Details Go Here -->
                            <h2>Review A Review</h2>
                            <p class="item-intro text-muted">Provide feedback on a review.</p>
                            <img class="img-responsive img-centered" src="img/portfolio/treehouse-preview.png" alt="">
                            <form name="sentMessage" id="contactForm" method=post onsubmit="return check_all_fields(this)" action="home.jsp#visits" novalidate>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <input type="text" name="reviewID" class="form-control" placeholder="Review ID" id="reviewID" required data-validation-required-message="Please Fill in the Box.">
                                        <p class="help-block text-danger"></p>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <select name="score" required data-validation-required-message="Please select a score.">
                                            <option value="0">0 - Useless</option>
                                            <option value="1">1 - Useful</option>
                                            <option value="2">2 - Very Useful</option>
                                        <p class="help-block text-danger"></p>
                                        </select>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                                <div class="col-lg-12 text-center">
                                    <div id="success"></div>
                                    <button type="submit" class="btn btn-xl">Enter</button>
                                </div>
                            </div>
                            </form>

                            <%

                                        reviewID = request.getParameter("reviewID");
                                        score = request.getParameter("score");

                                        if (reviewID != null && score != null)
                                        {
                                            if(user.isReview(username, reviewID, con.stmt))
                                            {                             
                                                 
                                                 String point2 = "insert into Feedback (Login, RID, Usefulness) "
                                                         + "VALUES ('" + username + "', '" + reviewID + "', " + score + ")";                                             
                                                 
                                                 Stack<String> tempStack = new Stack<String>();
                                                 
                                                 tempStack.add(point2);
                                                 
                                                 if (user.addStack(username, tempStack, con.stmt))
                                                 {
                                                     tempStack.clear();
                                                 }
                                                 
                                                 out.println("<h3>You've given feedback on a review.</h3>");
                                                 
                                             }
                                             else
                                             {
                                                 System.out.println("<h3>Not a valid review ID. (You cannot review non-existing or your own reviews.</h3>");

                                             }    
                                        }
                            %>

                            <button type="button" class="btn btn-primary" data-dismiss="modal"><i class="fa fa-times"></i> Close </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Portfolio Modal 4 -->
    <div class="portfolio-modal modal fade" id="portfolioModal4" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-content">
            <div class="close-modal" data-dismiss="modal">
                <div class="lr">
                    <div class="rl">
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 col-lg-offset-2">
                        <div class="modal-body">
                            <!-- Project Details Go Here -->
                            <h2>Favorites</h2>
                            <p class="item-intro text-muted">Add to Your Favorites.</p>
                            <img class="img-responsive img-centered" src="img/portfolio/golden-preview.png" alt="">
                            <form name="sentMessage" id="contactForm" method=post onsubmit="return check_all_fields(this)" action="home.jsp#visits" novalidate>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <input type="text" name="point2" class="form-control" placeholder="Point of Interest Name *" id="point2" required data-validation-required-message="Please Fill in the Box.">
                                        <p class="help-block text-danger"></p>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                                <div class="col-lg-12 text-center">
                                    <div id="success"></div>
                                    <button type="submit" class="btn btn-xl">Enter</button>
                                </div>
                            </div>
                            </form>

                            <%

                            point = request.getParameter("point2");

                            if (point != null)
                            {
                                 String pointID = user.isPOI(username, point, con.stmt);
                                 String name = point;
                                 if(pointID.length() > 0)
                                 { 
                                     point = "insert into Favorites (pid, login)"
                                            + "VALUES (" + pointID + ",'" + username + "');";
                                     
                                     Stack<String> tempStack = new Stack<String>();
                                     
                                     tempStack.add(point);
                                     
                                     if (user.addStack(username, tempStack, con.stmt))
                                     {
                                         tempStack.clear();
                                     }
                                     
                                     out.println("<h3>" + name + " has been favorited.</h3>");
                                     
                                 }
                                 else
                                 {
                                     System.out.println("<h3>Not a valid POI name.</h3>");
                                 }
                            }

                            %>

                            <button type="button" class="btn btn-primary" data-dismiss="modal"><i class="fa fa-times"></i> Close </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Portfolio Modal 5 -->
    <div class="portfolio-modal modal fade" id="portfolioModal5" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-content">
            <div class="close-modal" data-dismiss="modal">
                <div class="lr">
                    <div class="rl">
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 col-lg-offset-2">
                        <div class="modal-body">
                            <!-- Project Details Go Here -->
                            <h2>Add to Visited</h2>
                            <p class="item-intro text-muted">Must Confirm Before Final Submission.</p>
                            <img class="img-responsive img-centered" src="img/portfolio/escape-preview.png" alt="">
                            <form name="sentMessage" id="contactForm" onsubmit="return addFields(this)" novalidate>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <input type="text" name="point" class="form-control" placeholder="POI Name" id="point" required data-validation-required-message="Please Fill in the Box.">
                                        <p class="help-block text-danger"></p>
                                    </div>
                                    <div class="form-group">
                                        <input type="text" name="cost" class="form-control" placeholder="Cost of Visit (Integer)" id="cost" required data-validation-required-message="Please Fill in the Box.">
                                        <p class="help-block text-danger"></p>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <input type="text" name="date" class="form-control" placeholder="Date (YYYY-MM-DD HH:MM:SS)" id="date" required data-validation-required-message="Please Fill in the Box.">
                                        <p class="help-block text-danger"></p>
                                    </div>
                                    <div class="form-group">
                                        <input type="text" name="partySize" class="form-control" placeholder="Party Size *" id="partySize" required data-validation-required-message="Please Fill in the Box.">
                                        <p class="help-block text-danger"></p>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                                <div class="col-lg-12 text-center">
                                    <div id="success"></div>
                                    <button type="submit" class="btn btn-xl">Enter</button>
                                </div>
                            </div>
                            </form>

                            <%
                                        point = request.getParameter("point");
                                        cost = request.getParameter("cost");
                                        date = request.getParameter("date");
                                        partySize = request.getParameter("partySize");

                                        if (point != null && cost != null && partySize != null)
                                        {
                                            String pointID = user.isPOI(username, point, con.stmt);
                                            visitNames.push(pointID);
                                             if(pointID.length() > 0)
                                             {
                                                 
                                                 point = "insert into Visited (Login, ID";
                                                 String values = "VALUES ('" + username + "'," + pointID + "";
                                                 
                                                 if (cost.length() != 0)
                                                 {
                                                     point += ", Cost";
                                                     values += "," + cost;
                                                 }
                                                 if (date.length() != 0)
                                                 {
                                                     point += ", Date";
                                                     values += "," + date;
                                                 }
                                                 if (partySize.length() != 0)
                                                 {
                                                     point += ", PartySize";
                                                     values += "," + partySize;
                                                 }
                                                 
                                                 point += ") ";
                                                 values += ");";
                                                 
                                                 point += values;
                                                 visits.push(point);
                                                 out.println("<h3>Added to the list! Please confirm to submit.</h3>");
                                             }
                                             else
                                             {
                                                 System.out.println("<h3 style=\"red\">Not a valid POI name.</h3>");
                                             }

                                            if (!visits.isEmpty() && !visitNames.isEmpty())
                                            {
                                                session.setAttribute("visitsAtt", visits);
                                                session.setAttribute("visitNamesAtt", visitNames);
                                            }
                                        }

                            %>


                            <button type="button" class="btn btn-primary" data-dismiss="modal"><i class="fa fa-times"></i> Close </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Portfolio Modal 6 -->
    <div class="portfolio-modal modal fade" id="portfolioModal6" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-content">
            <div class="close-modal" data-dismiss="modal">
                <div class="lr">
                    <div class="rl">
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 col-lg-offset-2">
                        <div class="modal-body">
                            <!-- Project Details Go Here -->
                            <h2>Confirm and Submit</h2>
                            <p class="item-intro text-muted">Review Your Visits Before Submitting.</p>
                            <img class="img-responsive img-centered" src="img/portfolio/dreams-preview.png" alt="">
                            <form name="sentMessage" id="contactForm" method=post onsubmit="return check_all_fields(this)" action="home.jsp#visits" novalidate>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <select name="choice2" required data-validation-required-message="Please select an option.">
                                            <option value="y">Yes</option>
                                            <option value="n">No</option>
                                        <p class="help-block text-danger"></p>
                                        </select>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                                <div class="col-lg-12 text-center">
                                    <div id="success"></div>
                                    <button type="submit" class="btn btn-xl">Enter</button>
                                </div>
                            </div>
                            </form>

                            <%
                                choice = request.getParameter("choice2");

                                if (choice != null)
                                {
                                    String f = "n";
                                    if (!visits.isEmpty())
                                    {
                                         Stack<String> tempVisits = new Stack<String>();
                                         while (!visits.isEmpty())
                                         {
                                             String nPoint = visits.pop();
                                             out.println(nPoint);
                                             tempVisits.push(nPoint);
                                         }
                                         
                                         try{
                                             f = choice;
                                         }catch (Exception e)
                                         {
                                         }                                     
                                         
                                         if (f.equals("y")) //Yes
                                         {
                                             if (user.addStack(username, tempVisits, con.stmt))
                                             {
                                                 visits.clear();
                                             }                                              
                                             
                                             while (!visitNames.isEmpty())
                                             {
                                                 select = "select Name, Count(visit.Login) ";
                                                 from = "FROM POI, Visited visit ";
                                                 where = "WHERE POI.ID=visit.ID "
                                                        + "AND visit.Login=ANY(select V.Login "
                                                        + "From Visited V "
                                                        + "Where V.login != '" +username+ "' "
                                                                + "AND V.ID ='" +visitNames.pop()+ "') ";
                                                 groupBy = "Order By Count(visit.Login) DESC;";
                                                 
                                                 
                                                 sql = select+from+where+groupBy;
                                                 
                                                 out.println("<h3>Retrieving a list of suggestions...</h3>");
                                                 rs=con.stmt.executeQuery(sql);
                                                 rsmd = rs.getMetaData();
                                                 numCols = rsmd.getColumnCount();
                                                 while (rs.next())
                                                 {
                                                     for (int i=1; i<=numCols;i++)
                                                         out.print("<h3 align=\"center\">"+rs.getString(i)+"  </h3>");
                                                     out.println("-------------------");
                                                 }
                                                 out.println(" ");
                                                 rs.close();
                                             }

                                             
                                         }
                                         
                                         else if (f.equals("n")) //No
                                         {
                                             visits = tempVisits;
                                             out.println("<h3>Visits not saved.</h3>");
                                         }
                                         else
                                         {
                                             visits = tempVisits;
                                             out.println("<h3>Invalid Input. Visits not saved.</h3>");
                                         }
                                     }
                                     else
                                     {
                                         out.println("No unsaved visits.");
                                     }

                                    if (!visits.isEmpty() && !visitNames.isEmpty())
                                    {
                                        session.setAttribute("visitsAtt", visits);
                                        session.setAttribute("visitNamesAtt", visitNames);
                                    }
                                }

                            %>
                            <button type="button" class="btn btn-primary" data-dismiss="modal"><i class="fa fa-times"></i> Close </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <!-- Portfolio Modal 7 -->
    <div class="portfolio-modal modal fade" id="portfolioModal7" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-content">
            <div class="close-modal" data-dismiss="modal">
                <div class="lr">
                    <div class="rl">
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 col-lg-offset-2">
                        <div class="modal-body">
                            <!-- Project Details Go Here -->
                            <h2>All POIs</h2>
                            <p class="item-intro text-muted">Below is the List of All POIs</p>
                            <img class="img-responsive img-centered" src="img/portfolio/roundicons-free.png" alt="">

                            <%
                                out.println("Generating current points of interest...");
                                sql= "select Name from POI";
                                rs=con.stmt.executeQuery(sql);
                                rsmd = rs.getMetaData();
                                numCols = rsmd.getColumnCount();
                                 while (rs.next())
                                 {
                                     for (int i=1; i<=numCols;i++)
                                         out.print("<h3 align=\"center\">" + rs.getString(i)+"  ");
                                     out.println("---------------------");
                                 }
                                 rs.close();

                            %>

                            <button type="button" class="btn btn-primary" data-dismiss="modal"><i class="fa fa-times"></i> Close </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Portfolio Modal 8 -->
    <div class="portfolio-modal modal fade" id="portfolioModal8" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-content">
            <div class="close-modal" data-dismiss="modal">
                <div class="lr">
                    <div class="rl">
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 col-lg-offset-2">
                        <div class="modal-body">
                            <h2>Update POI</h2>
                            <p class="item-intro text-muted">Outdated? Update It Below!</p>
                            <img class="img-responsive img-centered" src="img/portfolio/startup-framework-preview.png" alt="">
                            <form name="sentMessage" id="contactForm" method=post onsubmit="return check_all_fields(this)" action="home.jsp#admin" novalidate>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <input type="text" name="point" class="form-control" placeholder="POI Name" id="point" required data-validation-required-message="Please Fill in the Box.">
                                        <p class="help-block text-danger"></p>
                                    </div>
                                    <div class="form-group">
                                        <input type="text" name="address" class="form-control" placeholder="City, State (Non-Abbreviated)" id="address" required data-validation-required-message="Please Fill in the Box.">
                                        <p class="help-block text-danger"></p>
                                    </div>
                                    <div class="form-group">
                                        <input type="text" name="website" class="form-control" placeholder="Website *" id="website" required data-validation-required-message="Please Fill in the Box.">
                                        <p class="help-block text-danger"></p>
                                    </div>
                                    <div class="form-group">
                                        <input type="text" name="pnumber" class="form-control" placeholder="Phone Number (xxxyyyyzzzz)" id="pnumber" required data-validation-required-message="Please Fill in the Box.">
                                        <p class="help-block text-danger"></p>
                                    </div>
                                    <div class="form-group">
                                        <input type="text" name="year" class="form-control" placeholder="Year Established *" id="year" required data-validation-required-message="Please Fill in the Box.">
                                        <p class="help-block text-danger"></p>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <input type="text" name="hours" class="form-control" placeholder="Hours (H-H)" id="hours" required data-validation-required-message="Please Fill in the Box.">
                                        <p class="help-block text-danger"></p>
                                    </div>
                                    <div class="form-group">
                                        <input type="text" name="price" class="form-control" placeholder="Price (Integer)" id="price" required data-validation-required-message="Please Fill in the Box.">
                                        <p class="help-block text-danger"></p>
                                    </div>
                                    <div class="form-group">
                                        <input type="text" name="keywords" class="form-control" placeholder="Keywords (Keyword1, Keyword2,...)" id="keywords" required data-validation-required-message="Please Fill in the Box.">
                                        <p class="help-block text-danger"></p>
                                    </div>
                                    <div class="form-group">
                                        <input type="text" name="categories" class="form-control" placeholder="Categories (Category1, Category2,...)" id="categories" required data-validation-required-message="Please Fill in the Box.">
                                        <p class="help-block text-danger"></p>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                                <div class="col-lg-12 text-center">
                                    <div id="success"></div>
                                    <button type="submit" class="btn btn-xl">Enter</button>
                                </div>
                            </div>
                            </form>
                            <%

                                            point = request.getParameter("point");
                                            address = request.getParameter("address");
                                            website = request.getParameter("website");
                                            pnumber = request.getParameter("pnumber");
                                            year = request.getParameter("year");
                                            hours = request.getParameter("hours");
                                            price = request.getParameter("price");
                                            keywords = request.getParameter("keywords");
                                            categories = request.getParameter("categories");

                                            if (point != null && address != null && website != null)
                                            {

                                                 String pointID = user.isPOI(username, point, con.stmt);
                                                 if(pointID.length() != 0)
                                                 {                                     
                                                     
                                                     
                                                     String point2 = "update POI "
                                                            + "SET Name='"+ point +"' ";
                                                     
                                                     if (address.length() != 0)
                                                     {
                                                         point2 += ", Address='" + address + "' ";
                                                     }
                                                     if (website.length() != 0)
                                                     {
                                                         point2 += ", URL='" + website + "' ";
                                                     }
                                                     if (pnumber.length() != 0)
                                                     {
                                                         point2 += ", PhoneNumber=" + pnumber + " ";
                                                     }
                                                     if (year.length() != 0)
                                                     {
                                                         point2 += ", YearEstablished='" + year + "' ";
                                                     }
                                                     if (hours.length() != 0)
                                                     {
                                                         point2 += ", Hours='" + hours + "' ";
                                                     }
                                                     if (price.length() != 0)
                                                     {
                                                         point2 += ", Price=" + price + " ";
                                                     }
                                                     if (keywords.length() != 0)
                                                     {
                                                         sql="select Keywords from POI where Name='" + point + "' ";
                                                         rs=con.stmt.executeQuery(sql);
                                                         while (rs.next())
                                                         {
                                                             keywords += ", " + rs.getString("Keywords");
                                                         }
                                                         rs.close();
                                                         
                                                         point += ", Keywords='" + keywords + "'";
                                                     }
                                                     if (categories.length() != 0)
                                                     {
                                                         sql="select Categories from POI where Name='" + point + "' ";
                                                         rs=con.stmt.executeQuery(sql);
                                                         while (rs.next())
                                                         {
                                                             keywords += ", " + rs.getString("Categories");
                                                         }
                                                         rs.close();
                                                                                                 
                                                         point += ", Categories='" + categories + "' ";
                                                     }
                                                     
                                                     point2 += "WHERE Name='" + point + "';";
                                                     
                                                     Stack<String> tempStack = new Stack<String>();
                                                     
                                                     tempStack.add(point2);
                                                     
                                                     if (user.addStack(username, tempStack, con.stmt))
                                                     {
                                                         tempStack.clear();
                                                     }
                                                     
                                                     out.println("<h3>POI has been updated.</h3>");
                                                 }
                                                 else
                                                 {
                                                     out.println("<h3>Information provided was not valid.</h3>");
                                                 }
                                            
                                                address = null;
                                                website = null;
                                                pnumber = null;
                                                year = null;
                                                hours = null;
                                                price = null;
                                                keywords = null;
                                                categories = null;

                                            }

                            %>
                            <button type="button" class="btn btn-primary" data-dismiss="modal"><i class="fa fa-times"></i> Close </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Portfolio Modal 9 -->
    <div class="portfolio-modal modal fade" id="portfolioModal9" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-content">
            <div class="close-modal" data-dismiss="modal">
                <div class="lr">
                    <div class="rl">
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 col-lg-offset-2">
                        <div class="modal-body">
                            <!-- Project Details Go Here -->
                            <h2>Add a POI</h2>
                            <p class="item-intro text-muted">Not in UTrack? Add it below!</p>
                            <img class="img-responsive img-centered" src="img/portfolio/treehouse-preview.png" alt="">
                            <form name="sentMessage" id="contactForm" method=post onsubmit="return check_all_fields(this)" action="home.jsp#admin" novalidate>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <input type="text" name="point" class="form-control" placeholder="POI Name" id="point" required data-validation-required-message="Please Fill in the Box.">
                                        <p class="help-block text-danger"></p>
                                    </div>
                                    <div class="form-group">
                                        <input type="text" name="address" class="form-control" placeholder="City, State (Non-Abbreviated)" id="address" required data-validation-required-message="Please Fill in the Box.">
                                        <p class="help-block text-danger"></p>
                                    </div>
                                    <div class="form-group">
                                        <input type="text" name="website" class="form-control" placeholder="Website *" id="website" required data-validation-required-message="Please Fill in the Box.">
                                        <p class="help-block text-danger"></p>
                                    </div>
                                    <div class="form-group">
                                        <input type="text" name="pnumber" class="form-control" placeholder="Phone Number (xxxyyyyzzzz)" id="pnumber" required data-validation-required-message="Please Fill in the Box.">
                                        <p class="help-block text-danger"></p>
                                    </div>
                                    <div class="form-group">
                                        <input type="text" name="year" class="form-control" placeholder="Year Established *" id="year" required data-validation-required-message="Please Fill in the Box.">
                                        <p class="help-block text-danger"></p>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <input type="text" name="hours" class="form-control" placeholder="Hours (H-H)" id="hours" required data-validation-required-message="Please Fill in the Box.">
                                        <p class="help-block text-danger"></p>
                                    </div>
                                    <div class="form-group">
                                        <input type="text" name="price" class="form-control" placeholder="Price (Integer)" id="price" required data-validation-required-message="Please Fill in the Box.">
                                        <p class="help-block text-danger"></p>
                                    </div>
                                    <div class="form-group">
                                        <input type="text" name="keywords" class="form-control" placeholder="Keywords (Keyword1, Keyword2,...)" id="keywords" required data-validation-required-message="Please Fill in the Box.">
                                        <p class="help-block text-danger"></p>
                                    </div>
                                    <div class="form-group">
                                        <input type="text" name="categories" class="form-control" placeholder="Categories (Category1, Category2,...)" id="categories" required data-validation-required-message="Please Fill in the Box.">
                                        <p class="help-block text-danger"></p>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                                <div class="col-lg-12 text-center">
                                    <div id="success"></div>
                                    <button type="submit" class="btn btn-xl">Enter</button>
                                </div>
                            </div>
                            </form>
<%

                                            point = request.getParameter("point");
                                            address = request.getParameter("address");
                                            website = request.getParameter("website");
                                            pnumber = request.getParameter("pnumber");
                                            year = request.getParameter("year");
                                            hours = request.getParameter("hours");
                                            price = request.getParameter("price");
                                            keywords = request.getParameter("keywords");
                                            categories = request.getParameter("categories");

                                            if (point != null && address != null && website != null)
                                            {
                                             String pointID = user.isPOI(username, point, con.stmt);
                                             if(pointID.length() == 0)
                                             {                                                                                
                                                 String point2 = "insert into POI (Name";
                                                 String values = "VALUES ('" + point + "'";
                                                 
                                                 if (address.length() != 0)
                                                 {
                                                     point2 += ", Address";
                                                     values += ",'" + address + "'";
                                                 }
                                                 if (website.length() != 0)
                                                 {
                                                     point2 += ", URL";
                                                     values += ",'" + website + "'";
                                                 }
                                                 if (pnumber.length() != 0)
                                                 {
                                                     point2 += ", PhoneNumber";
                                                     values += "," + pnumber;
                                                 }
                                                 if (year.length() != 0)
                                                 {
                                                     point2 += ", YearEstablished";
                                                     values += ",'" + year + "'";
                                                 }
                                                 if (hours.length() != 0)
                                                 {
                                                     point2 += ", Hours";
                                                     values += ",'" + hours + "'";
                                                 }
                                                 if (price.length() != 0)
                                                 {
                                                     point2 += ", Price";
                                                     values += "," + price + "";
                                                 }
                                                 if (keywords.length() != 0)
                                                 {
                                                     point2 += ", Keywords";
                                                     values += ",'" + keywords + "'";
                                                 }
                                                 if (categories.length() != 0)
                                                 {
                                                     point2 += ", Categories";
                                                     values += ",'" + categories + "'";
                                                 }
                                                 
                                                 
                                                 point2 += ") ";
                                                 values += ");";
                                                 
                                                 point2 += values;
                                                 
                                                 Stack<String> tempStack = new Stack<String>();
                                                 
                                                 tempStack.add(point2);
                                                 
                                                 if (user.addStack(username, tempStack, con.stmt))
                                                 {
                                                     tempStack.clear();
                                                 }
                                                 
                                                 out.println("<h3>POI has been added.</h3>");
                                             }
                                             else
                                             {
                                                 out.println("<h3>Information provided was not valid.</h3>");
                                             }

                                                point = null;
                                                address = null;
                                                website = null;
                                                pnumber = null;
                                                year = null;
                                                hours = null;
                                                price = null;
                                                keywords = null;
                                                categories = null;
                                            }

%>
                            <button type="button" class="btn btn-primary" data-dismiss="modal"><i class="fa fa-times"></i> Close </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Portfolio Modal 10 -->
    <div class="portfolio-modal modal fade" id="portfolioModal10" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-content">
            <div class="close-modal" data-dismiss="modal">
                <div class="lr">
                    <div class="rl">
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 col-lg-offset-2">
                        <div class="modal-body">
                            <!-- Project Details Go Here -->
                            <h2>Most Trusted Users</h2>
                            <p class="item-intro text-muted">Y'all are Stand Up People</p>
                            <img class="img-responsive img-centered" src="img/portfolio/golden-preview.png" alt="">
                            <%

                                            select = "select T1.Login2 ";
                                            from = "FROM Trust T1, Trust T2 ";
                                            where = "WHERE T1.Login2=T2.Login2 AND T1.Trusted!=T2.Trusted ";
                                            groupBy = "Group By T1.Trusted ";
                                            orderBy = "Order By Count(T1.Trusted) DESC;";
                                             
                                            sql = select+from+where+groupBy+orderBy;
                                             
                                            rs=con.stmt.executeQuery(sql);
                                            rsmd = rs.getMetaData();
                                            numCols = rsmd.getColumnCount();
                                             while (rs.next())
                                             {
                                                 for (int i=1; i<=numCols;i++)
                                                     out.print("<h3 align=\"center\">"+rs.getString(i)+"  </h3>");
                                                 out.println("----------------");
                                             }
                                             rs.close();

                            %>
                            <button type="button" class="btn btn-primary" data-dismiss="modal"><i class="fa fa-times"></i> Close </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

        <!-- Portfolio Modal 11 -->
    <div class="portfolio-modal modal fade" id="portfolioModal11" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-content">
            <div class="close-modal" data-dismiss="modal">
                <div class="lr">
                    <div class="rl">
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 col-lg-offset-2">
                        <div class="modal-body">
                            <!-- Project Details Go Here -->
                            <h2>Most Useful Users</h2>
                            <p class="item-intro text-muted">Pay it Forward</p>
                            <img class="img-responsive img-centered" src="img/portfolio/golden-preview.png" alt="">
                            <%

                                            select = "select T1.Login2 ";
                                            from = "FROM Trust T1, Trust T2 ";
                                            where = "WHERE T1.Login2=T2.Login2 AND T1.Trusted!=T2.Trusted ";
                                            groupBy = "Group By T1.Trusted ";
                                            orderBy = "Order By Count(T1.Trusted) DESC;";
                                             
                                            sql = select+from+where+groupBy+orderBy;
                                             
                                            rs=con.stmt.executeQuery(sql);
                                            rsmd = rs.getMetaData();
                                            numCols = rsmd.getColumnCount();
                                             while (rs.next())
                                             {
                                                 for (int i=1; i<=numCols;i++)
                                                     out.print("<h3 align=\"center\">"+rs.getString(i)+"  </h3>");
                                                 out.println("----------------");
                                             }
                                             rs.close();

                            %>
                            <button type="button" class="btn btn-primary" data-dismiss="modal"><i class="fa fa-times"></i> Close </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
   
    <!-- Portfolio Modal 12 -->
    <div class="portfolio-modal modal fade" id="portfolioModal12" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-content">
            <div class="close-modal" data-dismiss="modal">
                <div class="lr">
                    <div class="rl">
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 col-lg-offset-2">
                        <div class="modal-body">
                            <h2>Degrees of Separation</h2>
                            <p class="item-intro text-muted">See How Close Two Users Are!</p>
                            <img class="img-responsive img-centered" src="img/portfolio/startup-framework-preview.png" alt="">
                            <form name="sentMessage" id="contactForm" method=post onsubmit="return check_all_fields(this)" action="home.jsp#admin" novalidate>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <input type="text" name="username1" class="form-control" placeholder="Username *" id="username1" required data-validation-required-message="Please Fill in the Box.">
                                        <p class="help-block text-danger"></p>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <input type="text" name="username2" class="form-control" placeholder="Username *" id="username2" required data-validation-required-message="Please Fill in the Box.">
                                        <p class="help-block text-danger"></p>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                                <div class="col-lg-12 text-center">
                                    <div id="success"></div>
                                    <button type="submit" class="btn btn-xl">Enter</button>
                                </div>
                            </div>
                            </form>
                            <%

                                            user1 = request.getParameter("username1");
                                            user2 = request.getParameter("username2");

                                            if (user1 != null && user2 != null)
                                            {

                                                 if(user.shareFavorites(user1, user2, con.stmt))
                                                 {
                                                     out.println("<h3 align=\"center\">These two users, " + user1 + " and " + user2 + ", have 1 degree of separation.</h3>");
                                                 }
                                                 else if (user.shareAnyFavorites(user1, user2, con.stmt))
                                                 {
                                                     out.println("<h3 align=\"center\">These two users, " + user1 + " and " + user2 + ", have 2 degrees of separation.</h3>");
                                                 }
                                                 else
                                                 {
                                                     out.println("<h3 align=\"center\">These two users, " + user1 + " and " + user2 + ", do not have 1 or 2 degrees of separation.</h3>");
                                                 }
                                            
                                                user1 = null;
                                                user2 = null;

                                            }

                            %>
                            <button type="button" class="btn btn-primary" data-dismiss="modal"><i class="fa fa-times"></i> Close </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

        <!-- Portfolio Modal 13 -->
    <div class="portfolio-modal modal fade" id="portfolioModal13" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-content">
            <div class="close-modal" data-dismiss="modal">
                <div class="lr">
                    <div class="rl">
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 col-lg-offset-2">
                        <div class="modal-body">
                            <!-- Project Details Go Here -->
                            <h2>Most Popular POIs</h2>
                            <p class="item-intro text-muted">on UTrack!</p>
                            <img class="img-responsive img-centered" src="img/portfolio/dreams-preview.png" alt="">

                            <%
                                     select = "select POI.Name, POI.Categories ";
                                     from = "FROM POI, Visited ";
                                     where = "WHERE POI.ID=Visited.ID AND POI.Categories LIKE '%" + category + "%' ";
                                     groupBy = "Group By POI.Categories, Visited.Login ";
                                     orderBy = "Order By Count(Visited.Login) DESC;";

                                 sql = select+from+where+groupBy+orderBy;
                             
                                 rs=con.stmt.executeQuery(sql);
                                 rsmd = rs.getMetaData();
                                 numCols = rsmd.getColumnCount();
                                 count = 0;
                                 while (rs.next())
                                 {
                                     for (int i=1; i<=numCols;i++)
                                         out.print("<h3 align=\"center\">"+ rs.getString(i)+"  </h3>");
                                     out.println("");
                                     count++;
                                 }
                                 out.println("------------------------");
                                 rs.close();

                            %>
                            <button type="button" class="btn btn-primary" data-dismiss="modal"><i class="fa fa-times"></i> Close </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

        <!-- Portfolio Modal 14 -->
    <div class="portfolio-modal modal fade" id="portfolioModal14" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-content">
            <div class="close-modal" data-dismiss="modal">
                <div class="lr">
                    <div class="rl">
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 col-lg-offset-2">
                        <div class="modal-body">
                            <!-- Project Details Go Here -->
                            <h2>Most Expensive POIs</h2>
                            <p class="item-intro text-muted">High Roller Heaven.</p>
                            <img class="img-responsive img-centered" src="img/portfolio/dreams-preview.png" alt="">
                            <%
                                 select = "select POI.Name, POI.Categories, Visited.Cost ";
                                 from = "FROM POI, Visited ";
                                 where = "WHERE POI.ID=Visited.ID AND POI.Categories LIKE '%" + category + "%' ";
                                 groupBy = "Group By POI.Categories, Visited.Cost ";
                                 orderBy = "Order By avg(Visited.Cost) DESC;";

                                 sql = select+from+where+groupBy+orderBy;
                             
                                 rs=con.stmt.executeQuery(sql);
                                 rsmd = rs.getMetaData();
                                 numCols = rsmd.getColumnCount();
                                 count = 0;
                                 while (rs.next())
                                 {
                                     for (int i=1; i<=numCols;i++)
                                         out.print("<h3 align=\"center\">"+ rs.getString(i)+"  </h3>");
                                     out.println("");
                                     count++;
                                 }
                                 out.println("------------------------");
                                 rs.close();

                            %>
                            <button type="button" class="btn btn-primary" data-dismiss="modal"><i class="fa fa-times"></i> Close </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

        <!-- Portfolio Modal 15 -->
    <div class="portfolio-modal modal fade" id="portfolioModal15" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-content">
            <div class="close-modal" data-dismiss="modal">
                <div class="lr">
                    <div class="rl">
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 col-lg-offset-2">
                        <div class="modal-body">
                            <!-- Project Details Go Here -->
                            <h2>Most Highly Rated POIs</h2>
                            <p class="item-intro text-muted">Best Value!</p>
                            <img class="img-responsive img-centered" src="img/portfolio/dreams-preview.png" alt="">
                            <%
                                 select = "select POI.Name, POI.Categories ";
                                 from = "FROM POI, Review ";
                                 where = "WHERE POI.ID=Review.ID AND POI.Categories LIKE '%" + category + "%' ";
                                 groupBy = "Group By POI.Categories ";
                                 orderBy = "Order By avg(Review.Score) DESC;";

                                 sql = select+from+where+groupBy+orderBy;
                             
                                 rs=con.stmt.executeQuery(sql);
                                 rsmd = rs.getMetaData();
                                 numCols = rsmd.getColumnCount();
                                 count = 0;
                                 while (rs.next())
                                 {
                                     for (int i=1; i<=numCols;i++)
                                         out.print("<h3 align=\"center\">"+ rs.getString(i)+"  </h3>");
                                     out.println("");
                                     count++;
                                 }
                                 out.println("------------------------");
                                 rs.close();
                            %>
                            <button type="button" class="btn btn-primary" data-dismiss="modal"><i class="fa fa-times"></i> Close </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- jQuery -->
    <script src="js/jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>

    <!-- Plugin JavaScript -->
    <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>
    <script src="js/classie.js"></script>
    <script src="js/cbpAnimatedHeader.js"></script>

    <!-- Contact Form JavaScript -->
    <script src="js/jqBootstrapValidation.js"></script>
    <script src="js/contact_me.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="js/agency.js"></script>

</body>

<%
}
else
{
%>

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>UTrack</title>

    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="css/agency3.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700' rel='stylesheet' type='text/css'>

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body id="page-top" class="index">

    <!-- Header -->
    <header>
        <div class="container">
            <div class="intro-text">
                <div class="intro-lead-in"><font style="color: gold; background-color: clear;"></font></div>
                <div class="intro-lead-in"><font style="color: white; background-color: clear">Invalid Credentials! Redirecting...</font></div>
            </div>
        </div>
    </header>


    <META http-equiv="refresh" content="3; http://georgia.eng.utah.edu:8080/~cs5530u96/index.jsp"></META>
</body>
<%
}
%>

</html>