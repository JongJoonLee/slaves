package kr.co.techflower.service.impl;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.techflower.service.NoticeSevice;
import ngel.core.service.AbstractCommonService;

@Service("noticeSevice")
public class NoticeSeviceImpl extends AbstractCommonService implements NoticeSevice {

	@Override
	public void getNoticeList(Map<String, Object> map,Model model,
			@RequestParam(value = "page", required = false, defaultValue = "1") int cnt)
			throws Exception {
		System.out.println("(보드리스트)cnt : "+cnt);


		model.addAttribute("list", mapper.selectList("Board.getNotice_BoardList", (cnt-1)*10));
		
		
	}
	@Override
	public int getTotgl1(){
		
		int tot=0;
		tot=mapper.selectOne("Board.getNotice_BoardCount");
		return tot;
	}
	
	@Override
	public void getNoticeSearch (Map<String, Object> map, Model model,
	@RequestParam(value = "page", required = false, defaultValue = "1") int cnt,
	@RequestParam(value = "s_type") String s_type, 
	@RequestParam(value = "s_text") String s_text)
	throws UnsupportedEncodingException {
		
	
		System.out.println("cnt : "+cnt);
		System.out.println("s_text : "+s_text);
		System.out.println("s_type : "+s_type);
		
		Map<String, Object> tptx = new HashMap<String, Object>();
		tptx.put("s_text", s_text);
		tptx.put("s_type", s_type);
		tptx.put("cnt", (cnt-1)*10);
		model.addAttribute("list", mapper.selectList("Board.getNotice_BoardSearch",tptx));
		model.addAttribute("s_type", s_type);
		model.addAttribute("s_text", s_text);
			
	}
	
	
	@Override
	public int getSearchTotgl1(@RequestParam(value = "s_type") String s_type, 
			@RequestParam(value = "s_text") String s_text){
		Map<String, Object> cntsearchtot = new HashMap<String, Object>();
		cntsearchtot.put("s_text", s_text);
		cntsearchtot.put("s_type", s_type);
		int tot=0;
		tot=mapper.selectOne("Board.getNotice_BoardSearchTot",cntsearchtot);
		return tot;
	}
	

	

}
