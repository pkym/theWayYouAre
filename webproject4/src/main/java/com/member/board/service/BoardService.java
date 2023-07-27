package com.member.board.service;

import com.member.board.dto.BoardDTO;
import com.member.board.dto.BoardFileDTO;
import com.member.board.dto.PageDTO;
import com.member.board.repository.BoardRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
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
    public int save(BoardDTO boardDTO) throws IOException {
        if (boardDTO.getBoardFile().isEmpty()) {
            return boardRepository.save(boardDTO);
        } else {
            // 첨부파일 여부를 1로 바꿈
            boardDTO.setFileAttached(1);
            System.out.println("바뀌나" + boardDTO);
            // board_table에 글만 저장
            boardRepository.save(boardDTO);
            // board_table에서 저장된 글의 아이디를 가져오자
            Long boardId = boardRepository.findOne().getId();
            // boardDTO에서 저장된 첨부파일의 이룸 가져와서 변환
            MultipartFile boardFile = boardDTO.getBoardFile();
            String originalFileName = boardFile.getOriginalFilename();
            String storedFileName = System.currentTimeMillis() + "_" + originalFileName;
            // boardfiledto 객체 생성 및 DTO 값 넣기
            BoardFileDTO boardFileDTO = new BoardFileDTO();
            boardFileDTO.setBoardId(boardId);
            boardFileDTO.setOriginalFileName(originalFileName);
            boardFileDTO.setStoredFileName(storedFileName);
            // 로컬에 저장하기
            String savePath = "/Users/keeyoungmin/Downloads/springboot/" + storedFileName;
            boardFile.transferTo(new File((savePath)));

            return boardRepository.saveS(boardFileDTO);
        }
    }

    /**
     * 게시글 전체 가져오기 메소드
     */
    public List<BoardDTO> findAll() {
        return boardRepository.findAll();
    }

    /**
     * 게시글 한 개 보기 메소드
     */
    public BoardDTO findById(Long id) {
        return boardRepository.findById(id);
    }

    /**
     * 게시 파일 가져오기 메소드
     */
    public BoardFileDTO findByIdFile(Long id) {
        return boardRepository.findByIdFile(id);
    }

    /**
     * 조회 수 업데이트 메소드
     */
    public void updateView(Long id) {
        boardRepository.updateView(id);
    }

    /**
     * 글 수정 메소드
     */
    public void update(BoardDTO boardDTO) {
        boardRepository.update(boardDTO);
    }

    /**
     * 글 삭제 메소드
     */
    public void delete(Long id) {
        boardRepository.delete(id);
    }

    /**
     * 페이징 처리 메소드
     * 1페이지당 보여지는 글 갯수 3
     * 1page==> 0
     * 2page==> 3
     * 3page==> 6
     */
    int pageLimit = 5; // 한 페이지당 보여줄 글 갯수
    int blockLimit = 10; // 하단에 보여줄 페이지 번호 갯수

    public List<BoardDTO> pagingList(int page) {
        int pageStart = (page - 1) * pageLimit;
        PageDTO pageDTO = new PageDTO();
        pageDTO.setStartPage(pageStart);
        pageDTO.setMaxPage(pageLimit);
        List<BoardDTO> pagingList = boardRepository.pagingList(pageDTO);
        //Map<String, Integer> pagingParams = new HashMap<>();
        //pagingParams.put("start", pageStart);
        //pagingParams.put("limit", pageLimit);

        return pagingList;
    }

    /**
     * 페이징 처리 메소드
     * 전체 글 갯수 조회
     * 전체 페이지 갯수 계산(10/3=3.33333 => 4)
     * 시작 페이지 값 계산(1, 4, 7, 10,...)
     * 끝 페이지 값 계산(3, 6, 9, 12,...)
     */

    public PageDTO pagingParam(int page) {
        int boardCount = boardRepository.boardCount();
        int maxPage = (int) (Math.ceil((double) boardCount / pageLimit));
        int startPage = (((int) (Math.ceil((double) page / blockLimit))) - 1) * blockLimit + 1;
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
