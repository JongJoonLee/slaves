package kr.co.techflower.service.impl;


import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.techflower.service.PromoteService;
import ngel.core.service.AbstractCommonService;

@Service("promoteService")
public class PromoteServiceImpl extends AbstractCommonService implements PromoteService{
	
	@Override
	public void getPromoteList(Map<String, Object> map,Model model,
			@RequestParam(value = "page", required = false, defaultValue = "1") int cnt) throws Exception{
		
		model.addAttribute("list",mapper.selectList("Promote.getPromoteList", (cnt-1)*10));
		
		
	}
	@Override
	public int getPromoteCount(){
		
		int tot = 0;
		tot=mapper.selectOne("Promote.getPromoteCount");
		return tot;
	}
	
	@Override
	public void getPromoteContents(Model model,
			@RequestParam(value = "tb_promote_no") int tb_promote_no) throws Exception{
		System.out.println("겟프로모트콘텐츠넘버 : " + tb_promote_no);
		model.addAttribute("ctnt", mapper.selectOne("Promote.getPromoteContents", tb_promote_no));
		model.addAttribute("ctntpre", mapper.selectOne("Promote.getTb_promote_Prev",tb_promote_no));
		model.addAttribute("ctntnext", mapper.selectOne("Promote.getTb_promote_Next",tb_promote_no));
		
	}
	
	
	@Override
	public void inputPromote(Map<String, Object> map, Model model){
		mapper.insert("Promote.setPromote", map);
	}
	
	
	@Override
	public void updatePromote(Map<String, Object> map, @RequestParam(value = "tb_promote_no")int tb_promote_no, Model model){
		
		
		mapper.update("Promote.update_Promote",map);
	}
	
	@Override
	public void updatePromoteHit(@RequestParam(value = "tb_promote_no")int tb_promote_no,Model model){
		// 조회수증가
		Map<String, Object> map = new HashMap<String, Object>();
		int hit = mapper.selectOne("Promote.getPromotehit",tb_promote_no);
		System.out.println("조회수 : " + hit);
		map.put("tb_promote_hit", (hit + 1));
		map.put("tb_promote_no", tb_promote_no);
		mapper.update("Promote.updatePromoteHit", map);
		System.out.println("업데이트 후 : "+mapper.selectOne("Promote.getPromotehit",tb_promote_no));
		
	}
	
	@Override
	public void getPromoteSearch (Map<String, Object> map, Model model,
		@RequestParam(value = "page", required = false, defaultValue = "1") int cnt,
		@RequestParam(value = "stype") String stype, 
		@RequestParam(value = "stext") String stext)
		throws UnsupportedEncodingException{
		Map<String, Object> tptx = new HashMap<String, Object>();
		tptx.put("stext", stext);
		tptx.put("stype", stype);
		tptx.put("cnt", (cnt-1)*10);
		model.addAttribute("list", mapper.selectList("Promote.getPromoteSearch",tptx));
		model.addAttribute("stype", stype);
		model.addAttribute("stext", stext);
		model.addAttribute("cnt", cnt);
	}
	
	@Override
	public int getSearchTotgl1(@RequestParam(value = "stype") String stype, 
			@RequestParam(value = "stext") String stext){
		Map<String, Object> cntsearchtot = new HashMap<String, Object>();
		cntsearchtot.put("stext", stext);
		cntsearchtot.put("stype", stype);
		int tot=0;
		tot=mapper.selectOne("Promote.getPromoteSearchTot",cntsearchtot);
		
		return tot;
	}
	

}
