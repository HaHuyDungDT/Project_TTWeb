<%@ page import="model.Product" %>
<%@ page import="dao.impl.ProductDAOImpl" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <!-- Thêm JSTL taglib -->

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Sản phẩm</title>
    <!-- Các link css, js khác -->
</head>
<body>
<!-- HEADER -->
<jsp:include page="header.jsp"/>
<!-- /HEADER -->

<!-- MENU -->
<jsp:include page="menu.jsp"/>
<!-- /MENU -->

<!-- BREADCRUMB -->
<div id="breadcrumb" class="section">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <ul class="breadcrumb-tree">
                    <li><a href="#">Trang chủ</a></li>
                    <li class="active">Sản phẩm</li>
                </ul>
            </div>
        </div>
    </div>
</div>
<!-- /BREADCRUMB -->

<!-- SECTION -->
<div class="section">
    <div class="container">
        <div class="row">
            <%
                // Lấy id sản phẩm từ request và kiểm tra nếu không tồn tại thì thông báo lỗi
                String prodId = request.getParameter("id");
                Product product = ProductDAOImpl.getById(prodId);
            %>

            <!-- Kiểm tra xem có sản phẩm hay không và thông báo lỗi nếu không tìm thấy -->
            <c:if test="${empty product}">
                <h3>Không tìm thấy sản phẩm!</h3>
            </c:if>

            <!-- Nếu sản phẩm tồn tại, hiển thị thông tin sản phẩm -->
            <c:if test="${not empty product}">
                <!-- Product main img -->
                <div class="col-md-5 col-md-push-2">
                    <div id="product-main-img">
                        <div class="product-preview">
                            <img src="<%= (product.getImages() != null && !product.getImages().isEmpty())
                                          ? product.getImages().get(0).getLinkImage()
                                          : "img/default.jpg" %>" alt="Product Image"/>
                        </div>
                    </div>
                </div>
                <!-- /Product main img -->

                <!-- Product thumb imgs -->
                <div class="col-md-2 col-md-pull-5">
                    <div id="product-imgs">
                        <%
                            if(product.getImages() != null && !product.getImages().isEmpty()){
                                for(int i = 0; i < product.getImages().size(); i++){
                        %>
                        <div class="product-preview">
                            <img src="<%= product.getImages().get(i).getLinkImage() %>" alt="Thumbnail"/>
                        </div>
                        <%
                            }
                        } else {
                        %>
                        <div class="product-preview">
                            <img src="img/default.jpg" alt="Default Image"/>
                        </div>
                        <%
                            }
                        %>
                    </div>
                </div>
                <!-- /Product thumb imgs -->

                <!-- Product details -->
                <div class="col-md-5">
                    <div class="product-details">
                        <h2 class="product-name"><%= product.getName() %></h2>
                        <div>
                            <fmt:formatNumber value="<%= product.getPrice() %>"
                                              type="number" pattern="#,##0" var="formattedPrice"/>
                            <h3 class="product-price">${formattedPrice} VNĐ</h3>
                        </div>
                        <ul style="list-style-type: disc">
                            <li><%= product.getDetail() %></li>
                        </ul>
                        <div class="form-group">
                            <label for="quantity">Số lượng:</label>
                            <input style="width: 70px" type="number" class="form-control" id="quantity" name="quantity" min="1" max="100" value="1"/>
                        </div>
                        <br>
                        <div class="add-to-cart">
                            <form action="addcart" method="post">
                                <input type="hidden" name="id" value="<%= product.getId() %>"/>
                                <button type="submit" class="add-to-cart-btn">
                                    <i class="fa fa-shopping-cart"></i> Thêm vào giỏ hàng
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
                <!-- /Product details -->
            </c:if>

        </div>
    </div>
</div>
<!-- /SECTION -->

<!-- FOOTER -->
<jsp:include page="footer.jsp"/>
<!-- /FOOTER -->

<!-- jQuery Plugins -->
<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/slick.min.js"></script>
<script src="js/nouislider.min.js"></script>
<script src="js/jquery.zoom.min.js"></script>
<script src="js/main.js"></script>
</body>
</html>
