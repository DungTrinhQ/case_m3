<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="banner-w3">
            <div class="demo-1">            
                <div id="example1" class="core-slider core-slider__carousel example_1 is-loaded">
                    <div class="core-slider_viewport">
                        <div class="core-slider_list" style="width: 2560px; transform: translateX(-1920px);">
                            <div class="core-slider_item" style="width: 640px;">
                                <img src="images/b1.jpg" class="img-responsive" alt="">
                            </div>
                            <div class="core-slider_item" style="width: 640px;">
                                <img src="images/b2.jpg" class="img-responsive" alt="">
                            </div>
                            <div class="core-slider_item" style="width: 640px;">
                                <img src="images/b3.jpg" class="img-responsive" alt="">
                            </div>
                            <div class="core-slider_item" style="width: 640px;">
                                <img src="images/b4.jpg" class="img-responsive" alt="">
                            </div>
                        </div>
                    </div>
                    <div class="core-slider_nav">
                        <div class="core-slider_arrow core-slider_arrow__right"></div>
                        <div class="core-slider_arrow core-slider_arrow__left"></div>
                    </div>
                    <div class="core-slider_control-nav"><div class="core-slider_control-nav-item"></div><div class="core-slider_control-nav-item"></div><div class="core-slider_control-nav-item"></div><div class="core-slider_control-nav-item is-active"></div></div>
                </div>
            </div>
            <link href="css/coreSlider.css" rel="stylesheet" type="text/css">
            <script src="js/coreSlider.js"></script>
            <script>
            $('#example1').coreSlider({
                pauseOnHover: false,
                interval: 3000,
                controlNavEnabled: true
            });

            </script>

        </div>	
    </body>
</html>
