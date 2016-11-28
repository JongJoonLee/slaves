package kr.co.techflower.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import kr.co.techflower.service.PartnerService;
import ngel.core.service.AbstractCommonService;

@Service("partnerService")
public class PartnerServiceImpl extends AbstractCommonService implements PartnerService {
	
	
	
	@Override
	public void doPartnerList(Map<String, Object> map,Model model)
			throws Exception {
		
	
		
		model.addAttribute("list", mapper.selectList("PartnerMapper.selectPartnerLIST", map));
		
		
		
	}

	
	
	
	

	
}
