package com.member.board.service;

import com.member.board.dto.CmtDTO;
import com.member.board.repository.CmtRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class CmtService {
    private final CmtRepository cmtRepository;
    public void save(CmtDTO cmtDTO) {
        cmtRepository.save(cmtDTO);
    }

    public List<CmtDTO> findAll(Long boardId) {
        return cmtRepository.findAll(boardId);
    }

    public CmtDTO findLast(Long boardId) {
        return cmtRepository.findLast(boardId);
    }
}
