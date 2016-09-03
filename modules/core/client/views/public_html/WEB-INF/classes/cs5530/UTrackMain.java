package cs5530;

import java.lang.*;
import java.sql.*;
import java.io.*;
import java.util.*;

public class UTrackMain {

	/**
	 * @param args
	 */
	public static void startMenu()
	{
		 System.out.println("        Welcome to the UTrack!     ");
		 System.out.println("        Please Register or Login    ");
    	 System.out.println("1. Register:");
    	 System.out.println("2. Login:");
    	 System.out.println("3. exit:");
    	 System.out.println("4. Bonus! Degrees of Separation:");
    	 System.out.println("Please Enter The Number of Your Choice Below:");
	}
	
	/**
	 * @param args
	 */
	public static void userMenu(String username)
	{
		 System.out.println("        Welcome " + username + "!     ");
		 System.out.println(" :::Options::: ");
    	 System.out.println("1. Search Points of Interests:");
    	 System.out.println("2. Useful Feedbacks:");
    	 System.out.println("3. Visits and Feedbacks:");
    	 System.out.println("4. Cross User Feedback:");
    	 System.out.println("5. Statistics:");
    	 System.out.println("6. Admin:");
    	 System.out.println("7. Log Out:");
    	 System.out.println("8. Exit:");
    	 System.out.println("Please Enter The Number of Your Choice Below:");
	}
	
	/**
	 * 
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		System.out.println("CS5530 Database Project");
		Connector con=null;
		
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
        
        Stack<String> visits= new Stack<String>();
        Stack<String> visitNames = new Stack<String>();
        
        Boolean loggedIn = false;
        Boolean visiting = false;
        Boolean admin = false;
        Boolean adminAccess = false;
        
        HashSet<String> admins = new HashSet<String>();
        admins.add("WildTurtle");
        admins.add("wildturtle");
        admins.add("WILDTURTLE");
        admins.add("Foodie");
        admins.add("foodie");
        admins.add("FOODIE");
        
        String sql=null;
        int c=0;
         try
		 {
			//remember to replace the password
			 	 con= new Connector();
	             System.out.println ("Database connection established");
	         
	             BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
	             
	             while(true)
	             {
	            	 
	            	 
	            	 if (!loggedIn) //If the user hasn't logged in
	            	 {
	            		 admin = false;
		            	 startMenu();
		            	 while ((choice = in.readLine()) == null && choice.length() == 0);
		            	 try{
		            		 c = Integer.parseInt(choice);
		            	 }catch (Exception e)
		            	 {
		            		 
		            		 continue;
		            	 }
		            	 if (c<1 | c>4)
		            		 continue;
		            	 if (c==1)
		            	 {
		            		 System.out.println("Username:");
		            		 while ((username = in.readLine()) == null && username.length() == 0);
		            		 System.out.println("Password:");
		            		 while ((password = in.readLine()) == null && password.length() == 0);
		            		 System.out.println("Full Name:");
		            		 while ((fullname = in.readLine()) == null && fullname.length() == 0);
		            		 System.out.println("Address (Format: City, State):");
		            		 while ((address = in.readLine()) == null && address.length() == 0);
		            		 System.out.println("Phone Number (10 Digits, No Hyphens, or Spaces):");
		            		 while ((pnumber = in.readLine()) == null && pnumber.length() == 0);
		            		 User user=new User();
		            		 if(user.register(username, password, fullname, address, pnumber, con.stmt))
		            		 {
		            			 System.out.println("You've been registered! Please login to continue.");
			            		 System.out.println(" ");
		            		 }
		            		 else
		            		 {
		            			 System.out.println("Username has already been taken. Please try again.");
			            		 System.out.println(" ");
		            		 }
		            	 }
		            	 else if (c==2)
		            	 {	 
		            		 System.out.println("Username:");
		            		 while ((username = in.readLine()) == null && username.length() == 0);
		            		 System.out.println("Password:");
		            		 while ((password = in.readLine()) == null && password.length() == 0);
		            		 User user=new User();
		            		 if(user.login(username, password, con.stmt))
		            		 {
		            			 System.out.println("You've been logged in as " + username);
			            		 System.out.println(" ");
		            			 loggedIn = true;
		            			 c=0;
		            		 }
		            		 else
		            		 {
		            			 System.out.println("Invalid username or password.");
			            		 System.out.println(" ");
		            		 }
		            	 }
		            	 else if (c==3)
		            	 {   
		            		 System.out.println("Never forget.");
		            		 con.stmt.close(); 
		        
		            		 break;
		            	 }
		            	 else
		            	 {
		            		 System.out.println("This tool can determine if two users have 1 or 2 degrees of separation.");
		            		 System.out.println("What are the two users? Format: login1, login2");
		            		 while ((address = in.readLine()) == null);
		            		 
		            		 User user = new User();
		            		 
	            			 String str2 = address;
	            			 String keywordList[] = str2.split(",");
		            		 
	            			 if(user.shareFavorites(keywordList[0], keywordList[1], con.stmt))
	            			 {
			            		 System.out.println("These two users have 1 degree of separation.");
	            			 }
	            			 else if (user.shareAnyFavorites(keywordList[0], keywordList[1], con.stmt))
	            			 {
	            				 System.out.println("These two users have 2 degrees of separation.");
	            			 }
	            			 else
	            			 {
	            				 System.out.println("These two users do not have 1 or 2 degrees of separation.");
	            			 }
	            			 
		            	 }
		             }
	            	 
	            	 
	            	 
	            	 else //LoggedIn
	            	 {
	            		 if (username != null)
	            		 {
	            			 if (admins.contains(username))
	            			 {
	            				 admin = true;
	            			 }

		            		 userMenu(username);
			            	 while ((choice = in.readLine()) == null && choice.length() == 0);
			            	 try{
			            		 c = Integer.parseInt(choice);
			            	 }catch (Exception e)
			            	 {
			            		 
			            		 continue;
			            	 }
			            	 
			            	 if (c<1 | c>8) //If the option isn't available, reiterate prompt
			            	 {
			            		 continue;
			            	 }
			            	 
			            	 if (c==1) //Search Points of Interest
			            	 {
			            		 int d = 0;
			            		 
			            		 System.out.println("To narrow down your search please answer the following questions.");
			            		 System.out.println("You may skip a question by pressing enter.");
			            		 System.out.println(" ");

			            		 System.out.println("What is the city OR state? (No abbreviations)");
			            		 while ((address = in.readLine()) == null);
			            		 System.out.println("Keywords? (keyword1, keyword2...)");
			            		 while ((keywords = in.readLine()) == null);
			            		 System.out.println("Categories? (category1, category2)");
			            		 while ((categories = in.readLine()) == null);
			            		 System.out.println("What is your minimum price? (Integer)");
			            		 while ((value1 = in.readLine()) == null);
			            		 System.out.println("What is your maximum price? (Integer)");
			            		 while ((value2 = in.readLine()) == null);
			            		 System.out.println("How would you like this info sorted?");
			            		 System.out.println("1: By Price");
			            		 System.out.println("2: By Score");
			            		 System.out.println("3: By Trusted Scores");
				            	 while ((choice = in.readLine()) == null && choice.length() == 0);
				            	 try{
				            		 d = Integer.parseInt(choice);
				            	 }catch (Exception e)
				            	 {
				            		 
				            		 continue;
				            	 }
				            	 
		            			 String select = "select name, price ";
		            			 String from = "FROM POI, Trust, Review ";
		            			 String where = "WHERE Review.ID=POI.ID ";
		            			 String groupBy = "Group By ";
			            		 
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
			            		 
			            		 if (d<1 || d>3)
			            		 {
			            			 continue;
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
		            			 
			            		 System.out.println("Generating points of interest...");
			            		 ResultSet rs=con.stmt.executeQuery(sql);
			            		 ResultSetMetaData rsmd = rs.getMetaData();
			            		 int numCols = rsmd.getColumnCount();
			            		 while (rs.next())
			            		 {
			            			 for (int i=1; i<=numCols;i++)
			            				 System.out.print(rs.getString(i)+"  ");
			            			 System.out.println("");
			            		 }
			            		 System.out.println(" ");
			            		 rs.close();
			            	 }
			            	 
			            	 else if (c==2) //Useful feedbacks
			            	 {
			            		 int d = 0;
			            		 
			            		 System.out.println("This will return the the most useful feedbacks/reviews.");
			            		 System.out.println("You may skip a question by pressing enter.");
			            		 System.out.println(" ");

			            		 System.out.println("How many would you like to display?");
				            	 while ((choice = in.readLine()) == null && choice.length() == 0);
				            	 try{
				            		 d = Integer.parseInt(choice);
				            	 }catch (Exception e)
				            	 {
				            		 
				            		 continue;
				            	 }
				            	 
		            			 String select = "select Thoughts, DateTime, Score, ID, Review.Login, Usefulness ";
		            			 String from = "FROM Review, Feedback ";
		            			 String where = "WHERE Review.RID=Feedback.RID ";
		            			 String groupBy = "Order By Usefulness DESC;";
			            		 
			            		 
			            		 sql = select+from+where+groupBy;
		            			 
			            		 System.out.println("Generating points of interest...");
			            		 ResultSet rs=con.stmt.executeQuery(sql);
			            		 ResultSetMetaData rsmd = rs.getMetaData();
			            		 int numCols = rsmd.getColumnCount();
			            		 int count = 0;
			            		 while (rs.next())
			            		 {
			            			 for (int i=1; i<=numCols;i++)
			            				 System.out.print(rs.getString(i)+"  ");
			            			 System.out.println("");
			            			 count++;
			            			 if (count == d)
			            			 {
			            				 break;
			            			 }
			            		 }
			            		 System.out.println(" ");
			            		 rs.close();
			            	 }
			            	 
			            	 else if (c==3) //Visits and Feedbacks
			            	 {
			            	     int d=0;
			            		 String f="";
			            		 visiting = true;
			            		 while (visiting)
			            		 {
				            		 System.out.println("Options:");
				            		 
				            		 System.out.println("1. Existing Points of Interest");
				            		 System.out.println("2. Give a review/feedback.");
				            		 System.out.println("3. Rate a review/feedback.");
				            		 System.out.println("4. Declare Favorites Here!");
				            		 System.out.println("5. Add to Visited (Must confirm below before final submission)");
				            		 System.out.println("6. Confirm and Submit Visits");
				            		 System.out.println("7. Return to User Menu");
				                	 System.out.println("Please Enter The Number of Your Choice Below:");
					            	 while ((choice = in.readLine()) == null && choice.length() == 0);
					            	 try{
					            		 d = Integer.parseInt(choice);
					            	 }catch (Exception e)
					            	 {
					            		 continue;
					            	 }
					            	 
					            	 if (d<1 | d>7) //If the option isn't available, reiterate prompt
					            	 {
					            		 continue;
					            	 }
					            	 
					            	 if (d==1) //Existing Points of Interest
					            	 {
					            		 System.out.println("Generating current points of interest...");
					            		 sql= "select Name from POI";
					            		 ResultSet rs=con.stmt.executeQuery(sql);
					            		 ResultSetMetaData rsmd = rs.getMetaData();
					            		 int numCols = rsmd.getColumnCount();
					            		 while (rs.next())
					            		 {
					            			 for (int i=1; i<=numCols;i++)
					            				 System.out.print(rs.getString(i)+"  ");
					            			 System.out.println("");
					            		 }
					            		 System.out.println(" ");
					            		 rs.close();
					            	 }
					            	 
					            	 else if (d==2)  //Provide feedback
					            	 {
					            		 System.out.println("Which point would you like to review?");
					            		 while ((point = in.readLine()) == null && point.length() == 0);
					            		 User user=new User();
					            		 String pointID = user.isPOI(username, point, con.stmt);
					            		 String name = point;
					            		 if(pointID.length() > 0 && !user.hasBeenReviewed(username, pointID, con.stmt))
					            		 { 
					            			 System.out.println("Please tell us about it!");
					            			 System.out.println("");
						            		 System.out.println("Thoughts? (Optional, Leave Blank to Skip)");
						            		 while ((thoughts = in.readLine()) == null);
						            		 System.out.println("Date (YYYY-MM-DD HH:MM:SS)");
						            		 while ((date = in.readLine()) == null && date.length() == 0);
						            		 System.out.println("Score? (0-10)");
						            		 while ((score = in.readLine()) == null && score.length() == 0);		            		 
						            		 
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
					            			 
					            			 System.out.println("POI has been reviewed by you.");
						            		 System.out.println(" ");

					            			 
					            		 }
					            		 else
					            		 {
					            			 System.out.println("Not a valid POI name or you've already reviewed this point.");
						            		 System.out.println(" ");
					            		 }
					            	 }
					            	 
					            	 else if (d==3) //Rate a review
					            	 {
					            		 System.out.println("What is the ID of the review you would like to rate?");
					            		 while ((reviewID = in.readLine()) == null && reviewID.length() == 0);
					            		 User user=new User();
					            		 if(user.isReview(username, reviewID, con.stmt))
					            		 { 
						            		 System.out.println("Usefulness? (0, 1, 2 with 2 being very useful)");
						            		 while ((score = in.readLine()) == null && score.length() == 0);		            		 
						            		 
					            			 String point2 = "insert into Feedback (Login, RID, Usefulness) "
					            					 + "VALUES ('" + username + "', '" + reviewID + "', " + score + ")";					     			    	 
					     			    	 
					            			 Stack<String> tempStack = new Stack<String>();
					            			 
					            			 tempStack.add(point2);
					            			 
						            		 if (user.addStack(username, tempStack, con.stmt))
						            		 {
						            			 tempStack.clear();
						            		 }
					            			 
					            			 System.out.println("You've given feedback on a review.");
						            		 System.out.println(" ");

					            			 
					            		 }
					            		 else
					            		 {
					            			 System.out.println("Not a valid review ID. (You cannot review non-existing or your own reviews.");
						            		 System.out.println(" ");
					            		 }
					            	 }
					            	 
					            	 else if (d==4)  //(Declare Favorites Here!)
					            	 {
					            		 System.out.println("Which point is your favorite?");
					            		 while ((point = in.readLine()) == null && point.length() == 0);
					            		 User user=new User();
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
					            			 
					            			 System.out.println(name + " has been favorited.");
						            		 System.out.println(" ");
					            			 
					            		 }
					            		 else
					            		 {
					            			 System.out.println("Not a valid POI name.");
						            		 System.out.println(" ");
					            		 }
					            	 }
					            	 
					            	 else if (d==5) //Add to Visited (Must confirm below before final submission)
					            	 {				            		 
					            		 System.out.println("Which point have you visited?");
					            		 while ((point = in.readLine()) == null && point.length() == 0);
					            		 User user=new User();
					            		 String pointID = user.isPOI(username, point, con.stmt);
					            		 visitNames.push(pointID);
					            		 if(pointID.length() > 0)
					            		 {
					            			 System.out.println("Please tell us about it!...or press enter to skip any of the questions.");
					            			 System.out.println("");
						            		 System.out.println("How much did it cost? (Integers)");
						            		 while ((cost = in.readLine()) == null);
						            		 System.out.println("When did you visit? (YYYY-MM-DD HH:MM:SS)");
						            		 while ((date = in.readLine()) == null);
						            		 System.out.println("How big was your party?");
						            		 while ((partySize = in.readLine()) == null);
						            		 
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
					            			 System.out.println("Added to the list! Please confirm to submit.");
						            		 System.out.println(" ");
					            		 }
					            		 else
					            		 {
					            			 System.out.println("Not a valid POI name.");
						            		 System.out.println(" ");
					            		 }
					            	 }
					            	 
					            	 else if (d==6) //Confirm and Submit Visits
					            	 {
					            		 if (!visits.isEmpty())
					            		 {
						            		 System.out.println("Would you like to submit these visits? (y/n)");
						            		 Stack<String> tempVisits = new Stack<String>();
						            		 while (!visits.isEmpty())
						            		 {
						            			 String nPoint = visits.pop();
						            			 System.out.println(nPoint);
						            			 tempVisits.push(nPoint);
						            		 }
						            		 
							            	 while ((choice = in.readLine()) == null && choice.length() == 0);
							            	 try{
							            		 f = choice;
							            	 }catch (Exception e)
							            	 {
							            		 continue;
							            	 }							           
							            	 
							            	 if (f.equals("y")) //Yes
							            	 {
							            		 System.out.println("Retrieving a list of suggestions...");
							            		 User user=new User();
							            		 if (user.addStack(username, tempVisits, con.stmt))
							            		 {
							            			 visits.clear();
							            		 }							            		
						            			 
						            			 while (!visitNames.isEmpty())
						            			 {
							            			 String select = "select Name, Count(visit.Login) ";
							            			 String from = "FROM POI, Visited visit ";
							            			 String where = "WHERE POI.ID=visit.ID "
							            			 		+ "AND visit.Login=ANY(select V.Login "
							            			 		+ "From Visited V "
							            			 		+ "Where V.login != '" +username+ "' "
							            			 				+ "AND V.ID ='" +visitNames.pop()+ "') ";
							            			 String groupBy = "Order By Count(visit.Login) DESC;";
								            		 
								            		 
								            		 sql = select+from+where+groupBy;
							            			 
								            		 System.out.println("Retrieving a list of suggestions...");
								            		 ResultSet rs=con.stmt.executeQuery(sql);
								            		 ResultSetMetaData rsmd = rs.getMetaData();
								            		 int numCols = rsmd.getColumnCount();
								            		 int count = 0;
								            		 while (rs.next())
								            		 {
								            			 for (int i=1; i<=numCols;i++)
								            				 System.out.print(rs.getString(i)+"  ");
								            			 System.out.println("");
								            			 count++;
								            			 if (count == d)
								            			 {
								            				 break;
								            			 }
								            		 }
								            		 System.out.println(" ");
								            		 rs.close();
						            			 }

							            		 
							            	 }
							            	 
							            	 else if (f.equals("n")) //No
							            	 {
							            		 visits = tempVisits;
							            		 System.out.println("Visits not saved.");
							            		 continue;
							            	 }
							            	 else
							            	 {
							            		 visits = tempVisits;
							            		 System.out.println("Invalid Input. Visits not saved.");
							            		 continue;
							            	 }
					            		 }
					            		 else
					            		 {
					            			 System.out.println("No unsaved visits.");
					            			 System.out.println("");
					            		 }
					            	 }
					            	 
					            	 else //Return to User Menu
					            	 {
					            		 if (!visits.isEmpty())
					            		 {
						            		 System.out.println("Unsaved visits! Are you sure you want to continue? (y/n)");
							            	 while ((choice = in.readLine()) == null && choice.length() == 0);
							            	 try{
							            		 f = choice;
							            	 }catch (Exception e)
							            	 {
							            		 continue;
							            	 }							           
							            	 
							            	 if (f.equals("y")) //Yes
							            	 {
							            		 visits.clear();
							            		 visitNames.clear();
							            		 f="";
							            		 visiting = false;
							            	 }
							            	 
							            	 else if (f.equals("n")) //No
							            	 {
							            		 f="";
							            		 continue;
							            	 }
							            	 else
							            	 {
							            		 f = "";
							            		 continue;
							            	 }
					            		 }
					 
					            		 visiting = false;
					            	 }
			            		 }
			            		 
			            	 }			            	 
			            	 
			            	 else if (c==4) //Cross User Feedback
			            	 {
			            		 System.out.println("Which user are you reviewing?");
			            		 while ((chosenName = in.readLine()) == null && chosenName.length() == 0);
			            		 User user=new User();
			            		 if(user.isUser(chosenName, con.stmt))
			            		 {						            			 
			            			 System.out.println("What would you rate " + chosenName + "? (trusted or not-trusted)");
				            		 while ((score = in.readLine()) == null && score.length() == 0);			            		 
				            		 
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
			            			 
			            			 System.out.println("Trust Recorded.");
				            		 System.out.println(" ");
			            		 }
			            		 else
			            		 {
			            			 System.out.println("User does not exist.");
				            		 System.out.println(" ");
			            		 }
			            	 }
			            	 
			            	 else if (c==5) //Statistics
			            	 {
			            		 int d = 0;
			            		 
			            		 System.out.println("Options:");
			            		 System.out.println("1. Most Popular POIs for a Category");
			            		 System.out.println("2. Most Expensive POIs for a Category");
			            		 System.out.println("3. Most Highly Rated POIs for a Category");
			                	 System.out.println("Please Enter The Number of Your Choice Below:");
				            	 while ((choice = in.readLine()) == null && choice.length() == 0);
				            	 try{
				            		 d = Integer.parseInt(choice);
				            	 }catch (Exception e)
				            	 {
				            		 continue;
				            	 }
				            	 
			                	 System.out.println("For which category?");
				            	 while ((choice = in.readLine()) == null && choice.length() == 0);
				            	 
		            			 String select = "select POI.Name, POI.Categories ";
		            			 String from = "FROM POI, Visited ";
		            			 String where = "WHERE POI.ID=Visited.ID AND POI.Categories LIKE '%" + choice + "%' ";
		            			 String groupBy = "Group By POI.Categories ";
		            			 String orderBy = "Order By avg(score) DESC;";
			            		 
				            	 
				            	 if (d<1 || d>3)
				            	 {
				            		 continue;
				            	 }
				            	 if (d==1)
				            	 {
			            			 select = "select POI.Name, POI.Categories ";
			            			 from = "FROM POI, Visited ";
			            			 where = "WHERE POI.ID=Visited.ID AND POI.Categories LIKE '%" + choice + "%' ";
			            			 groupBy = "Group By POI.Categories, Visited.Login ";
			            			 orderBy = "Order By Count(Visited.Login) DESC;";
				            	 }
				            	 else if (d==2)
				            	 {
			            			 select = "select POI.Name, POI.Categories, Visited.Cost ";
			            			 from = "FROM POI, Visited ";
			            			 where = "WHERE POI.ID=Visited.ID AND POI.Categories LIKE '%" + choice + "%' ";
			            			 groupBy = "Group By POI.Categories, Visited.Cost ";
			            			 orderBy = "Order By avg(Visited.Cost) DESC;";
				            	 }
				            	 else
				            	 {
			            			 select = "select POI.Name, POI.Categories ";
			            			 from = "FROM POI, Review ";
			            			 where = "WHERE POI.ID=Review.ID AND POI.Categories LIKE '%" + choice + "%' ";
			            			 groupBy = "Group By POI.Categories ";
			            			 orderBy = "Order By avg(Review.Score) DESC;";
				            	 }
				            	 
			            		 sql = select+from+where+groupBy+orderBy;
		            			 
			            		 System.out.println("Generating points of interest...");
			            		 ResultSet rs=con.stmt.executeQuery(sql);
			            		 ResultSetMetaData rsmd = rs.getMetaData();
			            		 int numCols = rsmd.getColumnCount();
			            		 int count = 0;
			            		 while (rs.next())
			            		 {
			            			 for (int i=1; i<=numCols;i++)
			            				 System.out.print(rs.getString(i)+"  ");
			            			 System.out.println("");
			            			 count++;
			            			 if (count == d)
			            			 {
			            				 break;
			            			 }
			            		 }
			            		 System.out.println(" ");
			            		 rs.close();
			            		 System.out.println("Returning to main menu...");
			            	 }
			            	 
			            	 else if (c==6) //Admin
			            	 {
			            		 if (admin)
			            		 {
			            			 int d=0;
			            			 String f="";
			            			 adminAccess = true;
			            			 while(adminAccess)
			            			 {
			            				 
					            		 System.out.println("Options:");
					            		 System.out.println("1. Existing Points of Interest");
					            		 System.out.println("2. Update POI");
					            		 System.out.println("3. Add New POI");
					            		 System.out.println("4. Most Trusted Users");
					            		 System.out.println("5. Most Useful Users");
					            		 System.out.println("6. Return to User Menu");
					                	 System.out.println("Please Enter The Number of Your Choice Below:");
						            	 while ((choice = in.readLine()) == null && choice.length() == 0);
						            	 try{
						            		 d = Integer.parseInt(choice);
						            	 }catch (Exception e)
						            	 {
						            		 continue;
						            	 }
						            	 
						            	 if (d<1 | d>6) //If the option isn't available, reiterate prompt
						            	 {
						            		 continue;
						            	 }
						            	 
						            	 if (d==1) //Existing Points of Interest
						            	 {
						            		 System.out.println("Generating current points of interest...");
						            		 sql= "select Name from POI";
						            		 ResultSet rs=con.stmt.executeQuery(sql);
						            		 ResultSetMetaData rsmd = rs.getMetaData();
						            		 int numCols = rsmd.getColumnCount();
						            		 while (rs.next())
						            		 {
						            			 for (int i=1; i<=numCols;i++)
						            				 System.out.print(rs.getString(i)+"  ");
						            			 System.out.println("");
						            		 }
						            		 System.out.println(" ");
						            		 rs.close();
						            	 }
						            	 
						            	 else if (d==2) //Update POI
						            	 {
						            		 System.out.println("What is the name of the POI?");
						            		 while ((point = in.readLine()) == null && point.length() == 0);
						            		 User user=new User();
						            		 String pointID = user.isPOI(username, point, con.stmt);
						            		 if(pointID.length() != 0)
						            		 {						            			 
						            			 System.out.println("Please let us know what you would like to update!...or press enter to skip any of the questions.");
						            			 System.out.println("");
							            		 System.out.println("Where are they? (City, Non-Abbreviated State Name)");
							            		 while ((address = in.readLine()) == null);
							            		 System.out.println("New website? (URL)");
							            		 while ((website = in.readLine()) == null);
							            		 System.out.println("New phone number?");
							            		 while ((pnumber = in.readLine()) == null);
							            		 System.out.println("Year established? (YYYY)");
							            		 while ((year = in.readLine()) == null);
							            		 System.out.println("New hours? (H-H)");
							            		 while ((hours = in.readLine()) == null);
							            		 System.out.println("New Approximate Price? (0-100)");
							            		 while ((price = in.readLine()) == null);
							            		 System.out.println("New Keywords? (Keyword1, Keyword2,...)");
							            		 while ((keywords = in.readLine()) == null);
							            		 System.out.println("New Categories? (Category1, Category2...)");
							            		 while ((categories = in.readLine()) == null);
							            		 
							            		 
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
								            		 ResultSet rs=con.stmt.executeQuery(sql);
								            		 while (rs.next())
								            		 {
								            			 keywords += ", " + rs.getString("Keywords");
								            		 }
								            		 System.out.println(" ");
								            		 rs.close();
								            		 
							            			 point += ", Keywords='" + keywords + "'";
							            		 }
							            		 if (categories.length() != 0)
							            		 {
							            			 sql="select Categories from POI where Name='" + point + "' ";
								            		 ResultSet rs=con.stmt.executeQuery(sql);
								            		 while (rs.next())
								            		 {
								            			 keywords += ", " + rs.getString("Categories");
								            		 }
								            		 System.out.println(" ");
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
						            			 
						            			 System.out.println("POI has been updated.");
							            		 System.out.println(" ");
						            		 }
						            		 else
						            		 {
						            			 System.out.println("Information provided was not valid.");
							            		 System.out.println(" ");
						            		 }
						            	 }
						            	 
						            	 else if (d==3) //Add to POI
						            	 {
						            		 System.out.println("What is the name of the POI?");
						            		 while ((point = in.readLine()) == null && point.length() == 0);
						            		 User user=new User();
						            		 String pointID = user.isPOI(username, point, con.stmt);
						            		 if(pointID.length() == 0)
						            		 {				            			 
						            			 System.out.println("Please tell us about it!...or press enter to skip any of the questions.");
						            			 System.out.println("");
							            		 System.out.println("Where are they? (City, Non-Abbreviated State Name)");
							            		 while ((address = in.readLine()) == null);
							            		 System.out.println("Do they have a website? (URL)");
							            		 while ((website = in.readLine()) == null);
							            		 System.out.println("Do they have a phone number?");
							            		 while ((pnumber = in.readLine()) == null);
							            		 System.out.println("Year established? (YYYY)");
							            		 while ((year = in.readLine()) == null);
							            		 System.out.println("What are their hours? (H-H)");
							            		 while ((hours = in.readLine()) == null);
							            		 System.out.println("Approximate Price? (0-100)");
							            		 while ((price = in.readLine()) == null);
							            		 System.out.println("Keywords? (Keyword1, Keyword2,...)");
							            		 while ((keywords = in.readLine()) == null);
							            		 System.out.println("Categories? (Category1, Category2...)");
							            		 while ((categories = in.readLine()) == null);
							            		 
							            		 
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
						            			 
						            			 System.out.println("POI has been added.");
							            		 System.out.println(" ");
						            		 }
						            		 else
						            		 {
						            			 System.out.println("Information provided was not valid.");
							            		 System.out.println(" ");
						            		 }
						            	 }
						            	 
						            	 else if(d==4) //Most trusted
						            	 {
					            			 String select = "select T1.Login2 ";
					            			 String from = "FROM Trust T1, Trust T2 ";
					            			 String where = "WHERE T1.Login2=T2.Login2 AND T1.Trusted!=T2.Trusted ";
					            			 String groupBy = "Group By T1.Trusted ";
					            			 String orderBy = "Order By Count(T1.Trusted) DESC;";
					            			 
						            		 sql = select+from+where+groupBy+orderBy;
						            		 
						            		 System.out.println("Generating most trusted users...");
						            		 ResultSet rs=con.stmt.executeQuery(sql);
						            		 ResultSetMetaData rsmd = rs.getMetaData();
						            		 int numCols = rsmd.getColumnCount();
						            		 while (rs.next())
						            		 {
						            			 for (int i=1; i<=numCols;i++)
						            				 System.out.print(rs.getString(i)+"  ");
						            			 System.out.println("");
						            		 }
						            		 System.out.println(" ");
						            		 rs.close();
						            	 }
						            	 
						            	 else if(d==5) //Most Useful
						            	 {
					            			 String select = "select Feedback.Login ";
					            			 String from = "FROM Feedback ";
					            			 String groupBy = "Group By avg(Feedback.Usefulness) ";
					            			 String orderBy = "Order By avg(Feedback.Usefulness) DESC;";
					            			 
						            		 sql = select+from+groupBy+orderBy;
						            		 
						            		 System.out.println("Generating most useful users...");
						            		 ResultSet rs=con.stmt.executeQuery(sql);
						            		 ResultSetMetaData rsmd = rs.getMetaData();
						            		 int numCols = rsmd.getColumnCount();
						            		 while (rs.next())
						            		 {
						            			 for (int i=1; i<=numCols;i++)
						            				 System.out.print(rs.getString(i)+"  ");
						            			 System.out.println("");
						            		 }
						            		 System.out.println(" ");
						            		 rs.close();
						            	 }
						            	 
						            	 else
						            	 {
						            		 adminAccess = false;
						            	 }
			            				 
			            			 }
			            		 }
			            		 else
			            		 {
			            			 System.out.println("Administrative Access Only.");
			            			 System.out.println(" ");
			            		 }
			            	 }
			            	 else if (c==7) //Logout
			            	 {
			            		 loggedIn = false;
			            		 username = "";
			            		 c=0;
			            	 }
			            	 else //Exit
			            	 {
			            		 System.out.println("Never forget.");
			            		 con.stmt.close(); 
			        
			            		 break;
			            	 }
	            		 }

	            	 }
	            	 
	            	 
	            	 
	             }
		 }
         catch (Exception e)
         {
        	 e.printStackTrace();
        	 System.err.println ("Either connection error or query execution error!");
         }
         finally
         {
        	 if (con != null)
        	 {
        		 try
        		 {
        			 con.closeConnection();
        			 System.out.println ("Database connection terminated");
        		 }
        	 
        		 catch (Exception e) { /* ignore close errors */ }
        	 }	 
         }
	}
}