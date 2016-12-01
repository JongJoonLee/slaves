package kr.co.techflower.web;



import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import ngel.core.web.FrameworkController;

@Controller
public class ProductController extends FrameworkController{
	
	@RequestMapping(value="/cms/product.do")
	public String doProductList(Model model, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		
		return "tiles.product";
	}
	
	@RequestMapping(value="/cms/productDetail.do")
	public String doProductDetail(Model model, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		
		return "/cms/productDetail";
	}

}
