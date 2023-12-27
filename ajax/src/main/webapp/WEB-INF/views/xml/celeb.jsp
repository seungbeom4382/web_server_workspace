<?xml version="1.0" encoding="utf-8" ?>
<%@ page contentType="text/xml;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<Celebs>
    <c:forEach items="${celebs}" var="celeb"> <!-- 반복문 통해서 celeb 여러개 출력 -->
        <Celeb>
            <Id>${celeb.id}</Id>
            <Name>${celeb.name}</Name>
            <Profile>${celeb.profile}</Profile>
            <Type>${celeb.type}</Type>
        </Celeb>
    </c:forEach>
</Celebs>