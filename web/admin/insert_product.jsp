<%@page import="model.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.CategoryDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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
        <![endif]-->    </head>
    <body class="hold-transition skin-blue sidebar-mini">
        <%
        if (session.getAttribute("userAdmin") == null) {
                response.sendRedirect("/admin/login.jsp");
            }
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
                    <!-- Content Header (Page header) -->
                    <section class="content-header">
                        <h1>
                            Sản phẩm
                        </h1>
                        <ol class="breadcrumb">
                            <li><a href="#"><i class="fa fa-dashboard"></i> Trang chủ</a></li>
                            <li><a href="${pageContext.request.contextPath}/admin/manager_product.jsp">Sản phẩm</a></li>
                            <li class="active">Thêm mới</li>
                        </ol>
                    </section>
                    <!-- Main content -->
                    <section class="content">
                        <!-- Horizontal Form -->
                        <div class="box box-info">
                            <div class="box-header with-border">
                                <h3 class="box-title">Thông tin sản phẩm</h3>
                            </div><!-- /.box-header -->
                            <!-- form start -->
                            <form action="/ManagerProductServlet"  method="post" enctype="multipart/form-data" class="form-horizontal">
                                <div class="box-body">
		                    <div class="form-group">
                                        <label class="col-sm-2 control-label">Tên sản phẩm</label>
                                        <div class="col-sm-8">
                                            <input onkeyup="InputProName()" id="proname" type="text" class="form-control" name="productname" placeholder="Sản phẩm">		                      	
                                            <span id="msgProductName" style="color:red" hidden>Vui lòng nhập tên sản phẩm!</span>
                                        </div>		                      
		                    </div>  
		                    
		                    <div class="form-group">
                                        <label class="col-sm-2 control-label">Danh mục</label>
                                        <div class="col-sm-8">
                                            <select name="categoryid" id="categoryid" class="form-control">
                                            <% 
                        			out.print("<option value="+0+">--- Chọn danh mục ---</option>");
                        			CategoryDAO categoryDAO = new CategoryDAO();
		                    		ArrayList<Category>  listCategory = categoryDAO.getListCategory();
                        			if(listCategory != null){
                           				for(Category cate : listCategory){
                                			out.print("<option value="+cate.getCategoryID()+">"+ cate.getCategoryName() +"</option>");
                            			}
                           			}
                                            %> 
                                            </select>	
                                             <span id="msgCate" style="color:red" hidden>Vui lòng chọn thể loại!</span>
                                        </div>		                      
		                    </div> 
		                    
		                    <div class="form-group">
                                        <label class="col-sm-2 control-label">Đơn giá</label>
                                        <div class="col-sm-8">
                                            <input onkeypress="return isNumberKey(event)" id="price" type="text" class="form-control" name="price" placeholder="Đơn giá">		                      	
                                            <span id="msgPrice" style="color:red" hidden>Vui lòng nhập đơn giá!</span>
                                        </div>		                      
		                    </div>
		                    
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">Số lượng</label>
                                        <div class="col-sm-8">
                                            <input onkeypress="return isNumberKey(event)" id="quantity" type="text" class="form-control" name="quantity" placeholder="Số lượng">		                      	
                                            <span id="msgQuantity" style="color:red" hidden>Vui lòng nhập số lượng!</span>
                                        </div>		                      
		                    </div>        
                                            
		                    <div class="form-group">
                                        <label class="col-sm-2 control-label">Hình ảnh</label>
                                        <div class="col-sm-8">
                                            <input onchange="readURL(this);" type="file" id="file" name="file" name="uploadFile" class="btn btn-white btn-warning btn-bold">	   
                                             <img class="text-center" width="160" height="230" alt="Hình ảnh" style="border:1px solid black;" hidden id="showAvatar" >            
                                            <span id="msgImg" style="color:red" hidden>Vui lòng chọn file ảnh!</span>
                                        </div>		                      
		                    </div>
		                    
		                    <div class="form-group">
                                        <label class="col-sm-2 control-label">Mô tả</label>
                                        <div class="col-sm-8">
                                            <textarea id="des" type="text" class="form-control" name="description" placeholder="Diễn giải" rows="10" cols="80"></textarea>	                      	
                                            <span id="msgDes" style="color:red" hidden>Vui lòng nhập diễn giải!</span>
                                            
                                        </div>		                      
		                    </div>   
                                </div>
		                 
		                 <div class="box-footer">
                                    <a href='manager_product.jsp' class="btn btn-default">Hủy</a> 
                                    <input type="hidden" name="command" value="insert"> 
                                    <input onclick="return SaveProduct();" id="btnAdd" type="submit" class="btn btn-success pull-right" value='Thêm'/>
                                </div>
                            </form>                               
                        </div><!-- /.box -->
                    </section><!-- /.content -->
                </div>
                <!-- /.content-wrapper -->
            <jsp:include page="footer.jsp"></jsp:include>
            <!-- Control Sidebar -->

        </div>
        <!-- ./wrapper -->
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
        <script src="${pageContext.request.contextPath}/admin/content/dist/js/autoNumeric.js"></script>
        
        
        <script language="javascript">                
                function readURL(input) {
                   
                    if (input.files && input.files[0]) {
                        var reader = new FileReader();
                        reader.onload = function(e) {
                            $('#showAvatar').prop('hidden', false);
                            $('#showAvatar').attr('src', e.target.result);
                        };
                        reader.readAsDataURL(input.files[0]);
                    }
                }
        </script>
        <script language="javascript">  
            $(document).ready(function () {
                $('#price').bind('blur focusout keypress keyup', function () {
                    //$('#price').autoNumeric('init');
                })
            });
            
        </script>
        
        <script language="javascript">  
            
            function isNumberKey(evt){
                var charCode = (evt.which) ? evt.which : event.keyCode
                if (charCode > 31 && (charCode < 48 || charCode > 57))
                    return false;
                return true;
            }
            
            function SaveProduct(){
                if($('#proname').val() == "")
                {
                    $('#msgProductName').prop('hidden', false);
                    
                    if($('#des').val() == "")
                    {
                        $('#msgDes').prop('hidden', false);
                    }
                    else
                    {
                        $('#msgDes').prop('hidden', true);
                    }
                    
                    if($('#price').val() == "")
                    {
                        $('#msgPrice').prop('hidden', false);
                    }
                    else
                    {
                        $('#msgPrice').prop('hidden', true);
                    }
                    
                    if($('#quantity').val() == "")
                    {
                        $('#msgQuantity').prop('hidden', false);
                    }
                    else
                    {
                        $('#msgQuantity').prop('hidden', true);
                    }
                    
                    if($('#categoryid').val() == 0)
                    {
                        $('#msgCate').prop('hidden', false);
                    }
                    else
                    {
                        $('#msgCate').prop('hidden', true);
                    }
                    
                     if($('#file').val() == "")
                    {
                        $('#msgImg').prop('hidden', false);
                    }
                    else
                    {
                        $('#msgImg').prop('hidden', true);
                    }
                    return false;
                }
                else if($('#des').val() == "")
                {
                    $('#msgDes').prop('hidden', false);
                    
                    if($('#proname').val() == "")
                    {
                        $('#msgProductName').prop('hidden', false);
                    }
                    else
                    {
                        $('#msgProductName').prop('hidden', true);
                    }
                    
                    if($('#price').val() == "")
                    {
                        $('#msgPrice').prop('hidden', false);
                    }
                    else
                    {
                        $('#msgPrice').prop('hidden', true);
                    }
                    
                    if($('#quantity').val() == "")
                    {
                        $('#msgQuantity').prop('hidden', false);
                    }
                    else
                    {
                        $('#msgQuantity').prop('hidden', true);
                    }
                    
                    if($('#categoryid').val() == 0)
                    {
                        $('#msgCate').prop('hidden', false);
                    }
                    else
                    {
                        $('#msgCate').prop('hidden', true);
                    }
                    
                     if($('#file').val() == "")
                    {
                        $('#msgImg').prop('hidden', false);
                    }
                    else
                    {
                        $('#msgImg').prop('hidden', true);
                    }
                    return false;
                }
                else if($('#file').val() == "")
                {
                    $('#msgImg').prop('hidden', false);
                    
                    if($('#proname').val() == "")
                    {
                        $('#msgProductName').prop('hidden', false);
                    }
                    else
                    {
                        $('#msgProductName').prop('hidden', true);
                    }
                    
                    if($('#price').val() == "")
                    {
                        $('#msgPrice').prop('hidden', false);
                    }
                    else
                    {
                        $('#msgPrice').prop('hidden', true);
                    }
                    
                    if($('#quantity').val() == "")
                    {
                        $('#msgQuantity').prop('hidden', false);
                    }
                    else
                    {
                        $('#msgQuantity').prop('hidden', true);
                    }
                    
                    if($('#categoryid').val() == 0)
                    {
                        $('#msgCate').prop('hidden', false);
                    }
                    else
                    {
                        $('#msgCate').prop('hidden', true);
                    }
                    
                     if($('#des').val() == "")
                    {
                        $('#msgDes').prop('hidden', false);
                    }
                    else
                    {
                        $('#msgDes').prop('hidden', true);
                    }
                    return false;
                }
                else if($('#price').val() == "")
                {
                    $('#msgPrice').prop('hidden', false);
                    
                    if($('#proname').val() == "")
                    {
                        $('#msgProductName').prop('hidden', false);
                    }
                    else
                    {
                        $('#msgProductName').prop('hidden', true);
                    }
                    
                    if($('#file').val() == "")
                    {
                        $('#msgImg').prop('hidden', false);
                    }
                    else
                    {
                        $('#msgImg').prop('hidden', true);
                    }
                    
                    if($('#quantity').val() == "")
                    {
                        $('#msgQuantity').prop('hidden', false);
                    }
                    else
                    {
                        $('#msgQuantity').prop('hidden', true);
                    }
                    
                    if($('#categoryid').val() == 0)
                    {
                        $('#msgCate').prop('hidden', false);
                    }
                    else
                    {
                        $('#msgCate').prop('hidden', true);
                    }
                    
                     if($('#des').val() == "")
                    {
                        $('#msgDes').prop('hidden', false);
                    }
                    else
                    {
                        $('#msgDes').prop('hidden', true);
                    }
                    return false;
                }
                else if($('#categoryid').val() == "")
                {
                    $('#msgCate').prop('hidden', false);
                    
                    if($('#proname').val() == "")
                    {
                        $('#msgProductName').prop('hidden', false);
                    }
                    else
                    {
                        $('#msgProductName').prop('hidden', true);
                    }
                    
                    if($('#quantity').val() == "")
                    {
                        $('#msgQuantity').prop('hidden', false);
                    }
                    else
                    {
                        $('#msgQuantity').prop('hidden', true);
                    }
                    
                    if($('#file').val() == "")
                    {
                        $('#msgImg').prop('hidden', false);
                    }
                    else
                    {
                        $('#msgImg').prop('hidden', true);
                    }
                    
                    if($('#price').val() == "")
                    {
                        $('#msgPrice').prop('hidden', false);
                    }
                    else
                    {
                        $('#msgCate').prop('hidden', true);
                    }
                    
                     if($('#des').val() == "")
                    {
                        $('#msgDes').prop('hidden', false);
                    }
                    else
                    {
                        $('#msgDes').prop('hidden', true);
                    }
                    return false;
                }
                 else if($('#quantity').val() == "")
                {
                    $('#msgQuantity').prop('hidden', false);
                    
                    if($('#proname').val() == "")
                    {
                        $('#msgProductName').prop('hidden', false);
                    }
                    else
                    {
                        $('#msgProductName').prop('hidden', true);
                    }
                    
                    if($('#categoryid').val() == "")
                    {
                        $('#msgCate').prop('hidden', false);
                    }
                    else
                    {
                        $('#msgCate').prop('hidden', true);
                    }
                    
                    if($('#file').val() == "")
                    {
                        $('#msgImg').prop('hidden', false);
                    }
                    else
                    {
                        $('#msgImg').prop('hidden', true);
                    }
                    
                    if($('#price').val() == "")
                    {
                        $('#msgPrice').prop('hidden', false);
                    }
                    else
                    {
                        $('#msgCate').prop('hidden', true);
                    }
                    
                     if($('#des').val() == "")
                    {
                        $('#msgDes').prop('hidden', false);
                    }
                    else
                    {
                        $('#msgDes').prop('hidden', true);
                    }
                    return false;
                }
               
                
                return true;
            }
        </script>
    </body>
</html>
