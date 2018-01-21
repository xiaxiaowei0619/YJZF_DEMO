<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'index.jsp' starting page</title>
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
    <a href="getDyn/getDyn.jsp">获取动态码</a><br>
    <a href="quickPay/quickPay.jsp">快捷支付消费</a><br>
    <a href="QPay02/QPay.jsp">一键支付</a><br>
    <br/><br/>
    <a href="ind_auth/ind_auth.jsp">卡信息验证</a><br>
     <a href="ind_auth_verify/ind_auth_verify.jsp">卡信息验证-动态验证</a><br>
    
    <br/><br/>
    <a href="pciQuery/pciQuery.jsp">PCI查询</a><br>
    <a href="pciDelete/pciDelete.jsp">PCI删除</a><br><br>
    
      <br/><br/>
      <a href="cxjylsbw/index.html">查询</a><br><br>
      
    </div>
  </body>
</html>
