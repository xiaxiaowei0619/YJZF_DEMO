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
    
    <title>My JSP 'QPay.jsp' starting page</title>
    
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
    <body>
    <center>
        <font size=6>一键支付</font>
        <form action="QPay02/QPay2.jsp" method="post">
		<table border="1">
		  <tr>
			<td>版本号（version）</td>
			<td><input type="text" name="version" value="1.0" /></td>
		  </tr>
		  <tr>
			<td>交易类型编码（txnType）</td>
			<td><input type="text" name="txnType" value="PUR" /></td>
		  </tr>
		  <tr>
			<td>特殊交易标志（spFlag）</td>
			<td><input type="text" name="spFlag" value="QPay02" /></td>
		  </tr>
		  <tr>
			<td>消息状态（interactiveStatus）</td>
			<td><input type="text" name="interactiveStatus" value="TR1" /></td>
		  </tr>
		  <tr>
			<td>商户编号（merchantId）</td>
			<td><input type="text" name="merchantId" value="104110045112012" /></td>
		  </tr>
		  <tr>
			<td>终端编号（terminalId）</td>
			<td><input type="text" name="terminalId" value="00002012" /></td>
		  </tr>
		  <tr>
			<td>外部跟踪编号（externalRefNumber）</td>
			<td><input type="text" name="externalRefNumber" value="<%=new SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date())%>" /></td>
		  </tr>
		  <tr>
			<td>交易金额（amount）</td>
			<td><input type="text" name="amount" value="10" /></td>
		  </tr>
		  <tr>
			<td>短卡号（storableCardNo）</td>
			<td><input type="text" name="storableCardNo" value="6217009100" /></td>
		  </tr>
		  
		  <tr>
			<td>客户号（customerId）</td>
			<td><input type="text" name="customerId" value="33150001" /></td>
		  </tr>
		  
		  <tr>
			<td>商户端交易时间（entryTime）</td>
			<td><input type="text" name="entryTime" value="<%=new SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date())%>" /></td>
		  </tr>	
		<tr>
			<td>tr3Url地址（tr3Url）</td>
			<td><input type="text" name="tr3Url" value="http://101.227.69.165:8801/YJZF_DEMO/ReceiveTR3ToTR4.jsp" /></td>
		</tr>	  
	      <tr>
			<td align="center"><input type="submit" value="提交" /></td>
			<td align="center"><input type="reset" value="重置" /></td>
		  </tr>
		</table>
		</form>
	<br>
    </center><br>
  </body>
</html>
