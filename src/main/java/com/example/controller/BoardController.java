package com.example.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.dao.BoardDAO;
import com.example.domain.BoardVO;
import com.example.domain.Page;
import com.example.domain.ReplyVO;
import com.example.service.BoardService;
import com.example.service.ReplyService;

@Controller
@RequestMapping("/board/*")
public class BoardController {
	@Inject
	private BoardService service;
	
	@Inject
	private ReplyService replyService;
	
	// 게시물 목록
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public void getList(Model model) throws Exception {
		List list = null;
		list = service.list();
		model.addAttribute("list", list);
	}
	// 게시물 목록 + 페이징
	@RequestMapping(value = "/listPage", method = RequestMethod.GET)
	public void getListPage(Model model, @RequestParam("num") int num) throws Exception { // num은 페이지 번호를 의미함
		Page page = new Page();
		
		page.setNum(num);
		page.setCount(service.count());
		
		List<BoardVO> list = null;
		list = service.listPage(page.getDisplayPost(), page.getPostNum());
		
		model.addAttribute("list",list);
		model.addAttribute("page", page);
		model.addAttribute("select", num);
	}
	// 게시물 목록 + 페이징 + 검색
	@RequestMapping(value = "/listPageSearch", method = RequestMethod.GET)
	public void getListPageSearch(Model model, @RequestParam("num") int num, 
		@RequestParam(value = "searchType",required = false, defaultValue = "title") String searchType,
		@RequestParam(value = "keyword",required = false, defaultValue = "") String keyword
			) throws Exception {
	 
		Page page = new Page();
	 
		page.setNum(num);
		page.setCount(service.searchCount(searchType, keyword));
		
		page.setSearchType(searchType);
		page.setKeyword(keyword);
		
	 	List<BoardVO> list = null;
		list = service.listPageSearch(page.getDisplayPost(), page.getPostNum(), searchType, keyword);
	 
		model.addAttribute("list", list);
		model.addAttribute("page", page);
		model.addAttribute("select", num);
	}
	
	// 게시물 작성
	@RequestMapping(value = "/write", method = RequestMethod.GET)
	public void getWrite(HttpSession session, Model model) throws Exception {
		Object loginInfo = session.getAttribute("member");
		
		if(loginInfo == null) {
			model.addAttribute("errmsg", false);
		}
	}
	@RequestMapping(value = "/write", method = RequestMethod.POST)
	public String postWrite(BoardVO vo) throws Exception {
		service.write(vo);
		return "redirect:/board/listPageSearch?num=1";
	}
	
	// 게시물 조회
	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public void getView(@RequestParam("bno") int bno, Model model, HttpSession session) throws Exception {
		BoardVO vo = service.view(bno);
		model.addAttribute("view", vo);
		
		// 조회수
		service.viewCount(bno);
		
		// 댓글 조회
		List<ReplyVO> reply = null;
		reply = replyService.list(bno);
		model.addAttribute("reply", reply);
		// 댓글 작성자 필드 자동완성
		Object loginInfo = session.getAttribute("member");
		if(loginInfo == null) {
			model.addAttribute("errmsg", false);
		}
	}
	
	// 게시물 수정
	@RequestMapping(value = "/modify", method = RequestMethod.GET)
	public void getModify(@RequestParam("bno") int bno, Model model) throws Exception {
		BoardVO vo = service.view(bno);
		model.addAttribute("view", vo);
	}
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String postModify(BoardVO vo) throws Exception {
		service.modify(vo);
		return "redirect:/board/view?bno=" + vo.getBno();
	}
	
	// 게시물 삭제
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String getDelete(@RequestParam("bno") int bno) throws Exception {
		service.delete(bno);
		return "redirect:/board/listPageSearch?num=1";
	}
}