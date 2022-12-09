package kr.or.ddit.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.domain.Approval;
import kr.or.ddit.domain.StudentLecture;
import kr.or.ddit.mapper.ApprovalMapper;
import kr.or.ddit.mapper.LectureMapper;
import kr.or.ddit.mapper.StudentLectureApplyMapper;
import kr.or.ddit.service.ApprovalService;
import kr.or.ddit.service.StudentLectureApplyService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class StudentLectureApplyServiceImpl implements StudentLectureApplyService{
	
	@Autowired
	StudentLectureApplyMapper studentLectureApplyMapper;
	
	
	@Transactional
	@Override
	public int apply(StudentLecture studentLecture) {
		
		int headcount = this.studentLectureApplyMapper.checkHeadcount(studentLecture);
		
		if(headcount == 0) {
			return 0;
		}
		
		int result = this.studentLectureApplyMapper.apply(studentLecture);
		
		if(result == 0) {
			return 0;
		}
		return this.studentLectureApplyMapper.increaseHeadcount(studentLecture);
	}
	
	@Transactional
	@Override
	public int applyCancel(StudentLecture studentLecture) {
		int result = this.studentLectureApplyMapper.applyCancel(studentLecture);
		if(result == 0) {
			return 0;
		}
		return this.studentLectureApplyMapper.decreaseHeadcount(studentLecture);
	}
}
