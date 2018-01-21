<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
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
	<h1>PCI查询</h1>
		<form action="pciQuery/pciQueryTr2.jsp" method="post">
		<table border="1">
		  <tr>
			<td>版本号（version）</td>
			<td><input type="text" name="version" value="1.0" /></td>
		  </tr>
		  <tr>
			<td>商户编号（merchantId）</td>
			<td><input type="text" name="merchantId" value="104110045112012" /></td>
		  </tr>
		  <tr>
			<td>客户号（customerId）</td>
			<td><input type="text" name="customerId" value="33150005" /></td>
		  </tr>	  
		  <tr>
			<td>卡类型（cardType）0001信用卡类型  0002:借记卡类型</td>
			<td><input type="text" name="cardType" value="0002" /></td>
		  </tr>
		  <tr>
			<td>缩略卡号（storablePan）</td>
			<td><input type="text" name="storablePan" value="" /></td>
		  </tr>
		  <tr>
			<td>银行代码（bankId）</td>
			<td><input type="text" name="bankId" value="" /></td>
		  </tr>
		  
		  
		  <tr>
			<td align="center"><input type="submit" value="提交" />
			<td align="center"><input type="reset" value="重置" /></td>
		  </tr>
		</table>
		</form>
	</div><br>
  </body>
</html>