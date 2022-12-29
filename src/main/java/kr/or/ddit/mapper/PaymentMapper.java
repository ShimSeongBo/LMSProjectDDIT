package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.domain.Department;
import kr.or.ddit.domain.Payment;
import kr.or.ddit.domain.Student;

public interface PaymentMapper {

	//등록금 목록 조회
	public List<Department> collegeFeeList();
	
	//등록금 고지 관리 목록
	public List<Payment> adminBillList();
	
	//등록금 고지 관리 리스트 개수
	public int adminBillCount();
	
	//등록금 납부 총 납부액
	public Payment sumFee();
	
	//등록금 납부 관리 리스트
	public List<Payment> adminPaymentList();
	
	//학생 등록금 납부내역 리스트
	public List<Payment> stuPaymentList(int stuNo);
	
	//학생 등록금 납부내역 미납자 확인
	public int billCount(int stuNo);
	
	//학생 납부확인서
	public Student paymentFormStuInfo(int stuNo);
	public List<Payment> paymentFormInfo(int payCd);
	public List<Department> paymentFormDepInfo(int payCd);
}
