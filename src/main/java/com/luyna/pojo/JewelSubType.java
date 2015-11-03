package com.luyna.pojo;

public class JewelSubType {
    private String subtypeid;

    private String subtypename;

    public String getSubtypeid() {
        return subtypeid;
    }

    public void setSubtypeid(String subtypeid) {
        this.subtypeid = subtypeid == null ? null : subtypeid.trim();
    }

    public String getSubtypename() {
        return subtypename;
    }

    public void setSubtypename(String subtypename) {
        this.subtypename = subtypename == null ? null : subtypename.trim();
    }
}