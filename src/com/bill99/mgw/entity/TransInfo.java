package com.bill99.mgw.entity;

public class TransInfo {
	
	private  String postUrl;			//�ύ��ַ
	private  boolean FLAG;		//�����ж�ѡ�õĽ�������
	private  String recordeText_1;		//������¼XML���ݸ�ʽ�ֶΣ�������¼XML��һ����־���ݸ�ʽ�ֶ�
	private  String recordeText_2;		//����ǵ����ݶ�ʱ��������¼XML�ڶ�����־���ݸ�ʽ�ֶ�
	private  String txnType;		//��������
	///TransInfo transInfo= new TransInfo();
	public  String getPostUrl() {
		return postUrl;
	}

	public  void setPostUrl(String postUrl) {
		this.postUrl = postUrl;
	}

	public  boolean isFLAG() {
		return FLAG;
	}

	public  void setFLAG(boolean flag) {
		FLAG = flag;
	}

	public  String getRecordeText_1() {
		return recordeText_1;
	}

	public  void setRecordeText_1(String recordeText_1) {
		this.recordeText_1 = recordeText_1;
	}

	public  String getRecordeText_2() {
		return recordeText_2;
	}

	public  void setRecordeText_2(String recordeText_2) {
		this.recordeText_2 = recordeText_2;
	}

	public  String getTxnType() {
		return txnType;
	}
	
	public  void setTxnType(String txnType) {
		this.txnType = txnType;
	}
/*
	public static TransInfo setTxnType(String txnType) {
		TransInfo transInfo=new TransInfo();
		transInfo.setRecordeText_1("GetDynNumContent");
		transInfo.setRecordeText_2("ErrorMsgContent");
		txnType = txnType;
		return transInfo;
	}
	*/
}
