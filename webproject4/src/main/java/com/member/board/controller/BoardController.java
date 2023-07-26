package com.member.board.controller;

import com.member.board.dto.BoardDTO;
import com.member.board.dto.CmtDTO;
import com.member.board.dto.PageDTO;
import com.member.board.service.BoardService;
import com.member.board.service.CmtService;
import com.member.board.service.MemberService;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;


@Controller
@RequestMapping("/board")
@RequiredArgsConstructor
public class BoardController {
    private final BoardService boardService;
    private final CmtService cmtService;

    /**
     * 글쓰기 페이지로 이동
     */
    @GetMapping("/save")
    public String saveForm() {
        return "board/write";
    }

    /**
     * 글쓰기페이지에서 데이터를 받아와서 저장 후 리스트로 이동
     */
    @PostMapping("/save")
    public String save(@ModelAttribute BoardDTO boardDTO) {
        System.out.println("글 저장하기" + boardDTO);
        int saveResult = boardService.save(boardDTO);
        if (saveResult > 0) {
            return "redirect:/board/list";
        } else {
            return "board/write";
        }
    }

    /**
     * /board/paging?page=2
     * 처음페이지 요청은 1페이지를 보여줌
     * page 파라미터가 없어도 디테일로 넘어갈 때 에러가 나지 않도록 false로 설정
     */
    @GetMapping("/paging")
    public String paging(Model model, @RequestParam(value = "page", required = false, defaultValue = "1") int page) {
        System.out.println(page);
        // 해당 페이지에서 보여줄 글 목록
        List<BoardDTO> pagingList = boardService.pagingList(page);
        PageDTO pageDTO = boardService.pagingParam(page);
        model.addAttribute("boardList", pagingList);
        model.addAttribute("paging", pageDTO);
        return "board/paging";
    }

    /**
     * 리스트 페이지 요청하기
     */
    @GetMapping("/")
    public String listPage() {
        return "board/list";
    }

    /**
     * 리스트에 글 목록을 ajax로 불러오기
     */
    @GetMapping("/list")
    public @ResponseBody List<BoardDTO> findAll(@RequestParam(value = "page", required = false, defaultValue = "1") int page) {
        List<BoardDTO> pagingList = boardService.pagingList(page);
        //List<BoardDTO> boardDTOList = boardService.findAll();
        return pagingList;
    }

    /** 리스트페이지에 페이지 번호를 AJAX로 불러오기*/
    @GetMapping("/listNum")
    public @ResponseBody PageDTO findNum(@RequestParam(value = "page", required = false, defaultValue = "1") int page){
        PageDTO pageDTO = boardService.pagingParam(page);
        return pageDTO;
    }

    /**
     * 리스트페이지에서 글 클릭시 해당 글의 상세보기로 이동
     */
    @GetMapping("/detail")
    public String findById(@RequestParam("id") Long id, @RequestParam(value = "page", required = false, defaultValue = "1") int page, Model model) {
        //  해당 게시글의 조회수를 하나 올리고
        boardService.updateView(id);
        // 게시글 데이터를 가져와서 board/detail.jsp에 출력
        BoardDTO boardDTO = boardService.findById(id);
        model.addAttribute("boardDTO", boardDTO);
        model.addAttribute("page", page);

        // 좋아요 수 가져오기
        return "board/detail";
    }

    /** 리스트페이지에서 댓글목록을 ajax로 불러오기 */
    @GetMapping("/detail/cmt")
    public @ResponseBody List<CmtDTO> findCmtAll(@RequestParam("id") Long id) {
        // 댓글목록 가져오기
        List<CmtDTO> cmtDTOList = cmtService.findAll(id);
        return cmtDTOList;
    }

    /**
     * 글 상세보기 페이지에서 글 수정하기 페이지 원래 썼던글 보여주기
     */
    @GetMapping("/update")
    public String updateForm(@RequestParam("id") Long id, Model model) {
        BoardDTO boardDTO = boardService.findById(id);
        model.addAttribute("boardDTO", boardDTO);
        System.out.println("수정하고 싶어요" + boardDTO);
        return "board/update";
    }

    /**
     * 글 수정하기 요청
     */
    @PostMapping("/update")
    public String update(@ModelAttribute BoardDTO boardDTO, Model model) {
        boardService.update(boardDTO);
        System.out.println(boardDTO + "어떻게 변했나");
        BoardDTO dto = boardService.findById(boardDTO.getId());
        model.addAttribute("board", dto);
        return "board/detail";
    }

    /**
     * 글 삭제하기 요청
     */
    @GetMapping("/delete")
    public String delete(@RequestParam("id") Long id) {
        System.out.println(id);
        boardService.delete(id);
        return "redirect:/board/list";
    }


}
