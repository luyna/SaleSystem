package com.luyna.test;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateTest {
   public static void main(String[] args) throws ParseException{
	   System.out.println(new Date(0));
	   System.out.println(new Date());
	   Date date = new Date();
       System.out.println(date.toString());
       System.out.println("1diyige__________________________");
       DateFormat df = new SimpleDateFormat ("yyyy-MM-dd");     
       Date d1 = df.parse("2001-01-01");
       System.out.println(d1.toString());
       System.out.println("2diyige__________________________");
       DateFormat df2 = DateFormat.getDateInstance(DateFormat.SHORT);
       System.out.println(df2.format(new Date()));        
       Date d2 = df2.parse("11-10-10");
       System.out.println("DateFormat.SHORT: " + d2.toString());
       System.out.println("3diyige__________________________");
       DateFormat df3 = DateFormat.getDateInstance(DateFormat.MEDIUM);
       System.out.println(df3.format(new Date()));        
       Date d3 = df3.parse("2010-11-10");
       System.out.println("DateFormat.MEDIUM: " + d3.toString());
       System.out.println("4diyige__________________________");
       DateFormat df4 = DateFormat.getDateInstance(DateFormat.LONG);
       System.out.println(df4.format(new Date()));        
       Date d4 = df4.parse("2010年11月10日");
       System.out.println("DateFormat.LONG: " + d4.toString());
   }
}
