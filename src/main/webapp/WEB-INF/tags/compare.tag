<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="label" required="true" %>
<%@ attribute name="current" required="true" type="java.lang.Double" %>
<%@ attribute name="last" required="true" type="java.lang.Double" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<p>${label}:
    <c:choose>
        <c:when test="${last == 0 && current == 0}">
            <span class="text-muted">Không có dữ liệu</span>
        </c:when>
        <c:when test="${last == 0 && current > 0}">
            <span class="text-success">Tăng đột biến</span>
        </c:when>
        <c:when test="${last > 0 && current == 0}">
            <span class="text-danger">Giảm hoàn toàn</span>
        </c:when>
        <c:otherwise>
<%--            <c:set var="percent" value="${((current - last) * 100.0) / last}" />--%>
            <c:set var="percentRaw" value="${((current - last) * 100.0) / last}" />
            <c:set var="percent" value="${(percentRaw lt 0.01 and percentRaw gt -0.01) ? 0 : percentRaw}" />


            <c:choose>
                <c:when test="${percent > 0}">
                    <span class="text-success">Tăng <fmt:formatNumber value="${percent}" maxFractionDigits="1"/>%</span>
                </c:when>
                <c:otherwise>
                    <span class="text-danger">Giảm <fmt:formatNumber value="${-percent}" maxFractionDigits="1"/>%</span>
                </c:otherwise>
            </c:choose>
        </c:otherwise>
    </c:choose>
</p>
