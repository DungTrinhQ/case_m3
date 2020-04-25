package model;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;



public class Revenues {
    
    private Timestamp Ngay;
    private long DoanhThu;

    public Revenues() {
    }

    public Revenues(Timestamp Ngay, long DoanhThu) {
        this.Ngay = Ngay;
        this.DoanhThu = DoanhThu;
    }

    SimpleDateFormat ft = new SimpleDateFormat ("yyyy.MM.dd");
    
    public Timestamp getNgay() {
        return Ngay;
    }

    public void setNgay(Timestamp Ngay) {
        this.Ngay = Ngay;
    }

    public long getDoanhThu() {
        return DoanhThu;
    }
    
    public void setDoanhThu(long DoanhThu) {
        this.DoanhThu = DoanhThu;
    }
}
