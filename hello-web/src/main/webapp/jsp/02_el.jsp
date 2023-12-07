<%--
    EL 내장객체
    - context객체속성 (생략가능, 생략시 page-request-session-application순으로 조회)
        - pageScope
        - requestScope
        - sessionScope
        - applicationScope
    - 사용자입력값
        - param
        - paramValues
    - header 정보
        - header
        - headerValues
    - 쿠키 cookie
    - PageContext객체 직접 접근
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>JSP | EL</title>
</head>
<body>
    <h1>EL</h1>
    <h2>context내장객체 속성</h2>
    <ul>
        <li>이름 : ${name} ${requestScope.name} ${sessionScope.name}</li>
        <li>숫자 : ${num}</li>
        <li>취미 : ${hobbies}
            <ul>
                <li>${hobbies[0]}</li>
                <li>${hobbies[1]}</li>
                <li>${hobbies[2]}</li>
                <li>${hobbies[3]}</li>
                <li>${hobbies[4]}</li>
            </ul>
        </li>
        <li>책/가격 : ${bookMap}
            <ul>
                <li>${bookMap.MyJava}</li>
                <li>${bookMap['정신이 나가기전']}</li>
                <li>${bookMap["Dr.zang\'s office"]}</li>
            </ul>
        </li>
    </ul>

    <h2>사용자입력값 처리</h2>
    <ul>
        <li>name : ${param.name}</li>
        <li>option1 : ${paramValues.option[0]}</li>
        <li>option2 : ${paramValues.option[1]}</li>
    </ul>

    <h2>헤더값</h2>
    <ul>
        <li>User-Agent : ${header['User-Agent']}</li>
    </ul>
</body>
</html>
