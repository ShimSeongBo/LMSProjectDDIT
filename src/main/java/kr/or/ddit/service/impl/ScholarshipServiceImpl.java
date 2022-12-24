package kr.or.ddit.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.domain.Scholarship;
import kr.or.ddit.domain.SclHistory;
import kr.or.ddit.mapper.ScholarshipMapper;
import kr.or.ddit.service.ScholarshipService;

@Service
public class ScholarshipServiceImpl implements ScholarshipService {

	@Autowired
	private ScholarshipMapper scholarshipMapper;
	
	@Override
	public List<Scholarship> scholarshipInquiry() {
		return this.scholarshipMapper.scholarshipInquiry();
	}
	
	@Override
	public List<SclHistory> scholarshipAwardList() {
		return this.scholarshipMapper.scholarshipAwardList();
	}
	
	@Override
	public int scholarshipCheck() {
		return this.scholarshipMapper.scholarshipCheck();
	}
	
	@Override
	public List<SclHistory> studentInfoList(int stuNo) {
		return this.scholarshipMapper.studentInfoList(stuNo);
	}
	
	@Override
	public int scholarshipConfer(SclHistory sclHistory) {
		return this.scholarshipMapper.scholarshipConfer(sclHistory);
	}
}
