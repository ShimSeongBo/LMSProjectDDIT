package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.domain.Student;

public interface ManagementOfStudentByProfessorMapper {

	//학생 조회
	public List<Student> StudentList(int depCd);
	//학생 상세
	public Student StudentDetail(int stuNo);
}
