<%@page import="model.Users"%>
<%@page import="model.Cart"%>
<%@page import="java.util.Map"%>
<%@page import="model.Item"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html><head>
        <title>Shop Linh Tinh</title>
        <link rel="icon" href="${pageContext.request.contextPath}/images/icon.ico" type="image/png" />
        <!--css-->
        <link href="css/bootstrap.css" rel="stylesheet" type="text/css" media="all">
        <link href="css/style.css" rel="stylesheet" type="text/css" media="all">
        <link href="css/font-awesome.css" rel="stylesheet">
        <!--css-->
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <meta name="keywords" content="New Shop Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template, 
              Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design">
        <script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
        <script src="js/jquery.min.js"></script>
        <link href="//fonts.googleapis.com/css?family=Cagliostro" rel="stylesheet" type="text/css">
        <link href="//fonts.googleapis.com/css?family=Open+Sans:400,800italic,800,700italic,700,600italic,600,400italic,300italic,300" rel="stylesheet" type="text/css">
        <!--search jQuery-->
        <script src="js/main.js"></script>
        <!--search jQuery-->
        <script src="js/responsiveslides.min.js"></script>
        <script>
            $(function () {
                $("#slider").responsiveSlides({
                    auto: true,
                    nav: true,
                    speed: 500,
                    namespace: "callbacks",
                    pager: true,
                });
            });
        </script>
        <!--mycart-->
        <script type="text/javascript" src="js/bootstrap-3.1.1.min.js"></script>
        <!-- cart -->
        <script src="js/simpleCart.min.js"></script>
        <!-- cart -->
        <!--start-rate-->
        <script src="js/jstarbox.js"></script>
        <link rel="stylesheet" href="css/jstarbox.css" type="text/css" media="screen" charset="utf-8">
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
    </head>
    <body>

        <%
            Cart cart = (Cart) session.getAttribute("cart");
            if (cart == null) {
                cart = new Cart();
                session.setAttribute("cart", cart);
            }
            Users users = (Users) session.getAttribute("user");
            if (users == null) {
                response.sendRedirect("/login.jsp");
            }
        %>

        <!--header-->
        <jsp:include page="header.jsp"></jsp:include>
            <!--header-->
            <!--content-->
            <div class="content">
                <div class="cart-items">
                    <div class="container">
                    <%if (cart.countItem() == 0) {
                    %>
                    <h1>Giỏ Hàng Rỗng</h1>
                    ${requestScope['javax.servlet.forward.request_uri']}
                    <%
                    } else {
                    %>

                    <table class="table" style="text-align: center;">
                        <tr style="background-color: #4CAF50; color: white;">
                            <td style="background-color: #4CAF50; color: white;">Mã SP</td>
                            <td style="background-color: #4CAF50; color: white;">Tên SP</td>
                            <td style="background-color: #4CAF50; color: white;">Hình ảnh</td>
                            <td style="background-color: #4CAF50; color: white;">Số lượng</td>
                            <td style="background-color: #4CAF50; color: white;">Đơn giá</td>
                            <td style="background-color: #4CAF50; color: white;">Thành tiền</td>
                            <td></td>
                        </tr>
                        <%
                            for (Map.Entry<Long, Item> item : cart.getCartItems().entrySet()) {
                        %>
                        <tr style="background-color: #f2f2f2;">
                            <td><%=item.getValue().getProduct().getProductID()%></td>
                            <td><%=item.getValue().getProduct().getProductName()%></td>
                            <td><img src="<%=item.getValue().getProduct().getProductImage()%>" width="100" height="100" /></td>
                            <td><%=item.getValue().getQuantity()%></td>
                            <td><%=item.getValue().getProduct().getProductPrice()%> VNĐ</td>
                            <td><%=item.getValue().getProduct().getProductPrice() * item.getValue().getQuantity()%> VNĐ</td>
                            <td>
                                <a href="CartServlet?command=remove&productID=<%=item.getValue().getProduct().getProductID()%>">Xóa</a> 
                            </td>

                        </tr>

                        <%
                            }
                        %>
                    </table>
                    
                    <br/>
                    <br/>
                    <form action="CheckOutServlet" method="post">
                        <div class="clearfix"></div>
                        <br/>
                        <div><h2 style="text-align: center;">Thông tin khách hàng</h2></div>
                        <br/>
                        <div>
                            <div class="form-group">
                                <label for="DiaChi">Địa chỉ:</label>
                                <textarea class="form-control" rows="5" id="DiaChi" name="address" data-error="#errDiaChi"></textarea>
                                <span style="color: red" id="errDiaChi"></span>
                            </div>
                            <div class="form-group">
                                <label for="SoDienThoai">Số điện thoại:</label>
                                <input type="text" class="form-control" id="SoDienThoai" name="phone" data-error="#errSDT">
                                <span style="color: red" id="errSDT"></span>
                            </div>
                        </div>
                        <input type="submit" value="Đặt hàng" class="btn btn-success" id="btnDatHang"/>
                    </form>
                    <%
                        }
                    %>
                </div>
            </div>
            <!-- checkout -->	
        </div>
        <!--content-->
        <!---footer--->
        <jsp:include page="footer.jsp"></jsp:include>
        <!---footer--->
    </body>
</html>