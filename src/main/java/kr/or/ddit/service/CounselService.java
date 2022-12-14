package kr.or.ddit.service;

import java.util.List;

import kr.or.ddit.domain.Counsel;

public interface CounselService {
	
	//학생의 상담신청 목록
	public List<Counsel> studentApplyList(int stuNo);
	//학생의 상담신청
	public int applyInsert(Counsel counsel);
	//교수의 상담답변
	public int applyAnswerUpdate(Counsel counsel);
	//교수의 상담목록 조회
	public List<Counsel> professorCounselList(int proNo);
	//학생의 담당 교수 목록
	public List<Counsel> listOfProfessor(int stuNo);


}
