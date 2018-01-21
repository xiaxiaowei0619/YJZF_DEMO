package action;


import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;

import java.io.InputStream;

import java.io.OutputStream;

import java.net.URL;

import java.util.HashMap;

import java.security.KeyStore;


import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.KeyManagerFactory;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;

import com.bill99.mgw.entity.TransInfo;
import com.bill99.mgw.util.*;

public class Post
{
	/**
	* ��ָ��URL����POST����������
	* @param url ���������URL
	* @param param ����������������Ӧ����name1=value1&name2=value2����ʽ��
    * @return URL������Զ����Դ����Ӧ
	 * @throws Exception 
    */
	public static HashMap sendPost(String url,String tr1XML,TransInfo transInfo) throws Exception
	{
		//jdk1.7��ʾ��javax.net.ssl.SSLProtocolException: handshake alert: unrecognized_name
		//����1������ϵͳ���ԣ�System.setProperty("jsse.enableSNIExtension", "false");
        //����2�������tomcat:
		//                  1. linux����catalina.sh����JAVA_OPTS="$JAVA_OPTS -Djsse.enableSNIExtension=false"
		//                  2. win����catalina.bat����JAVA_OPTS="$JAVA_OPTS -Djsse.enableSNIExtension=false"
		System.setProperty("jsse.enableSNIExtension", "false");
		ParseUtil parseUtil =new ParseUtil();
		OutputStream out = null;
		HashMap respXml = null;
		String jksFile = Post.class.getResource("10411004511201290.jks").toURI().getPath();
		//��ȡ֤��·��
		File certFile = new File(jksFile);  //����֤�飬����������Ҫ�滻
	    //����Java��Կ�⣬JKS��keytool������Java��Կ�⣬������Կ��
		KeyStore ks = KeyStore.getInstance("JKS");
		ks.load(new FileInputStream(certFile), "vpos123".toCharArray());
		//�������ڹ���JKS��Կ�����Կ������
		KeyManagerFactory kmf = KeyManagerFactory.getInstance(KeyManagerFactory.getDefaultAlgorithm());
		//��ʼ��֤��
		kmf.init(ks, "vpos123".toCharArray());

		//ͬλ����֤���ξ���Դ//ͬλ����֤�����ε�֤����Դ
		TrustManager[] tm = { new MyX509TrustManager() }; 
		
		//��ʼ����ȫ�׽���
		SSLContext sslContext = SSLContext.getInstance("SSL");
		//��ʼ��SSL�������ڶ��������Ǹ���JSSEʹ�õĿ�����֤�����Դ������Ϊnull�Ǵ�javax.net.ssl.trustStore�л��֤�顣
		//������������JSSE���ɵ�����������������Ӱ��ϵͳ�İ�ȫ�ԣ�����Ϊnull�Ǹ���ѡ�񣬿��Ա�֤JSSE�İ�ȫ�ԡ�
		sslContext.init(kmf.getKeyManagers(),tm, null);
		
		//�����������õ�SSL������������SSLSocketFactory,��ͨ���Ĳ���������ͬ
		SSLSocketFactory factory = sslContext.getSocketFactory();
		
		try
	    {
		    URL realUrl = new URL(url);
		    //�򿪺�URL֮�������
		    HttpsURLConnection conn = (HttpsURLConnection)realUrl.openConnection();
		    //������ȫ�������׽���
			conn.setSSLSocketFactory(factory);
		    //����POST�������������������,ʹ�� URL ���ӽ����������
		    conn.setDoOutput(true);
		    conn.setDoInput(true);
		    //����URL���ӵĳ�ʱʱ��
		    conn.setReadTimeout(100000);
		    
		    //����ͨ�õ���������
		    String authString = "104110045112012" + ":" + "vpos123";//�����ʺţ�����������Ҫ�滻�����̻����
			String auth = "Basic " + Base64Binrary.encodeBase64Binrary(authString.getBytes());
		    conn.setRequestProperty("Authorization", auth);
		    
		    // ��ȡURLConnection�����Ӧ�������
		    out = conn.getOutputStream();
		    //�����������
			out.write(tr1XML.getBytes("utf-8"));
		 
		    //flush ������Ļ���
		    out.flush();
	        
		    //�õ�����˷���
		 	 InputStream is = conn.getInputStream();
		 	String reqData = "";
		    if(is!=null && !"".equals(is))
		    {
		    	ByteArrayOutputStream bos = new ByteArrayOutputStream();
				byte[] receiveBuffer = new byte[2048];//����������
				int readBytesSize = is.read(receiveBuffer);//��ȡ���ݳ��ȣ�InputStreamҪ��ȡ�����ݳ���һ��ҪС�ڵ��ڻ������е��ֽ���
					
				while(readBytesSize != -1){//�ж����Ƿ�λ���ļ�ĩβ��û�п��õ��ֽ�
					bos.write(receiveBuffer, 0, readBytesSize);//��receiveBuffer�ڴ洦��0ƫ�ƿ�ʼд��д��readBytesSize������ȵ��ֽ�
					readBytesSize = is.read(receiveBuffer);
				}
				reqData = new String(bos.toByteArray(), "UTF-8");//������tr2����
		    }
		    System.out.println("tr2���ģ�"+reqData);
			respXml= parseUtil.parseXML(reqData,transInfo);//������XML�ĺ������ݿ�Ǯ���ص�TR2��XML������
		    
	    }
	    catch(Exception e)
	    {
		    System.out.println("����POST��������쳣��" + e);
		    e.printStackTrace();
	    }
	    //ʹ��finally�����ر��������������
	    finally
	    {
	    	if (out != null){out.close();}
			
	    }
	    return respXml;
	}
	public static void main(String[] args) {
		File certFile1 = new File("C://TS/mgw.cer");
		System.out.println(certFile1.toString());
	}
	
}