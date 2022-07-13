package com.kh.icodi.admin.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.icodi.admin.model.dto.ProductIO;
import com.kh.icodi.admin.model.service.AdminService;

/**
 * Servlet implementation class AdminProductStockServlet
 */
@WebServlet("/admin/productStock")
public class AdminProductStockServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AdminService adminService = new AdminService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			request.setCharacterEncoding("utf-8");
			String productName = request.getParameter("productName");
			String ioStatus = request.getParameter("ioStatus");
			int ioStock =Integer.parseInt(request.getParameter("ioStock"));
			System.out.println("productName = " + productName);
			System.out.println("ioStatus = " + ioStatus);
			System.out.println("ioStock = " + ioStock);
			ProductIO productIo = new ProductIO(0, productName, ioStatus, ioStock);

			int result = adminService.insertIO(productIo);
			response.sendRedirect(request.getContextPath() + "/admin/adminPage");
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
}
