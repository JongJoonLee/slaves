package kr.co.techflower.service.impl;

import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import kr.co.techflower.service.ProductService;
import ngel.core.service.AbstractCommonService;

@Service("productService")
public class ProductServiceImpl extends AbstractCommonService implements ProductService{
	
	@Override
	public void ProductList(Map<String, Object> map,Model model){
		
		model.addAttribute("list", mapper.selectList("Product.getProductTitle", map));
		model.addAttribute("listsub", mapper.selectList("Product.getProductSubTitle", map));
	}
	
	
	

}
