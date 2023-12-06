package com.sh.web.servlet;

import java.io.IOException;
import java.util.Arrays;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 클라이언트 : /hello-web/testPerson2.do
 * 서버 : /hello-web에 해당하는 프로젝트 찾고, /testPerson2.do에 해당하는 servlet을 찾아서 연결.
 * 
 * @WebServlet("/testPerson2.do") : context path 작성하지 않는다.
 * 
 */
@WebServlet("/testPerson2.do")
public class TestPersonPostServlet extends HttpServlet {
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 요청메시지에 대한 인코딩 처리
		req.setCharacterEncoding("utf-8"); // 대소문자 구별 안함.
		
		// 사용자 입력값 처리
		String name = req.getParameter("name"); // input태그의 name속성값
		String color = req.getParameter("color");
		String animal = req.getParameter("animal");
		String[] foods = req.getParameterValues("food");
		
		System.out.println(name);
		System.out.println(color);
		System.out.println(animal);
		System.out.println(Arrays.toString(foods));
		
		// 응답 html 작성
		resp.setContentType("text/html; charset=utf-8");
		PrintWriter out = resp.getWriter(); // 출력대상이 응답메시지인 문자기반 출력스트림
		String body = """
				<!doctype html>
				<html>
					<head>
						<meta charset="utf-8"/>
						<title>개인취향검사 결과 POST</title>
					</head>
					<body>
						<h1>개인취향검사 결과 POST</h1>
						<p>반갑습니다. %s님</p>
						<p>%s색을 좋아하십니다.</p>
						<p>동물은 %s를 좋아하십니다.</p>
						<p>중국집 음식중에는 %s을 좋아하십니다.</p>
					</body>
				</html>
				""".formatted(name, color, animal, Arrays.toString(foods));
				System.out.println(body); // 콘솔에 출력
				
				out.append(body); // 응답메세지 body에 출력
	}

}
