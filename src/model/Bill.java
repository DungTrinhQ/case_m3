package model;

import java.sql.Timestamp;


public class Bill {

    private long billID;
    private long userID;
    private double total;
    private String phone;
    private String address;
    private Timestamp date;
    private int paid;
    private int status;

    public Bill() {
    }

    public Bill(long billID, long userID, double total, 
                String phone, String address, Timestamp date,
                int paid, int status) {
        this.billID = billID;
        this.userID = userID;
        this.total = total;
        this.phone = phone;
        this.address = address;
        this.date = date;
        this.paid = paid;
        this.status = status;
    }

    public long getBillID() {
        return billID;
    }

    public void setBillID(long billID) {
        this.billID = billID;
    }

    public long getUserID() {
        return userID;
    }

    public void setUserID(long userID) {
        this.userID = userID;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Timestamp getDate() {
        return date;
    }

    public void setDate(Timestamp date) {
        this.date = date;
    }
    
    public int getPaid() {
        return paid;
    }

    public void setPaid(int paid) {
        this.paid = paid;
    }
    
    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

}
