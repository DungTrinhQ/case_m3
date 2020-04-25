<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <aside class="main-sidebar">
            <!-- sidebar: style can be found in sidebar.less -->
            <section class="sidebar">
                <!-- Sidebar user panel -->
                <div class="user-panel">
                    <div class="pull-left image">
                        <img src="${pageContext.request.contextPath}/admin/content/dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">
                    </div>
                    <div class="pull-left info">
                        <p>Admin</p>
                        <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
                    </div>
                </div>

                <!-- sidebar menu: : style can be found in sidebar.less -->
                <ul class="sidebar-menu">
                    <li class="header">Chức năng chính</li>
                     <li><a href="${pageContext.request.contextPath}/admin/index.jsp"><i class="fa fa-dashboard"></i> <span>Tổng quan</span></a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/manager_category.jsp"><i class="fa fa-object-group"></i> <span>Quản lý danh mục</span></a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/manager_product.jsp"><i class="fa fa-spinner"></i> <span>Quản lý sản phẩm</span></a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/management_bill.jsp"><i class="fa fa-industry"></i> <span>Quản lý đơn hàng</span></a></li>
                </ul>
            </section>
            <!-- /.sidebar -->
        </aside>
    </body>
</html>
