package com.luyna.pojo;

public class ShopCart extends ShopCartKey {
    private Integer jewelnum;

	private String remark;
	
	private Jewel jewel;

	public Integer getJewelnum() {
		return jewelnum;
	}

	public void setJewelnum(Integer jewelnum) {
		this.jewelnum = jewelnum;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark == null ? null : remark.trim();
	}

	public Jewel getJewel() {
		return jewel;
	}

	public void setJewel(Jewel jewel) {
		this.jewel = jewel;
	}

}