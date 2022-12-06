package kr.or.ddit.service;

import java.util.List;

import kr.or.ddit.domain.College;

public interface CollegeService {
	
	//단과대학 목록
	public List<College> CollegeList();
	//단과대학 상세
	public College CollegeDetail(int colCd);
	//단과대학 수정
	public int CollegeUpdate(College college);
	
}
