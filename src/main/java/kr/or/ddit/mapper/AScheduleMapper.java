package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.domain.ASchedule;
import kr.or.ddit.domain.Allocation;
import kr.or.ddit.domain.StudentLecture;

public interface AScheduleMapper {

	// 일정 등록
	public int register(ASchedule aSchedule);
}
