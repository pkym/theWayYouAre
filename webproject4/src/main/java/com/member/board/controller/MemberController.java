package com.member.board.controller;

import com.member.board.dto.CmtDTO;
import com.member.board.dto.MemberDTO;
import com.member.board.service.MemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
    /** 메인페이지로 이동*/
    @GetMapping("/")
    public String main(){
        return "/board/main";
    }

    /** 이메일 중복 체크 */
    @PostMapping("/emailCheck")
    public @ResponseBody String emailCheck(@RequestParam("memberEmail") String memberEmail){
        System.out.println("memberEmail"+memberEmail);
        String checkResult = memberService.emailCheck(memberEmail);
        return checkResult;
    }

    /** 회원정보 수정 페이지 이동*/
    @GetMapping("/update")
    public String updateForm(HttpSession session, Model model){
        Long memberId = (long)session.getAttribute("memberId");
        MemberDTO memberDTO = memberService.updateForm(memberId);
        model.addAttribute("updateMember",memberDTO);
        return "/member/mypage";
    }
    /** 회원정보 수정하기 */
    @PostMapping("/update")
    public @ResponseBody MemberDTO update(@ModelAttribute MemberDTO memberDTO){
        System.out.println(memberDTO);
        memberService.update(memberDTO);
        MemberDTO memberdto = memberService.findByMemberEmail(memberDTO.getMemberEmail());
        return memberdto;
    }

    /** 회원 탈퇴하기 */
    @GetMapping("/{id}")
    public String delete(@PathVariable Long id, HttpSession session){
        System.out.println("탈퇴"+id);
        memberService.delete(id);
        session.invalidate();
        return "redirect:/";
    }

    /** 로그아웃 기능 */
    @GetMapping("/logout")
    public String logout(HttpSession session){
        session.invalidate();
        return "member/home";
    }


    /** 에러발생시 에러페이지 요청 메소드 */
    @GetMapping("/error")
    public String handleError(){
        return "error";
    }

}


