<%--
  Created by IntelliJ IDEA.
  User: 82104
  Date: 2023-12-14
  Time: 오전 11:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.sh.mvc.member.model.entity.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<div class="p-10">
    <div class="relative overflow-x-auto shadow-md sm:rounded-lg">
        <h1 class="m-4 text-xl font-bold leading-tight tracking-tight text-gray-900 md:text-2xl">
            회원관리
        </h1>
        <form name="memberSearchFrm" action="${pageContext.request.contextPath}/admin/searchMember">
            <div class="p-4 bg-white flex">
                <select id="search-type" name="search-type" required class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 p-1.5">
                    <option value="" disabled selected>검색</option>
                    <option value="id" ${param['search-type']} eq 'id' ? 'selected' : ''}>아이디</option>
                    <option value="name" ${param['search-type']} eq 'name' ? 'selected' : ''}>이름</option>
                    <option value="email" ${param['search-type']} eq 'email' ? 'selected' : ''}>이메일</option>
                </select>
                <div class="ml-1">
                    <input type="search" id="search-keyword" name="search-keyword" placeholder="검색어를 입력하세요..." value="${param['search-keyword']}" required class="block p-2 text-sm text-gray-900 border border-gray-300 rounded-lg w-80 bg-gray-50 focus:ring-blue-500 focus:border-blue-500" >
                </div>
            </div>
        </form>
        <table class="w-full text-sm text-left rtl:text-right text-gray-500">
            <thead class="text-xs text-gray-700 uppercase bg-gray-50">
            <tr>
                <th scope="col" class="p-4">
                    <div class="flex items-center">
                        <input id="checkbox-all-search" type="checkbox" class="w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500">
                        <label for="checkbox-all-search" class="sr-only">checkbox</label>
                    </div>
                </th>
                <th scope="col" class="px-6 py-3">아이디</th>
                <th scope="col" class="px-6 py-3">이름</th>
                <th scope="col" class="px-6 py-3">권한</th>
                <th scope="col" class="px-6 py-3">생일</th>
                <th scope="col" class="px-6 py-3">이메일</th>
                <th scope="col" class="px-6 py-3">전화번호</th>
                <th scope="col" class="px-6 py-3">성별</th>
                <th scope="col" class="px-6 py-3">취미</th>
                <th scope="col" class="px-6 py-3">포인트</th>
                <th scope="col" class="px-6 py-3">가입일</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${members}" var="member" varStatus="vs">
            <tr class="bg-white border-b">
                <td class="w-4 p-4">
                    <div class="flex items-center">
                        <input id="checkbox-table-search-1" type="checkbox" class="w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500">
                        <label for="checkbox-table-search-1" class="sr-only">checkbox</label>
                    </div>
                </td>
                <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap">
                    ${member.id}
                </th>
                <td class="px-6 py-4">
                    ${member.name}
                </td>
                <td class="px-6 py-4">
                    <select data-id="${member.id}" data-reg-date="${member.regDate}" class="member-role bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5">
                        <option value="U" ${member.role == Role.U ? 'selected' : ''}>일반</option>
                        <option value="A" ${member.role == Role.A ? 'selected' : ''}>관리자</option>
                    </select>

                </td>
                <td class="px-6 py-4">
                    ${member.birthday}
                </td>
                <td class="px-6 py-4">
                    ${member.email}
                </td>
                <td class="px-6 py-4">
                    ${member.phone}
                </td>
                <td class="px-6 py-4">
                    ${member.gender eq Gender.M ? '남' : (member.gender eq Gender.F ? '여' : '')}
                </td>
                <td class="px-6 py-4" title="<c:forEach items="${member.hobby}" var="h" varStatus="vs">${h}${not vs.last ? ',' : ''}</c:forEach>">
                    ${member.hobby[0]}${member.hobby.size() > 1 ? '...' : ''}
                </td>
                <td class="px-6 py-4">
                    ${member.point}
                </td>
                <td class="px-6 py-4">
                    <%-- ${member.regDate} --%>
                    <%-- fmt:formatDate는 java.util.Date만 처리할 수 있다. --%>
                    <%-- 1. LocalDate -> Date 변환 (fmt:parseDate) --%>
                    <%-- 2. Date포맷팅(fmt:formatDate) --%>
                    <fmt:parseDate value="${member.regDate}" pattern="yyyy-MM-dd" var="regDate" scope="page"/>
                    <fmt:formatDate value="${regDate}" pattern="yyyy/MM/dd"/>
                </td>
            </tr>

            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<form action="${pageContext.request.contextPath}/admin/updateMemberRole" name="memberRoleUpdateFrm" method="post">
    <input type="hidden" name="id">
    <input type="hidden" name="role">
</form>
<script src="${pageContext.request.contextPath}/js/admin/memberList.js"></script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>