<%@page import="model.Category"%>
<%@page import="dao.CategoryDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            CategoryDAO categoryDAO = new CategoryDAO();
        %>
        <div class="logo-nav-left1">
            <nav class="navbar navbar-default">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header nav_2">
                    <button type="button" class="navbar-toggle collapsed navbar-toggle1" data-toggle="collapse" data-target="#bs-megadropdown-tabs">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                </div> 
                <div class="collapse navbar-collapse" id="bs-megadropdown-tabs">
                    <ul class="nav navbar-nav">
                        <li class="active"><a href="index.jsp" class="act">Trang chủ</a></li>	
                        <!-- Mega Menu -->
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Nữ <b class="caret"></b></a>
                            <ul class="dropdown-menu multi-column columns-3">
                                <div class="row">
                                    <div class="col-sm-3  multi-gd-img">
                                        <ul class="multi-column-dropdown">
                                            <h6>For Women</h6>
                                            <%
                                                for (Category c : categoryDAO.getListCategoryForWomen()) {
                                            %>
                                                <li><a href="product.jsp?categoryID=<%=c.getCategoryID()%>&pages=1"><%=c.getCategoryName()%></a></li>
                                            <%
                                                }
                                            %>
                                        </ul>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                            </ul>
                        </li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Nam <b class="caret"></b></a>
                            <ul class="dropdown-menu multi-column columns-3">
                                <div class="row">
                                    <div class="col-sm-3  multi-gd-img">
                                        <ul class="multi-column-dropdown">
                                            <h6>For Men</h6>
                                            <%
                                                for (Category c : categoryDAO.getListCategoryForMen()) {
                                            %>
                                                <li><a href="product.jsp?categoryID=<%=c.getCategoryID()%>&pages=1"><%=c.getCategoryName()%></a></li>
                                            <%
                                                }
                                            %>
                                        </ul>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                            </ul>
                        </li>
                        <li><a href="contact.jsp">Liên hệ</a></li>
                    </ul>
                </div>
            </nav>
        </div>
    </body>
</html>
