<%@page import="tools.FormatPrice"%>
<%@page import="model.Product"%>
<%@page import="dao.ProductDAO"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
    <head>
        <title>Shop Linh Tinh</title>
        <link rel="icon" href="${pageContext.request.contextPath}/images/icon.ico" type="image/png" />
        <!--css-->
        <link href="css/bootstrap.css" rel="stylesheet" type="text/css" media="all"/>
        <link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
        <link href="css/font-awesome.css" rel="stylesheet">
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
        <script type="text/javascript" src="js/bootstrap-3.1.1.min.js"></script>
        <!-- cart -->
        <script src="js/simpleCart.min.js"></script>
        <!-- cart -->
        <script defer src="js/jquery.flexslider.js"></script>
        <link rel="stylesheet" href="css/flexslider.css" type="text/css" media="screen" />
        <script src="js/imagezoom.js"></script>
        <script>
            // Can also be used with $(document).ready()
            $(window).load(function () {
                $('.flexslider').flexslider({
                    animation: "slide",
                    controlNav: "thumbnails"
                });
            });
        </script>

        <!--mycart-->
        <!--start-rate-->
        <script src="js/jstarbox.js"></script>
        <link rel="stylesheet" href="css/jstarbox.css" type="text/css" media="screen" charset="utf-8" />
        <script type="text/javascript">
            jQuery(function () {
                jQuery('.starbox').each(function () {
                    var starbox = jQuery(this);
                    starbox.starbox({
                        average: starbox.attr('data-start-value'),
                        changeable: starbox.hasClass('unchangeable') ? false : starbox.hasClass('clickonce') ? 'once' : true,
                        ghosting: starbox.hasClass('ghosting'),
                        autoUpdateAverage: starbox.hasClass('autoupdate'),
                        buttons: starbox.hasClass('smooth') ? false : starbox.attr('data-button-count') || 5,
                        stars: starbox.attr('data-star-count') || 5
                    }).bind('starbox-value-changed', function (event, value) {
                        if (starbox.hasClass('random')) {
                            var val = Math.random();
                            starbox.next().text(' ' + val);
                            return val;
                        }
                    })
                });
            });
        </script>
        <!--//End-rate-->
        <link href="css/owl.carousel.css" rel="stylesheet">
        <script src="js/owl.carousel.js"></script>
        <script>
            $(document).ready(function () {
                $("#owl-demo").owlCarousel({
                    items: 1,
                    lazyLoad: true,
                    autoPlay: true,
                    navigation: false,
                    navigationText: false,
                    pagination: true,
                });
            });
        </script>

    </head>
    <body>
        
        <%
            ProductDAO productDAO = new ProductDAO();
            Product product = new Product();
            String productID = "";
            if (request.getParameter("productID") != null) {
                productID = request.getParameter("productID");
                product = productDAO.getProduct(Long.parseLong(productID));
            }
            FormatPrice format = new FormatPrice();
        %>
        
        <!--header-->
        <jsp:include page="header.jsp"></jsp:include>
        <!--header-->

        <!--content-->
        <div class="content">
            <!--single-->
            <div class="single-wl3">
                <div class="container">
                    <div class="single-grids">
                        <div class="col-md-9 single-grid">
                            <div clas="single-top">
                                <div class="single-left">
                                    <div class="flexslider">
                                        <ul class="slides">
                                            <li data-thumb="${pageContext.request.contextPath}/<%=product.getProductImage()%>">
                                                <div class="thumb-image"> <img src="${pageContext.request.contextPath}/<%=product.getProductImage()%>" data-imagezoom="true" class="img-responsive"> </div>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="single-right simpleCart_shelfItem">
                                    <h4><%=product.getProductName()%></h4>
                                    
                                    <p class="price item_price"><fmt:formatNumber type = "number" maxFractionDigits = "3" value = "<%=product.getProductPrice() %>" /> VND</p>
                                    <div class="description">
                                        <p><span>Mô tả ngắn : </span> <%=product.getProductDescription()%> </p>
                                    </div>
                                    <div class="women">
                                        <span class="size">XL / XXL / S </span>
                                        <a href="CartServlet?command=single&productID=<%=product.getProductID()%>" data-text="Add To Cart" class="my-cart-b item_add">Add To Cart</a>
                                    </div>
                                    <div class="social-icon">
                                        <a href="#"><i class="icon"></i></a>
                                        <a href="#"><i class="icon1"></i></a>
                                        <a href="#"><i class="icon2"></i></a>
                                        <a href="#"><i class="icon3"></i></a>
                                    </div>
                                </div>
                                <div class="clearfix"> </div>
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