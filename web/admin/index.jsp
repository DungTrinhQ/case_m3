<%@page import="java.util.Date"%>
<%@page import="model.Revenues"%>
<%@page import="dao.RevenuesDAO"%>
<%@page import="model.Product"%>
<%@page import="dao.ProductDAO"%>
<%@page import="model.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.CategoryDAO"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
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
        <link href="${pageContext.request.contextPath}/admin/content/bootstrap/css/bootstrap-datepicker3.css" rel="stylesheet" type="text/css"/>

        <link href="${pageContext.request.contextPath}/admin/content/dist/css/skins/_all-skins.min.css" rel="stylesheet" type="text/css"/>
        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->

        <script type="text/javascript" src="http://www.google.com/jsapi"></script>
        <script type="text/javascript">
            //load the Google Visualization API and the chart
            google.load('visualization', '1', {'packages': ['columnchart']});

            //set callback
            google.setOnLoadCallback(createChart);

            //callback function
            function createChart() {

                //create data table object
                var dataTable = new google.visualization.DataTable();

            <%
                    RevenuesDAO revenuesDAO = new RevenuesDAO();

                    String fromdate = "";
                    String todate = "";
                    if (request.getParameter("fromdate") != null) {
                        fromdate = request.getParameter("fromdate");
                    }

                    if (request.getParameter("todate") != null) {
                        todate = request.getParameter("todate");
                    }

                    ArrayList<Revenues> listRe = revenuesDAO.getListRevenues(fromdate, todate);
            %>

                //define columns
                dataTable.addColumn('string', 'Quarters 2009');
                dataTable.addColumn('number', 'Doanh thu');

                //define rows of data
                dataTable.addRows([
            <%
                        Date time = null;
                        for (Revenues re : listRe) {
            %>
                    ['<fmt:formatDate value="<%=re.getNgay()%>" pattern="MM-dd-yyyy"/> ', <%=re.getDoanhThu()%>],
            <%}%>

                ]);

                //instantiate our chart object
                var chart = new google.visualization.ColumnChart(document.getElementById('chart'));

                //define options for visualization
                var options = {width: 700, height: 300, is3D: true, title: 'Doanh thu theo ngày'};

                //draw our chart
                chart.draw(dataTable, options);

            }
        </script>


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

            /* String fromdate2 = "";
                 String todate2 = "";
                 if (request.getParameter("fromdate") != null) {
                     fromdate2 = request.getParameter("fromdate");
                }                 
                if (request.getParameter("todate") != null) {
                    todate2 = request.getParameter("todate");
                }*/
            ArrayList<Product> listProduct = productDAO.getListProductOutStock();
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
                            Tổng quan
                        </h1>
                        <ol class="breadcrumb">
                            <li class="active"><i class="fa fa-dashboard"></i> Tổng quan</li>
                        </ol>
                    </section>
                    <!-- Main content -->
                    <section class="content">

                        <form method="get" action="/DashboardServlet">
                            <div class="col-md-12">
                                <div class="input-group">
                                    <div class="col-sm-8 col-xs-12">
                                        <div class="input-group">
                                            <div class="input-group-addon">
                                                <i class="fa fa-calendar-check-o">
                                                </i>
                                            </div>
                                            <input value="<%=fromdate%>" style="cursor:pointer" class="form-control" id="date" name="date" readonly type="text" placeholder="Từ ngày" />
                                        <div class="input-group-addon">
                                            <span>~</span>
                                        </div>
                                        <input value="<%=todate%>" style="cursor:pointer" class="form-control" id="date2" name="date2" readonly type="text" placeholder="Đến ngày" />
                                    </div>
                                </div>
                                <div class="col-sm-4 col-xs-12">
                                    <input type="hidden" name="command" value="search">
                                    <span class="input-group-btn">
                                        <button onclick="return GetData();" class="btn btn-default" type="submit">
                                            Xem doanh thu
                                        </button>
                                    </span>
                                </div>  

                            </div>
                        </div>
                    </form>

                    <div id="chart"></div>

                    <!-- Default box -->
                    <div class="box">
                        <div class="box-header with-border">
                            <h3 class="box-title">Danh sách sản phẩm gần hết hàng</h3>
                            <div class="box-tools pull-right">
                                <button class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse"><i class="fa fa-minus"></i></button>
                                <button class="btn btn-box-tool" data-widget="remove" data-toggle="tooltip" title="Remove"><i class="fa fa-times"></i></button>
                            </div>
                        </div>
                        <div class="box-body">

                            <div class="row">     
                                <div class="col-md-12 table-responsive">
                                    <table class="table table-bordered ">
                                        <tr>
                                            <th style="width: 5%">STT</th>
                                            <th style="width: 25%">Tên sản phẩm</th>
                                            <th style="width:25%">Thể loại</th>
                                            <th style="width: 15%">Giá bán</th>
                                            <th style="width: 10%">Số lượng tồn</th>
                                            <th style="width: 10%">Thao tác</th>
                                        </tr>
                                        <%
                                            int count1 = 0;
                                            for (Product product : listProduct) {
                                                count1++;
                                        %>
                                        <tr>
                                            <td><%=count1%></td>                                                                            
                                            <td><%=product.getProductName()%></td>
                                            <td><%=product.getCategoryName()%></td>
                                            <td>
                                                <fmt:formatNumber type = "number" maxFractionDigits = "3" value = "<%=product.getProductPrice()%>" />
                                            </td>
                                            <td><%=product.getProductQuantity()%></td>
                                            <td>			                    		
                                                <a class="btn btn-sm btn-primary" title="Cập nhật số lượng" href="edit_product.jsp?productID=<%=product.getProductID()%>">
                                                    <i class="fa fa-pencil"></i>
                                                </a>                                                
                                            </td>
                                        </tr>
                                        <%}%>

                                    </table>
                                </div>

                            </div>
                        </div><!-- /.box-body -->
                        <div class="box-footer">
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
        <script src="${pageContext.request.contextPath}/admin/content/bootstrap/js/bootstrap-datepicker.min.js"></script>

        <script language="javascript">
                                            function GetData() {
                                                if ($('#date').val() == "")
                                                {
                                                    return false;
                                                } else if ($('#date2').val() == "")
                                                {
                                                    return false;
                                                }

                                                return true;
                                            }
        </script>


        <script>
            $(document).ready(function () {
                var date_input = $('input[name="date"]'); //our date input has the name "date"
                var date_input2 = $('input[name="date2"]'); //our date input has the name "date"
                var container = $('.bootstrap-iso form').length > 0 ? $('.bootstrap-iso form').parent() : "body";
                date_input.datepicker({
                    format: 'mm/dd/yyyy',
                    container: container,
                    todayHighlight: true,
                    autoclose: true,
                })
                date_input2.datepicker({
                    format: 'mm/dd/yyyy',
                    container: container,
                    todayHighlight: true,
                    autoclose: true,
                })
            })
        </script>

    </body>
</html>
