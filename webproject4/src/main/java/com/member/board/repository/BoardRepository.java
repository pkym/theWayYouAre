package com.member.board.repository;

import com.member.board.dto.BoardDTO;
import com.member.board.dto.BoardFileDTO;
import com.member.board.dto.PageDTO;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
@RequiredArgsConstructor
public class BoardRepository {
    private final SqlSessionTemplate sql;

    /**
     * 글 저장하기
     */
    public int save(BoardDTO boardDTO) {
        return sql.insert("Board.save", boardDTO);
    }

    public int saveS(BoardFileDTO boardFileDTO) {
        return sql.insert("Board.saveS", boardFileDTO);
    }

    /**
     * 글 불러오기
     */
    public List<BoardDTO> findFive() {
        return sql.selectList("Board.findAll");
    }

    /**
     * 글 찾기
     */
    public BoardDTO findById(Long id) {
        return sql.selectOne("Board.findById", id);
    }

    /**파일 찾기 */
    public BoardFileDTO findByIdFile(Long id) {
        return sql.selectOne("Board.findByIdFile", id);
    }

    /**
     * 가장 최신 글 하나만 찾기
     */
    public BoardDTO findOne() {
        return sql.selectOne("Board.findOne");
    }

    /**
     * 조회수 올리기
     */
    public void updateView(Long id) {
        sql.update("Board.updateView", id);
    }

    /**
     * 글 수정하기
     */
    public void update(BoardDTO boardDTO) {
        sql.update("Board.update", boardDTO);
    }

    /**
     * 글 삭제하기
     */
    public void delete(Long id) {
        sql.delete("Board.delete", id);
    }

    /**
     * 게시글 총 개수 구하기
     */
    public int boardCount() {
        return sql.selectOne("Board.boardCount");
    }

    /**
     * 페이징 처리된 글 불러오기
     */
    public List<BoardDTO> pagingList(PageDTO pageDTO) {
        return sql.selectList("Board.pagingList", pageDTO);
    }



    /*public List<BoardDTO> pagingList(Map<String, Integer> pagingParams) {
        return sql.selectList("Board.pagingList",pagingParams);
    }*/

}
