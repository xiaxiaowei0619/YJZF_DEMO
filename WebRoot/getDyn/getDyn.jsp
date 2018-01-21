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
	<h1>获取动态码</h1>
		<form action="getDyn/getDynTr2.jsp" method="post">
		<table border="1">
		<tr>
			<td>商户编号（merchantId）</td>
			<td><input type="text" name="merchantId" value="104110045112012" /></td>
		  </tr>
		<tr>
			<td>客户号（customerId）</td>
			<td><input type="text" name="customerId" value="00002012" /></td>
		  </tr>	  	
		  
		  <tr>
			<td>外部跟踪编号（externalRefNumber）</td>
			<td><input type="text" name="externalRefNumber" value="" /></td>
		  </tr>	
		  
		  <tr>
			<td>客户姓名（cardHolderName）</td>
			<td><input type="text" name="cardHolderName" value="测试" /></td>
		  </tr>
		  
		   <tr>
			<td>证件类型（idType）</td>
			<td><input type="text" name="idType" value="0" /></td>
		  </tr>
		  
		  <tr>
			<td>客户身份证号（cardHolderId）</td>
			<td><input type="text" name="cardHolderId" value="32058219870706111X" /></td>
		  </tr>
		  	
		  <tr>
			<td>卡号（pan）</td>
			<td><input type="text" name="pan" value="6217003320034459100" /></td>
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
			<td>卡效期（expiredDate）</td>
			<td><input type="text" name="expiredDate" value="0911" /></td>
		  </tr>
		  	
		  	 <tr>
			<td>手机号码（phoneNO）</td>
			<td><input type="text" name="phoneNO" value="13500000000" /></td>
		  </tr>
		  		  
		  		  
		  <tr>
			<td>安全校验值（CVV2或CVC2）</td>
			<td><input type="text" name="cvv2" value="111" /></td>
		  </tr>
		  <tr>
			<td>交易金额（amount）</td>
			<td><input type="text" name="amount" value="10" /></td>
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
