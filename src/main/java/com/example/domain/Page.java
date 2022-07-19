package com.example.domain;

public class Page {
	private int num; // 현재 페이지 번호
	private int count; // 게시물 갯수
	private int postNum = 20; // 한 페이지 당 게시물 수
	private int pageNum; // 하단 페이징 번호
	private int displayPost; // 출력할 게시물
	private int pageNum_cnt = 10; // 한 페이지에 표시할 페이징 번호 갯수 
	private int endPageNum; // 표시되는 마지막 페이징 번호
	private int startPageNum;  // 표시되는 첫 페이징 번호

	// 이전, 다음 버튼 표시
	private boolean prev;
	private boolean next;
	
	public void setNum(int num) {
		this.num = num;
	}

	public void setCount(int count) {
		this.count = count;
		dataCalc();
	}

	public int getCount() {
		return count;
	}

	public int getPostNum() {
		return postNum;
	}

	public int getPageNum() {
		return pageNum;
	}

	public int getDisplayPost() {
		return displayPost;
	}

	public int getPageNumCnt() {
		return pageNum_cnt;
	}

	public int getEndPageNum() {
		return endPageNum;
	}

	public int getStartPageNum() {
		return startPageNum;
	}

	public boolean getPrev() {
		return prev;
	} 

	public boolean getNext() {
		return next;
	}
	
	public void dataCalc() {
		endPageNum = (int)(Math.ceil((double)num / (double)pageNum_cnt) * pageNum_cnt);
		startPageNum = endPageNum - (pageNum_cnt - 1);
		
		int endPageNum_tmp = (int)(Math.ceil((double)count / (double)postNum));  // 마지막 페이지의 표시 오류를 해결하기 위한 임시 변수
		if(endPageNum > endPageNum_tmp) {
			endPageNum = endPageNum_tmp;
		}
		
		prev = startPageNum == 1 ? false : true;
		next = endPageNum * postNum >= count ? false : true; 	
		
		displayPost = (num - 1) * postNum;
	}

	private String searchType;
	private String keyword; 
	
	public String getSearchTypeKeyword() {
		if(searchType.equals("") || keyword.equals("")) {
			return ""; 
		} else {
			return "&searchType=" + searchType + "&keyword=" + keyword; 
		}
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;  
	}
	public String getSearchType() {
		return searchType;
	} 
	public void setKeyword(String keyword) {
		this.keyword = keyword;  
	} 
	public String getKeyword() {
		return keyword;
	}
}
