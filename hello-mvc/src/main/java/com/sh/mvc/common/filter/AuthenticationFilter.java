package com.sh.mvc.common.filter;

import com.sh.mvc.member.model.entity.Member;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * annotation은 속성을 가질수 있다.
 * - 대표속성 하나는 value alias사용가능하고, 생략도 가능하다.
 * - @WebFilter 어노테이션은 urlPatterns, value 동일
 */
@WebFilter(urlPatterns = {
    "/member/memberDetail", 
    "/member/memberUpdate",
    "/member/memberDelete",
    "/board/boardCreate"
})
public class AuthenticationFilter extends HttpFilter {
    @Override
    protected void doFilter(HttpServletRequest req, HttpServletResponse resp, FilterChain chain) throws IOException, ServletException {
        // 인증여부 검사
        HttpSession session = req.getSession();
        Member loginMember = (Member) session.getAttribute("loginMember");
        if(loginMember == null) {
            session.setAttribute("msg", "로그인후 사용가능합니다. 😉");
            resp.sendRedirect(req.getContextPath() + "/");
            return; // redirect/forward 이후 실행코드는 없어야 한다.
        }
        super.doFilter(req, resp, chain);
    }
}
