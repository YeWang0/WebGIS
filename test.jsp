<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
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
  
  <body>
   <%
   
   String username = "admin";//(String)request.getParameter("username");  
		ArrayList sessionKey=new ArrayList<String>();
		ArrayList sessionKey2=new ArrayList<String>();
		int i,j;
		UserBeanCL uCl=new UserBeanCL();
	//	out.print(uCl.checkuser("admin1", "admin"));
		sessionKey=uCl.getmarkers(username);
		sessionKey2=uCl.gettrack(username);
	//	out.print(sessionKey);
	//	out.print("\n");
	//	out.print(sessionKey2);
		i=uCl.getI();
	//	out.print(i);
		j=uCl.getJ();
		
    %>
<script language="javascript">
 
	var list=new Array();
	getpoints(list);
	var PointsData=opData(list);
	
	var line=getline();
	alert(line[0]);
	function opData(list){
		var i=0;
		var result=new Array();
		var t;
	//	alert(list.length);
		for(var i=0;i<list.length;i++){
	
			result[i]=new Array();
		//	alert(list[i]);
			for(var j=0;j<5;j++){
			t=list[i].substring(0,list[i].indexOf('$'));
			list[i]=list[i].replace(t+"$","");
			result[i][j]=t;
			if(j==0){
				var a=t.indexOf('(');
				var b=t.indexOf(' ');
				var c=t.indexOf(')');
				result[i][j]=parseFloat(t.substring(a+1,b));
			//	alert(result[i][j]);
				result[i][j+1]=parseFloat(t.substring(b,c));
			//	alert(result[i][j+1]);
				j++;
			}	
			}
		//	alert(result[i]);
		}
		return result;
	}
	
	function getpoints(list){
	var p="<%=sessionKey%>";
	var n="<%=i%>";
	var i=n;
	p=p.replace("]",",");
	var a=p.indexOf(",");
	while(i>0){
		a=p.indexOf(",");
		list.push(p.substring(1,a));
		p=p.substring(a+1);
		i--;
		}
	}
	
	function getline(){
		var s="<%=sessionKey2%>";
		s=s.replace(")]",",)");
		s=s.replace("[MULTIPOINT(","");
		var x,y;
		var points=new Array();
		for(var i=0;s[0]!=')';i++){
			points[i]=new Array();
			x=s.indexOf(" ");
			y=s.indexOf(",");
			points[i][0]=s.substring(0,x);
			points[i][1]=s.substring(x+1,y);
			s=s.substring(y+1,s.length);
		}
		return points;
	}
    </script>
  </body>
</html>
