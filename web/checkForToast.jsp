<c:if test="${sessionScope.toast != null}">
    <script type="text/javascript">
    <c:choose>
        <c:when test="${sessionScope.toast.getMessageType().equals('info')}">
            toastr.info("${sessionScope.toast.getMessageString()}");
        </c:when>
         <c:when test="${sessionScope.toast.getMessageType().equals('success')}">
            toastr.success("${sessionScope.toast.getMessageString()}");
        </c:when>
        <c:when test="${sessionScope.toast.getMessageType().equals('warning')}">
            toastr.warning("${sessionScope.toast.getMessageString()}");
        </c:when>
        <c:when test="${sessionScope.toast.getMessageType().equals('error')}">
            toastr.error("${sessionScope.toast.getMessageString()}");
        </c:when>
    </c:choose>
    </script>
</c:if>       