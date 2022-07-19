package com.example.service;

import java.util.List;

import com.example.domain.BoardVO;

public interface BoardService {
	// 게시물 목록
	public List<BoardVO> list() throws Exception;
	// 게시물 목록 + 페이징
	public List<BoardVO> listPage(int displayPost, int postNum) throws Exception; 
	// 게시물 목록 + 페이징 + 검색
	public List<BoardVO> listPageSearch(
			int displayPost, int postNum, String searchType, String keyword) throws Exception;
	
	// 게시물 작성
	public void write(BoardVO vo) throws Exception;
	
	// 게시물 조회
	public BoardVO view(int bno) throws Exception;
	
	// 게시물 수정
	public void modify(BoardVO vo) throws Exception;
	
	// 게시물 삭제
	public void delete(int bno) throws Exception; 
	
	// 게시물 갯수
	public int count() throws Exception;
	// 게시물 갯수 + 검색 기능 적용
	public int searchCount(String searchType, String keyword) throws Exception;
	
	// 조회수
	public void viewCount(int bno) throws Exception;
}
