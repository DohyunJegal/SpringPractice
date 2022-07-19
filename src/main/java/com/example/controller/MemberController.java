package com.example.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.domain.MemberVO;
import com.example.service.MemberService;

@Controller
@RequestMapping("/member/*")
public class MemberController {
	@Inject
	MemberService service;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	// 회원가입
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public void getRegister() throws Exception {
		
	}
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String postRegister(MemberVO vo, @RequestParam("newuserId") String nid,
			@RequestParam("newuserPassword") String npw, @RequestParam("newuserName") String nname) throws Exception {
		String inputPassword = npw;
		String password = passwordEncoder.encode(inputPassword);
		vo.setUserPassword(password);
		vo.setUserId(nid);
		vo.setUserName(nname);
		
		service.register(vo);
		return "redirect:/";
	}
	// 아이디 중복확인
	@ResponseBody
	@RequestMapping(value = "/idCheck", method = RequestMethod.POST)
	public int postIdCheck(HttpServletRequest req) throws Exception {
		String userId = req.getParameter("userId");
		MemberVO idCheck =  service.idCheck(userId);
		
		int result = 0;
		 
		if(idCheck != null) {
			result = 1;
		} 
		
		return result;
	}
	// 닉네임 중복확인
	@ResponseBody
	@RequestMapping(value = "/nameCheck", method = RequestMethod.POST)
	public int postNameCheck(HttpServletRequest req) throws Exception {
		String userName = req.getParameter("userName");
		MemberVO nameCheck =  service.idCheck(userName);
			
		int result = 0;
			 
		if(nameCheck != null) {
			result = 1;
		} 
			
		return result;
	}
	
	// 로그인
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(MemberVO vo, HttpServletRequest req, RedirectAttributes rttr) throws Exception {
		HttpSession session = req.getSession();
		MemberVO login = service.login(vo);
		boolean passwordMatch = false;
		
		if(login != null) {
			passwordMatch = passwordEncoder.matches(vo.getUserPassword(), login.getUserPassword());
		}
		
		if(passwordMatch) {
			session.setAttribute("member", login);
		} else {
			session.setAttribute("member", null);
			rttr.addFlashAttribute("msg", false);
		}
		
		/* 일반 로그인
		if(login == null) {
			session.setAttribute("member", null);  
			rttr.addFlashAttribute("msg", false);
		} else {
			session.setAttribute("member", login);
		}
		*/
	   
		return "redirect:/";
	}

	// 로그아웃
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) throws Exception {
		session.invalidate();
		return "redirect:/";
	}
	
	// 회원정보 수정
	@RequestMapping(value = "/modify", method = RequestMethod.GET)
	public void getModify() throws Exception {
	}
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String postModify(HttpSession session, MemberVO vo) throws Exception {
		String inputPassword = vo.getUserPassword();
		String password = passwordEncoder.encode(inputPassword);
		vo.setUserPassword(password);
		
		service.modify(vo);
		session.invalidate();
		
		return "redirect:/";
	}
	
	// 회원탈퇴
	@RequestMapping(value = "/withdrawal", method = RequestMethod.GET)
	public void getWithdrawal() throws Exception {
	}
	@RequestMapping(value = "/withdrawal", method = RequestMethod.POST)
	public String postWithdrawal(HttpSession session, MemberVO vo, RedirectAttributes rttr) throws Exception {
		MemberVO member = (MemberVO)session.getAttribute("member");
		boolean passwordMatch = passwordEncoder.matches(vo.getUserPassword(), member.getUserPassword());
	     
		if(!passwordMatch) {
			rttr.addFlashAttribute("errmsg", false);
			return "redirect:/member/withdrawal";
		}
	 
		service.withdrawal(vo);
		session.invalidate();
		
		return "redirect:/";
	}
}
