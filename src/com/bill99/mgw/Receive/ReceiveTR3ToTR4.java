package com.bill99.mgw.Receive;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.bill99.mgw.entity.TransInfo;
import com.bill99.mgw.util.ParseUtil;
import com.bill99.mgw.util.SignUtil;



public class ReceiveTR3ToTR4 extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * Constructor of the object.
	 */
	public ReceiveTR3ToTR4() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		this.doPost(request, response);
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		TransInfo transInfo=new TransInfo();
		ParseUtil parseXML= new ParseUtil();
		
		//����������Ϣ���ַ�����
		request.setCharacterEncoding("utf-8");
				
		InputStream is = request.getInputStream();
		ByteArrayOutputStream bos = new ByteArrayOutputStream();
		byte[] receiveBuffer = new byte[2048];
		int readBytesSize = is.read(receiveBuffer);
		while(readBytesSize != -1){
			bos.write(receiveBuffer, 0, readBytesSize);
			readBytesSize = is.read(receiveBuffer);
		}
		
		String reqData = new String(bos.toByteArray(), "UTF-8");
		System.out.println("TR3��Ϣ��"+reqData);
		
		
		if(!SignUtil.veriSignForXml(reqData)) {
			
			System.out.println("ReceiveTR3ToTR4:��ǩ�ɹ�");
		}else{
			System.out.println("ReceiveTR3ToTR4:��ǩʧ��");
			//����TR3��ĵ�һ����־�ֶ�
			transInfo.setRecordeText_1("TxnMsgContent");
			//����TR3��Ĵ����־�ֶ�
			transInfo.setRecordeText_2("ErrorMsgContent");
			//�������Ľ�����ʽ
			transInfo.setFLAG(true);
	
			/***************��ʼ����TR3**************/
			//����ȡ�����ݴ���DOM����������
			HashMap respXml=parseXML.parseXML(reqData, transInfo);
			if(respXml!=null){
	
				//�ӿڰ汾�ţ�version��
				String version=(String)respXml.get("version");
						  
				//�������ͱ��루txnType��
				String txnType=(String)respXml.get("txnType");
		
				//��Ϣ״̬��interactiveStatus��
				String interactiveStatus=(String)respXml.get("interactiveStatus");
						  
				//���׽�amount��
				String amount=(String)respXml.get("amount");
				
				//�̻����		  
				String merchantId=(String)respXml.get("merchantId");
	
				//�̻����		  
				String settleMerchantId=(String)respXml.get("settleMerchantId");
						  
				//�ն˱�ţ�terminalId��
				String terminalId=(String)respXml.get("terminalId");
						  
				//�ⲿ�����ο��ţ�externalRefNumber��
				String externalRefNumber=(String)respXml.get("externalRefNumber");
						  
				//�ͻ��ţ�customerId��
				String customerId=(String)respXml.get("customerId");
						  
				//�����ο��ţ�refNumber��
				String refNumber=(String)respXml.get("refNumber");
						  
				//Ӧ���루responseCode��
				String responseCode=(String)respXml.get("responseCode");
		
				//Ӧ���ı���Ϣ��responseTextMessage��
		//		String responseTextMessage=(String)respXml.get("responseTextMessage");
						  
				//���״���ʱ�䣨transTime��
				String transTime=(String)respXml.get("transTime");
						  
				//�ͻ��˽���ʱ�䣨entryTime��
				String entryTime=(String)respXml.get("entryTime");
						  
				//������֯��ţ�cardOrg��
				String cardOrg=(String)respXml.get("cardOrg");
						  
				//�����������ƣ�issuer��
				String issuer=(String)respXml.get("issuer");
							
				//���Կ��ţ�storableCardNo��
				String storableCardNo=(String)respXml.get("storableCardNo");
						  
				//��Ȩ�루authorizationCode��	
				String authorizationCode=(String)respXml.get("authorizationCode");
							
				//��������ǩ����signature��
				String signature=(String)respXml.get("signature");
		
				/********TR3�������*********************************/
				
				
				
				//��Ӧ����responseCode��ֵΪ00ʱ�����׳ɹ� ,txnType :PUR������
				if("00".equals(responseCode)){
					/***************************************************************
					 * �������ݿ���߼�����������������ݿ������¼��
					 **************************************************************/
				}
				/********���TR4************************************/
				StringBuffer tr4XML=new StringBuffer();
				tr4XML.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?><MasMessage xmlns=\"http://www.99bill.com/mas_cnp_merchant_interface\"><version>1.0</version><TxnMsgContent>");
				tr4XML.append("<txnType>").append(txnType).append("</txnType>");
				tr4XML.append("<interactiveStatus>TR4</interactiveStatus>");
				tr4XML.append("<merchantId>").append(merchantId).append("</merchantId>");
				if(settleMerchantId!=null && "".equals(settleMerchantId)){
					tr4XML.append("<settleMerchantId>").append(settleMerchantId).append("</settleMerchantId>");
				}
				tr4XML.append("<terminalId>").append(terminalId).append("</terminalId>");
				tr4XML.append("<refNumber>").append(refNumber).append("</refNumber>");
				tr4XML.append("</TxnMsgContent></MasMessage>");
				System.out.println("TR3ToTR4��Ϣ��"+tr4XML.toString());
				response.getOutputStream().write(new String(tr4XML).getBytes("UTF-8"));
			}
		}
	}

	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}

}
