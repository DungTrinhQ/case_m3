package dao;

import connect.DBConnect;
import model.BillDetail;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;


public class BillDetailDAO {

    public void insertBillDetail(BillDetail bd) throws SQLException {
        Connection connection = DBConnect.getConnection();
        String sql = "INSERT INTO bill_detail VALUES(?,?,?,?,?)";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setLong(1, bd.getBillDetailID());
        ps.setLong(2, bd.getBillID());
        ps.setLong(3, bd.getProductID());
        ps.setDouble(4, bd.getPrice());
        ps.setInt(5, bd.getQuantity());
        ps.executeUpdate();
    }
    
     public ArrayList<BillDetail> getProductBillDetail(long billID) {
        try {
            Connection connection = DBConnect.getConnection();
            String sql = "SELECT * FROM bill_detail WHERE bill_id = " + billID + "";
            PreparedStatement ps = connection.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            ArrayList<BillDetail> list = new ArrayList<>();
            while (rs.next()) {
                BillDetail billDetail = new BillDetail();
                billDetail.setBillID(rs.getLong("bill_id"));
                billDetail.setProductID(rs.getLong("product_id"));
                billDetail.setPrice(rs.getDouble("price"));
                billDetail.setQuantity(rs.getInt("quantity"));
                list.add(billDetail);
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(BillDetailDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public static void main(String[] args) throws SQLException {
        new BillDetailDAO().insertBillDetail(new BillDetail(0, 0, 0, 0, 0));
    }

}
