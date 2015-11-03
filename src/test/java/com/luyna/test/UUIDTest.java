package com.luyna.test;

import java.util.UUID;

public class UUIDTest {
public static void main(String[] args){

	String s=UUID.randomUUID().toString();
	System.out.println(s.substring(0,8)+s.substring(9,13)+s.substring(14,18)+s.substring(19,23)+s.substring(24));
	s=UUID.randomUUID().toString();
	System.out.println(s.substring(0,8)+s.substring(9,13)+s.substring(14,18)+s.substring(19,23)+s.substring(24)); 
	s=UUID.randomUUID().toString();
	System.out.println(s.substring(0,8)+s.substring(9,13)+s.substring(14,18)+s.substring(19,23)+s.substring(24)); 
	s=UUID.randomUUID().toString();
	System.out.println(s.substring(0,8)+s.substring(9,13)+s.substring(14,18)+s.substring(19,23)+s.substring(24)); 
}
}
