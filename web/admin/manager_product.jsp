<%@page import="model.Product"%>
<%@page import="dao.ProductDAO"%>
<%@page import="model.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.CategoryDAO"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Admin</title>
        <!-- Tell the browser to be responsive to screen width -->
         <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
         <link rel="icon" href="${pageContext.request.contextPath}/images/icon.ico" type="image/png" />
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <!-- Bootstrap 3.3.6 -->
        <link href="${pageContext.request.contextPath}/admin/content/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
        <!-- Ionicons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
        <!-- Theme style -->
        <link href="${pageContext.request.contextPath}/admin/content/dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css"/>
        <!-- AdminLTE Skins. Choose a skin from the css/skins
             folder instead of downloading all of them to reduce the load. -->

        <link href="${pageContext.request.contextPath}/admin/content/dist/css/skins/_all-skins.min.css" rel="stylesheet" type="text/css"/>
        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
    </head>
    <body class="hold-transition skin-blue sidebar-mini">

        <%
            if (session.getAttribute("userAdmin") == null) {
                response.sendRedirect("/admin/login.jsp");
            }
            ProductDAO productDAO = new ProductDAO();
            
            int pages = 1;
            int recordsPerPage = 5;
            if (request.getParameter("pages") != null) {
                pages = (int) Integer.parseInt(request.getParameter("pages"));
            }
            
            String keyword = "";
            if (request.getParameter("keyword") != null) {
                keyword = request.getParameter("keyword");
            }

            ArrayList<Product> listProduct = productDAO.getListProductPageList(keyword, (pages-1)*recordsPerPage, recordsPerPage);
            int noOfRecords = productDAO.countProduct();       
            int noOfPages = (int) Math.ceil(noOfRecords * 1.0 / recordsPerPage);
        %>

        <!-- Site wrapper -->
        <div class="wrapper">
            <jsp:include page="header.jsp"></jsp:include>
                <!-- =============================================== -->
                <!-- Left side column. contains the sidebar -->
            <jsp:include page="menu.jsp"></jsp:include>
                <!-- =============================================== -->
                <!-- Content Wrapper. Contains page content -->
                <div class="content-wrapper">
                    <!-- Content Header (Page header) -->
                    <section class="content-header">
                        <h1>
                            Danh mục sản phẩm

                        </h1>
                        <ol class="breadcrumb">
                            <li><a href="#"><i class="fa fa-dashboard"></i> Trang chủ</a></li>
                            <li class="active">Danh mục sản phẩm</li>
                        </ol>
                    </section>
                    <!-- Main content -->
                    <section class="content">
                        <!-- Default box -->
                        <div class="box">
                            <div class="box-header with-border">
                                <h3 class="box-title">Danh sách</h3>
                                <div class="box-tools pull-right">
                                    <button class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse"><i class="fa fa-minus"></i></button>
                                    <button class="btn btn-box-tool" data-widget="remove" data-toggle="tooltip" title="Remove"><i class="fa fa-times"></i></button>
                                </div>
                            </div>
                            <div class="box-body">
                                <div class="row">
                                    <form method="get" action="/ManagerProductServlet">
                                        <div class="col-md-6">
                                            <div class="input-group">
                                                <input type="text" class="form-control" name="keyword" value="<%=keyword%>" placeholder="Từ khóa">
                                                 <input type="hidden" name="command" value="search">
                                                <span class="input-group-btn">  
                                                    <button class="btn btn-default" type="submit" > 
                                                        Tìm kiếm
                                                    </button>
                                                </span>
                                            </div>
                                        </div>
                                    </form>

                                    <div class="col-md-6">
                                        <button onclick="window.location.href='insert_product.jsp'" class="btn btn-success">Thêm mới</button>
                                    </div>
                                </div>
                                                 <br>
                                <div class="row">     
                                    <div class="col-md-12 table-responsive">
                                    <table class="table table-bordered ">
                                        <tr>
                                            <th style="width: 5%">STT</th>
                                                <th style="width: 10%">Hình ảnh</th>
                                                <th style="width: 25%">Tên sản phẩm</th>
                                                <th style="width:25%">Thể loại</th>
                                                <th style="width: 10%">Giá bán</th>
                                                <th style="width: 10%">Số lượng tồn</th>
                                                <th style="width: 20%">Thao tác</th>
                                        </tr>
                                        <%                                            
                                            int count1 = 0;
                                            for (Product product : listProduct) {
                                                count1++;
                                        %>
                                        <tr>
                                            <td><%=count1%></td>
                                            <td>                                   
                                                <img src="${pageContext.request.contextPath}/<%=product.getProductImage()%>" class="img-responsive" alt="<%=product.getProductImage()%>">
                                            </td>                                   
                                            <td><%=product.getProductName() %></td>
                                             <td><%=product.getCategoryName() %></td>
                                            <td>
                                                <fmt:formatNumber type = "number" maxFractionDigits = "3" value = "<%=product.getProductPrice() %>" />
                                            </td>
                                             <td><%=product.getProductQuantity()%></td>
                                            <td>			                    		
                                                <a class="btn btn-sm btn-primary" href="edit_product.jsp?productID=<%=product.getProductID()%>">
                                                    <i class="fa fa-pencil"></i>
                                               </a>                                                
                                                <button class="btn  btn-sm btn-danger" onclick="deleteRecord(<%=product.getProductID()%>);">
                                                    <i class="fa fa-trash"></i>
                                                </button>
                                            </td>
                                        </tr>
                                        <%}%>
                                        <tfoot>
                                            <tr>
                                                <td colspan="7"><span class="pull-right">Trang: <%=(pages)%> - Tổng số bản ghi: <%=noOfRecords%></span></td>
                                            </tr>
                                        </tfoot>
                                    </table>
                                </div>
                                
                            </div>
                        </div><!-- /.box-body -->
                        <div class="box-footer">
                           
                            <ul class="pagination pagination-sm">
                                <li>
                                    <a href="#" aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>
                                <%for (int i = 1; i <= noOfPages; i++) {%>
                                    <li><a href="${pageContext.request.contextPath}/admin/manager_product.jsp?&pages=<%=i%>"><%=i%></a></li>
                                <%}%>
                                <li>
                                    <a href="#" aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                    </a>
                                </li>
                            </ul>
                        </div><!-- /.box-footer-->
                    </div><!-- /.box -->
                </section><!-- /.content -->
                <!-- /.content -->
            </div>
            <!-- /.content-wrapper -->
            <jsp:include page="footer.jsp"></jsp:include>
            <!-- Control Sidebar -->

        </div>
        <!-- ./wrapper -->
        <!-- jQuery 2.2.3 -->
        <script src="${pageContext.request.contextPath}/admin/content/plugins/jQuery/jQuery-2.1.4.min.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/admin/content/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        <!-- Bootstrap 3.3.6 -->
        <!-- SlimScroll -->
        <script src="${pageContext.request.contextPath}/admin/content/plugins/slimScroll/jquery.slimscroll.min.js"></script>
        <!-- FastClick -->
        <script src="${pageContext.request.contextPath}/admin/content/plugins/fastclick/fastclick.js"></script>
        <!-- AdminLTE App -->
        <script src="${pageContext.request.contextPath}/admin/content/dist/js/app.min.js"></script>
        <!-- AdminLTE for demo purposes -->
        <script src="${pageContext.request.contextPath}/admin/content/dist/js/demo.js"></script>
        
          <script language="javascript">
            function deleteRecord(id){
                var doIt=confirm('Bạn có muốn xóa sản phẩm này?');
                if(doIt){
                    var xhttp;
                    var url = "/ManagerProductServlet?command=delete&productidDele="+id;
                                           
                    if(window.XMLHttpRequest)
                    {
                        xhttp =new XMLHttpRequest();                                              
                    }
                    else
                    {
                        xhttp = new ActiveXObject("Microsoft.XMLHTTP");
                    }
                                           
                    xhttp.onreadystatechange = function(){
                    if(xhttp.readyState == 4)
                    {
                        alert('Xóa thành công');
                        window.location.reload();
                    }
                }
                                           
                xhttp.open("GET", url, true);
                xhttp.send();
            }
        }
      </script>
    </body>
</html>
