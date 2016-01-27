<%@page import="sqlOperation.UserBean"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>My JSP 'Userinfo.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>

    <%
    UserBean userBean=(UserBean)session.getAttribute("userinfo");
    
     %>
     
   
     <table border="1px" bordercolor="black">
      <tr>
     	<td width="90">用户名</td>
     	<td><%out.print( userBean.getName()); %></td>
     </tr>
     <tr>
     	<td>密码</td>
	     <td><%out.print(  userBean.getPassword()); %></td>
     </tr>
     <tr>
     	<td>性别</td>
	    <td><%out.print(  userBean.getSex()); %></td>
     </tr>
     <tr>
     	<td>年龄</td>
     	<td><%out.print(  userBean.getAge()); %></td>
     </tr>
     <tr>
     	<td>简历</td>
     	<td><%out.print(  userBean.getResume()); %></td>
     </tr>
      <tr>
     	<td>工作</td>
		<td><%out.print(  userBean.getJob()); %></td>
     </tr>
     </table>
    
     
  </body>
</html>
