package com.luyna.pojo;

import java.util.Date;

public class Jewel {
    private String styleno;

    private Integer typeno;

    private String jewelname;

    private Float weight;

    private String fineness;

    private String specification;

    private String accessory;

    private Float accessoryprice;

    private String suite;

    private Integer storage;

    private Date time;

    private String instruction;

    private String remark;
    
    private JewelSubType subtype;
    
    private String status;

   /* public Jewel(){}
    public Jewel(String styleno, Integer typeno, String jewelname,
			Float weight, String fineness, String specification,
			String accessory, Float accessoryprice, String suite,
			Integer storage, Date time, String instruction, String remark,
			JewelSubType subtype) {
		super();
		this.styleno = styleno;
		this.typeno = typeno;
		this.jewelname = jewelname;
		this.weight = weight;
		this.fineness = fineness;
		this.specification = specification;
		this.accessory = accessory;
		this.accessoryprice = accessoryprice;
		this.suite = suite;
		this.storage = storage;
		this.time = time;
		this.instruction = instruction;
		this.remark = remark;
		this.subtype = subtype;
	}*/

	public String getStyleno() {
        return styleno;
    }

    public void setStyleno(String styleno) {
        this.styleno = styleno == null ? null : styleno.trim();
    }

    public Integer getTypeno() {
        return typeno;
    }

    public void setTypeno(Integer typeno) {
        this.typeno = typeno;
    }

    public String getJewelname() {
        return jewelname;
    }

    public void setJewelname(String jewelname) {
        this.jewelname = jewelname == null ? null : jewelname.trim();
    }

    public Float getWeight() {
        return weight;
    }

    public void setWeight(Float weight) {
        this.weight = weight;
    }

    public String getFineness() {
        return fineness;
    }

    public void setFineness(String fineness) {
        this.fineness = fineness == null ? null : fineness.trim();
    }

    public String getSpecification() {
        return specification;
    }

    public void setSpecification(String specification) {
        this.specification = specification == null ? null : specification.trim();
    }

    public String getAccessory() {
        return accessory;
    }

    public void setAccessory(String accessory) {
        this.accessory = accessory == null ? null : accessory.trim();
    }

    public Float getAccessoryprice() {
        return accessoryprice;
    }

    public void setAccessoryprice(Float accessoryprice) {
        this.accessoryprice = accessoryprice;
    }

    public String getSuite() {
        return suite;
    }

    public void setSuite(String suite) {
        this.suite = suite == null ? null : suite.trim();
    }

    public Integer getStorage() {
        return storage;
    }

    public void setStorage(Integer storage) {
        this.storage = storage;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public String getInstruction() {
        return instruction;
    }

    public void setInstruction(String instruction) {
        this.instruction = instruction == null ? null : instruction.trim();
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

	public JewelSubType getSubtype() {
		return subtype;
	}

	public void setSubtype(JewelSubType subtype) {
		this.subtype = subtype;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}


	
}