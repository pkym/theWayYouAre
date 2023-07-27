package com.member.board.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PageDTO {
    private int page;
    private int maxPage; // 한페이지당 보여줄 글 개수
    private int startPage;
    private int endPage;
}
