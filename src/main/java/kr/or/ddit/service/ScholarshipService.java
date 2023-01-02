package kr.or.ddit.service;

import java.util.HashMap;
import java.util.List;

import kr.or.ddit.domain.Scholarship;
import kr.or.ddit.domain.SclHistory;

public interface ScholarshipService {

	public List<Scholarship> scholarshipInquiry();

	public List<SclHistory> scholarshipAwardList();

	public int scholarshipCheck(int stuNo);

	public List<SclHistory> studentInfoList(int stuNo);

	public int scholarshipConfer(SclHistory sclHistory);

	public List<SclHistory> stuScholarshipList(int stuNo);

	public HashMap<String, Object> scholarshipBenefitCertificate(int sclhCd);

}
