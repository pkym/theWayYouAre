package com.member.board.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BoardFileDTO {
    private long id;
    private String originalFileName;
    private String storedFileName;
    private long boardId;
}
