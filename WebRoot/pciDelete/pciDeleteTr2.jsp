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
    String version = request.getParameter("version");    //接口版本号
    String merchantId = request.getParameter("merchantId");    //商户编号
    String customerId = request.getParameter("customerId");    //客户号
    String pan = request.getParameter("pan");    //卡号
    String storablePan = request.getParameter("storablePan");    //缩略卡号
    String bankId = request.getParameter("bankId");    //银行代码
    
    //设置节点
    transInfo.setRecordeText_1("PciDeleteContent");
	transInfo.setRecordeText_2("ErrorMsgContent");
    
    //Tr1报文拼接
    String str1Xml = "";
        str1Xml += "<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
        str1Xml += "<MasMessage xmlns=\"http://www.99bill.com/mas_cnp_merchant_interface\">";
        str1Xml += "<version>1.0</version>";
        str1Xml += "<PciDeleteContent>";
        str1Xml += "<merchantId>" + merchantId + "</merchantId>";
        str1Xml += "<customerId>" + customerId + "</customerId>";
        str1Xml += "<pan>" + pan + "</pan>";
        str1Xml += "<storablePan>" + storablePan + "</storablePan>";
        str1Xml += "<bankId>" + bankId + "</bankId>";
        str1Xml += "</PciDeleteContent>";
        str1Xml += "</MasMessage>";
        
    System.out.println("tr1报文  str1Xml = " + str1Xml);
    
  	String url = "https://sandbox.99bill.com:9445/cnp/pci_del";    //测试环境地址
 	 //String url = "https://mas.99bill.com/cnp/pci_del";     //线上环境
    
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
			System.out.println("PCI删除成功");
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
	<h1>PCI删除结果</h1>
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
			<td>卡号（pan）</td>
			<td><%=respXml.get("pan") %></td>
		  </tr>
		  <tr>
			<td>缩略卡号（storablePan）</td>
			<td><%=respXml.get("storablePan") %></td>
		  </tr>
		  <tr>
			<td>银行代码（bankId）</td>
			<td><%=respXml.get("bankId") %></td>
		  </tr>
		  
		  <tr>
			<td>应答码（responseCode）</td>
			<td><%=respXml.get("responseCode") %></td>
		  </tr>
		  <tr>
			<td>应答码文本消息（responseTextMessage）</td>
			<% if(respXml.get("responseTextMessage")==null){%>
			<td>PCI删除成功</td>
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