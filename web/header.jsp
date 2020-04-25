<%@page import="model.Cart"%>
<%@page import="model.Users"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>

        <%
            Users users = null;
            if (session.getAttribute("user") != null) {
                users = (Users) session.getAttribute("user");
            }
            Cart cart = (Cart) session.getAttribute("cart");
            if (cart == null) {
                cart = new Cart();
                session.setAttribute("cart", cart);
            }

        %>

        <div class="header">
            <div class="header-top">
                <div class="container">
                    <div class="top-left">
                        <a href="#"> Trợ giúp  <i class="glyphicon glyphicon-phone" aria-hidden="true"></i> 0329400927</a>
                    </div>
                    <div class="top-right">
                        <ul>
                            <li><a href="checkout.jsp">Thanh toán</a></li>
                                <%
                                    if (session.getAttribute("user") != null) {
                                %>
                                 <li><a href="#"><%=users.getUserName()%></a></li>
                                  <li><a href="UsersServlet"> Đăng xuất </a></li>
                            <%
                                }else
                                {
                            %>
                            <li><a href="login.jsp">Đăng nhập</a></li>
                            <li><a href="register.jsp"> Đăng ký </a></li>
                            <%
                                }
                            %>
                        </ul>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
            <div class="heder-bottom">
                <div class="container">
                    <div class="logo-nav">
                        <div class="logo-nav-left">
                            <h1><a href="index.jsp">Group 4 <span>Shop fashion</span></a></h1>
                        </div>
                        <jsp:include page="menu.jsp"></jsp:include>
                            <div class="logo-nav-right">
                                <ul class="cd-header-buttons">
                                    <li><a class="cd-search-trigger" href="#cd-search"> <span></span></a></li>
                                </ul> <!-- cd-header-buttons -->
                                <div id="cd-search" class="cd-search">
                                    <form action="#" method="post">
                                        <input name="Search" type="search" placeholder="Search...">
                                    </form>
                                </div>	
                            </div>
                            <div class="header-right2">
                                <div class="cart box_1">
                                    <a href="checkout.jsp">
                                        <h3> <div class="total">
                                            <span ><fmt:formatNumber type = "number" maxFractionDigits = "3" value = "<%=cart.totalCart()%>" /></span> (<span><%=cart.count()%></span> items)</div>
                                        <img src="images/bag.png" alt="">
                                    </h3>
                                </a>
                                <div class="clearfix"> </div>
                            </div>	
                        </div>
                        <div class="clearfix"> </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
