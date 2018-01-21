<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.bill99.mgw.entity.*"%>
<%@page import="com.bill99.mgw.util.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.HashMap"%>

<%
	//设置请求信息的字符编码
	request.setCharacterEncoding("utf-8");

	InputStream is = request.getInputStream();
	BufferedReader in = new BufferedReader(new InputStreamReader(is,"UTF-8"));
	String line = null;
	StringBuilder sb = new StringBuilder();
	TransInfo transInfo = new TransInfo();
	ParseUtil parseXML = new ParseUtil();
	while ((line = in.readLine()) != null) {
			sb.append(line);
	}
	System.out.println("TR3信息：" + sb.toString());
	
	
	if (SignUtil.veriSignForXml(sb.toString())) {
	   
		//返回TR3后的第一个标志字段
		transInfo.setRecordeText_1("TxnMsgContent");
		//返回TR3后的错误标志字段
		transInfo.setRecordeText_2("ErrorMsgContent");
		//设置最后的解析方式
		transInfo.setFLAG(true);

		//开始接收TR3
		//将获取的数据传入DOM解析函数中
		HashMap respXml = parseXML.parseXML(sb.toString(), transInfo);
		if (respXml != null) {

			//接口版本号（version）
			String version = (String) respXml.get("version");

			//交易类型编码（txnType）
			String txnType = (String) respXml.get("txnType");

			//消息状态（interactiveStatus）
			String interactiveStatus = (String) respXml
					.get("interactiveStatus");

			//交易金额（amount）
			String amount = (String) respXml.get("amount");

			//商户编号		  
			String merchantId = (String) respXml.get("merchantId");

			//商户编号		  
			String settleMerchantId = (String) respXml
					.get("settleMerchantId");

			//终端编号（terminalId）
			String terminalId = (String) respXml.get("terminalId");

			//外部检索参考号（externalRefNumber）
			String externalRefNumber = (String) respXml
					.get("externalRefNumber");

			//客户号（customerId）
			String customerId = (String) respXml.get("customerId");

			//检索参考号（refNumber）
			String refNumber = (String) respXml.get("refNumber");

			//应答码（responseCode）
			String responseCode = (String) respXml.get("responseCode");

			//应答文本信息（responseTextMessage）
			//		String responseTextMessage=(String)respXml.get("responseTextMessage");

			//交易传输时间（transTime）
			String transTime = (String) respXml.get("transTime");

			//客户端交易时间（entryTime）
			String entryTime = (String) respXml.get("entryTime");

			//发卡组织编号（cardOrg）
			String cardOrg = (String) respXml.get("cardOrg");

			//发卡银行名称（issuer）
			String issuer = (String) respXml.get("issuer");

			//缩略卡号（storableCardNo）
			String storableCardNo = (String) respXml
					.get("storableCardNo");

			//授权码（authorizationCode）	
			String authorizationCode = (String) respXml
					.get("authorizationCode");

			//报文数字签名（signature）
			String signature = (String) respXml.get("signature");

			//TR3接收完毕

			//当应答码responseCode的值为00时，交易成功 ,txnType :PUR是消费
			if ("00".equals(responseCode)) {
				//进行数据库的逻辑操作，比如更新数据库或插入记录。
				
			}
			//输出TR4
			StringBuffer tr4XML = new StringBuffer();
			tr4XML
					.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?><MasMessage xmlns=\"http://www.99bill.com/mas_cnp_merchant_interface\"><version>1.0</version><TxnMsgContent>");
			tr4XML.append("<txnType>").append(txnType).append(
					"</txnType>");
			tr4XML.append("<interactiveStatus>TR4</interactiveStatus>");
			tr4XML.append("<merchantId>").append(merchantId).append(
					"</merchantId>");
			tr4XML.append("<terminalId>").append(terminalId).append(
					"</terminalId>");
			tr4XML.append("<refNumber>").append(refNumber).append(
					"</refNumber>");
			tr4XML.append("</TxnMsgContent></MasMessage>");
		
			
			BufferedWriter outW = new BufferedWriter(response.getWriter());
						outW.write(tr4XML.toString());
						outW.flush();
						outW.close();
		} 
	} else {
		System.out.println("ReceiveTR3ToTR4:验签失败");
}
	
	
%>
