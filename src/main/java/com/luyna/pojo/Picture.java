package com.luyna.pojo;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonIgnore;

public class Picture implements Serializable{
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String styleno;

    private String picname;

    private String picsuffix;

    private byte[] piccontent;

    public String getStyleno() {
        return styleno;
    }

    public void setStyleno(String styleno) {
        this.styleno = styleno == null ? null : styleno.trim();
    }

    public String getPicname() {
        return picname;
    }

    public void setPicname(String picname) {
        this.picname = picname == null ? null : picname.trim();
    }

    public String getPicsuffix() {
        return picsuffix;
    }

    public void setPicsuffix(String picsuffix) {
        this.picsuffix = picsuffix == null ? null : picsuffix.trim();
    }

    public byte[] getPiccontent() {
        return piccontent;
    }

    public void setPiccontent(byte[] piccontent) {
        this.piccontent = piccontent;
    }
}