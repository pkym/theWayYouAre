package com.member.board.repository;

import com.member.board.dto.MemberDTO;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
@RequiredArgsConstructor
public class MemberRepository {
    // mybatis 의 쿼리들을 호출해주는 역할 , 매개변수 받거나 주는 역할
    private final SqlSessionTemplate sql; // 의존성 주입

    /** save 라는 이름의 mapper를 호출하기*/
    public int save(MemberDTO memberDTO) {
        return sql.insert("Member.save",memberDTO); //"namespace.id"
    }

    /** login 이라는 이름의 mapper를 호출하기*/
    public MemberDTO login(MemberDTO memberDTO) {
        return sql.selectOne("Member.login", memberDTO);

    }

    public MemberDTO findByMemberEmail(String loginEmail) {
        return sql.selectOne("Member.findByMemberEmail", loginEmail);
    }
}
