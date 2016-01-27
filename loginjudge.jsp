<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="sqlOperation.*"%> 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
 <%
 	String u=request.getParameter("username");
 	String p=request.getParameter("password");
 	UserBeanCL userBeanCL=new UserBeanCL();
	if(userBeanCL.checkuser(u,p)){
	UserBean userBean=userBeanCL.getUserInfo(u);

		session.setAttribute("userinfo",userBean);
		session.setAttribute("username", u);
		response.sendRedirect("Main.jsp?username="+u);
	} else{
		response.sendRedirect("login.html?fail to log in!");	
	}
 
 
  %>
</html>
