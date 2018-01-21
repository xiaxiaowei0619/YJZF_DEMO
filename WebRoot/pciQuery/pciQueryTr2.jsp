<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.bill99.mgw.entity.*"%>
<%@page import="java.util.HashMap"%>
<%@page import="action.*"%>
<%@page import="java.util.*"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<% 
    //设置请求信息字符编码
    request.setCharacterEncoding("UTF-8");
    TransInfo transInfo= new TransInfo();
    String version = request.getParameter("version");    //接口版本号
    String merchantId = request.getParameter("merchantId");    //商户编号
    String customerId = request.getParameter("customerId");    //客户号
    String cardType = request.getParameter("cardType");    //卡类型
    String storablePan = request.getParameter("storablePan");    //缩略卡号
    String bankId = request.getParameter("bankId");    //银行代码
    
    //设置节点
   transInfo.setRecordeText_1("PciQueryContent");
	transInfo.setRecordeText_2("ErrorMsgContent");
    
    //Tr1报文拼接
    String str1Xml = "";
        str1Xml += "<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
        str1Xml += "<MasMessage xmlns=\"http://www.99bill.com/mas_cnp_merchant_interface\">";
        str1Xml += "<version>1.0</version>";
        str1Xml += "<PciQueryContent>";
        str1Xml += "<merchantId>" + merchantId + "</merchantId>";
        str1Xml += "<customerId>" + customerId + "</customerId>";
        str1Xml += "<cardType>" + cardType + "</cardType>";
        str1Xml += "<storablePan>" + storablePan + "</storablePan>";
        str1Xml += "<bankId>" + bankId + "</bankId>";
        str1Xml += "</PciQueryContent>";
        str1Xml += "</MasMessage>";
        
    System.out.println("tr1报文  str1Xml = " + str1Xml);
    
   String url = "https://sandbox.99bill.com:9445/cnp/pci_query";    //测试环境地址
    // String url = "https://mas.99bill.com/cnp/pci_query";     //线上环境
    
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
			System.out.println("PCI查询成功");
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
	<h1>PCI查询结果</h1>
 		<table border="1">
 		  <%
		  	if(respXml.get("responseCode")!=null){
		   %>
		  <tr>
			<td>商户编号（merchantId）</td>
			<td><%=respXml.get("merchantId") %></td>
		  </tr>
		  <tr>
			<td>客户号（customerId）</td>
			<td><%=respXml.get("customerId") %></td>
		  </tr>
		  <tr>
			<td>卡类型（cardType）</td>
			<td><%=respXml.get("cardType") %></td>
		  </tr>
		  

		  
		  
		  <tr>
			<td>银行代码+缩略卡号+缩略手机号+手机号（pciInfos）</td>
			<td><%=respXml.get("pciInfos") %></td>
		  </tr>
		  
		  <tr>
			<td>应答码（responseCode）</td>
			<td><%=respXml.get("responseCode") %></td>
		  </tr>
		  <tr>
			<td>应答码文本消息（responseTextMessage）</td>
			<% if(respXml.get("responseTextMessage")==null){%>
			<td>PCI查询成功</td>
			<%}else{%>
			<td><%=respXml.get("responseTextMessage") %></td>
			<%} %>
		  </tr>
		  
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