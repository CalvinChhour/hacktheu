package cs5530;

import java.sql.*;
import java.util.*;

public class User {
		public User()
		{}
		
		/**
		 * 
		 * @param username
		 * @param password
		 * @param fullname
		 * @param address
		 * @param pnumber
		 * @param stmt
		 * @return
		 */
		public Boolean register(String username, String password, String fullname, String address, String pnumber, Statement stmt)
		{
			Connector connect = new Connector();

			

			String sql="select login from User where login='" + username + "'";
			String output="";
			ResultSet rs=null;
			Boolean registered = false;
   		 	System.out.println("Verifying if "+ username +" has been taken.");
   		 	try{
	   		 	rs=stmt.executeQuery(sql);
	   		 	while (rs.next())
				{
				//System.out.print("cname:");
				   output+=rs.getString("login")+"\n"; 
				}
			     
			    rs.close();
			     
			    if (output.length() == 0)
			    {
			    	sql = "insert into User (Login, Password, FullName, Address, PhoneNumber)"
			    			+ "VALUES ('" + username + "','" + password + "','" + fullname + "','" + address + "',"
			    			 + pnumber + ");";
			    	if (stmt.executeUpdate(sql) > 0)
			    	{
				   		registered = true;	
			    	}
			    }
			    else
			    {
			    	registered = false;
			    }
   		 	}
   		 	catch(Exception e)
   		 	{
   		 		System.out.println("Address or PhoneNumber was invalid. Please try again.");
   		 	}
   		 	finally
   		 	{
   		 		try{
	   		 		if (rs!=null && !rs.isClosed())
	   		 			rs.close();
   		 		}
   		 		catch(Exception e)
   		 		{
   		 			System.out.println("cannot close resultset");
   		 		}
   		 	}
		    return registered;
		}
		
		public Boolean isUser(String username, Statement stmt)
		{
			String sql="select login from User where login='" + username + "'";
			String output="";
			ResultSet rs=null;
   		 	System.out.println("Verifying if "+ username +" exists.");
   		 	try{
	   		 	rs=stmt.executeQuery(sql);
	   		 	while (rs.next())
				{
				//System.out.print("cname:");
				   output+=rs.getString("login")+"\n"; 
				}
			     
			    rs.close();
			     
			    if (output.length() == 0)
			    {
			    	return false;
			    }
			    else
			    {
			    	return true;
			    }
   		 	}
   		 	catch(Exception e)
   		 	{
   		 		System.out.println("Address or PhoneNumber was invalid. Please try again.");
   		 	}
   		 	finally
   		 	{
   		 		try{
	   		 		if (rs!=null && !rs.isClosed())
	   		 			rs.close();
   		 		}
   		 		catch(Exception e)
   		 		{
   		 			System.out.println("cannot close resultset");
   		 		}
   		 	}
		    return false;
		}
		
		/**
		 * 
		 * @param username
		 * @param password
		 * @param stmt
		 * @return
		 */
		public Boolean login(String username, String password, Statement stmt)
		{
			String sql="select login from User where login='" + username + "' AND password='" + password + "'";
			String output="";
			ResultSet rs=null;
			Boolean loggedIn = false;
   		 	System.out.println("Verifying "+sql);
   		 	try{
	   		 	rs=stmt.executeQuery(sql);
	   		 	while (rs.next())
				{
				   output+=rs.getString("login")+"\n"; 
				}
			     
			    rs.close();
			     
			    if (output.length() != 0)
			    {
			   		loggedIn = true;	    	 
			    }
			    else
			    {
			    	loggedIn = false;
			    }
   		 	}
   		 	catch(Exception e)
   		 	{
   		 		System.out.println("cannot execute the query");
   		 	}
   		 	finally
   		 	{
   		 		try{
	   		 		if (rs!=null && !rs.isClosed())
	   		 			rs.close();
   		 		}
   		 		catch(Exception e)
   		 		{
   		 			System.out.println("cannot close resultset");
   		 		}
   		 	}
		    return loggedIn;
		}
		
		/**
		 * 
		 * @param username
		 * @param POI
		 * @param stmt
		 * @return
		 */
		public String isPOI(String username, String POI, Statement stmt)
		{
			String sql="select ID from POI where Name='" + POI + "';";
			String output="";
			ResultSet rs=null;
   		 	System.out.println("Verifying "+sql);
   		 	try{
	   		 	rs=stmt.executeQuery(sql);
	   		 	while (rs.next())
				{
				   output+=rs.getString("ID"); 
				}
			     
			    rs.close();
			     
			    if (output.length() != 0)
			    {
			   		return output;	    	 
			    }
			    else
			    {
			    	output = "";
			    	return output;
			    }
   		 	}
   		 	catch(Exception e)
   		 	{
   		 		System.out.println("Cannot execute the query");
   		 	}
   		 	finally
   		 	{
   		 		try{
	   		 		if (rs!=null && !rs.isClosed())
	   		 			rs.close();
   		 		}
   		 		catch(Exception e)
   		 		{
   		 			System.out.println("Cannot close resultset");
   		 		}
   		 	}
   		 	return output;
		}
		
		
		/**
		 * 
		 * @param username
		 * @param POI
		 * @param stmt
		 * @return
		 */
		public Boolean addStack(String username, Stack<String> POI, Statement stmt)
		{
			String sql="";
			Boolean added = false;
   		 	System.out.println("Scottie is beaming your data.");
   		 	try{
		    	while (!POI.isEmpty())
		    	{
		    		sql = POI.pop();
			    	if (stmt.executeUpdate(sql) > 0)
			    	{
				   		added = true;	
			    	}
		    	}
   		 	}
   		 	catch(Exception e)
   		 	{
   		 		System.out.println("Unable to upload.");
   		 	}
   		 	finally
   		 	{
   		 		return added;
   		 	}
		}
		
		
		/**
		 * 
		 * @param username
		 * @param POI
		 * @param stmt
		 * @return
		 */
		public Boolean hasBeenReviewed(String username, String pointID, Statement stmt)
		{
			String sql="select login from Review where ID=" + pointID + " AND login='"+ username +"';";
			String output="";
			ResultSet rs=null;
   		 	System.out.println("Verifying "+sql);
   		 	try{
	   		 	rs=stmt.executeQuery(sql);
	   		 	while (rs.next())
				{
				   output+=rs.getString("login"); 
				}
			     
			    rs.close();
			     
			    if (output.length() != 0)
			    {
			   		return true;	    	 
			    }
			    else
			    {
			    	output = "";
			    	return false;
			    }
   		 	}
   		 	catch(Exception e)
   		 	{
   		 		System.out.println("Cannot execute the query");
   		 	}
   		 	finally
   		 	{
   		 		try{
	   		 		if (rs!=null && !rs.isClosed())
	   		 			rs.close();
   		 		}
   		 		catch(Exception e)
   		 		{
   		 			System.out.println("Cannot close resultset");
   		 		}
   		 	}
   		 	return false;
		}
		
		/**
		 * 
		 * @param username
		 * @param POI
		 * @param stmt
		 * @return
		 */
		public Boolean feedBackExists(String username, String chosenName, Statement stmt)
		{
			String sql="select login from Trust where Login=" + username + " AND Login2='"+ chosenName +"';";
			String output="";
			ResultSet rs=null;
   		 	System.out.println("Verifying "+sql);
   		 	try{
	   		 	rs=stmt.executeQuery(sql);
	   		 	while (rs.next())
				{
				   output+=rs.getString("login"); 
				}
			     
			    rs.close();
			     
			    if (output.length() != 0)
			    {
			   		return true;	    	 
			    }
			    else
			    {
			    	output = "";
			    	return false;
			    }
   		 	}
   		 	catch(Exception e)
   		 	{
   		 		System.out.println("Cannot execute the query");
   		 	}
   		 	finally
   		 	{
   		 		try{
	   		 		if (rs!=null && !rs.isClosed())
	   		 			rs.close();
   		 		}
   		 		catch(Exception e)
   		 		{
   		 			System.out.println("Cannot close resultset");
   		 		}
   		 	}
   		 	return false;
		}
		
		/**
		 * 
		 * @param username
		 * @param POI
		 * @param stmt
		 * @return
		 */
		public Boolean isReview(String username, String reviewID, Statement stmt)
		{
			String sql="select login from Review where RID=" + reviewID + " AND login!='"+ username +"';";
			String output="";
			ResultSet rs=null;
   		 	System.out.println("Verifying "+sql);
   		 	try{
	   		 	rs=stmt.executeQuery(sql);
	   		 	while (rs.next())
				{
				   output+=rs.getString("login"); 
				}
			     
			    rs.close();
			     
			    if (output.length() != 0)
			    {
			   		return true;	    	 
			    }
			    else
			    {
			    	output = "";
			    	return false;
			    }
   		 	}
   		 	catch(Exception e)
   		 	{
   		 		System.out.println("Cannot execute the query");
   		 	}
   		 	finally
   		 	{
   		 		try{
	   		 		if (rs!=null && !rs.isClosed())
	   		 			rs.close();
   		 		}
   		 		catch(Exception e)
   		 		{
   		 			System.out.println("Cannot close resultset");
   		 		}
   		 	}
   		 	return false;
		}
		
		/**
		 * 
		 * @param username
		 * @param POI
		 * @param stmt
		 * @return
		 */
		public Boolean shareFavorites(String login1, String login2, Statement stmt)
		{
			String sql="select f1.pid from Favorites f1, Favorites f2 where f1.pid=f2.pid AND f1.Login='" + login1 + "' AND f2.Login='"+ login2 +"';";
			String output="";
			ResultSet rs=null;
   		 	System.out.println("Verifying "+sql);
   		 	try{
	   		 	rs=stmt.executeQuery(sql);
	   		 	while (rs.next())
				{
				   output+=rs.getString("login"); 
				}
			     
			    rs.close();
			     
			    if (output.length() != 0)
			    {
			   		return true;	    	 
			    }
			    else
			    {
			    	output = "";
			    	return false;
			    }
   		 	}
   		 	catch(Exception e)
   		 	{
   		 		System.out.println("Cannot execute the query");
   		 	}
   		 	finally
   		 	{
   		 		try{
	   		 		if (rs!=null && !rs.isClosed())
	   		 			rs.close();
   		 		}
   		 		catch(Exception e)
   		 		{
   		 			System.out.println("Cannot close resultset");
   		 		}
   		 	}
   		 	return false;
		}
		
		/**
		 * 
		 * @param username
		 * @param POI
		 * @param stmt
		 * @return
		 */
		public Boolean shareAnyFavorites(String login1, String login2, Statement stmt)
		{
			String sql="select f3.Login "
					+ "from Favorites f1, Favorites f2, Favorites f3 "
					+ "where f1.pid=f2.pid AND f2.pid=f3.pid "
					+ "AND f1.Login='" + login1 + "' "
						+ "AND f2.Login='" + login2 + "' "
						+ "AND f3.Login!='" + login1 + "' "
							+ "AND f3.Login!='"+ login2 +"';";
			String output="";
			ResultSet rs=null;
   		 	System.out.println("Verifying "+sql);
   		 	try{
	   		 	rs=stmt.executeQuery(sql);
	   		 	while (rs.next())
				{
				   output+=rs.getString("login"); 
				}
			     
			    rs.close();
			     
			    if (output.length() != 0)
			    {
			   		return true;	    	 
			    }
			    else
			    {
			    	output = "";
			    	return false;
			    }
   		 	}
   		 	catch(Exception e)
   		 	{
   		 		System.out.println("Cannot execute the query");
   		 	}
   		 	finally
   		 	{
   		 		try{
	   		 		if (rs!=null && !rs.isClosed())
	   		 			rs.close();
   		 		}
   		 		catch(Exception e)
   		 		{
   		 			System.out.println("Cannot close resultset");
   		 		}
   		 	}
   		 	return false;
		}
}
