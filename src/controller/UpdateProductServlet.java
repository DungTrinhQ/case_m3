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
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;


@WebServlet(name = "UpdateProductServlet", urlPatterns = {"/UpdateProductServlet"})
public class UpdateProductServlet extends HttpServlet {
    
    ProductDAO productDAO  = new ProductDAO();

    private static final String UPLOAD_DIRECTORY = "upload";

    private static final int MEMORY_THRESHOLD = 1024 * 1024 * 3;  // 3MB
    private static final int MAX_FILE_SIZE = 1024 * 1024 * 40; // 40MB
    private static final int MAX_REQUEST_SIZE = 1024 * 1024 * 50; // 50MB
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
   
        String url = "";

        boolean isMultipart = ServletFileUpload.isMultipartContent(request);
        if (!isMultipart) {
            return ;
        }
        

        DiskFileItemFactory factory = new DiskFileItemFactory();

        factory.setSizeThreshold(MEMORY_THRESHOLD);

        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));

        ServletFileUpload upload = new ServletFileUpload(factory);

        upload.setFileSizeMax(MAX_FILE_SIZE);

        upload.setSizeMax(MAX_REQUEST_SIZE);


        String uploadPath = getServletContext().getRealPath("")
                + File.separator + UPLOAD_DIRECTORY;


        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }
        
        try {
            @SuppressWarnings("unchecked")
            List<FileItem> formItems = upload.parseRequest(request);

            String product_name = "";
            long id = 0;
            long category_id = 0;
            long price = 0;
            long quantity = 0;
            String description = "";
            String fileName = "";
            String filePath = "";
            
            if (formItems != null && formItems.size() > 0) {
                int i = 0;
                for (FileItem item : formItems) {
                    i = i + 1;
                    if(i == 1){     
                         id = Long.parseLong(item.getString());
                       
                    }
                     else if(i == 2){
                        product_name = new String(item.getString().getBytes("iso-8859-1"), "UTF-8");
                    }
                    else if(i == 3){
                        category_id = Long.parseLong(item.getString());
                    }
                    else if(i == 4){
                        String valuePrice = item.getString().replace(",", "").replace(".", "");
                        price = Long.parseLong(valuePrice);
                    }
                    else if(i == 5){
                       
                        quantity = Long.parseLong(item.getString());
                    }
                    else if (!item.isFormField()) 
                    {
                        fileName = new File(item.getName()).getName();
                        
                        if(fileName.length() != 0)
                        {
                             filePath = uploadPath + File.separator + fileName;
                            File storeFile = new File(filePath);

                            item.write(storeFile);
                        }                     
                    }               
                    else if(i == 7){
                        description = new String(item.getString().getBytes("iso-8859-1"), "UTF-8");
                        
                        try{
                            if(fileName.length() == 0)
                            {
                                 String img = "upload/" + fileName;        
                                 String cateName = "";
                                 productDAO.update(new Product(id, category_id, product_name, fileName, price, quantity , description, cateName));
                                 url = "admin/manager_product.jsp?pages=1";                        
                            }
                            else
                            {
                                 String img = "upload/" + fileName;                
                                 String cateName = "";
                                 productDAO.update(new Product(id, category_id, product_name, img, price, quantity , description, cateName));
                                 url = "admin/manager_product.jsp?pages=1"; 
                            } 
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
