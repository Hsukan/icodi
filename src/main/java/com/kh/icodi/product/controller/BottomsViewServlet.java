package com.kh.icodi.product.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class BottomsViewServlet
 */
@WebServlet("/product/bottoms")
public class BottomsViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
		request.setAttribute("categoryNo", categoryNo);
		request.getRequestDispatcher("/WEB-INF/views/product/bottomsView.jsp").forward(request, response);
	}
}