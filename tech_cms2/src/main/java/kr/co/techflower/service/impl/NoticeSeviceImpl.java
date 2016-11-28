package kr.co.techflower.service.impl;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;

import java.util.Locale;
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
		/*mapper.selectOne("Board.getNotice_BoardCount", tot);*/
		System.out.println(tot);
		
		return tot;
	}
	
	@Override
	public int getNoticeSearch (Locale locale, Model model,
	@RequestParam(value = "page", required = false) int cnt,
	@RequestParam(value = "s_type") String s_type, @RequestParam(value = "s_text") String s_text)
	throws UnsupportedEncodingException {
		
		
		/*bcp.setCnt((cnt - 1) * 20);
		bcp.setTxt(s_text); // 검색내용
		bcp.setType(s_type);// 카테고리
		List<BoardVO> list = boardDAO.getNotice_BoardSearch(bcp);*/

		// System.out.println(bcp.getCnt());

		// String aaa = new String(s_text.getBytes("8859_1"),"KSC5601");
		System.out.println("cnt : "+cnt);
		System.out.println("s_text : "+s_text);
		System.out.println("s_type : "+s_type);
		
		Map<String, Object> tptx = new HashMap<String, Object>();
		tptx.put("s_text", s_text);
		tptx.put("s_type", s_type);
		tptx.put("cnt", (cnt-1)*10);
		
		
		
		
		model.addAttribute("list", mapper.selectList("Board.getNotice_BoardSearch",tptx));
		
		Map<String, Object> totgl = new HashMap<String, Object>();
		totgl.put("s_type", s_type);
		totgl.put("s_text", s_text);
		totgl.put("cnt", (cnt-1)*10);
		int tot= 0;
		tot=mapper.selectOne("Board.getNotice_BoardSearchTot",totgl);
		
		
		System.out.println("검색총게시물수 : "+tot);
		
		
		model.addAttribute("cont", (tot / 10) + 1);

		model.addAttribute("s_type", s_type);
		model.addAttribute("s_text", s_text);
		
		
		
		
		return tot;		
	}
	
	
	
	
	
	

	
	

	

}
