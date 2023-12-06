package com.sh.web.servlet;

import java.io.IOException;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet 생명주기
 * - HttpServlet 상속
 * - tomcat에 의해서 싱글턴객체(프로그램당 객체를 하나만 만들어서 재사용하는 패턴)로 관리
 * 
 * 1. 최초 요청시 servlet 객체 생성
 * 2. @PostConstruct 메소드 호출
 * 3. 설정메소드 init 호출
 * 
 * 4. 실제요청시 service 호출
 * 5. 전송방식별로 doGet, doPost 등이 호출
 * 
 * 6. destroy메소드 호출
 * 7. @PreDestroy 메소드 호출
 * 8. 자원반납
 * 
 */

@WebServlet("/lifecycle.do")
public class LifeCycleServlet extends HttpServlet {
	
	public LifeCycleServlet() {
		System.out.println("1. 생성자 호출! " + this);
	}
	
	@PostConstruct
	public void postConstruct() {
		System.out.println("2. @PostConstruct");
	}
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		System.out.println("3. init");
	}
	
	@Override
	public void service(ServletRequest req, ServletResponse res) throws ServletException, IOException {
		System.out.println("4. service " + this);
		super.service(req, res);
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("5. doGet " + this );
	}
	
	@Override
	public void destroy() {
		System.out.println("6. destroy");
	}
	
	@PreDestroy
	public void preDestroy() {	
		System.out.println("7. preDestroy");
	}
}
