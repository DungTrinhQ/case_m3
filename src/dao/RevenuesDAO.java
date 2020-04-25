package dao;

import connect.DBConnect;
import model.Revenues;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class RevenuesDAO {
    
    public ArrayList<Revenues> getListRevenues(String fromdate, String todate) {
        try {
            Connection connection = DBConnect.getConnection();
            String sql = "";
            if(fromdate.length() > 0 && todate.length() > 0)
            {
                sql = "select b.date as Ngay, sum(bd.quantity * bd.price) as DoanhThu from bill b join bill_detail bd on b.bill_id = bd.bill_id where DATE_FORMAT(STR_TO_DATE(b.date, \"%Y-%m-%d %H:%i:%s\"), \"%m/%d/%Y\") between '"+fromdate+"' and '"+todate+"' group by b.date";
            }
            else
            {
                sql = "select b.date as Ngay, sum(bd.quantity * bd.price) as DoanhThu \n" +
                      "from bill b join bill_detail bd on b.bill_id = bd.bill_id \n" +
                      "where DATE_FORMAT(STR_TO_DATE(b.date, \"%Y-%m-%d %H:%i:%s\"), \"%Y-%m-%d\") = CURDATE()\n" +
                      "group by b.date;";
            }
            
            PreparedStatement ps = connection.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            ArrayList<Revenues> list = new ArrayList<>();
            while (rs.next()) {
                Revenues re = new Revenues();
                re.setNgay(rs.getTimestamp("Ngay"));
                re.setDoanhThu(rs.getLong("DoanhThu"));            
                list.add(re);
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(BillDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
     public static void main(String[] args) throws SQLException {
        
       RevenuesDAO dao  =new RevenuesDAO();
       
       ArrayList<Revenues> ab =  dao.getListRevenues("25/04/2020", "26/04/2020");
       System.out.println(ab.size());
    }
}
