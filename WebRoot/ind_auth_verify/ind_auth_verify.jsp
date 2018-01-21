<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'getDyn.jsp' starting page</title>
    
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
    <div align="center">
	<h1>卡信息验证(发不发送验证码是在mas后台控制)</h1>
		<form action="ind_auth_verify/ind_auth_verify_post.jsp" method="post">
		<table border="1">
		<tr>
			<td>商户编号（merchantId）</td>
			<td><input type="text" name="merchantId" value="104110045112012" /></td>
		  </tr>
		<tr>
			<td>终端号（terminalId）</td>
			<td><input type="text" name="terminalId" value="00002012" /></td>
		  </tr>	
		<tr>
			<td>客户号（customerId）</td>
			<td><input type="text" name="customerId" value="33150001" /></td>
		  </tr>	  	
		  
		  <tr>
			<td>外部跟踪编号（externalRefNumber）</td>
			<td><input type="text" name="externalRefNumber" value="" /></td>
		  </tr>	
		  <tr>
			<td>卡号（pan）</td>
			<td><input type="text" name="pan" value="6217003320034459100" /></td>
		  </tr>
	  	  
		 
		  
		  <tr>
			<td>验证码（validCode）</td>
			<td><input type="text" name="validCode" value="" /></td>
		  </tr>
		  <tr>
			<td>安全校验值（token）</td>
			<td><input type="text" name="token" value="" /></td>
		  </tr>
		  	 <tr>
			<td>手机号（phoneNO）</td>
			<td><input type="text" name="phoneNO" value="13500000000" /></td>
		  </tr>
		  		  
		  <tr>
			<td align="center"><input type="submit" value="提交" /></td>
			<td align="center"><input type="reset" value="重置" /></td>
		  </tr>
		</table>
		</form>
	</div><br>
  </body>
</html>
