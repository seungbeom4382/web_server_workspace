package com.sh.mvc.photo.controller;

import com.sh.mvc.photo.model.service.PhotoService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/photo/photoList")
public class PhotoListServlet extends HttpServlet {
    private PhotoService photoService = new PhotoService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. 사용자입력값
        // 2. 업무로직
        int limit = 5;
        int totalCount = photoService.getTotalCount();
        int totalPage = (int) Math.ceil((double) totalCount / limit);
        req.setAttribute("totalPage", totalPage);
        // 3. view단처리 (동기적 처리->forwarding)
        req.getRequestDispatcher("/WEB-INF/views/photo/photoList.jsp").forward(req, resp);
    }
}