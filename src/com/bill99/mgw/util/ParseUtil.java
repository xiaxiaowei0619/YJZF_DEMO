package com.bill99.mgw.util;

import java.util.HashMap;

import com.bill99.mgw.entity.TransInfo;
import com.bill99.mgw.util.ParseXMLUtil;

/**
 * @Description: ��ǮVOP_CNP��Interface�ӿڳ���
 * @Copyright (c) �Ϻ���Ǯ��Ϣ�������޹�˾
 * @version 2.0
 */

/**
 * ��������ƴ��XML���ͽ���XML
 * */
@SuppressWarnings("unchecked")
public class ParseUtil {
	/**
	 * �������XML����������һ��HashMap
	 * resXml����Ǯ���ص�XML������
	 * */
	public  HashMap parseXML(String resXml, TransInfo transInfo ){
		//TransInfo transInfo= new TransInfo();
	
		HashMap returnRespXml=null;
		ParseXMLUtil pxu=ParseXMLUtil.initParseXMLUtil();//��ʼ��ParseXMLUtil
		if(resXml!=null){
			System.out.println("TransInfo.isFLAG()= " + transInfo.isFLAG());
			//�����ж�ѡ���Ǹ�������ȡXML����
			if(transInfo.isFLAG()){
				returnRespXml= pxu.returnXMLData(pxu.parseXML(resXml), transInfo.getRecordeText_1(), transInfo.getRecordeText_2());
			}else{
				returnRespXml= pxu.returnXMLDataList(pxu.parseXML(resXml), transInfo.getRecordeText_1(), transInfo.getRecordeText_2());
			}
		}
		return returnRespXml;
	}
}
