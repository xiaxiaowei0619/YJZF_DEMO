<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.bill99.mgw.entity.*"%>
<%@page import="com.bill99.mgw.util.*"%>
<%@page import="java.util.HashMap"%>
<%@page import="action.*"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<% 
    //设置请求信息字符编码
    request.setCharacterEncoding("UTF-8");
    
    TransInfo transInfo= new TransInfo();
    
    
    String merchantId = request.getParameter("merchantId");    //商户编号
    String terminalId = request.getParameter("terminalId");    //终端编号
    String customerId = request.getParameter("customerId");    //客户号
    String externalRefNumber = request.getParameter("externalRefNumber");    //外部跟踪号
   
    String pan = request.getParameter("pan");    //卡号
    String validCode = request.getParameter("validCode");    
    String token = request.getParameter("token");    

    String phoneNO = request.getParameter("phoneNO");   
    
    //设置手机动态鉴权节点
    transInfo.setRecordeText_1("indAuthDynVerifyContent");
	transInfo.setRecordeText_2("ErrorMsgContent");
    
    //Tr1报文拼接
    String str1Xml = "";
   
        str1Xml += "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>";
        str1Xml += "<MasMessage xmlns=\"http://www.99bill.com/mas_cnp_merchant_interface\">";
        str1Xml += "<version>1.0</version>";
        str1Xml += "<indAuthDynVerifyContent>";
        str1Xml += "<merchantId>" + merchantId + "</merchantId>";
       str1Xml += "<terminalId>" + terminalId + "</terminalId>";
        str1Xml += "<customerId>" + customerId + "</customerId>";
        str1Xml += "<externalRefNumber>" + externalRefNumber + "</externalRefNumber>";
        str1Xml += "<pan>" + pan + "</pan>";
        str1Xml += "<validCode>" + validCode + "</validCode>";
      str1Xml += "<token>" + token + "</token>";
       str1Xml += "<phoneNO>" + phoneNO + "</phoneNO>";
       
        str1Xml += "</indAuthDynVerifyContent>";
        str1Xml += "</MasMessage>";
 
        
        
    System.out.println("tr1报文  str1Xml = " + str1Xml);
    
    String url = "https://sandbox.99bill.com:9445/cnp/ind_auth_verify";    //测试环境地址
    //String url = "https://mas.99bill.com/cnp/ind_auth_verify";     //线上环境
    
    //TR2接收的数据
    HashMap respXml = Post.sendPost(url,str1Xml,transInfo);
	System.out.println("respXml = " + respXml);
	
	if(respXml==null)
	{
	    System.out.println("读取内容出错");
    }
    else
    {
		//如果TR2获取的应答码responseCode的值为00时，成功
		if("00".equals((String)respXml.get("responseCode")))
		{
			/*************************************
			 *进行数据库的逻辑操作，比如更新数据库或插入记录。
			 *************************************/
			System.out.println("卡信息验证交易成功");
	    }
    }
    
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'getDynTr2.jsp' starting page</title>
    
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
	<h1>卡信息验证结果</h1>
 		<table border="1">
 		  <%
		  	if(respXml.get("responseCode")!=null){
		   %>
		  <tr>
			<td>商户编号（merchantId）</td>
			<td><%=respXml.get("merchantId") %></td>
		  </tr>
		  <tr>
			<td>终端编号（terminalId）</td>
			<td><%=respXml.get("terminalId") %></td>
		  </tr>
		  <tr>
			<td>客户号（customerId）</td>
			<td><%=respXml.get("customerId") %></td>
		  </tr>
		  <tr>
			<td>外部跟踪编号（externalRefNumber）</td>
			<td><%=respXml.get("externalRefNumber") %></td>
		  </tr>
		  <tr>
			<td>缩略卡号（storablePan）</td>
			<td><%=respXml.get("storablePan") %></td>
		  </tr>
		  <tr>
			<td>应答码（responseCode）</td>
			<td><%=respXml.get("responseCode") %></td>
		  </tr>
		  <tr>
			<td>应答码文本消息（responseTextMessage）</td>
			<% if(respXml.get("responseTextMessage")==null){%>
			<td>获取动态码成功</td>
			<%}else{%>
			<td><%=respXml.get("responseTextMessage") %></td>
			<%} %>
		  </tr>
		  
		  <!-- mas后台配置了发送验证码，会返回token并下发动态码 
		  <tr>
			<td>令牌信息（token）</td>
			<td><%=respXml.get("token") %></td>
		  </tr>
		  -->
		  
		  <%
		  	}else{
		   %>
 		  <tr>
			<td>错误代码（errorCode）</td>
			<td><%=respXml.get("errorCode") %>
		  </tr>
		  <tr>
			<td>错误信息（errorMessage）</td>
			<td><%=respXml.get("errorMessage") %></td>
		  </tr>
		  <%
		  }
		   %>
		</table>
  	</div> <br>
  </body>
</html>
