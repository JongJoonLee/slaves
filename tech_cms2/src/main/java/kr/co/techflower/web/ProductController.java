package kr.co.techflower.web;



import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.techflower.service.ProductService;
import ngel.core.web.FrameworkController;

@Controller
public class ProductController extends FrameworkController{
	
	@Autowired
	ProductService productservice;
	
	
	
	@RequestMapping(value="/cms/product.do")
	public String doProductList(Model model, HttpServletRequest req, HttpServletResponse res) throws Exception{
		Map<String, Object> list = new HashMap<String, Object>();
		productservice.ProductList(list, model);
		
		
		return "tiles.product";
	}
	
	@RequestMapping(value="/cms/productDetail.do")
	public String doProductDetail(Model model, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		
		return "/cms/productDetail";
	}

}
