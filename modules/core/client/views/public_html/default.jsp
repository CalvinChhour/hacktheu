<%@ page language="java" import="cs5530.*" %>
<!DOCTYPE html>
<html lang="en">

<%

UTrackMain main = new UTrackMain();
Connector connector = new Connector();
User user = new User();


String choice;
String chosenName;
String username=null;
String password;
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

String value1;
String value2;

Boolean loggedIn = false;
Boolean visiting = false;
Boolean admin = false;
Boolean adminAccess = false;
Boolean registered = false;

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
    <link href="css/agency.css" rel="stylesheet">

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
                <ul class="nav navbar-nav navbar-right" style="margin-top: 10; padding-top: 10">
                    <li class="hidden">
                        <a href="#page-top"></a>
                    </li>

                    <%
                    String registerName = request.getParameter("registerName");
                    String registerFullName = request.getParameter("registerFullName");
                    String registerLocation = request.getParameter("registerLocation");
                    String registerPassword = request.getParameter("registerPassword");
                    String registerPhone = request.getParameter("registerPhone");

                    if (registerName != null && registerFullName != "" && registerLocation != "" && registerPassword != "" && registerPhone != "")
                    {

                        registered = user.register(registerName, registerPassword, registerFullName, registerLocation, registerPhone, connector.stmt);

                        if (!registered)
                        {

                        %>

                        <li>
                        <a class="page-scroll" style="color: red" href="#Register">This username has already been taken!</a>
                        </li>

                        <%

                        }

                        else
                        {

                    %>

                        <li>
                        <a class="page-scroll" href="#Register">Registration Sent!</a>
                        </li>

                    <%

                        }
                    }

                    else if (registerName != null || registerFullName != null || registerLocation != null || registerPassword != null || registerPhone != null)
                    {
                        if (!registered)
                        {
                    %>

                        <li>
                        <a class="page-scroll" style="color: red" href="#Register">Please Complete All Fields!</a>
                        </li>

                    <%
                        }

                    }

                    %>

                    <li>

                    <%

                    username = request.getParameter("usernameAttribute");
                    if (username == null) {

                    %>
                        <form name="login" id="contactForm" method=post onsubmit="return check_all_fields(this)" action="home.jsp" novalidate>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <input type="text" name="usernameAttribute" class="form-control" placeholder="Username *" id="name" required data-validation-required-message="Input Required">
                                        <p style="color: red;" class="help-block text-danger"></p>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <input type="password" name="passwordAttribute" class="form-control" placeholder="Password *" id="message" required data-validation-required-message="Input Required">
                                        <p style="color: red;" class="help-block text-danger"></p>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                                <div class="text-center align="center"">
                                <div id="success"></div>
                                    <button type="submit" style="color: white; background-color: gold; border: thin; border-color: black" class="btn btn-lg">Login</button>

                                </div>
                            </div>
                        </form>

                        <%
                            }
                            else
                            {
                                password = request.getParameter("passwordAttribute");
                                loggedIn = user.login(username, password, connector.stmt);

                                if (loggedIn)
                                {


                                %>

                                <p style="color: gold">Logging In...</p>
                                



                                <%
                                    
                                }
                                else if (!loggedIn)
                                {

                                %>

<!-- Insert Login Form Here ()()()()()()()()()()()()()()()()()()()()()()()()()()()()()() -->

                            <p style="color: red">Invalid Login</p>

                        <form name="login" id="contactForm" method=post onsubmit="return check_all_fields(this)" action="index.jsp" novalidate>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <input type="text" name="usernameAttribute" class="form-control" placeholder="Username *" id="name" required data-validation-required-message="Input Required">
                                        <p style="color: red;" class="help-block text-danger"></p>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <input type="password" name="passwordAttribute" class="form-control" placeholder="Password *" id="message" required data-validation-required-message="Input Required">
                                        <p style="color: red;" class="help-block text-danger"></p>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                                <div class="text-center align="center"">
                                <div id="success"></div>
                                    <button type="submit" style="color: white; background-color: gold; border: thin; border-color: black" class="btn btn-lg">Login</button>

                                </div>
                            </div>
                        </form>




                            <%
                                }
                                //connector.closeStatement();
                                //connector.closeConnection();
                            }
                            %>


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
                <div class="intro-lead-in">It's Time to Explore</div>
                <div class="intro-heading">The World is Waiting</div>
                <a href="#Register" class="page-scroll btn btn-xl">Register</a>
                <div class="intro-heading"><br></div>
            </div>
        </div>
    </header>

    <!-- Registration Section -->
    <section id="Register" class="bg-light-gray">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <h2 class="section-heading">Register</h2>
                    <h3 class="section-subheading text-muted">Please Enter Your Information Below!</h3>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">




                    <form name="login" id="contactForm" method=post onsubmit="return check_all_fields(this)" action="index.jsp" novalidate>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <input type="text" name="registerName" class="form-control" placeholder="Username *" id="name" required data-validation-required-message="Please Enter Your Username.">
                                    <p class="help-block text-danger"></p>
                                </div>
                                <div class="form-group">
                                    <input type="text" name="registerFullName" class="form-control" placeholder="Full Name *" id="message" required data-validation-required-message="Please Enter Your Full Name.">
                                    <p class="help-block text-danger"></p>
                                </div>
                                <div class="form-group">
                                    <input type="text" name="registerLocation" class="form-control" placeholder="City, State *" id="message" required data-validation-required-message="Please Enter the City, State of Your Address.">
                                    <p class="help-block text-danger"></p>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <input type="password" name="registerPassword" class="form-control" placeholder="Password *" id="message" required data-validation-required-message="Please Enter Your Password.">
                                    <p class="help-block text-danger"></p>
                                </div>
                                <div class="form-group">
                                    <input type="text" name="registerPhone" class="form-control" placeholder="Phone Number (xxxyyyzzzz) *" id="message" required data-validation-required-message="Please Enter Your Phone Number.">
                                    <p class="help-block text-danger"></p>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                            <div class="text-center" align="center">
                                <div id="success"></div>
                                <button type="submit" class="btn btn-xl">Enter</button>
                                <div class="intro-lead-in"><br></br></div>
                            </div>
                        </div>
                    </form>





                </div>
            </div>

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

</html>
