package com.luyna.test;

import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;

import com.luyna.controller.UserController;

public class MD5Test {
	public static void main(String [] args){
		UserController controller=new UserController();

			System.out.println(controller.encoderByMd5("123").length());
			System.out.println(controller.encoderByMd5("于娈"));
			System.out.println(controller.encoderByMd5("fdsafa"));
			System.out.println(controller.encoderByMd5("123于娈fafdsaf"));
			String id="0";
			
			if(id.equals("0")){
				System.out.println("companyid:"+id+"fdfa");
			}
	}
  
  
}
