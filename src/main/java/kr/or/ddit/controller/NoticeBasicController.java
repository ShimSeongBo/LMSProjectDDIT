package kr.or.ddit.controller;

import java.util.List;

import kr.or.ddit.domain.notice.NoticeBasic;
import kr.or.ddit.service.NoticeBasicService;
import kr.or.ddit.util.FileUploadUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.multipart.MultipartFile;

@Slf4j
@Controller
@RequestMapping("/notice")
@RequiredArgsConstructor // 어노테이션이 궁금하면 생성자 주입과 관련해서 찾아보시길..!
public class NoticeBasicController {

    /**
     * DI(의존성 주입)을 하는 방법에는 3가지가 있다.
     * 1) 필드 주입
     * 2) 수정자(Setter) 주입
     * 3) 생성자 주입
     * <p>
     * 이 중 3) 생성자 주입을 쓸 것을 Spring 에서 권장한다.
     * 장/단점이 궁금하면 슬랙으로..ㅎ
     */

    private final NoticeBasicService noticeBasicService; // final을 붙인 이유: 생성시 초기값을 꼭 넣어줘야 함!

    private final FileUploadUtil fileUploadUtil;

    private static final String HOME = "redirect:/notice/list";

    //공지사항 리스트
    @GetMapping("/list")
    public String testHome(Model model,
                           @RequestParam(value="viewPage", required = false, defaultValue = "1") int viewPage) {

        //총 행의 수
        int totalRow = noticeBasicService.getNoticeBasicTotalRow();

        //총 페이지의 수 계산
        int totalPage = (int) Math.ceil((double) totalRow / 10);

        List<NoticeBasic> noticeBasicList = noticeBasicService.noticeBasicList(viewPage);

        model.addAttribute("noticeBasicList", noticeBasicList);
        model.addAttribute("totalRow", totalRow);
        model.addAttribute("totalPage", totalPage);

        return "notice/test";
    }

    //공지사항 등록 폼
    @GetMapping("/noticeForm")
    public String createNoticeForm(NoticeForm form, Model model) {

        // 공지사항 등록을 위한 폼(제목, 내용)을 전달.
        model.addAttribute("form", new NoticeForm());

        return "notice/noticeForm";
    }

    //공지사항 등록(Save)
    @PostMapping("/noticeForm")
    public String createNotice(NoticeForm form,
                               @RequestParam MultipartFile[] files2
    ) {

        // 공지사항 등록을 위한 폼(제목, 내용)에 담아온 값을 꺼내어, NoticeBasic객체에 생성자로 세팅해준다. Setter로 값을 넣어주는 방법은 지양하는게 좋다.
        NoticeBasic noticeBasic = new NoticeBasic(form.getTitle(), form.getContent());

        // NoticeBasic객체를 save메서드를 호출하여, 서비스로직 실행.
        noticeBasicService.noticeBasicSave(noticeBasic);
        if (files2[0].getSize() > 0) {
            fileUploadUtil.fileUploadAction(files2);
        }

        return HOME;
    }

    //공지사항 상세페이지
    @GetMapping("/list/{noticeBasic.noticeCd}/detail")
    public String detail(@PathVariable("noticeBasic.noticeCd") Long noticeCd, Model model) {

        noticeBasicService.updateViewCount(noticeCd);

        // 게시글 아이디를(noticeCd) 통해서 findOne 메서드를 호출하여 조회한다.
        NoticeBasic noticeBasic = noticeBasicService.findOne(noticeCd);

        // 조회한 NoticeBasic객체를 'form'이라는 이름으로 객체를 전달한다.
        model.addAttribute("form", noticeBasic);

        return "notice/detail";
    }

    //공지사항 수정페이지
    @GetMapping("/update/{form.noticeCd}")
    public String updateForm(@PathVariable("form.noticeCd") Long noticeCd, Model model) {

        NoticeBasic noticeBasic = noticeBasicService.findOne(noticeCd);

        model.addAttribute("form", noticeBasic);

        return "notice/modifyForm";
    }

    @PostMapping("/update/{form.noticeCd}")
    public String updateNotice(@ModelAttribute("form") NoticeBasic form) {

        noticeBasicService.noticeBasicUpdate(form);

        return HOME;
    }

    //공지사항 삭제
    @GetMapping("/delete/{form.noticeCd}")
    public String delete(@PathVariable("form.noticeCd") Long noticeCd) {

        noticeBasicService.delete(noticeCd);

        return HOME;
    }

    //공지사항 등록


}
