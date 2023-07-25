package com.member.board.service;

import com.member.board.dto.BoardDTO;
import com.member.board.dto.PageDTO;
import com.member.board.repository.BoardRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class BoardService {
    private final BoardRepository boardRepository;

    /**
     * 글 저장 메소드
     */
    public int save(BoardDTO boardDTO) {
        return boardRepository.save(boardDTO);
    }

    /**
     * 게시글 가져오기 메소드
     */
    public List<BoardDTO> findAll() {
        return boardRepository.findAll();
    }

    /**
     * 게시글 한개 보기 메소드
     */
    public BoardDTO findById(Long id) {
        return boardRepository.findById(id);
    }

    /**
     * 조회 수 업데이트 메소드
     */
    public void updateView(Long id) {
        boardRepository.updateView(id);
    }

    public void update(BoardDTO boardDTO) {
        boardRepository.update(boardDTO);
    }

    public void delete(Long id) {
        boardRepository.delete(id);
    }

    int pageLimit = 3; // 한 페이지당 보여줄 글 갯수
    int blockLimit = 3; // 하단에 보여줄 페이지 번호 갯수
    public List<BoardDTO> pagingList(int page) {
        /*1페이지당 보여지는 글 갯수 3
         * 1page==> 0
         * 2page==> 3
         * 3page==> 6*/
        int pageStart = (page - 1) * pageLimit;
        Map<String,Integer> pagingParams = new HashMap<>();
        pagingParams.put("start", pageStart);
        pagingParams.put("limit", pageLimit);
        List<BoardDTO> pagingList = boardRepository.pagingList(pagingParams);

        return pagingList;
    }

    public PageDTO pagingParam(int page) {
        // 전체 글 갯수 조회
        int boardCount = boardRepository.boardCount();
        // 전체 페이지 갯수 계산(10/3=3.33333 => 4)
        int maxPage = (int) (Math.ceil((double) boardCount / pageLimit));
        // 시작 페이지 값 계산(1, 4, 7, 10, ~~~~)
        int startPage = (((int)(Math.ceil((double) page / blockLimit))) - 1) * blockLimit + 1;
        // 끝 페이지 값 계산(3, 6, 9, 12, ~~~~)
        int endPage = startPage + blockLimit - 1;
        if (endPage > maxPage) {
            endPage = maxPage;
        }
        PageDTO pageDTO = new PageDTO();
        pageDTO.setPage(page);
        pageDTO.setMaxPage(maxPage);
        pageDTO.setStartPage(startPage);
        pageDTO.setEndPage(endPage);
        return pageDTO;
    }
}
