package com.luyna.pojo;

import java.util.Date;

public class JewelOrder {
    private String orderid;

    private String username;

    private Integer totalnum;

    private Float totalweight;

    private Float accessoryprice;

    private String status;

    private String paytype;

    private Date ordertime;
    private Integer companyid;
    private String remark;

    public String getOrderid() {
        return orderid;
    }

    public void setOrderid(String orderid) {
        this.orderid = orderid ;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username == null ? null : username.trim();
    }

    public Integer getTotalnum() {
        return totalnum;
    }

    public void setTotalnum(Integer totalnum) {
        this.totalnum = totalnum;
    }

    public Float getTotalweight() {
        return totalweight;
    }

    public void setTotalweight(Float totalweight) {
        this.totalweight = totalweight;
    }

    public Float getAccessoryprice() {
        return accessoryprice;
    }

    public void setAccessoryprice(Float accessoryprice) {
        this.accessoryprice = accessoryprice;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status == null ? null : status.trim();
    }

    public String getPaytype() {
        return paytype;
    }

    public void setPaytype(String paytype) {
        this.paytype = paytype == null ? null : paytype.trim();
    }

    public Date getOrdertime() {
        return ordertime;
    }

    public void setOrdertime(Date ordertime) {
        this.ordertime = ordertime;
    }

	public Integer getCompanyid() {
		return companyid;
	}

	public void setCompanyid(Integer companyid) {
		this.companyid = companyid;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
}