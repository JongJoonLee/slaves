package kr.co.techflower.service.impl;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.techflower.service.RecruitService;
import ngel.core.service.AbstractCommonService;


@Service("RecruitService")
public class RecruitServiceImpl extends AbstractCommonService implements RecruitService{

	@Override
	public void getRecruitList(Map<String, Object> map,Model model,
			@RequestParam(value = "page", required = false, defaultValue = "1") int cnt)
			throws Exception {
		model.addAttribute("list", mapper.selectList("Recruit.getRecruit_BoardList", (cnt-1)*10));
	}
	@Override
	public void getRecruitSearch (Map<String, Object> map, Model model,
		@RequestParam(value = "page", required = false, defaultValue = "1") int cnt,
		@RequestParam(value = "stype") String stype, 
		@RequestParam(value = "stext") String stext)
		throws UnsupportedEncodingException{
		Map<String, Object> tptx = new HashMap<String, Object>();
		tptx.put("stext", stext);
		tptx.put("stype", stype);
		tptx.put("cnt", (cnt-1)*10);
		model.addAttribute("list", mapper.selectList("Recruit.getRecruit_BoardSearch",tptx));
		model.addAttribute("stype", stype);
		model.addAttribute("stext", stext);
		model.addAttribute("cnt", cnt);
	}
	
	@Override
	public int getTotgl1(){
		
		int tot=0;
		tot=mapper.selectOne("Recruit.getRecruit_BoardCount");
		return tot;
	}
	
	
	
	
	@Override
	public int getSearchTotgl1(@RequestParam(value = "stype") String stype, 
			@RequestParam(value = "stext") String stext){
		Map<String, Object> cntsearchtot = new HashMap<String, Object>();
		cntsearchtot.put("stext", stext);
		cntsearchtot.put("stype", stype);
		int tot=0;
		tot=mapper.selectOne("Recruit.getRecruit_BoardSearchTot",cntsearchtot);
		
		return tot;
	}
	
	@Override
	public void inputRecruit(Map<String, Object> bdwrite, Model model){
		
		//System.out.println("제목은 : "+bdwrite.get("notice_board_title"));
		mapper.insert("Recruit.insertNotice_Board", bdwrite);
		
	}
	
	
	@Override
	public void getRecruitContents(@RequestParam(value = "tb_recruit_no")int tb_recruit_no,Model model){
		System.out.println("서비스 글번호 : "+tb_recruit_no);
		
		
				
		
		model.addAttribute("ctnt", mapper.selectOne("Recruit.getRecruit_BoardContents", tb_recruit_no));
		model.addAttribute("ctntpre", mapper.selectOne("Recruit.getRecruit_Board_Prev",tb_recruit_no));
		model.addAttribute("ctntnext", mapper.selectOne("Recruit.getRecruit_Board_Next",tb_recruit_no));
		
		
		
		
		
		//System.out.println("서비스제목 : "+ctnt.get("notice_board_title"));
		
		
	}
	@Override
	public void updateHit(@RequestParam(value = "notice_board_no")int tb_recruit_no,Model model){
		// 조회수증가
		Map<String, Object> map = new HashMap<String, Object>();
		int hit = mapper.selectOne("Recruit.getRecruit_hit",tb_recruit_no);
		System.out.println("조회수 : " + hit);
		map.put("tb_recruit_hit", (hit + 1));
		map.put("tb_recruit_no", tb_recruit_no);
		mapper.update("Recruit.recruit_updateHit", map);
		System.out.println("업데이트 후 : "+mapper.selectOne("Recruit.recruit_updateHit",tb_recruit_no));
		
	}
	
	
	
}
