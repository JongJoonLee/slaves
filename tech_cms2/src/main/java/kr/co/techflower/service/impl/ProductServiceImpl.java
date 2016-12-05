package kr.co.techflower.service.impl;

import java.util.ArrayList;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.techflower.service.ProductService;
import ngel.core.service.AbstractCommonService;

@Service("productService")
public class ProductServiceImpl extends AbstractCommonService implements ProductService{
	
	@Override
	public void ProductList(Map<String, Object> map,Model model){
		
		model.addAttribute("list", mapper.selectList("Product.getProductTitle", map));
		//model.addAttribute("listsub", mapper.selectList("Product.getProductSubTitle", map));
	}
	
	@Override
	public void ProductSubList(Map<String, Object> map,Model model){
		List<Object> listsub1 = new ArrayList<Object>();
		List<Object> listsub2 = new ArrayList<Object>();
		List<Object> listsub3 = new ArrayList<Object>();
		List<Object> listsub4 = new ArrayList<Object>();
		
		
		listsub1=mapper.selectList("Product.getProductSubNo1", map);
		listsub2=mapper.selectList("Product.getProductSubNo2", map);
		listsub3=mapper.selectList("Product.getProductSubNo3", map);
		listsub4=mapper.selectList("Product.getProductSubNo4", map);
		
		
		
		model.addAttribute("listsub1",listsub1);
		model.addAttribute("listsub2",listsub2);
		model.addAttribute("listsub3",listsub3);
		model.addAttribute("listsub4",listsub4);
		
		
		
		
		//listsub=mapper.selectList("Product.getProductSubTitle", map);
		
		//System.out.println(listsub);
		
		//model.addAttribute("listsub", mapper.selectList("Product.getProductSubTitle", map));
		//model.addAttribute("listsub",listsub);
	}
	
	@Override
	public void getProductDetailTitle(Map<String, Object> map,Model model,
			@RequestParam(value = "tb_product_sub_no", required = false) String tb_product_sub_no){
		List<Object> listDetail = new ArrayList<Object>();
		
		listDetail = mapper.selectList("getProductDetailTitle", Integer.parseInt(tb_product_sub_no));
		model.addAttribute("listDetail", listDetail);
		
		
		System.out.println("서비스 디테일넘버랑게! : "+tb_product_sub_no);
		System.out.println("서비스 리스트 내용 : "+listDetail);
	}
	
	
	

}
