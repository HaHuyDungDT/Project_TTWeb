<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Thêm sản phẩm mới</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow-sm">
                <div class="card-body">
                    <h4 class="card-title mb-4">Thêm sản phẩm mới</h4>
                    <form action="${pageContext.request.contextPath}/admin/add-product" method="post">
                        <div class="mb-3">
                            <label class="form-label">Tên sản phẩm</label>
                            <input type="text" name="name" class="form-control" placeholder="Nhập tên sản phẩm" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Giá</label>
                            <input type="number" step="0.01" name="price" class="form-control" placeholder="Nhập giá" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Loại sản phẩm (ID)</label>
                            <input type="number" name="productTypeId" class="form-control" placeholder="Nhập loại sản phẩm ID" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Nhà sản xuất (ID)</label>
                            <input type="number" name="producerId" class="form-control" placeholder="Nhập NSX ID" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Số lượng</label>
                            <input type="number" name="quantity" class="form-control" placeholder="Nhập số lượng" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Trạng thái</label>
                            <input type="text" name="status" class="form-control" placeholder="Nhập trạng thái" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Mã khuyến mãi (ID)</label>
                            <input type="number" name="couponId" class="form-control" placeholder="Nhập mã khuyến mãi ID">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Ngày nhập</label>
                            <input type="date" name="importDate" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Mô tả chi tiết</label>
                            <textarea name="detail" rows="4" class="form-control" placeholder="Nhập mô tả chi tiết"></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary">Thêm sản phẩm</button>
                        <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-link">← Quay lại danh sách</a>
                    </form>
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger mt-3">${error}</div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
