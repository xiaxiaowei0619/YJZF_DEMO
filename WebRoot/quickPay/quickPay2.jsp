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
    //消费信息
    String version = request.getParameter("version");    //版本号
    String txnType = request.getParameter("txnType");    //交易类型
    String spFlag=request.getParameter("spFlag");    //特殊交易标志
    String interactiveStatus = request.getParameter("interactiveStatus");    //消息状态
    String cardNo = request.getParameter("cardNo");    //卡号
    String storableCardNo = request.getParameter("storableCardNo");    //缩略卡号
    String expiredDate = request.getParameter("expiredDate");    //卡有效期
    String cvv2 = request.getParameter("cvv2");    //卡背面安全校验码
    String amount = request.getParameter("amount");    //交易金额,以元为单位，小数点后最多两位
    String merchantId = request.getParameter("merchantId");    //商户编号
    String terminalId = request.getParameter("terminalId");    //终端编号
    String cardHolderName = request.getParameter("cardHolderName");    //持卡人姓名
    String cardHolderId = request.getParameter("cardHolderId");    //持卡人证件号
    String idType = request.getParameter("idType");    //证件类型
    String entryTime = request.getParameter("entryTime");    //商户端交易时间
    String externalRefNumber = request.getParameter("externalRefNumber");    //外部跟踪号
    String customerId = request.getParameter("customerId");    //客户号
    String tr3Url = request.getParameter("tr3Url");    //tr3回调地址
    
    //在快捷支付交易模式下，extData包含以下列表字段
    String phone = request.getParameter("phone");    //持卡人手机号
    String validCode = request.getParameter("validCode");    //手机验证码
    String savePciFlag = request.getParameter("savePciFlag");    //是否保存鉴权信息
    String token = request.getParameter("token");    //手机验证码令牌
    String payBatch = request.getParameter("payBatch");    //快捷支付批次
    
    //设置消费交易的两个节点
   transInfo.setRecordeText_1("TxnMsgContent");
	transInfo.setRecordeText_2("ErrorMsgContent");
    
    //Tr1报文拼接
    String str1Xml = "";
    if(payBatch.equals("1")){
    //消费交易（首次）报文
        str1Xml += "<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
        str1Xml += "<MasMessage xmlns=\"http://www.99bill.com/mas_cnp_merchant_interface\">";
        str1Xml += "<version>1.0</version>";
        
        str1Xml += "<TxnMsgContent>";
        str1Xml += "<interactiveStatus>" + interactiveStatus + "</interactiveStatus>";
        str1Xml += "<spFlag>" + spFlag + "</spFlag>";
        str1Xml += "<txnType>" + txnType + "</txnType>";
        str1Xml += "<merchantId>" + merchantId + "</merchantId>";
        str1Xml += "<terminalId>" + terminalId + "</terminalId>";
        str1Xml += "<externalRefNumber>" + externalRefNumber + "</externalRefNumber>";
        str1Xml += "<entryTime>" + entryTime + "</entryTime>";
        str1Xml += "<amount>" + amount + "</amount>";
        str1Xml += "<cardNo>" + cardNo + "</cardNo>";
        //str1Xml += "<storableCardNo>" + storableCardNo + "</storableCardNo>";
        if(!"".equals(expiredDate) && !"".equals(cvv2)){
       str1Xml += "<expiredDate>" + expiredDate + "</expiredDate>";
       str1Xml += "<cvv2>" + cvv2 + "</cvv2>";
        }
        str1Xml += "<customerId>" + customerId + "</customerId>";
        str1Xml += "<cardHolderName>" + cardHolderName + "</cardHolderName>";
        str1Xml += "<idType>" + idType + "</idType>";
        str1Xml += "<cardHolderId>" + cardHolderId + "</cardHolderId>";
        str1Xml += "<tr3Url>"+tr3Url+"</tr3Url>";
        
        str1Xml += "<extMap>";
        str1Xml += "<extDate><key>phone</key><value>" + phone + "</value></extDate>";
        str1Xml += "<extDate><key>validCode</key><value>" + validCode + "</value></extDate>";
        str1Xml += "<extDate><key>savePciFlag</key><value>" + savePciFlag + "</value></extDate>";
        str1Xml += "<extDate><key>token</key><value>" + token + "</value></extDate>";
        str1Xml += "<extDate><key>payBatch</key><value>" + payBatch + "</value></extDate>";
        str1Xml += "</extMap>";
        
        str1Xml += "</TxnMsgContent>";
        str1Xml += "</MasMessage>";
    }
    else{
    //消费交易（再次）
        str1Xml += "<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
        str1Xml += "<MasMessage xmlns=\"http://www.99bill.com/mas_cnp_merchant_interface\">";
        str1Xml += "<version>1.0</version>";
        
        str1Xml += "<TxnMsgContent>";
        str1Xml += "<interactiveStatus>" + interactiveStatus + "</interactiveStatus>";
        str1Xml += "<spFlag>" + spFlag + "</spFlag>";
        str1Xml += "<txnType>" + txnType + "</txnType>";
        str1Xml += "<merchantId>" + merchantId + "</merchantId>";
        str1Xml += "<terminalId>" + terminalId + "</terminalId>";
        str1Xml += "<externalRefNumber>" + externalRefNumber + "</externalRefNumber>";
        str1Xml += "<entryTime>" + entryTime + "</entryTime>";
        str1Xml += "<amount>" + amount + "</amount>";
        //str1Xml += "<cardNo>" + cardNo + "</cardNo>";
        str1Xml += "<storableCardNo>" + storableCardNo + "</storableCardNo>";
        //str1Xml += "<expiredDate>" + expiredDate + "</expiredDate>";
        //str1Xml += "<cvv2>" + cvv2 + "</cvv2>";
        str1Xml += "<customerId>" + customerId + "</customerId>";
        //str1Xml += "<cardHolderName>" + cardHolderName + "</cardHolderName>";
        //str1Xml += "<idType>" + idType + "</idType>";
        //str1Xml += "<cardHolderId>" + cardHolderId + "</cardHolderId>";
        str1Xml += "<tr3Url>"+tr3Url+"</tr3Url>";
        
        str1Xml += "<extMap>";
        //str1Xml += "<extDate><key>phone</key><value>" + phone + "</value></extDate>";
        str1Xml += "<extDate><key>validCode</key><value>" + validCode + "</value></extDate>";
        str1Xml += "<extDate><key>savePciFlag</key><value>" + savePciFlag + "</value></extDate>";
        str1Xml += "<extDate><key>token</key><value>" + token + "</value></extDate>";
        str1Xml += "<extDate><key>payBatch</key><value>" + payBatch + "</value></extDate>";
        str1Xml += "</extMap>";
        
        str1Xml += "</TxnMsgContent>";
        str1Xml += "</MasMessage>";
    }    
        
    System.out.println("tr1报文  str1Xml = " + str1Xml);
    
    String url = "https://sandbox.99bill.com:9445/cnp/purchase";    //测试环境地址
    //String url = "https://mas.99bill.com/cnp/purchase";     //线上环境
    
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
			System.out.println("交易成功");
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
    <center>
        <font size=6>快捷支付结果</font>
        <table width="350" border="1">
           <%
		  	if(respXml.get("responseCode")!=null){
		   %>
          <tr><td>交易类型</td><td><%=respXml.get("txnType") %></td></tr>
          <tr><td>消息状态</td><td><%=respXml.get("interactiveStatus") %></td></tr>
          <tr><td>交易金额</td><td><%=respXml.get("amount") %></td></tr>  
          <tr><td>商户编号</td><td><%=respXml.get("merchantId") %></td></tr>
          <tr><td>终端编号</td><td><%=respXml.get("terminalId") %></td></tr>
          <tr><td>客户端交易时间</td><td><%=respXml.get("entryTime") %></td></tr>
          <tr><td>外部跟踪号</td><td><%=respXml.get("externalRefNumber") %></td></tr> 
          <tr><td>交易传输时间</td><td><%=respXml.get("transTime") %></td></tr>
		  <tr><td>客户号</td><td><%=respXml.get("customerId") %></td></tr>
		  <tr>
		    <td><font color="#ff0000">应答码</font></td>
		    <td><font color="#ff0000"><%=respXml.get("responseCode") %></font></td>
		  </tr>
		  <tr>
		    <td><font color="#ff0000">应答码文本消息</font></td>
		    <td><font color="#ff0000"><%=respXml.get("responseTextMessage") %></font></td>
		  </tr>
		  
		  <%
		  	}else{
		  %>
 		  <tr><td>错误代码（errorCode）</td><td><%=respXml.get("errorCode") %></td></tr>
		  <tr><td>错误信息（errorMessage）</td><td><%=respXml.get("errorMessage") %></td></tr>
		  <%
		  }
		  %>    
        </table></br>
    </center><br>
  </body>
</html>