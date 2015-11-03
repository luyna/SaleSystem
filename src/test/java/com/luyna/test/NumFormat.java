package com.luyna.test;

import java.text.DecimalFormat;

public class NumFormat {

	public static void main(String[] args){
		System.out.println(new DecimalFormat("#.##").format(12.34000015258789));
	}
}
