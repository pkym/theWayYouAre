package com.member.board.service;

import com.member.board.dto.MemberDTO;
import com.member.board.repository.MemberRepository;
import lombok.RequiredArgsConstructor; // final이 붙은 필드만 갖고 생성자 만듦
import org.springframework.stereotype.Service;



@Service
@RequiredArgsConstructor
public class MemberService {
    private final MemberRepository memberRepository;


    /** 회원 저장 메소드 */
    public int save(MemberDTO memberDTO) {
        return memberRepository.save(memberDTO);
    }
    /** 로그인 메소드 */
    public MemberDTO login(MemberDTO memberDTO) {
        MemberDTO loginMember = memberRepository.login(memberDTO);
        //selectOne 값이 null 이 아니면 로그인멤버 객체를 되돌려준다
        if(loginMember != null){
            return loginMember;
        }else{
            return null;
        }
    }
    /** 이메일로 회원찾기 메소드 */
    public MemberDTO findByMemberEmail(String loginEmail){
        return memberRepository.findByMemberEmail(loginEmail);
    }

    /** 이메일 중복 체크 메소드*/
    public String emailCheck(String loginEmail) {
        MemberDTO memberDTO = memberRepository.findByMemberEmail(loginEmail);
        System.out.println(memberDTO+"이메일로찾기");
        if(memberDTO == null){
            return "ok";
        }else{
            return "no";
        }
    }
    /** 회원 수정페이지 메소드*/
    public MemberDTO updateForm(Long memberId) {
        MemberDTO memberDTO = memberRepository.findById(memberId);
        return memberDTO;
    }
    /** 회원 수정 메소드 */
    public int update(MemberDTO memberDTO){
        return memberRepository.update(memberDTO);
    }
    /** 회원 탈퇴 메소드 */
    public void delete(Long id) {
        memberRepository.delete(id);
    }
}
