<%@page import="tools.FormatPrice"%>
<%@page import="dao.CategoryDAO"%>
<%@page import="model.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Product"%>
<%@page import="model.Cart"%>
<%@page import="dao.ProductDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
    <head>
        <title> Shop Linh Tinh</title>
        <!--css-->
        <link rel="icon" href="${pageContext.request.contextPath}/images/icon.ico" type="image/png" />
        <link href="css/bootstrap.css" rel="stylesheet" type="text/css" media="all"/>
        <link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
        <link href="css/font-awesome.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="css/jquery-ui.css">
        <!--css-->
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="keywords" content="" />
        <script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
        <script src="js/jquery.min.js"></script>
        <link href='//fonts.googleapis.com/css?family=Cagliostro' rel='stylesheet' type='text/css'>
        <link href='//fonts.googleapis.com/css?family=Open+Sans:400,800italic,800,700italic,700,600italic,600,400italic,300italic,300' rel='stylesheet' type='text/css'>
        <!--search jQuery-->
        <script src="js/main.js"></script>
        <!--search jQuery-->

        <!--mycart-->
        <script type="text/javascript" src="js/bootstrap-3.1.1.min.js"></script>
        <!-- cart -->
        <script src="js/simpleCart.min.js"></script>
        <!-- cart -->

    </head>
    <body>

        <%
            ProductDAO productDAO = new ProductDAO();
            CategoryDAO categoryDAO = new CategoryDAO();
            
            long categoryID = 0;
            if (request.getParameter("categoryID") != null) {
                categoryID = (long) Long.parseLong(request.getParameter("categoryID"));
            }
            Cart cart = (Cart) session.getAttribute("cart");
            if (cart == null) {
                cart = new Cart();
                session.setAttribute("cart", cart);
            }
            
            // Phân trang
            int pages = 0, firstResult = 0, maxResult = 0, total = 0;
            if (request.getParameter("pages") != null) {
                pages = (int) Integer.parseInt(request.getParameter("pages"));
            }

            total = productDAO.countProductByCategory(categoryID);
            if (total <= 8) {
                firstResult = 1;
                maxResult = total;
            } else {
                firstResult = (pages - 1) * 8;
                maxResult = 8;
            }

            ArrayList<Product> listProduct = productDAO.getListProductByNav(
                    categoryID, firstResult, maxResult);
        %>
        <!--header-->
        <jsp:include page="header.jsp"></jsp:include>
            <!--header-->
            <!--content-->
            <div class="content">
                <div class="products-agileinfo">
                    <div class="container">
                        <div class="product-agileinfo-grids w3l">
                            <div class="col-md-3 product-agileinfo-grid">
                                <div class="categories">
                                    <h3>Danh mục</h3>
                                    <ul class="tree-list-pad">
                                        <li><input type="checkbox" checked="checked" id="item-0" /><label for="item-0"><span></span>Thời trang nữ</label>
                                            <ul>
                                            <%
                                                for (Category c : categoryDAO.getListCategoryForWomen()) {
                                            %>
                                                <li><a href="product.jsp?categoryID=<%=c.getCategoryID()%>&pages=1"><%=c.getCategoryName()%></a></li>
                                            <%
                                                }
                                            %>
                                            </ul>
                                        </li>
                                        <li><input type="checkbox" checked="checked" id="item-0" /><label for="item-0"><span></span>Thời trang nam</label>
                                            <ul>
                                            <%
                                                for (Category c : categoryDAO.getListCategoryForMen()) {
                                            %>
                                                <li><a href="product.jsp?categoryID=<%=c.getCategoryID()%>&pages=1"><%=c.getCategoryName()%></a></li>
                                            <%
                                                }
                                            %>
                                            </ul>
                                        </li>
                                    </ul>
                                </div>

                            </div>
                            <div class="col-md-9 product-agileinfon-grid1 w3l">

                                <div class="bs-example bs-example-tabs" role="tabpanel" data-example-id="togglable-tabs">
                                    <ul id="myTab" class="nav1 nav1-tabs left-tab" role="tablist">

                                        <div id="myTabContent" class="tab-content">
                                            <div role="tabpanel" class="tab-pane fade in active" id="home" aria-labelledby="home-tab">
                                                <div class="product-tab">
                                                <%
                                                    FormatPrice format = new FormatPrice();
                                                    for (Product p : listProduct) {
                                                %>
                                                <div class="col-md-4 product-tab-grid simpleCart_shelfItem" style="margin-bottom: 50px;">
                                                    <div class="grid-arr">
                                                        <div  class="grid-arrival">
                                                            <figure>		
                                                                <a href="single.jsp?productID=<%=p.getProductID()%>" class="new-gri" data-toggle="modal" data-target="#myModal1">
                                                                    <div class="grid-img">
                                                                        <a href="single.jsp?productID=<%=p.getProductID()%>">
                                                                            <img  src="<%=p.getProductImage()%>" class="img-responsive" alt="<%=p.getProductName()%>">
                                                                        </a>
                                                                    </div>		
                                                                </a>		
                                                            </figure>	
                                                        </div>
                                                        <div class="block">
                                                            <div class="starbox small ghosting"> </div>
                                                        </div>
                                                        <div class="women">
                                                            <h6><a href="single.jsp?productID=<%=p.getProductID()%>"><%=p.getProductName()%></a></h6>
                                                            <span class="size">XL / XXL / S </span>
                                                            <p><em><%=format.formatNumber(p.getProductPrice())%></em> VND</p>
                                                            <a href="CartServlet?command=plus&productID=<%=p.getProductID()%>&categoryID=<%=categoryID%>" data-text="Add To Cart" class="my-cart-b item_add">Thêm vào giỏ hàng</a>
                                                        </div>
                                                    </div>
                                                </div>
                                                <%
                                                    }
                                                %>


                                            </div>
                                            <div class="clearfix"> </div>  

                                            <nav aria-label="Page navigation">
                                                <ul class="pagination pagination-lg">
                                                    <li>
                                                        <a href="#" aria-label="Previous">
                                                            <span aria-hidden="true">&laquo;</span>
                                                        </a>
                                                    </li>
                                                    <%for(int i=1;i<=(total/8)+1;i++){%>
                                                    <li><a href="product.jsp?categoryID=<%=categoryID%>&pages=<%=i%>"><%=i%></a></li>
                                                    <%}%>
                                                    <li>
                                                        <a href="#" aria-label="Next">
                                                            <span aria-hidden="true">&raquo;</span>
                                                        </a>
                                                    </li>
                                                </ul>
                                            </nav>
                                            
                                        </div>
                                        <div role="tabpanel" class="tab-pane fade" id="profile" aria-labelledby="profile-tab">
                                            <div class="product-tab1">
                                                <div class="col-md-4 product-tab1-grid">
                                                    <div class="grid-arr">
                                                        <div  class="grid-arrival">
                                                            <figure>		
                                                                <a href="#" class="new-gri" data-toggle="modal" data-target="#myModal1">
                                                                    <div class="grid-img">
                                                                        <img  src="images/p6.jpg" class="img-responsive" alt="">
                                                                    </div>
                                                                    <div class="grid-img">
                                                                        <img  src="images/p5.jpg" class="img-responsive"  alt="">
                                                                    </div>			
                                                                </a>		
                                                            </figure>	
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-8 product-tab1-grid1 simpleCart_shelfItem">
                                                    <div class="block">
                                                        <div class="starbox small ghosting"> </div>
                                                    </div>
                                                    <div class="women">
                                                        <h6><a href="single.html">Sed ut perspiciatis unde</a></h6>
                                                        <span class="size">XL / XXL / S </span>
                                                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Atqui iste locus est, Piso, tibi etiam atque etiam confirmandus, inquam; Refert tamen, quo modo. Quod autem meum munus dicis non equidem recuso, sed te adiungo socium. </p>
                                                        <p ><del>$100.00</del><em class="item_price">$70.00</em></p>
                                                        <a href="#" data-text="Add To Cart" class="my-cart-b item_add">Add To Cart</a>
                                                    </div>
                                                </div>
                                                <div class="clearfix"></div>
                                            </div>
                                            <div class="product-tab1 prod3">
                                                <div class="col-md-4 product-tab1-grid">
                                                    <div class="grid-arr">
                                                        <div  class="grid-arrival">
                                                            <figure>		
                                                                <a href="#" class="new-gri" data-toggle="modal" data-target="#myModal1">
                                                                    <div class="grid-img">
                                                                        <img  src="images/i2.jpg" class="img-responsive" alt="">
                                                                    </div>
                                                                    <div class="grid-img">
                                                                        <img  src="images/i1.jpg" class="img-responsive"  alt="">
                                                                    </div>			
                                                                </a>		
                                                            </figure>	
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-8 product-tab1-grid1 simpleCart_shelfItem">
                                                    <div class="block">
                                                        <div class="starbox small ghosting"> </div>
                                                    </div>
                                                    <div class="women">
                                                        <h6><a href="single.html">Sed ut perspiciatis unde</a></h6>
                                                        <span class="size">XL / XXL / S </span>
                                                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Atqui iste locus est, Piso, tibi etiam atque etiam confirmandus, inquam; Refert tamen, quo modo. Quod autem meum munus dicis non equidem recuso, sed te adiungo socium. </p>
                                                        <p ><del>$100.00</del><em class="item_price">$70.00</em></p>
                                                        <a href="#" data-text="Add To Cart" class="my-cart-b item_add">Add To Cart</a>
                                                    </div>
                                                </div>
                                                <div class="clearfix"></div>
                                            </div>
                                            <div class="product-tab1">
                                                <div class="col-md-4 product-tab1-grid">
                                                    <div class="grid-arr">
                                                        <div  class="grid-arrival">
                                                            <figure>		
                                                                <a href="#" class="new-gri" data-toggle="modal" data-target="#myModal1">
                                                                    <div class="grid-img">
                                                                        <img  src="images/i4.jpg" class="img-responsive" alt="">
                                                                    </div>
                                                                    <div class="grid-img">
                                                                        <img  src="images/i3.jpg" class="img-responsive"  alt="">
                                                                    </div>			
                                                                </a>		
                                                            </figure>	
                                                        </div>

                                                    </div>
                                                </div>
                                                <div class="col-md-8 product-tab1-grid1 simpleCart_shelfItem">
                                                    <div class="block">
                                                        <div class="starbox small ghosting"> </div>
                                                    </div>
                                                    <div class="women">
                                                        <h6><a href="single.html">Sed ut perspiciatis unde</a></h6>
                                                        <span class="size">XL / XXL / S </span>
                                                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Atqui iste locus est, Piso, tibi etiam atque etiam confirmandus, inquam; Refert tamen, quo modo. Quod autem meum munus dicis non equidem recuso, sed te adiungo socium. </p>
                                                        <p ><del>$100.00</del><em class="item_price">$70.00</em></p>
                                                        <a href="#" data-text="Add To Cart" class="my-cart-b item_add">Add To Cart</a>
                                                    </div>
                                                </div>
                                                <div class="clearfix"></div>
                                            </div>
                                            <div class="product-tab1 prod3">
                                                <div class="col-md-4 product-tab1-grid">
                                                    <div class="grid-arr">
                                                        <div  class="grid-arrival">
                                                            <figure>		
                                                                <a href="#" class="new-gri" data-toggle="modal" data-target="#myModal1">
                                                                    <div class="grid-img">
                                                                        <img  src="images/i6.jpg" class="img-responsive" alt="">
                                                                    </div>
                                                                    <div class="grid-img">
                                                                        <img  src="images/i5.jpg" class="img-responsive"  alt="">
                                                                    </div>			
                                                                </a>		
                                                            </figure>	
                                                        </div>

                                                    </div>
                                                </div>
                                                <div class="col-md-8 product-tab1-grid1 simpleCart_shelfItem">
                                                    <div class="block">
                                                        <div class="starbox small ghosting"> </div>
                                                    </div>
                                                    <div class="women">
                                                        <h6><a href="single.html">Sed ut perspiciatis unde</a></h6>
                                                        <span class="size">XL / XXL / S </span>
                                                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Atqui iste locus est, Piso, tibi etiam atque etiam confirmandus, inquam; Refert tamen, quo modo. Quod autem meum munus dicis non equidem recuso, sed te adiungo socium. </p>
                                                        <p ><del>$100.00</del><em class="item_price">$70.00</em></p>
                                                        <a href="#" data-text="Add To Cart" class="my-cart-b item_add">Add To Cart</a>
                                                    </div>
                                                </div>
                                                <div class="clearfix"></div>
                                            </div>
                                            <div class="product-tab1">
                                                <div class="col-md-4 product-tab1-grid">
                                                    <div class="grid-arr">
                                                        <div  class="grid-arrival">
                                                            <figure>		
                                                                <a href="#" class="new-gri" data-toggle="modal" data-target="#myModal1">
                                                                    <div class="grid-img">
                                                                        <img  src="images/i8.jpg" class="img-responsive" alt="">
                                                                    </div>
                                                                    <div class="grid-img">
                                                                        <img  src="images/i7.jpg" class="img-responsive"  alt="">
                                                                    </div>			
                                                                </a>		
                                                            </figure>	
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-8 product-tab1-grid1 simpleCart_shelfItem">
                                                    <div class="block">
                                                        <div class="starbox small ghosting"> </div>
                                                    </div>
                                                    <div class="women">
                                                        <h6><a href="single.html">Sed ut perspiciatis unde</a></h6>
                                                        <span class="size">XL / XXL / S </span>
                                                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Atqui iste locus est, Piso, tibi etiam atque etiam confirmandus, inquam; Refert tamen, quo modo. Quod autem meum munus dicis non equidem recuso, sed te adiungo socium. </p>
                                                        <p ><del>$100.00</del><em class="item_price">$70.00</em></p>
                                                        <a href="#" data-text="Add To Cart" class="my-cart-b item_add">Add To Cart</a>
                                                    </div>
                                                </div>
                                                <div class="clearfix"></div>
                                            </div>

                                        </div>
                                    </div>
                            </div>
                        </div>
                        <div class="clearfix"> </div>
                    </div>
                </div>
            </div>
        </div>
        <!--content-->
        <!---footer--->
        <jsp:include page="footer.jsp"></jsp:include>
        <!---footer--->

    </body>
</html>