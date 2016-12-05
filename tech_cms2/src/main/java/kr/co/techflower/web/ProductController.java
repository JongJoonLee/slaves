package kr.co.techflower.web;



import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.techflower.service.ProductService;
import ngel.core.web.FrameworkController;

@Controller
public class ProductController extends FrameworkController{
	
	@Autowired
	ProductService productservice;
	
	
	
	@RequestMapping(value="/cms/product.do")
	public String doProductList(Model model, HttpServletRequest req, HttpServletResponse res) throws Exception{
		Map<String, Object> list = new HashMap<String, Object>();
		Map<String, Object> listsub1 = new HashMap<String, Object>();
		Map<String, Object> listsub2 = new HashMap<String, Object>();
		Map<String, Object> listsub3 = new HashMap<String, Object>();
		Map<String, Object> listsub4 = new HashMap<String, Object>();
		
		
		productservice.ProductList(list, model);
		
		
		productservice.ProductSubList(listsub1, model);
		productservice.ProductSubList(listsub2, model);
		productservice.ProductSubList(listsub3, model);
		productservice.ProductSubList(listsub4, model);
		
		return "tiles.product";
	}
	
	@RequestMapping(value="/cms/productDetail.do")
	public String doProductDetail(Map<String, Object> listDetail, Model model, HttpServletRequest req, HttpServletResponse res,
			@RequestParam(value = "tb_product_sub_no", required = false,defaultValue = "1") String tb_product_sub_no) throws Exception{
		
		//int tb_product_sub_no= Integer.parseInt(tb_product_sub_no);
		req.setAttribute("tb_product_sub_no", tb_product_sub_no);
		productservice.getProductDetailTitle(listDetail, model, tb_product_sub_no);
		
		
		return "/cms/productDetail";
	}

}
