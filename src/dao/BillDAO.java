package dao;

import connect.DBConnect;
import model.Bill;
import model.BillDetail;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;


public class BillDAO {

    ProductDAO productDAO = new ProductDAO();

    public void insertBill(Bill bill) throws SQLException {
        Connection connection = DBConnect.getConnection();
        String sql = "INSERT INTO bill VALUES(?,?,?,?,?,?)";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setLong(1, bill.getBillID());
        ps.setLong(2, bill.getUserID());
        ps.setDouble(3, bill.getTotal());
        ps.setString(4, bill.getPhone());
        ps.setString(5, bill.getAddress());
        ps.setTimestamp(6, bill.getDate());
        ps.executeUpdate();
    }

    public ArrayList<Bill> getListBill() {
        try {
            Connection connection = DBConnect.getConnection();
            String sql = "SELECT * FROM bill";
            PreparedStatement ps = connection.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            ArrayList<Bill> list = new ArrayList<>();
            while (rs.next()) {
                Bill bill = new Bill();
                bill.setBillID(rs.getLong("bill_id"));
                bill.setUserID(rs.getLong("user_id"));
                bill.setTotal(rs.getDouble("total"));
                bill.setPhone(rs.getString("phone"));
                bill.setAddress(rs.getString("address"));
                bill.setDate(rs.getTimestamp("date"));
                bill.setPaid(rs.getInt("paid"));
                bill.setStatus(rs.getInt("status"));
                list.add(bill);
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(BillDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    public int countBill() throws SQLException{
        Connection connection = DBConnect.getConnection();
        String sql = "SELECT count(bill_id) FROM bill";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        int count = 0;
        while (rs.next()) {
            count = rs.getInt(1);
        }
        return count;  
    }
    public ArrayList<Bill> getListBillPageList(int firstResult, int maxResult) {
        try {
            Connection connection = DBConnect.getConnection();
            String sql = "SELECT * FROM bill limit ?,?";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setInt(1, firstResult);
            ps.setInt(2, maxResult);
            ResultSet rs = ps.executeQuery();
            ArrayList<Bill> list = new ArrayList<>();
            while (rs.next()) {
                Bill bill = new Bill();
                bill.setBillID(rs.getLong("bill_id"));
                bill.setUserID(rs.getLong("user_id"));
                bill.setTotal(rs.getDouble("total"));
                bill.setPhone(rs.getString("phone"));
                bill.setAddress(rs.getString("address"));
                bill.setDate(rs.getTimestamp("date"));
                bill.setPaid(rs.getInt("paid"));
                bill.setStatus(rs.getInt("status"));
                list.add(bill);
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(BillDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public ArrayList<Bill> getBillByID(long billID) {
        try {
            Connection connection = DBConnect.getConnection();
            String sql = "SELECT * FROM bill WHERE bill_id = " + billID + "";
            PreparedStatement ps = connection.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            ArrayList<Bill> list = new ArrayList<>();
            while (rs.next()) {
                Bill bill = new Bill();
                bill.setBillID(rs.getLong("bill_id"));
                bill.setUserID(rs.getLong("user_id"));
                bill.setTotal(rs.getDouble("total"));
                bill.setPhone(rs.getString("phone"));
                bill.setAddress(rs.getString("address"));
                bill.setDate(rs.getTimestamp("date"));
                bill.setStatus(rs.getInt("status"));
                list.add(bill);
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(BillDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public ArrayList<BillDetail> getBillDetailByID(long billID) {
        try {
            Connection connection = DBConnect.getConnection();
            String sql = "SELECT * FROM bill_detail WHERE bill_id = " + billID + "";
            PreparedStatement ps = connection.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            ArrayList<BillDetail> list = new ArrayList<>();
            while (rs.next()) {
                BillDetail billDetail = new BillDetail();
                billDetail.setBillDetailID(rs.getLong("bill_detail_id"));
                billDetail.setBillID(rs.getLong("bill_id"));
                billDetail.setProductID(rs.getLong("product_id"));
                billDetail.setQuantity(rs.getInt("quantity"));
                billDetail.setPrice(rs.getDouble("price"));
                list.add(billDetail);
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(BillDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public boolean paidBill(long billID) {
        Connection connection = DBConnect.getConnection();
        String sql = "UPDATE bill SET paid = 1 WHERE bill_id = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setLong(1, billID);
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(BillDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean approveBill(long billID) {
        ArrayList<BillDetail> list = new ArrayList<>();
        list = getBillDetailByID(billID);
        Connection connection = DBConnect.getConnection();
        String sql = "UPDATE bill SET status = 1 WHERE bill_id = ?";
        for (BillDetail b : list) {
            UpdateProductWhenApproveBill(b.getBillID(), b.getProductID(), b.getQuantity());
        }
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setLong(1, billID);
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(BillDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public Bill getBill(long billID) throws SQLException {
        Connection connection = DBConnect.getConnection();
        String sql = "SELECT * FROM bill WHERE bill_id = '" + billID + "'";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        Bill bill = new Bill();
        while (rs.next()) {
            bill.setBillID(rs.getLong("bill_id"));
            bill.setUserID(rs.getLong("user_id"));
            bill.setTotal(rs.getDouble("total"));
            bill.setPhone(rs.getString("phone"));
            bill.setStatus(rs.getInt("status"));
            bill.setPaid(rs.getInt("paid"));
            bill.setDate(rs.getTimestamp("date"));
        }
        return bill;
    }

    public boolean deleteBill(long billID) {
        ArrayList<BillDetail> list = new ArrayList<>();
        Bill bill = new Bill();
        Connection connection = DBConnect.getConnection();
        String sql = "UPDATE bill SET status = 2 WHERE bill_id = ?";

        try {
            list = getBillDetailByID(billID);
            bill = getBill(billID);

            if (bill.getStatus() == 1) {
                for (BillDetail b : list) {
                    UpdateProductWhenDeleteBill(b.getBillID(), b.getProductID(), b.getQuantity());
                }
            }

            PreparedStatement ps = connection.prepareCall(sql);
            ps.setLong(1, billID);
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(BillDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean UpdateProductWhenDeleteBill(long billID, long productID, long quantityBill) {
        Connection connection = DBConnect.getConnection();
        long quantityCurrent;
        String sql = "UPDATE product SET product_quantity = ? WHERE product_id = ?";
        try {
            quantityCurrent = productDAO.getProduct(productID).getProductQuantity();
            long quantityProduct = quantityCurrent + quantityBill;
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setLong(1, quantityProduct);
            ps.setLong(2, productID);
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(BillDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean UpdateProductWhenApproveBill(long billID, long productID, long quantityBill) {
        Connection connection = DBConnect.getConnection();
        long quantityCurrent;
        String sql = "UPDATE product SET product_quantity = ? WHERE product_id = ?";
        try {
            quantityCurrent = productDAO.getProduct(productID).getProductQuantity();
            long quantityProduct = quantityCurrent - quantityBill;
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setLong(1, quantityProduct);
            ps.setLong(2, productID);
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(BillDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public static void main(String[] args) throws SQLException {

        new BillDAO().insertBill(new Bill(0, 0, 0, "s", "s", new Timestamp(new Date().getTime()), 0, 0));
    }

}
