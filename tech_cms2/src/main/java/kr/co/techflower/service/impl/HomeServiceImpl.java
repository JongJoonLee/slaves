package kr.co.techflower.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import ngel.core.service.AbstractCommonService;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import kr.co.techflower.service.HomeService;

@Service("homeService")
public class HomeServiceImpl extends AbstractCommonService implements HomeService {

	@Override
	public void getPageLoad(Map<String, Object> map, Model model) throws Exception {
		/*String[] vaPageId = {"auth","banner","basicCode","board","mail","menu","multilang","notice","panel","popup","user","webEdit"};*/
		
		String vsPageId = (String) map.get("pageId");
		if("user".equals(vsPageId)){
			map.put("pageNo", 1);
			model.addAttribute("checkboxList", mapper.selectList("UserMapper.selectUserDivList", map));
			
			List<Map<String, Object>> dataList = mapper.selectList("UserMapper.selectUserDataList", map);
			model.addAttribute("dataList", dataList);
			
			Map<String, Object> pagingMap = new HashMap<String, Object>();
			pagingMap.put("PAGE_NO", 1);
			pagingMap.put("TOT_PAGE", !dataList.isEmpty()?dataList.get(0).get("TOT_PAGE"):0);
			model.addAttribute("paging", pagingMap);			
		}else if("multilang".equals(vsPageId)){
			model.addAttribute("checkboxList", mapper.selectList("LanguageMapper.selectLocaleDivList", map));
		}else if("webEdit".equals(vsPageId)){
			model.addAttribute("checkboxList", mapper.selectList("WebeditorMapper.selectEditorComboList", map));
		}else if("surveyDetail".equals(vsPageId)){
			map.put("SURVEY_ID", map.get("surveyId"));
			model.addAttribute("surveyId", map.get("surveyId"));
			List<Map<String, Object>> dataList = mapper.select("SurveyMapper.selectSurveyDetailList", map);
			
			if(!dataList.isEmpty() && dataList.size() > 0){
				for(int i = 0; i < dataList.size(); i++){
					dataList.get(i).put("exampleList", mapper.select("SurveyMapper.selectSurveyDetailExampleList", dataList.get(i)));
				}
			}
			model.addAttribute("detailList", dataList);
			//model.addAttribute("exampleList", mapper.select("SurveyMapper.selectSurveyDetailExampleList", map));
		}
	}

}
