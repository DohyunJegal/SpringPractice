package com.example.dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.example.domain.MemberVO;

@Service
public class MemberDAOImpl implements MemberDAO {
	@Inject
	private SqlSession sql;
	
	private static String namespace = "com.example.mappers.memberMapper";
	
	// 회원가입
	@Override
	public void register(MemberVO vo) throws Exception {
		sql.insert(namespace + ".register", vo);
	}
	// 아이디 중복확인
	@Override
	public MemberVO idCheck(String userId) throws Exception {
		return sql.selectOne(namespace + ".idCheck", userId);
	}
	// 닉네임 중복확인
	@Override
	public MemberVO nameCheck(String userName) throws Exception {
		return sql.selectOne(namespace + ".nameCheck", userName);
	}

	// 로그인
	@Override
	public MemberVO login(MemberVO vo) throws Exception {
		return sql.selectOne(namespace + ".loginBcrypt", vo);
		
		/* 일반 로그인
		return sql.selectOne(namespace + ".login", vo);
		*/
	}

	// 회원정보 수정
	@Override
	public void modify(MemberVO vo) throws Exception {
		sql.update(namespace + ".modify", vo);
	}

	// 회원탈퇴
	@Override
	public void withdrawal(MemberVO vo) throws Exception {
		sql.delete(namespace + ".withdrawalBcrypt", vo);
		/* 일반 회원탈퇴
		sql.delete(namespace + ".withdrawal", vo);
		*/
	}

	
}
