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
		model.addAttribute("list", mapper.selectList("Board.getNotice_BoardList", (cnt-1)*10));
	}
	@Override
	public void getNoticeSearch (Map<String, Object> map, Model model,
		@RequestParam(value = "page", required = false, defaultValue = "1") int cnt,
		@RequestParam(value = "stype") String stype, 
		@RequestParam(value = "stext") String stext)
		throws UnsupportedEncodingException{
		Map<String, Object> tptx = new HashMap<String, Object>();
		tptx.put("stext", stext);
		tptx.put("stype", stype);
		tptx.put("cnt", (cnt-1)*10);
		model.addAttribute("list", mapper.selectList("Board.getNotice_BoardSearch",tptx));
		model.addAttribute("stype", stype);
		model.addAttribute("stext", stext);
		model.addAttribute("cnt", cnt);
	}
	
	@Override
	public int getTotgl1(){
		
		int tot=0;
		tot=mapper.selectOne("Board.getNotice_BoardCount");
		return tot;
	}
	
	
	
	
	@Override
	public int getSearchTotgl1(@RequestParam(value = "stype") String stype, 
			@RequestParam(value = "stext") String stext){
		Map<String, Object> cntsearchtot = new HashMap<String, Object>();
		cntsearchtot.put("stext", stext);
		cntsearchtot.put("stype", stype);
		int tot=0;
		tot=mapper.selectOne("Board.getNotice_BoardSearchTot",cntsearchtot);
		
		return tot;
	}
	
	@Override
	public void inputNotice(Map<String, Object> bdwrite, Model model){
		
		//System.out.println("제목은 : "+bdwrite.get("notice_board_title"));
		mapper.insert("Board.insertNotice_Board", bdwrite);
		
	}
	
	
	@Override
	public void getBoardContents(@RequestParam(value = "notice_board_no")int notice_board_no,Model model){
		System.out.println("서비스 글번호 : "+notice_board_no);
		
		
				
		
		model.addAttribute("ctnt", mapper.selectOne("Board.getNotice_BoardContents", notice_board_no));
		model.addAttribute("ctntpre", mapper.selectOne("Board.getNotice_Board_Prev",notice_board_no));
		model.addAttribute("ctntnext", mapper.selectOne("Board.getNotice_Board_Next",notice_board_no));
		
		
		
		
		
		//System.out.println("서비스제목 : "+ctnt.get("notice_board_title"));
		
		
	}
	@Override
	public void updateHit(@RequestParam(value = "notice_board_no")int notice_board_no,Model model){
		// 조회수증가
		Map<String, Object> map = new HashMap<String, Object>();
		int hit = mapper.selectOne("Board.getNotice_hit",notice_board_no);
		System.out.println("조회수 : " + hit);
		map.put("notice_board_hit", (hit + 1));
		map.put("notice_board_no", notice_board_no);
		mapper.update("Board.notice_updateHit", map);
		System.out.println("업데이트 후 : "+mapper.selectOne("Board.getNotice_hit",notice_board_no));
		
	}
	
	
	
	
	
	
	

	

}
