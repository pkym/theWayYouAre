package com.member.board.controller;

import com.member.board.dto.CmtDTO;
import com.member.board.service.CmtService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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

}
