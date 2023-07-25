package com.member.board.controller;

import com.member.board.dto.MemberDTO;
import com.member.board.service.MemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;


@Controller
@RequestMapping("/member")
@RequiredArgsConstructor // 서비스클래스 의존성 주입
public class MemberController {
    private final MemberService memberService;

    /** 회원가입 기능 */
    @PostMapping("/join")
    public String join(@ModelAttribute MemberDTO memberDTO) {
            memberService.save(memberDTO);
            return "member/home";
    }
    /** 로그인 기능 */
    @PostMapping("/login")
    public String login(@ModelAttribute MemberDTO memberDTO, HttpSession session){
        MemberDTO loginResult = memberService.login(memberDTO);
        System.out.println(loginResult+"loginResult");
        if(loginResult!=null){
            session.setAttribute("loginName", loginResult.getMemberName());
            session.setAttribute("memberId", loginResult.getId());
            return "board/main";
        }else{
            return "member/home";
        }
    }
    /** 이메일 중복 체크 */
    @PostMapping("/emailCheck")
    public @ResponseBody String emailCheck(@RequestParam("memberEmail") String memberEmail){
        System.out.println("memberEmail"+memberEmail);
        String checkResult = memberService.emailCheck(memberEmail);
        return checkResult;
    }

}


