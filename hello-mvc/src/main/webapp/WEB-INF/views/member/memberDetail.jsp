<%--
  Created by IntelliJ IDEA.
  User: 82104
  Date: 2023-12-13
  Time: 오전 9:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.sh.mvc.member.model.entity.Gender"%>
<%@ page import="java.util.Arrays" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<div class="flex flex-col items-center justify-center px-6 py-8 mx-auto lg:py-0">
    <div class="w-full bg-white rounded-lg shadow my-4 sm:max-w-md xl:p-0">
        <div class="p-6 space-y-4 md:space-y-6 sm:p-8">
            <h1 class="text-xl font-bold leading-tight tracking-tight text-gray-900 md:text-2xl">
                마이페이지
            </h1>
            <form name="memberUpdateFrm" action="${pageContext.request.contextPath}/member/memberUpdate" method="post" class="space-y-4 md:space-y-6">
                <div>
                    <label for="id" class="block mb-2 text-sm font-medium text-gray-900 after:content-['*'] after:ml-0.5 after:text-red-500">아이디</label>
                    <input type="text" name="id" id="id" class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5" value=${loginMember.id} readonly required>
                </div>
                <div>
                    <label for="name" class="block mb-2 text-sm font-medium text-gray-900 after:content-['*'] after:ml-0.5 after:text-red-500">이름</label>
                    <input type="text" name="name" id="name" class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5" value=${loginMember.name} required>
                </div>
                <div>
                    <label for="birthday" class="block mb-2 text-sm font-medium text-gray-900">생일</label>
                    <input type="date" name="birthday" id="birthday" class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5" value=${loginMember.birthday}>
                </div>
                <div>
                    <label for="email" class="block mb-2 text-sm font-medium text-gray-900 after:content-['*'] after:ml-0.5 after:text-red-500">이메일</label>
                    <input type="email" name="email" id="email" class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5" placeholder="name@company.com" value=${loginMember.email} required>
                </div>
                <div>
                    <label for="phone" class="block mb-2 text-sm font-medium text-gray-900">전화번호</label>
                    <input type="text" name="phone" id="phone" class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5" placeholder="(-) 없이 입력하세요." value=${loginMember.phone}>
                </div>
                <fieldset>
                    <legend class="mb-3">성별</legend>
                    <div class="inline-flex items-center mr-4">
                        <input id="country-option-1" type="radio" name="gender" value="M" class="w-4 h-4 border-gray-300 focus:ring-2 focus:ring-blue-300" ${loginMember.gender == Gender.M ? 'checked' : ''}>
                        <label for="country-option-1" class="block ms-2  text-sm font-medium text-gray-900">남</label>
                    </div>
                    <div class="inline-flex items-center mr-4">
                        <input id="country-option-2" type="radio" name="gender" value="F" class="w-4 h-4 border-gray-300 focus:ring-2 focus:ring-blue-300" ${loginMember.gender == 'F' ? 'checked' : ''}>
                        <label for="country-option-2" class="block ms-2 text-sm font-medium text-gray-900">여</label>
                    </div>
                </fieldset>
                <fieldset>
                    <legend class="mb-3">취미</legend>
                    <div class="inline-flex items-center mr-4">
                        <input id="hobby-1" type="checkbox" name="hobby" value="운동" class="w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500 focus:ring-2" ${loginMember.hobby.contains('운동') ? 'checked' : ''}>
                        <label for="hobby-1" class="ms-2 text-sm font-medium text-gray-900">운동</label>
                    </div>
                    <div class="inline-flex items-center mr-4">
                        <input id="hobby-2" type="checkbox" name="hobby" value="게임" class="w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500 focus:ring-2" ${loginMember.hobby.contains('게임') ? 'checked' : ''}>
                        <label for="hobby-2" class="ms-2 text-sm font-medium text-gray-900">게임</label>
                    </div>
                    <div class="inline-flex items-center mr-4">
                        <input id="hobby-3" type="checkbox" name="hobby" value="영화" class="w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500 focus:ring-2" ${loginMember.hobby.contains('영화') ? 'checked' : ''}>
                        <label for="hobby-3" class="ms-2 text-sm font-medium text-gray-900">영화</label>
                    </div>
                    <div class="inline-flex items-center mr-4">
                        <input id="hobby-4" type="checkbox" name="hobby" value="음악" class="w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500 focus:ring-2" ${loginMember.hobby.contains('음악') ? 'checked' : ''}>
                        <label for="hobby-4" class="ms-2 text-sm font-medium text-gray-900">음악</label>
                    </div>
                    <!-- c:set태그 context객체별 속성 생성 (c:remove와 반대) -->
                    <c:set var="hobbyDefaultList" value='<%= Arrays.asList("운동", "게임", "영화", "음악")%>' scope="page"></c:set>
                    <c:forEach items="${loginMember.hobby}" var="hobby" varStatus="vs">
                        <%-- el연산자 not(!) eq(==) ne(!=) gt(>) ge(>=) lt(<) le(<=) --%>
<%--                        <c:if test="hobby ne '운동' && hobby ne '게임' && hobby ne '영화' && hobby ne '음악'">--%>
                        <c:if test="${not hobbyDefaultList.contains(hobby)}">
                            <div class="inline-flex items-center mr-4">
                                <input id="hobby-${vs.count + hobbyDefaultList.size()}" type="checkbox" name="hobby" value="${hobby}" checked class="w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500 focus:ring-2">
                                <label for="hobby-${vs.count + hobbyDefaultList.size()}" class="ms-2 text-sm font-medium text-gray-900">${hobby}</label>
                            </div>
                        </c:if>
                    </c:forEach>
                    <div class="inline-flex items-center mr-4" id="hobby-etc-wrapper">
                        <input type="checkbox" value="" class="w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500 focus:ring-2" >
                        <label id="hobby-etc" class="ms-2 text-sm font-medium text-gray-500" contenteditable>직접입력</label>
                    </div>
                </fieldset>
                <div>
                    <label for="point" class="block mb-2 text-sm font-medium text-gray-900">포인트</label>
                    <input type="number" name="point" id="point" value=${loginMember.point} class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5" readonly>
                </div>

                <button type="button" class="text-white w-full bg-purple-400 hover:bg-purple-500 focus:ring-4 focus:outline-none focus:ring-primary-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center">비밀번호 변경</button>
                <button type="submit" class="text-white w-full bg-primary-600 hover:bg-primary-700 focus:ring-4 focus:outline-none focus:ring-primary-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center">저장</button>
                <p class="text-sm font-light text-red-500">
                    서비스를 그만 사용하고 싶으신가요? <a href="javascript:confirm('정말 탈퇴하시겠습니까?🥲') && document.memberDeleteFrm.submit();" class="font-medium text-red-600 hover:underline">여기서 회원탈퇴하세요😭</a>
                </p>
            </form>
        </div>
    </div>
</div>
<form action="${pageContext.request.contextPath}/member/memberDelete" method="post" name="memberDeleteFrm"></form>
<script src="${pageContext.request.contextPath}/js/member/memberDetail.js"></script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>