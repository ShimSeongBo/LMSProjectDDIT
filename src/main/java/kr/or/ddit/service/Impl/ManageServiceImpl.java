package kr.or.ddit.service.Impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.domain.Student;
import kr.or.ddit.mapper.ManageMapper;
import kr.or.ddit.service.ManageService;

@Service
public class ManageServiceImpl implements ManageService{

	@Autowired
	ManageMapper manageMapper;
	
	@Override
	public List<Student> studentList() {
		return this.manageMapper.studentList();
	}
	
	@Override
	public Student detailStu(Map<String, String> map) {
		return this.manageMapper.detailStu(map);
	}
	
	@Override
	public int deleteStu(Map<String, String> map) {
		return this.manageMapper.deleteStu(map);
	}
}
