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
	<h1>PCI删除</h1>
		<form action="pciDelete/pciDeleteTr2.jsp" method="post">
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
			<td><input type="text" name="customerId" value="3820150001609126" /></td>
		  </tr>	  
		  <tr>
			<td>卡号（pan）</td>
			<td><input type="text" name="pan" value="" /></td>
		  </tr>
		  <tr>
			<td>缩略卡号（storablePan）</td>
			<td><input type="text" name="storablePan" value="6228484579" /></td>
		  </tr>
		  <tr>
			<td>银行代码（bankId）</td>
			<td><input type="text" name="bankId" value="ABC" /></td>
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