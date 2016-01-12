package com.ynyes.huizi.util;

import java.util.Properties;

import org.apache.xml.resolver.helpers.PublicId;

/**
 * 后台常用常量
 * @author Sharon
 *
 */
public class SiteMagConstant {

    public static final int pageSize = 20;
       
    public static final String templatePath = "src/main/resources/templates/client/";
    
    public static final String backupPath = "src/main/resources/backup/";
    public static final String imagePath = "src/main/resources/static/images";
    public static final String apkPath = "src/main/resources/apk/";
   
//    public static final String backupPath = "/mnt/root/backup/";    
//    public static final String imagePath = "/mnt/root/images/";    
//    public static final String apkPath = "/mnt/root/apk/";
    
//    public static final String backupPath ;
//    public static final String imagePath; 
//    static {
//    	Properties props = System.getProperties();
//    	String operation = props.getProperty("os.name");
//    	if (operation.contains("Linux"))
//    	{
//    		 backupPath = "/mnt/root/backup/";
//    		 imagePath = "/mnt/root/images";
//    	}
//    	else
//    	{
//    		backupPath = "src/main/resources/backup/";
//    	    imagePath = "src/main/resources/static/images/";
//    	}
//    }
   
//    public static String backupPath; 
//    public static String imagePath;
//    
//    static{
//		Properties props = System.getProperties();
//		String operation = props.getProperty("os.name");
//		if(operation.contains("Linux")){
//			backupPath = "/mnt/root/backup/";
//			imagePath = "/mnt/root/images/goods";
//		}else{
//			backupPath = "src/main/resources/backup/";
//			imagePath = "src/main/resources/static/images";
//		}
//    }
}