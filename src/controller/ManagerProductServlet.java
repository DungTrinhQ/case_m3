package controller;

import dao.ProductDAO;
import model.Product;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;


@WebServlet("/ManagerProductServlet")
public class ManagerProductServlet extends HttpServlet {

    ProductDAO productDAO  = new ProductDAO();
    private static final String UPLOAD_DIRECTORY = "upload";

    private static final int MEMORY_THRESHOLD = 1024 * 1024 * 3;  // 3MB
    private static final int MAX_FILE_SIZE = 1024 * 1024 * 40; // 40MB
    private static final int MAX_REQUEST_SIZE = 1024 * 1024 * 50; // 50MB
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
        
        String command = request.getParameter("command");         

        String url = "";
        try{       
            if(command.equals("delete"))
            {          
                long idDelete = Long.parseLong(request.getParameter("productidDele"));
                productDAO.delete(idDelete);
                url = "/admin/manager_product.jsp";       
            }
            else if(command.equals("search"))
            {
                 String keyword = request.getParameter("keyword");
                 url = "admin/manager_product.jsp?pages=1&keyword=" + keyword;    
            }
	}
	catch(Exception ex){
            Logger.getLogger(ManagerProductServlet.class.getName()).log(Level.SEVERE, null, ex);
	}
       
        response.sendRedirect(url); 
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
        String url = "";
        
        // checks if the request actually contains upload file
        boolean isMultipart = ServletFileUpload.isMultipartContent(request);
        if (!isMultipart) {
            return;
        }
        
       // configures upload settings
        DiskFileItemFactory factory = new DiskFileItemFactory();
        // sets memory threshold - beyond which files are stored in disk 
        factory.setSizeThreshold(MEMORY_THRESHOLD);
        // sets temporary location to store files
        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));

        ServletFileUpload upload = new ServletFileUpload(factory);

        // sets maximum size of upload file
        upload.setFileSizeMax(MAX_FILE_SIZE);

        // sets maximum size of request (include file + form data)
        upload.setSizeMax(MAX_REQUEST_SIZE);

        // constructs the directory path to store upload file
        // this path is relative to application's directory
        String uploadPath = getServletContext().getRealPath("")
                + File.separator + UPLOAD_DIRECTORY;

        // creates the directory if it does not exist
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }
        
        try {
            @SuppressWarnings("unchecked")
            List<FileItem> formItems = upload.parseRequest(request);
            
            /*String command = request.getParameter("command");  
            String product_name = request.getParameter("productname");
            long category_id = Long.parseLong(request.getParameter("categoryid"));
            long price = Long.parseLong(request.getParameter("price"));
            String description = request.getParameter("description");*/
            
            String product_name = "";
            long category_id = 0;
            long price = 0;
            long quantity = 0;
            String description = "";
            String fileName = "";
            String filePath = "";
            
            if (formItems != null && formItems.size() > 0) {
                // iterates over form's fields
                int i = 0;
                for (FileItem item : formItems) {
                    i = i + 1;
                    if(i == 1){     
                        product_name = new String(item.getString().getBytes("iso-8859-1"), "UTF-8");
                    }
                    else if(i == 2){
                        category_id = Long.parseLong(item.getString());
                    }
                    else if(i == 3){
                        String valuePrice = item.getString().replace(",", "").replace(".", "");
                        price = Long.parseLong(valuePrice);
                    }
                    else if(i == 4){                
                        quantity = Long.parseLong(item.getString());
                    }
                    else if (!item.isFormField()) 
                    {
                        fileName = new File(item.getName()).getName();
                        filePath = uploadPath + File.separator + fileName;
                        File storeFile = new File(filePath);
                        // saves the file on disk
                        item.write(storeFile);
                    }                 
                    else if(i == 6){
                        description = new String(item.getString().getBytes("iso-8859-1"), "UTF-8");
                        
                        try{
                            //int count = productDAO.countProduct();  
                            String img = "upload/" + fileName;
                            String cateName = "";
                            productDAO.insert(new Product(new Date().getTime(),category_id, product_name, img, price, quantity, description, cateName));
                            url = "admin/manager_product.jsp?pages=1";  
                        }
                        catch(SQLException ex){
                            Logger.getLogger(ManagerProductServlet.class.getName()).log(Level.SEVERE, null, ex);
                            url = "/admin/insert_product.jsp";	
                        } 
                    }
                }
            }   
        } catch (Exception ex) {
            url = "/admin/insert_product.jsp";
        }
        
        response.sendRedirect(url);
    }
}
