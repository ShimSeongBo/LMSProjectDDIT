package kr.or.ddit.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.springframework.web.bind.annotation.SessionAttribute;

import kr.or.ddit.domain.Employee;
import kr.or.ddit.domain.Member;
import kr.or.ddit.domain.Student;
import kr.or.ddit.mapper.MemberMapper;
import lombok.extern.slf4j.Slf4j;

/* 	/notice/register >> loginForm >> 로그인 >> CustomLoginSuccessHandler(성공!)
 * 	>> 사용자 작업 >> /notice/register 로 리다이렉트 해줌(스프링 시큐리티에서 기본적으로 사용되는 구현 클래스)
 * 
 */

@Slf4j
public class CustomLoginSuccessHandler extends 
	SavedRequestAwareAuthenticationSuccessHandler {
	
	@Autowired
	MemberMapper memberMapper;
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request,
			HttpServletResponse response, Authentication auth) 
					throws ServletException, IOException {
		log.warn("onAuthenticationSuccess에 옴 로그인 성공 !!!!");
		
		//Authentication(인증) -> 로그인
		CustomUser customUser = (CustomUser)auth.getPrincipal();
		
		//로그인 아이디
		log.info("username : " + customUser.getUsername());
		Member member = customUser.getMemberVO();
		Member read = memberMapper.read(member.getMemNo());
		Employee readEmployee = memberMapper.readEmployee(member.getMemNo());
		Student readStudent = memberMapper.readStudent(member.getMemNo());
		
		log.info("이렇게하면 들어올까욤? " + readEmployee);
		
		HttpSession session = request.getSession();
		if(readEmployee != null) {
			session.setAttribute("name", readEmployee.getEmpNm());
		}else {
			session.setAttribute("name", readStudent.getStuNm());
		}
		
		super.onAuthenticationSuccess(request, response, auth);
	}
	
}
