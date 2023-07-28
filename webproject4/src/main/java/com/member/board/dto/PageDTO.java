package com.member.board.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PageDTO {
    private int page; // 현재 페이지
    private int maxPage; // 총 보여줄 페이지 번호
    private int startPage; // 보여줄 시작 페이지 >> 5개씩 이면 0, 5, ....
    private int endPage; //

    // startPage = (page-1) * maxPage
}
