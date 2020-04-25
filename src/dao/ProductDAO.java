package dao;

import connect.DBConnect;
import model.Product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


public class ProductDAO {


    public ArrayList<Product> getListProductByCategory(long category_id) throws SQLException {
        Connection connection = DBConnect.getConnection();
        String sql = "SELECT * FROM product WHERE category_id = '" + category_id + "'";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<Product> list = new ArrayList<>();
        while (rs.next()) {
            Product product = new Product();
            product.setProductID(rs.getLong("product_id"));
            product.setProductName(rs.getString("product_name"));
            product.setProductImage(rs.getString("product_image"));
            product.setProductPrice(rs.getLong("product_price"));
            product.setProductDescription(rs.getString("product_description"));
            list.add(product);
        }
        return list;
    }


    public Product getProduct(long productID) throws SQLException {
        Connection connection = DBConnect.getConnection();
        String sql = "SELECT * FROM product WHERE product_id = '" + productID + "'";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        Product product = new Product();
        while (rs.next()) {
            product.setProductID(rs.getLong("product_id"));
            product.setCategoryID(rs.getLong("category_id"));
            product.setProductName(rs.getString("product_name"));
            product.setProductQuantity(rs.getLong("product_quantity"));
            product.setProductImage(rs.getString("product_image"));
            product.setProductPrice(rs.getLong("product_price"));
             product.setProductQuantity(rs.getLong("product_quantity"));
            product.setProductDescription(rs.getString("product_description"));
        }
        return product;
    }
    
    

    public ArrayList<Product> getListProductByNav(long categoryID, int firstResult, int maxResult) throws SQLException{
        Connection connection = DBConnect.getConnection();
        String sql = "SELECT * FROM product WHERE category_id = '" + categoryID + "' limit ?,?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setInt(1, firstResult-1);
        ps.setInt(2, maxResult);
        ResultSet rs = ps.executeQuery();
        ArrayList<Product> list = new ArrayList<>();
        while (rs.next()) {
            Product product = new Product();
            product.setProductID(rs.getLong("product_id"));
            product.setProductName(rs.getString("product_name"));
            product.setProductImage(rs.getString("product_image"));
            product.setProductPrice(rs.getLong("product_price"));
            product.setProductDescription(rs.getString("product_description"));
            list.add(product);
        }
        return list;
    }
    

    public int countProductByCategory(long categoryID) throws SQLException{
        Connection connection = DBConnect.getConnection();
        String sql = "SELECT count(product_id) FROM product WHERE category_id = '" + categoryID + "'";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        int count = 0;
        while (rs.next()) {
            count = rs.getInt(1);
        }
        return count;  
    }
    

    public ArrayList<Product> getListProductPageList(String keyword, int firstResult, int maxResult) throws SQLException{
        Connection connection = DBConnect.getConnection();
        String sql = "";
        if(keyword.length() != 0)
        {
            sql = "SELECT product.*, category.category_name FROM product join category on product.category_id = category.category_id where product.product_name like '%"+keyword+"%' or product.product_description like '%"+keyword+"%' or category.category_name like '%"+keyword+"%' order by product_id desc limit ?,?";
        }
        else
        {
            sql = "SELECT product.*, category.category_name FROM product join category on product.category_id = category.category_id order by product_id desc limit ?,?";
        }
        
        PreparedStatement ps = connection.prepareCall(sql);

        int page = firstResult ;
        ps.setInt(1, page);
        ps.setInt(2, maxResult);
        ResultSet rs = ps.executeQuery();
         ArrayList<Product> list = new ArrayList<>();
        while (rs.next()) {
            Product product = new Product();
            product.setProductID(rs.getLong("product_id"));
            product.setProductName(rs.getString("product_name"));
            product.setProductImage(rs.getString("product_image"));
            product.setProductPrice(rs.getLong("product_price"));
            product.setProductQuantity(rs.getLong("product_quantity"));
            product.setProductDescription(rs.getString("product_description"));
            
            product.setCategoryID(rs.getLong("category_id"));
            product.setCategoryName(rs.getString("category_name"));
            
            list.add(product);
        }
        return list;
    }

    public ArrayList<Product> getListProductOutStock() throws SQLException{
        Connection connection = DBConnect.getConnection();
        String sql = "SELECT product.*, category.category_name FROM product join category on product.category_id = category.category_id where product.product_quantity <= 5  order by product_id desc";
       
        PreparedStatement ps = connection.prepareCall(sql);

        ResultSet rs = ps.executeQuery();
         ArrayList<Product> list = new ArrayList<>();
        while (rs.next()) {
            Product product = new Product();
            product.setProductID(rs.getLong("product_id"));
            product.setProductName(rs.getString("product_name"));
            product.setProductImage(rs.getString("product_image"));
            product.setProductPrice(rs.getLong("product_price"));
            product.setProductQuantity(rs.getLong("product_quantity"));
            product.setProductDescription(rs.getString("product_description"));
            
            product.setCategoryID(rs.getLong("category_id"));
            product.setCategoryName(rs.getString("category_name"));
            
            list.add(product);
        }
        return list;
    }
    
    

    public int countProduct() throws SQLException{
        Connection connection = DBConnect.getConnection();
        String sql = "SELECT count(product_id) FROM product";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        int count = 0;
        while (rs.next()) {
            count = rs.getInt(1);
        }
        return count;  
    }
    

    public void insert(Product p) throws SQLException
    {
        try {
            Connection connection = DBConnect.getConnection();
            String sql = "INSERT INTO product VALUE(?,?,?,?,?,?,?)";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setLong(1, p.getProductID());
            ps.setLong(2, p.getCategoryID());
            ps.setString(3, p.getProductName());
            ps.setString(4, p.getProductImage());
            ps.setLong(5, p.getProductPrice());
            ps.setLong(6, p.getProductQuantity());
            ps.setString(7, p.getProductDescription());
		         
            int temp = ps.executeUpdate();

        } catch (Exception e) {

	}
    }
    

	public boolean update(Product pro) throws SQLException {
	    try {
	         Connection connection = DBConnect.getConnection();
                 int temp = 0;
                 if(pro.getProductImage().length() == 0)
                 {
                    String sql = "UPDATE product SET product_name = ?, product_price = ?, product_description = ?,  category_id = ?, product_quantity = ? WHERE product_id = ?";
                    PreparedStatement ps = connection.prepareCall(sql);
                    ps.setString(1, pro.getProductName());
                    ps.setLong(2, pro.getProductPrice());
                    ps.setString(3, pro.getProductDescription());
                    ps.setLong(4, pro.getCategoryID());
                    ps.setLong(5, pro.getProductQuantity());
                    ps.setLong(6, pro.getProductID());
                    temp = ps.executeUpdate();
                    return temp == 1;
                 }
                 else
                 {
                    String sql = "UPDATE product SET product_name = ?, product_price = ?, product_description = ?,  category_id = ?, product_image = ?, product_quantity = ? WHERE product_id = ?";
                    PreparedStatement ps = connection.prepareCall(sql);
                    ps.setString(1, pro.getProductName());
                    ps.setLong(2, pro.getProductPrice());
                    ps.setString(3, pro.getProductDescription());
                    ps.setLong(4, pro.getCategoryID());
                    ps.setString(5, pro.getProductImage());
                     ps.setLong(6, pro.getProductQuantity());
                    ps.setLong(7, pro.getProductID());
                    temp = ps.executeUpdate();
                    return temp == 1;
                 }
	    } catch (Exception e) {
	         return false;
	    }
	}
       

        public boolean delete(long productid) throws SQLException {
            try {
                Connection connection = DBConnect.getConnection();
                String sql = "DELETE FROM product WHERE product_id = ?";
                PreparedStatement ps = connection.prepareCall(sql);
                ps.setLong(1, productid);
                int temp = ps.executeUpdate();
                    return temp == 1;
            } catch (Exception e) {
                return false;
            }
        }    
    
    public static void main(String[] args) throws SQLException {
        ProductDAO dao = new ProductDAO();
//        for (Product p : dao.getListProductByCategory(3)) {
//            System.out.println(p.getProductID() + " - " + p.getProductName());
//        }
        //System.out.println(dao.countProductByCategory(1));
        System.out.println(dao.countProduct());
       // productDAO.countProduct()
       // ArrayList<Product> list = dao.getListProductPageList(0, 8);
        //System.out.println(list.size());

        //dao.insert(new Product(dao.countProduct() + 1, 2, "Áo caro", "NULL", 120000, "ABC" ));
    }
    
}
