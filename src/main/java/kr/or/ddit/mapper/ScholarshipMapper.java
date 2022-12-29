package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.domain.Scholarship;
import kr.or.ddit.domain.SclHistory;

public interface ScholarshipMapper {

	//장학금 목록
	public List<Scholarship> scholarshipInquiry();
	
	//장학금 수여 목록
	public List<SclHistory> scholarshipAwardList();
	
	//장학금 수여자 확인
	public int scholarshipCheck(int stuNo);
	
	//장학금 수여학생 정보 가져오긔
	public List<SclHistory> studentInfoList(int stuNo);
	
	//장학금 수여
	public int scholarshipConfer(SclHistory sclHistory);
}
