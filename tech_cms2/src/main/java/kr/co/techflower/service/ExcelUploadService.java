package kr.co.techflower.service;

import java.util.Map;

public interface ExcelUploadService {

	//idxdd, idxCateId 를 이용하여 있으면 수정, 없으면 저장하는 메소드
	public int doSaveOneData(Map<String, Object> map) throws Exception;
	//모두 완료되면 tb_idx 테이블에 평균값 구해와서 저장하는 메소드
	public int doSaveCateIdAvg(Map<String, Object> map) throws Exception;
}
