package com.example.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.example.dao.MemberDAO;
import com.example.domain.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {
	@Inject
	private MemberDAO dao;
	
	// 회원가입
	@Override
	public void register(MemberVO vo) throws Exception {
		dao.register(vo);
	}
	// 아이디 중복확인
	@Override
	public MemberVO idCheck(String userId) throws Exception {
		return dao.idCheck(userId);
	}
	// 닉네임 중복확인
	@Override
	public MemberVO nameCheck(String userName) throws Exception {
		return dao.nameCheck(userName);
	}

	// 로그인
	@Override
	public MemberVO login(MemberVO vo) throws Exception {
		return dao.login(vo);
	}

	// 회원정보 수정
	@Override
	public void modify(MemberVO vo) throws Exception {
		dao.modify(vo);
	}
	
	// 회원탈퇴
	@Override
	public void withdrawal(MemberVO vo) throws Exception {
		dao.withdrawal(vo);
	}

	
}
