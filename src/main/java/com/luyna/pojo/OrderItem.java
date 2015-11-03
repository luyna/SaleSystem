package com.luyna.pojo;

public class OrderItem extends OrderItemKey {
    private String styleno;

    private Integer jewelnum;
    private Integer expectnum;

    private Jewel jewel;

    public String getStyleno() {
        return styleno;
    }

    public void setStyleno(String styleno) {
        this.styleno = styleno == null ? null : styleno.trim();
    }

    public Integer getJewelnum() {
        return jewelnum;
    }

    public void setJewelnum(Integer jewelnum) {
        this.jewelnum = jewelnum;
    }

	public Integer getExpectnum() {
		return expectnum;
	}

	public void setExpectnum(Integer expectnum) {
		this.expectnum = expectnum;
	}

	public Jewel getJewel() {
		return jewel;
	}

	public void setJewel(Jewel jewel) {
		this.jewel = jewel;
	}

    
}