package com.member.board.controller;

import com.member.board.dto.CmtDTO;
import com.member.board.service.CmtService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/cmt")
public class CmtController {
    private final CmtService cmtService;

    /**
     * 댓글 저장하고 불러오기
     */
    @PostMapping("/save")
    public @ResponseBody CmtDTO save(@ModelAttribute CmtDTO cmtDTO) {
        System.out.println("댓글저장" + cmtDTO);
        cmtService.save(cmtDTO);
        CmtDTO cmtdto = cmtService.findLast(cmtDTO.getBoardId());
        //List<CmtDTO> cmtDTOList = cmtService.findAll(cmtDTO.getBoardId());
        return cmtdto;
    }

    /**
     * 댓글 삭제하기
     */
    @DeleteMapping("/{id}")
    public @ResponseBody void delete(@PathVariable Long id) {
        cmtService.delete(id);
    }

    /**
     * 댓글 수정 요청하기
     */
    @GetMapping("/update/{id}")
    public @ResponseBody CmtDTO updateForm(@PathVariable Long id) {
        CmtDTO cmtDTO = cmtService.findById(id);
        return cmtDTO;
    }

    /**
     * 댓글 수정하기
     * Put 이나 Patch 맵핑 지원 X
     */
    @PostMapping("/update")
    public @ResponseBody CmtDTO update(@ModelAttribute CmtDTO cmtDTO) {
        System.out.println(cmtDTO);
        cmtService.update(cmtDTO);
        CmtDTO cmtdto = cmtService.findById(cmtDTO.getId());
        return cmtdto;
    }
}
