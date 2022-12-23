package kr.or.ddit.controller;

import java.util.ArrayList;
import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.domain.CommonDetail;
import kr.or.ddit.domain.Record;
import kr.or.ddit.service.CommonDetailService;
import kr.or.ddit.service.RecordService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/record")
public class RecordController {

	@Autowired
	RecordService recordService;
	@Autowired
	CommonDetailService commonDetailService;
	
	@GetMapping("/main")
	public String RecordList(Model model, int stuNo) {
		
		List<Record> recordsList = this.recordService.RecordList(stuNo);
		//공통 약속
		model.addAttribute("recordsList",recordsList);
		
		//forwarding
		return "record/main";
	}
	
	@GetMapping("/apply")
	public String RecordApply(int stuNo, Model model) {
		
		model.addAttribute("bodyTitle", "신청");
		model.addAttribute("stuNo", stuNo);
		
		//forwarding
		return "record/apply";
	}
	
	@PostMapping("/applyPost")
	public String RecordApplyPost(@ModelAttribute Record record) {
		if(record.getRgbCd().contains("휴학")) {
			String subRgbCd = record.getRgbCd().substring(3,7);
			record.setRgbCd(subRgbCd);
		}
		if(record.getRgbCd().contains("복학") || record.getRgbCd().contains("자퇴") || record.getRgbCd().contains("졸업")  ) {
			String subRgbCd = record.getRgbCd().substring(0,2);
			record.setRgbCd(subRgbCd);
		}
		
		List<CommonDetail> commonDetailList = this.commonDetailService.commonDetailList("APPROVAL");
		for (CommonDetail commonDetail : commonDetailList) {
			if(commonDetail.getComdNm().equals("승인대기")) {
				record.setRecYn(commonDetail.getComdCd());
			}
		}
		log.info("들어온 값 : " + record.toString());
		int result = this.recordService.RecordApply(record);
		if (result == 0 ) {
			log.info("등록실패");
		} else {
			log.info("등록성공");
		}
		return "redirect:/record/main?stuNo="+record.getStuNo();
	}
}
