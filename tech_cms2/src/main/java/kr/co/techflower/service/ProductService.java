package kr.co.techflower.service;

import java.util.Map;

import org.springframework.ui.Model;

public interface ProductService {

	void ProductList(Map<String, Object> map, Model model);

	void ProductSubList(Map<String, Object> map, Model model);

	

	

	

	void getProductDetailTitle(Map<String, Object> map, Model model, String tb_product_sub_no);

	void insertSubMenu(Map<String, Object> inslist, Model model);

	void updateSubMenu(Map<String, Object> map, int tb_product_sub_no, Model model);

	void deleteSubMenu(Map<String, Object> map, Model model);
	
	
	
}
