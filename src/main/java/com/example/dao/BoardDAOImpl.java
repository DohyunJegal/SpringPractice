package com.example.dao;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.domain.BoardVO;

@Repository
public class BoardDAOImpl implements BoardDAO {
	@Inject
	private SqlSession sql;
	
	private static String namespace = "com.example.mappers.board";
	
	// 게시물 목록
	@Override
	public List<BoardVO> list() throws Exception {
		return sql.selectList(namespace + ".list");
	}
	// 게시물 목록 + 페이징
	@Override
	public List<BoardVO> listPage(int displayPost, int postNum) throws Exception {
		HashMap data = new HashMap();
		
		data.put("displayPost", displayPost);
		data.put("postNum", postNum);
		
		return sql.selectList(namespace + ".listPage", data);
	}
	// 게시물 목록 + 페이징 + 검색
	@Override
	public List<BoardVO> listPageSearch(
		int displayPost, int postNum, String searchType, String keyword) throws Exception {

		HashMap<String, Object> data = new HashMap<String, Object>();
	  
		data.put("displayPost", displayPost);
		data.put("postNum", postNum);
	  
		data.put("searchType", searchType);
		data.put("keyword", keyword);
	  
		return sql.selectList(namespace + ".listPageSearch", data);
	}

	// 게시물 작성
	@Override
	public void write(BoardVO vo) throws Exception {
		sql.insert(namespace + ".write", vo);
	}

	// 게시물 조회
	@Override
	public BoardVO view(int bno) throws Exception {
		return sql.selectOne(namespace + ".view", bno);
	}

	// 게시물 수정
	@Override
	public void modify(BoardVO vo) throws Exception {
		sql.update(namespace + ".modify", vo);
		
	}

	// 게시물 삭제
	@Override
	public void delete(int bno) throws Exception {
		sql.delete(namespace + ".delete", bno);
	}

	// 게시물 갯수
	@Override
	public int count() throws Exception {
		return sql.selectOne(namespace + ".count");
	}
	// 게시물 갯수 + 검색 기능 적용
	@Override
	public int searchCount(String searchType, String keyword) throws Exception {
		HashMap data = new HashMap();
	 
		data.put("searchType", searchType);
		data.put("keyword", keyword);
	 
		return sql.selectOne(namespace + ".searchCount", data); 
	}
	
	// 조회수
	@Override
	public void viewCount(int bno) throws Exception {
		sql.delete(namespace + ".viewCount", bno);
	}
}
