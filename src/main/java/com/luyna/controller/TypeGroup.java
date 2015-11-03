package com.luyna.controller;

import java.util.List;

import com.luyna.pojo.JewelSubType;
import com.luyna.pojo.JewelType;

public class TypeGroup{
	private JewelType jewelType;
	private List<JewelSubType> subTypeList;
	
	public JewelType getJewelType() {
		return jewelType;
	}

	public void setJewelType(JewelType jewelType) {
		this.jewelType = jewelType;
	}

	public List<JewelSubType> getSubTypeList() {
		return subTypeList;
	}

	public void setSubTypeList(List<JewelSubType> subTypeList) {
		this.subTypeList = subTypeList;
	}

	public TypeGroup(JewelType jewelType,List<JewelSubType> subTypeList){
		this.jewelType=jewelType;
		this.subTypeList=subTypeList;
	}
}