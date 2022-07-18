package com.kh.icodi.admin.model.service;

import static com.kh.icodi.common.JdbcTemplate.close;
import static com.kh.icodi.common.JdbcTemplate.commit;
import static com.kh.icodi.common.JdbcTemplate.getConnection;
import static com.kh.icodi.common.JdbcTemplate.rollback;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.kh.icodi.admin.model.dao.AdminDao;
import com.kh.icodi.admin.model.dto.Product;
import com.kh.icodi.admin.model.dto.ProductAttachment;
import com.kh.icodi.admin.model.dto.ProductExt;
import com.kh.icodi.admin.model.dto.ProductIO;

public class AdminService {
	private AdminDao adminDao = new AdminDao();

	// 상품등록
	public int insertProduct(Product product) {
		Connection conn = getConnection();
		int result = 0;
		try {
			// 상품 테이블 insert
			result = adminDao.insertProduct(conn, product);
			
			// 첨부파일 테이블 insert
			List<ProductAttachment> attachments = ((ProductExt)product).getAttachmentList();
			if(attachments != null && !attachments.isEmpty()) {
				for(ProductAttachment attach : attachments) {
					attach.setProductCode(product.getProductCode());
					result = adminDao.insertAttachment(conn, attach);
				}
			}
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}
	
	// 상품 입출고 관리
	public int insertIO(ProductIO productIo) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = adminDao.insertIO(conn, productIo);
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}

	public List<ProductAttachment> findAttachmentByProductCode(String code) {
		Connection conn = getConnection();
		List<ProductAttachment> attachments = adminDao.findAttachmentByProductCode(conn, code);
		close(conn);
		return attachments;
	}

	public boolean deleteProduct(String[] pdCode) {
		Connection conn = getConnection();
		boolean result = true;
		try {
			result = adminDao.deleteProduct(conn, pdCode);
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);			
		}
		return result;
	}

	public int getTotalContentByCategoryNo(int categoryNo) {
		Connection conn = getConnection();
		int totalContent = adminDao.getTotalContentByCategoryNo(conn, categoryNo);
		close(conn);
		return totalContent;
	}

	public List<ProductExt> findProductList(Map<String, Object> param) {
		Connection conn = getConnection();
		List<ProductExt> productList = adminDao.findProductList(conn, param);
		for(ProductExt product : productList) {
			List<ProductAttachment> attachments = adminDao.findAttachmentByProductCode(conn, product.getProductCode());
			for(ProductAttachment attach : attachments) {
				product.addAttachment(attach);
			}
		}
		return productList;
	}
}
