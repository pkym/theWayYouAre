package com.member.board.repository;

import com.member.board.dto.CmtDTO;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class CmtRepository {
    private final SqlSessionTemplate sql;
    public void save(CmtDTO cmtDTO) {
        sql.insert("Cmt.save",cmtDTO);
    }

    public List<CmtDTO> findAll(Long boardId) {
        return sql.selectList("Cmt.findAll",boardId);
    }

    public CmtDTO findLast(Long boardId) {
        return sql.selectOne("Cmt.findLast", boardId);
    }
}
