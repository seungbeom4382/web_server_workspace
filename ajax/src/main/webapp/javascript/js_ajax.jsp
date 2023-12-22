<%--
  Created by IntelliJ IDEA.
  User: 82104
  Date: 2023-12-22
  Time: 오전 11:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <title>Ajax | JS - XMLHttpRequest</title>
</head>
<body>
    <h1>JS - XMLHttpRequest</h1>
    <form action="" name="testFrm">
        <input type="text" name="name" id="name" placeholder="이름을 입력하세요...">
        <br>
        <input type="number" name="num" id="num" placeholder="숫자를 입력하세요...">
        <br>
        <button type="button" onclick="doGet()">GET 제출</button>
        <button type="button" onclick="doPost()">POST 제출</button>
    </form>
    <div id="target"></div>

    <script>
        const contextPath = '${pageContext.request.contextPath}';
    </script>
    <script src="${pageContext.request.contextPath}/js/js_ajax.js"></script>
</body>
</html>