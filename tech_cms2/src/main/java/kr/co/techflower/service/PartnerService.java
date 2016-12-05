package kr.co.techflower.service;
import java.util.Map;

import org.springframework.ui.Model;

public interface PartnerService {

	

	

	void doPartnerList(Map<String, Object> map, Model model) throws Exception;

	void updatePartner(Map<String, Object> map, Model model);

	void insertPartner(Map<String, Object> map, Model model);

	void deletePartner(Map<String, Object> map, Model model);

}
