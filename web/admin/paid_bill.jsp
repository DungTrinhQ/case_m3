<%@page import="dao.ProductDAO"%>
<%@page import="dao.UsersDAO"%>
<%@page import="model.Bill"%>
<%@page import="dao.BillDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.BillDetailDAO"%>
<%@page import="model.BillDetail"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Admin</title>
    <link rel="icon" href="${pageContext.request.contextPath}/images/icon.ico" type="image/png" />
    <!-- Tell the browser to be responsive to screen width -->
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
        BillDetailDAO billDetailDAO = new BillDetailDAO();
        ArrayList<BillDetail> listProduct;

        String billID = "";
        if (request.getParameter("billID") != null) {
            billID = request.getParameter("billID");
        }
        listProduct = billDetailDAO.getProductBillDetail(Long.parseLong(billID));

        BillDAO billDAO = new BillDAO();
        ArrayList<Bill> listBill = billDAO.getBillByID(Long.parseLong(billID));
        UsersDAO usersDAO = new UsersDAO();
        ProductDAO productDAO = new ProductDAO();
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
                        Quản lý hóa đơn
                    </h1>
                    <ol class="breadcrumb">
                        <li><a href="index.jsp"><i class="fa fa-dashboard"></i> Trang chủ</a></li>
                        <li><a href="management_bill.jsp">Quản lý hóa đơn</a></li>
                        <li class="active">Chi tiết hóa đơn</li>
                    </ol>
                </section>
                <!-- Main content -->
                <section class="content">
                    <!-- Default box -->
                    <div class="box">
                        <div class="box-header with-border">
                            <h3 class="box-title">Chi tiết hóa đơn</h3>
                            <div class="box-tools pull-right">
                                <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse">
                                    <i class="fa fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <div class="box-body">
                            <div class="alert alert-warning fade in">
                                <span><i class="fa fa-bullhorn"></i> Bạn có chắc chắn muốn thanh toán cho hóa đơn này?</span>

                            </div>

                            <div class="col-md-8">
                                <!-- Start bordered form -->

                                <div class="panel-heading">
                                    <div class="pull-left">
                                        <h3 class="panel-title">Thông tin sản phẩm</h3>
                                    </div>
                                    <div class="clearfix"></div>
                                </div><!-- /.panel-heading -->
                                <div class="panel-body no-padding">
                                    <div class="form-body">
                                        <div class="table-responsive mb-20">
                                            <table class="table table-bordered">
                                                <tr>
                                                    <td>Mã sản phẩm</td>
                                                    <td>Tên sản phẩm</td>
                                                    <td>Giá</td>
                                                    <td>Số lượng</td>
                                                </tr>

                                            <% for (BillDetail billDetail : listProduct) {%>

                                            <tr>
                                                <td><%=productDAO.getProduct(billDetail.getProductID()).getProductID()%></td>
                                                <td><%=productDAO.getProduct(billDetail.getProductID()).getProductName()%></td>
                                                <td><%=billDetail.getPrice()%></td>
                                                <td><%=billDetail.getQuantity()%></td>
                                            </tr>
                                            <%}%>
                                        </table>
                                    </div>
                                </div>
                            </div>

                        </div>

                        <div class="col-md-4">

                            <div class="panel-heading">
                                <div class="pull-left">
                                    <h3 class="panel-title">Thông tin hóa đơn</h3>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                            <div class="panel-body no-padding">
                                <form class="form-horizontal form-bordered" role="form">
                                    <div class="form-body">
                                        <% for (Bill inforBill : listBill) {%>
                                        <div class="x_content">
                                            <div class="form-group">
                                                <label for="firstname-1" class="col-sm-4 control-label">Số phiếu</label>
                                                <div class="col-sm-8">
                                                    <input value="<%=inforBill.getBillID()%>" type="text" class="form-control" disabled="disabled" />
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="password-1" class="col-sm-4 control-label">Ngày giao</label>
                                                <div class="col-sm-8">
                                                    <input value="<%=inforBill.getDate()%>" disabled="disabled" type="text" class="form-control" />

                                                </div>
                                            </div><!-- /.form-group -->
                                            <div class="form-group">
                                                <label for="firstname-1" class="col-sm-4 control-label">Khách hàng</label>
                                                <div class="col-sm-8">
                                                    <input value="<%=usersDAO.getUser(inforBill.getUserID()).getUserEmail()%>"  type="text" class="form-control" disabled="disabled" />
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="firstname-1" class="col-sm-4 control-label">Số điện thoại</label>
                                                <div class="col-sm-8">
                                                    <input value="<%=inforBill.getPhone()%>"  type="text" class="form-control" disabled="disabled" />
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="firstname-1" class="col-sm-4 control-label">Địa chỉ</label>
                                                <div class="col-sm-8">
                                                    <input value="<%=inforBill.getAddress()%>"  type="text" class="form-control" disabled="disabled" />
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="firstname-1" class="col-sm-4 control-label">Tổng tiền</label>
                                                <div class="col-sm-8">
                                                    <input value="<%=inforBill.getTotal()%>"  type="text" class="form-control" disabled="disabled" />
                                                </div>
                                            </div>
                                        </div>

                                        <%}%>
                                    </div>
                                </form>
                            </div>
                        </div>


                    </div>
                    <div class="box-footer">
                        <a href='management_bill.jsp' class="btn btn-default pull-left">Quay lại</a> 
                        <a href='/ManagerBillServlet?command=paid_bill&billID=<%=billID%>' class="btn btn-primary pull-right">Thanh toán</a>
                    </div>
                </div>


                <!-- /.box -->
            </section>
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
</body>
