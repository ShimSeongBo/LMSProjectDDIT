package kr.or.ddit.mapper;


import kr.or.ddit.domain.qna.Qna;
import kr.or.ddit.domain.qna.qnareply.QnaReply;
import org.apache.ibatis.annotations.Select;
import java.util.List;

public interface QnaMapper {

    @Select("SELECT COUNT(*) FROM qna")
    int getQnaTotalRow();

    //문의게시판 등록
    void qnaSave(Qna qna);

    //문의게시판/검색결과 리스트 출력
    @Select("SELECT * FROM qna")
    List<Qna> showList();

    @Select("SELECT * FROM qna WHERE qna_cd = #{qnaCd}")
    Qna findOne(Long qnaCd);

    @Select("Delete FROM qna WHERE qna_cd = #{qnaCd}")
    void delete(Long qnaCd);

    void update(Qna qna);

    @Select("UPDATE QNA SET QNA_HIT = QNA_HIT + 1 WHERE QNA_CD = #{qnaCd}")
    void updateViewCount(Long qnaCd);

    void qnaReplySave(QnaReply qnaReply);

    @Select("SELECT * FROM QNA_REPLY WHERE QNA_CD = #{qnaCd}")
    QnaReply qnaReplyFindOne(Long qnaCd);
}
