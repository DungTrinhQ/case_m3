<%@page import="model.Bill"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.BillDAO"%>
<%@page import="dao.UsersDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Admin</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="icon" href="${pageContext.request.contextPath}/images/icon.ico" type="image/png" />
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
        BillDAO billDAO = new BillDAO();
        UsersDAO usersDAO = new UsersDAO(); 
        
        int pages = 1;
        int recordsPerPage = 5;
        
        if (request.getParameter("pages") != null) {
                pages = (int) Integer.parseInt(request.getParameter("pages"));
        }
        ArrayList<Bill> listBill = billDAO.getListBillPageList((pages - 1) * recordsPerPage, recordsPerPage);
        int noOfRecords = billDAO.countBill();
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
                        Quản lý hóa đơn
                    </h1>
                    <ol class="breadcrumb">
                        <li><a href="menu.jsp"><i class="fa fa-dashboard"></i> Trang chủ</a></li>
                        <li class="active">Quản lý hóa đơn</li>
                    </ol>
                </section>

                <!-- Main content -->
                <section class="content">
                    <!-- Default box -->
                    <div class="box">
                        <div class="box-header with-border">
                            <h3 class="box-title">Danh sách hóa đơn</h3>
                            <div class="box-tools pull-right">
                                <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse">
                                    <i class="fa fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <div class="box-body">
                            <table class="table table-bordered">
                                <tr>
                                    <th style="width: 95px">Số hóa đơn</th>
                                    <th>Khách hàng</th>
                                    <th>Số điện thoại</th>
                                    <th>Địa chỉ</th>
                                    <th>Tổng tiền</th>
                                    <th>Ngày giao</th>
                                    <th>Thanh toán</th>
                                    <th>Tình trạng</th>
                                    <th style="width: 80px">Tùy chọn</th>
                                </tr>
                            <% for (Bill bill : listBill) {%>
                            <tr>
                                <td><%=bill.getBillID()%></td>
                                <td><%=usersDAO.getUser(bill.getUserID()).getUserEmail()%></td>
                                <td><%=bill.getPhone()%></td>
                                <td><%=bill.getAddress()%></td>
                                <td><%=bill.getTotal()%></td>
                                <td><%=bill.getDate()%></td>
                                <%
                                    if (bill.getPaid() == 1) {
                                %>
                                <td>Đã thanh toán</td>

                                <%} else { %>
                                <td>Chưa thanh toán</td>
                                <%}%>

                                <%
                                    if (bill.getStatus() == 0) {
                                %>
                                <td>Chưa duyệt</td>
                                <td style="width:120px">
                                    <div class="btn-group">
                                        <button type="button" class="btn btn-danger dropdown-toggle" data-toggle="dropdown">
                                            <span class="caret"></span>
                                            <span class="sr-only">Toggle Dropdown</span>
                                        </button>
                                        <ul class="dropdown-menu" role="menu">
                                            <li><a href="${pageContext.request.contextPath}/admin/detail_bill.jsp?billID=<%=bill.getBillID()%>"><i class="fa fa-eye"></i> Chi tiết</a></li>
                                            <li><a href="${pageContext.request.contextPath}/admin/delete_bill.jsp?billID=<%=bill.getBillID()%>"><i class="fa fa-trash"></i> Hủy</a></li>
                                            <li><a href="${pageContext.request.contextPath}/admin/approve_bill.jsp?billID=<%=bill.getBillID()%>"><i class="fa fa-check-square"></i> Duyệt</a></li>
                                        </ul>
                                    </div>
                                </td>

                                <%} else if (bill.getStatus() == 1) {%>
                                <td>Đã duyệt</td>
                                <td style="width:120px">
                                    <div class="btn-group">
                                        <button type="button" class="btn btn-danger dropdown-toggle" data-toggle="dropdown">
                                            <span class="caret"></span>
                                            <span class="sr-only">Toggle Dropdown</span>
                                        </button>
                                        <ul class="dropdown-menu" role="menu">
                                            <li><a href="${pageContext.request.contextPath}/admin/detail_bill.jsp?billID=<%=bill.getBillID()%>"><i class="fa fa-eye"></i> Chi tiết</a></li>
                                            <li><a href="${pageContext.request.contextPath}/admin/delete_bill.jsp?billID=<%=bill.getBillID()%>"><i class="fa fa-trash"></i> Hủy</a></li>
                                            <li><a href="${pageContext.request.contextPath}/admin/paid_bill.jsp?billID=<%=bill.getBillID()%>"><i class="fa fa-credit-card"></i> Thanh toán</a></li>
                                        </ul>
                                    </div>
                                </td>

                                <%} else if (bill.getStatus() == 2) {%>
                                <td>Đã hủy</td>
                                <td style="width:120px">
                                    <div class="btn-group">
                                        <button type="button" class="btn btn-danger dropdown-toggle" data-toggle="dropdown">
                                            <span class="caret"></span>
                                            <span class="sr-only">Toggle Dropdown</span>
                                        </button>
                                        <ul class="dropdown-menu" role="menu">
                                            <li><a href="${pageContext.request.contextPath}/admin/detail_bill.jsp?billID=<%=bill.getBillID()%>"><i class="fa fa-eye"></i> Chi tiết</a></li>
                                        </ul>
                                    </div>
                                </td>

                                <%}%>

                            </tr>
                            <%}%>
                        </table>
                    </div>
                    <!-- /.box-body -->
                    <div class="box-footer">
                            <ul class="pagination pagination-sm">
                                <li>
                                    <a href="#" aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>
                                <%for (int i = 1; i <= noOfPages; i++) {%>
                                <li><a href="${pageContext.request.contextPath}/admin/management_bill.jsp?pages=<%=i%>"><%=i%></a></li>
                                    <%}%>
                                <li>
                                    <a href="#" aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    <!-- /.box-footer-->
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
