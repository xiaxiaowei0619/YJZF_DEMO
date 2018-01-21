<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.bill99.mgw.entity.*"%>
<%@page import="com.bill99.mgw.util.*"%>
<%@page import="java.util.HashMap"%>
<%@page import="action.*"%>
<%
   TransInfo transInfo= new TransInfo();
    //设置请求信息字符编码
    request.setCharacterEncoding("UTF-8");

//交易类型编码
//PUR：消费交易；INP：分期消费交易；PRE：预授权交易；CFM：预授权完成交易；VTX：撤销交易；RFD：退货交易
String txnType=request.getParameter("txnType");

//商户编号
//由快钱分配给商户的15位唯一的标识号
String merchantId=request.getParameter("merchantId");

//终端编号
//由快钱分配给商户的8位唯一标识号
String terminalId=request.getParameter("terminalId");

//外部跟踪编号（商家自己的订单号）
String externalRefNumber=request.getParameter("externalRefNumber");

//检索参考号
String refNumber=request.getParameter("refNumber");
		
	    //设置手机动态鉴权节点
    transInfo.setRecordeText_1("TxnMsgContent");
	transInfo.setRecordeText_2("ErrorMsgContent");
    


String str1Xml="";

  str1Xml += "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>";
        str1Xml += "<MasMessage xmlns=\"http://www.99bill.com/mas_cnp_merchant_interface\">";
         str1Xml += "<version>1.0</version>";
        str1Xml += "<QryTxnMsgContent>";
str1Xml += "<externalRefNumber>"+externalRefNumber+"</externalRefNumber>";
str1Xml += "<txnType>"+txnType+"</txnType>";
str1Xml += "<merchantId>"+merchantId+"</merchantId>";
str1Xml += "<terminalId>"+terminalId+"</terminalId>";
str1Xml += "</QryTxnMsgContent>";
str1Xml += "</MasMessage>";

      
    System.out.println("tr1报文  str1Xml = " + str1Xml);
    
    String url = "https://sandbox.99bill.com:9445/cnp/query_txn";    //测试环境地址
  //  String url = "https://mas.99bill.com/cnp/query_txn";     //线上环境
    
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

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>VPOS_CNP查询交易报文</title>
</head>

<body>
	<div align="center">
	<h1>查询交易报文</h1>
 		<table border="1">
 		 <tr>
			<td>接口版本号（version）</td>
			<td><%=respXml.get("version") %></td>
		  </tr>
		  <tr>
			<td>交易类型编码（txnType）</td>
			<td><%=respXml.get("txnType") %></td>
		  </tr>
		  <tr>
			<td>交易金额（amount）</td>
			<td><%=respXml.get("amount") %></td>
		  </tr>
		  <tr>
			<td>商户编号（merchantId）</td>
			<td><%=respXml.get("merchantId") %></td>
		  </tr>
		  <tr>
			<td>终端编号（terminalId）</td>
			<td><%=respXml.get("terminalId") %></td>
		  </tr>
		  <tr>
			<td>外部跟踪编号（externalRefNumber）</td>
			<td><%=respXml.get("externalRefNumber") %></td>
		  </tr>
		  <tr>
			<td>客户号（customerId）</td>
			<td><%=respXml.get("customerId") %></td>
		  </tr>
		  <tr>
			<td>检索参考号（refNumber）</td>
			<td><%=respXml.get("refNumber") %></td>
		  </tr>
		  <tr>
			<td>应答码（responseCode）</td>
			<td><%=respXml.get("responseCode") %></td>
		  </tr>
		  <tr>
			<td>应答文本信息（responseTextMessage）</td>
			<td><%=respXml.get("responseTextMessage") %></td>
		  </tr>	
		  <tr>
			<td>缩略卡号（storableCardNo）</td>
			<td><%=respXml.get("storableCardNo") %></td>
		  </tr>
		  <tr>
			<td>授权码（authorizationCode）</td>
			<td><%=respXml.get("authorizationCode") %></td>
		  </tr>
		  <tr>
			<td>交易传输时间（transTime）</td>
			<td><%=respXml.get("transTime") %></td>
		  </tr>
		  <tr>
			<td>撤销标志（voidFlag）</td>
			<td><%=respXml.get("voidFlag") %></td>
		  </tr>
		  <tr>
			<td>客户端交易时间（entryTime）</td>
			<td><%=respXml.get("entryTime") %></td>
		  </tr>
		  <tr>
			<td>发卡组织编号（cardOrg）</td>
			<td><%=respXml.get("cardOrg") %></td>
		  </tr>
		  <tr>
			<td>发卡银行名称（issuer）</td>
			<td><%=respXml.get("issuer") %></td>
		  </tr>
		  <tr>
			<td>错误代码（errorCode）</td>
			<td><%=respXml.get("errorCode") %></td>
		  </tr>
		  <tr>
			<td>错误信息（errorMessage）</td>
			<td><%=respXml.get("errorMessage") %></td>
		  </tr>
		</table>
  	</div>
</body>
</html>
