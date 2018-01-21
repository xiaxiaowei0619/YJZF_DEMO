package com.bill99.mgw.util;

import java.io.IOException;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.input.SAXBuilder;
import org.xml.sax.InputSource;

/**
 * �������ڽ���XML
 * */
@SuppressWarnings("unchecked")
public class ParseXMLUtil {
	
	/**
	 * �˷���������ʼ�������
	 * ����һ��ParseXMLUtil���ʵ��������
	 * */
	public static ParseXMLUtil initParseXMLUtil(){
		return new ParseXMLUtil();
	}
	
	/**
	 * �˷�����������XML�еĽڵ㣬���صõ�һ��HashMap�ļ�ֵ����
	 * hmΪ����������������XML�ڵ���Ϣ��
	 * e�Ǵ�������XML�ڵ�
	 * */
	private HashMap parseXMLNode(HashMap hm,Element e){
		Element child=null;   //����һ��ElementԪ�ض���
		
		//���濪ʼ����ѭ��
		for(Iterator childs= e.getChildren().iterator();childs.hasNext();){
			child=(Element)childs.next(); //��ȡ�ڵ��µ�ÿһ����Ԫ��
			hm.put(child.getName(), child.getValue()); //��ÿһ��Ԫ�ص����ƺ�ֵ�����浽HashMap�У������Ժ��ѯȡ��
		}
		return hm;
	}
	
	/**
	 * �˷�����������XML�еĽڵ�(��Ҫ�Ǳ���List�б�)�����صõ�һ��HashMap�ļ�ֵ����
	 * hmΪ����������������XML�ڵ���Ϣ��
	 * e�Ǵ�������XML�ڵ�
	 * */
	private HashMap parseXMLNodeList(HashMap hm,Element e,String flag2){
		Element child=null;   //����һ��ElementԪ�ض���
		Element child_txn=null;		//����һ��ElementԪ�ض���
		HashMap HM_txn=null;
		List list=null;
		
		//���濪ʼ����ѭ��
		for(Iterator childs= e.getChildren().iterator();childs.hasNext();){
			child=(Element)childs.next(); //��ȡ�ڵ��µ�ÿһ����Ԫ��
			if(flag2.equals(child.getName())){
				list=new ArrayList();   //ʵ����һ��List

				//���濪ʼ����ѭ�������ҽ�����HashMap���浽List�б���
				for (Iterator childs2= child.getChildren().iterator();childs2.hasNext();){
					HM_txn=new HashMap();      //����ʵ����һ��HashMap������������Txn�е�Ԫ��
					child_txn=(Element)childs2.next(); //��ȡÿһ����Ԫ��
					HM_txn=parseXMLNode(HM_txn,child_txn);   //����parseXMLNode�������õ��ýڵ��µ�����Ԫ��
					list.add(HM_txn);     //��HM_txn����List�б��У������Ժ��ѯȡ��
				}
				hm.put("Txn", list);
			}else{
				hm.put(child.getName(), child.getValue()); //��ÿһ��Ԫ�ص����ƺ�ֵ�����浽HashMap�У������Ժ��ѯȡ��
			}
		}
		return hm;
	}
	
	/**
	 * �˷�������������ȡ��XML����,����һ��XML�ĸ�Ԫ��Element����
	 * resXml����Ǯ���ص�XML������
	 * root�����յõ��ĸ�Ԫ��
	 * */
	public Element parseXML(String resXml){
		SAXBuilder sb=new SAXBuilder();  //��ʼ��SAXBuilder
		//����һ���µ��ַ���
        StringReader read = new StringReader(resXml);
        //�����µ�����ԴSAX ��������ʹ�� InputSource ������ȷ����ζ�ȡ XML ����
        InputSource inSource = new InputSource(read);
		Document doc=null;  //����һ��Document�ı�����
		Element root=null;  //����һ��Element��Ԫ�ض���
		try {
			doc=sb.build(inSource);		//�õ�������XML�ĵ�����
		} catch (JDOMException e1) {
			System.out.println("�����ı�����");
			e1.printStackTrace();
		} catch (IOException e1) {
			System.out.println("��ȡ����������");
			e1.printStackTrace();
		}
		
		if(doc!=null){
			root=doc.getRootElement();  //�õ�XML�ĸ�Ԫ��
		}else{
			System.out.println("����root����");
		}
		return root;
	}
	
	/**
	 * �˷���ͨ���õ��ĸ�Ԫ��root���󣬾������XML����
	 * flag1��flag2�����ж�XML���ݵı�־�ֶ�
	 * xmlData������һ��������XMLԪ�����ݵ�HashMap
	 * �����ڣ����ѡ��������ѡ�Ԥ��Ȩ��Ԥ��Ȩ��ɡ��������˻����ס�
	 *       ��ѯ������ˮ���ġ�Ԥ��Ȩ����֪ͨ��ά���ͻ��Ź�ϵ������Ϣ��ѯ����
	 * */
	public HashMap returnXMLData(Element root,String flag1,String flag2){
		HashMap xmlData=null;	//����һ��HashMap����
		Element child=null;   //����һ��ElementԪ�ض���
		
		if(root!=null){
			xmlData=new HashMap(); //��ʼ��HashMap,��������õ�������
			String childName="";
			
			//���濪ʼ����ѭ��
			for (Iterator childs= root.getChildren().iterator();childs.hasNext();) {
				child=(Element)childs.next(); //��ȡÿһ����Ԫ��
				childName=(String)child.getName();  //�õ��ýڵ������
				
				//�����һ���жϣ�����ƥ���һ��XML��־�ڵ㣨�磺TxnMsgContent����
				//�ڶ����жϣ�����ƥ��ڶ���XML��־�ڵ㣨�磺ErrorMsgContent��
				if(flag1.equals(childName)){
					xmlData=parseXMLNode(xmlData,child);   //����parseXMLNode�������õ��ýڵ��µ�����Ԫ��
				}else if(flag2.equals(childName)){
					xmlData=parseXMLNode(xmlData,child);   //����parseXMLNode�������õ��ýڵ��µ�����Ԫ��
				}else if("ErrorMsgContent".equals(childName)){
					xmlData=parseXMLNode(xmlData,child);   //����parseXMLNode�������õ��ýڵ��µ�����Ԫ��
				}else{
					xmlData.put(childName, child.getValue());  //����Ԫ�ر��浽HashMap��
				}
			}
		}
		return xmlData;
	}
	
	/**
	 * �˷���ͨ���õ��ĸ�Ԫ��root���󣬾������XML���ݣ����ض����ͬ�ڵ�ı���
	 * flag1��flag2�����ж�XML���ݵı�־�ֶ�
	 * xmlData������һ��������XMLԪ�����ݵ�HashMap
	 * �����ڣ���ѯ��ȷ����ˮ���ġ���ѯ��������ˮ���ġ���ѯ��������ˮ����
	 * */
	public HashMap returnXMLDataList(Element root,String flag1,String flag2){
		HashMap xmlData=null;	//����һ��HashMap����
		Element child=null;			//����һ��ElementԪ�ض���
		
		if(root!=null){
			xmlData=new HashMap(); //��ʼ��HashMap,��������õ�������
			String childName="";
			//���濪ʼ����ѭ��
			for (Iterator childs1= root.getChildren().iterator();childs1.hasNext();) {
				child=(Element)childs1.next(); //��ȡÿһ����Ԫ��
				childName=(String)child.getName();  //�õ��ýڵ������
				//�����ж������ж�ÿ�δ��ĸ��ڵ���ȡ��XMLԪ�أ��������ϸ�����ͬ��
				if(flag1.equals(childName)){
					xmlData=parseXMLNodeList(xmlData,child,flag2);   //����parseXMLNode�������õ��ýڵ��µ�����Ԫ��
				}else if("ErrorMsgContent".equals(childName)){
					xmlData=parseXMLNode(xmlData,child);   //����parseXMLNode�������õ��ýڵ��µ�����Ԫ��
				}else{
					xmlData.put(childName, child.getValue());  //����Ԫ�ر��浽HashMap��
				}
			}
		}
		//ѭ������
		return xmlData;
	}
	
}
