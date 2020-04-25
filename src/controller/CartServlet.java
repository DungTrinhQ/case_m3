package controller;

import dao.ProductDAO;
import model.Cart;
import model.Item;
import model.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "CartServlet", urlPatterns = {"/CartServlet"})
public class CartServlet extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String command = request.getParameter("command");
        String productID = request.getParameter("productID");
        String categoryID = request.getParameter("categoryID");
        Cart cart = (Cart) session.getAttribute("cart");

        try {
            Long idProduct = Long.parseLong(productID);
            Product product = productDAO.getProduct(idProduct);
            switch (command) {
                case "plus":
                    if (cart.getCartItems().containsKey(idProduct)) {
                        cart.plusToCart(idProduct, new Item(product,
                                cart.getCartItems().get(idProduct).getQuantity()));
                    } else {
                        cart.plusToCart(idProduct, new Item(product, 1));
                    }
                    break;
                case "single":
                    if (cart.getCartItems().containsKey(idProduct)) {
                        cart.plusToCart(idProduct, new Item(product,
                                cart.getCartItems().get(idProduct).getQuantity()));
                    } else {
                        cart.plusToCart(idProduct, new Item(product, 1));
                    }

                    break;
                case "remove":
                    cart.removeToCart(idProduct);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("/index.jsp");
        }
        if (command == "remove") {
            session.setAttribute("cart", cart);
            response.sendRedirect("/checkout.jsp");
        } else if (command.equals("plus")) {
            session.setAttribute("cart", cart);
            response.sendRedirect("product.jsp?categoryID=" + categoryID + "&pages=1");
        } else if (command.equals("single")) {
            session.setAttribute("cart", cart);
            response.sendRedirect("single.jsp?productID=" + productID);
        }

    }

}
