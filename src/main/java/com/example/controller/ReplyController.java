package com.example.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.domain.ReplyVO;
import com.example.service.ReplyService;

@Controller
@RequestMapping("/reply/*")
public class ReplyController {
	@Inject
	private ReplyService replyService;

	// 댓글 조회

	// 댓글 작성
	@RequestMapping(value = "/write", method = RequestMethod.POST)
	public String postWrite(ReplyVO vo) throws Exception {
		if(vo.getParent() == 0) {
			vo.setParent(replyService.getLastrno() + 1);
		}
		
		replyService.write(vo);
		return "redirect:/board/view?bno=" + vo.getBno();
	}
	
	// 댓글 수정
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String postModify(ReplyVO vo) throws Exception {
		replyService.modify(vo);
		return "redirect:/board/view?bno=" + vo.getBno();
	}
	
	// 댓글 삭제
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String postDelete(@RequestParam("rno") int rno, @RequestParam("bno") int bno) throws Exception {
		replyService.delete(rno);
		return "redirect:/board/view?bno=" + bno;
	}
}