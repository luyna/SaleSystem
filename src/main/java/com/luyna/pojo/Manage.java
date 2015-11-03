package com.luyna.pojo;

public class Manage {
    private Integer manageid;

    private String managename;

    private String password;

    public Integer getManageid() {
        return manageid;
    }

    public void setManageid(Integer manageid) {
        this.manageid = manageid;
    }

    public String getManagename() {
        return managename;
    }

    public void setManagename(String managename) {
        this.managename = managename == null ? null : managename.trim();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }
}