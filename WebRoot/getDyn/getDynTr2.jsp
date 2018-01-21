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
   TransInfo transInfo= new TransInfo();
    //设置请求信息字符编码
    request.setCharacterEncoding("UTF-8");
    
    //快捷支付首次支付时，卡号pan、手机号码phoneNO必须填写
    String pan = request.getParameter("pan");    //卡号
    String phoneNO = request.getParameter("phoneNO");    //手机号码
    
    String merchantId = request.getParameter("merchantId");    //商户编号
    String customerId = request.getParameter("customerId");    //客户号
    String externalRefNumber = request.getParameter("externalRefNumber");    //外部跟踪号
    if(externalRefNumber==null || "".equals(externalRefNumber)){
	    externalRefNumber=new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());
    }
    String cardHolderName = request.getParameter("cardHolderName");    //持卡人姓名
    String idType = request.getParameter("idType");    //证件类型
    String cardHolderId = request.getParameter("cardHolderId");    //证件号
    String storablePan = request.getParameter("storablePan");    //缩略卡号
    String bankId = request.getParameter("bankId");    //银行代码
   String expiredDate = request.getParameter("expiredDate");    //卡有效期
   String cvv2 = request.getParameter("cvv2");    //卡校验码
    String amount = request.getParameter("amount");    //交易金额
    
        String payBatch = request.getParameter("payBatch");    //快捷支付批次
    
    //设置手机动态鉴权节点
    transInfo.setRecordeText_1("GetDynNumContent");
	transInfo.setRecordeText_2("ErrorMsgContent");
    
    //Tr1报文拼接
    String str1Xml = "";
    
    if(!"".equals(phoneNO) && phoneNO != null){
    // 快捷支付手机动态鉴权（首次）
        str1Xml += "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>";
        str1Xml += "<MasMessage xmlns=\"http://www.99bill.com/mas_cnp_merchant_interface\">";
        str1Xml += "<version>1.0</version>";
        str1Xml += "<GetDynNumContent>";
        str1Xml += "<merchantId>" + merchantId + "</merchantId>";
        str1Xml += "<customerId>" + customerId + "</customerId>";
        str1Xml += "<externalRefNumber>" + externalRefNumber + "</externalRefNumber>";
        str1Xml += "<cardHolderName>" + cardHolderName + "</cardHolderName>";
        str1Xml += "<idType>" + idType + "</idType>";
        str1Xml += "<cardHolderId>" + cardHolderId + "</cardHolderId>";
        str1Xml += "<pan>" + pan + "</pan>";
       str1Xml += "<storablePan>" + storablePan + "</storablePan>";
       str1Xml += "<bankId>" + bankId + "</bankId>";
      if(!"".equals(expiredDate) && !"".equals(cvv2)){
   	//   str1Xml += "<expiredDate>" + expiredDate + "</expiredDate>";
    //    str1Xml += "<cvv2>" + cvv2 + "</cvv2>";
         }
        str1Xml += "<phoneNO>" + phoneNO + "</phoneNO>";
        str1Xml += "<amount>" + amount + "</amount>";
        str1Xml += "</GetDynNumContent>";
        str1Xml += "</MasMessage>";
        
    }else{
    //快捷支付手机动态鉴权（再次）
        str1Xml += "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>";
        str1Xml += "<MasMessage xmlns=\"http://www.99bill.com/mas_cnp_merchant_interface\">";
        str1Xml += "<version>1.0</version>";
        str1Xml += "<GetDynNumContent>";
        str1Xml += "<merchantId>" + merchantId + "</merchantId>";
        str1Xml += "<customerId>" + customerId + "</customerId>";
        str1Xml += "<externalRefNumber>" + externalRefNumber + "</externalRefNumber>";
        //str1Xml += "<cardHolderName>" + cardHolderName + "</cardHolderName>";
        //str1Xml += "<idType>" + idType + "</idType>";
        //str1Xml += "<cardHolderId>" + cardHolderId + "</cardHolderId>";
        //str1Xml += "<pan>" + pan + "</pan>";
        str1Xml += "<storablePan>" + storablePan + "</storablePan>";
        //str1Xml += "<bankId>" + bankId + "</bankId>";
        //str1Xml += "<expiredDate>" + expiredDate + "</expiredDate>";
        //str1Xml += "<cvv2>" + cvv2 + "</cvv2>";
        str1Xml += "<phoneNO>" + phoneNO + "</phoneNO>";
        str1Xml += "<amount>" + amount + "</amount>";
        str1Xml += "</GetDynNumContent>";
        str1Xml += "</MasMessage>";
    }
        
        
    System.out.println("tr1报文  str1Xml = " + str1Xml);
    
   String url = "https://sandbox.99bill.com:9445/cnp/getDynNum";    //测试环境地址
   //  String url = "https://mas.99bill.com/cnp/getDynNum";     //线上环境
    
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
			System.out.println("获取动态码成功");
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
	<h1>获取动态码</h1>
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
			<td>外部跟踪编号（externalRefNumber）</td>
			<td><%=externalRefNumber %></td>
		  </tr>
		    <tr>
			<td>缩略卡号（storablePan）</td>
			<td><%=respXml.get("storablePan") %></td>
		  </tr>
		  <tr>
			<td>令牌信息（token）</td>
			<td><%=respXml.get("token") %></td>
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
