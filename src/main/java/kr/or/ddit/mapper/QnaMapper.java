package kr.or.ddit.mapper;


import kr.or.ddit.domain.qna.Qna;
import kr.or.ddit.domain.qna.QnaVO;
import org.apache.ibatis.annotations.Select;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface QnaMapper {


    @Select("SELECT COUNT(*) FROM qna")
    int getQnaTotalRow();

    //문의게시판 등록
    int insertQuestion(HashMap<String, Object> map);

    void qnaSave(Qna qna);

    //문의게시판/검색결과 리스트 출력
    List<QnaVO> list(Map<String, String> map);

    QnaVO detail(HashMap<String, Object> map);

    //답변등록
    int qnarWrite(HashMap<String, Object> map);

    //조회수 증가
    int increaseHit(HashMap<String, Object> map);

    //답변 수정
    int updateRepl(HashMap<String, Object> map);

    //게시글 수정
    int updateQ(HashMap<String, Object> map);

    //게시글 삭제
    int deleteQrepl(int qnaCd);

    int deleteQ(int qnaCd);

    int getTotal(Map<String, String> map);

    @Select("SELECT * FROM qna")
    List<Qna> showList();
}
