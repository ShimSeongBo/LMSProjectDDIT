package kr.or.ddit.domain;

import java.util.Date;

import lombok.Data;

@Data
public class SclHistory {
	private int sclhCd;			//장학생 신청 코드
	private int sclCd;			//장학금코드
	private int stuNo;			//수여자번호
	private int sclhYr;			//연도
	private int sclhSem;		//학기
	private Date sclhDt;		//신청일자
	private String sclhYn;		//승인상태
	private String sclhPayYn;	//지급상태
	private int proNo;			//추천인
	private int sclhAmt;		//지급액
	
	private double totalAvg;	//성적
	private int ranking;		//등수
	
	private String sclNm;		//장학금명
	private int sclAmt;			//장학금액
	private String sclDetail;	//상세설명
	private int sclCap;			//수여인원
	
	private int colCd;			// 단과대코드
	private String colNm; 		//단과대학명
	private int colFee;			//단과대 등록금
	
	private String depNm ;		//학과명
	
	private String stuYr;       //학년
	private String stuNm;       //이름(한글)
	
	private int lecaCd;         //강의계획신청코드
	private int lecaCrd;        //학점
	private String lecaNm;      //강의명
	private String lecaCate;    //이수구분
	
	private double slScore;		//강의당 최종 성적
	
}
