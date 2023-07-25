package com.member.board.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.sql.Timestamp;

@Getter
@Setter
@ToString
public class CmtDTO {
    private long id;
    private String cmtWriter;
    private String cmtContents;
    private Long boardId;
    private Long memberId;
    private Timestamp cmtCreatedTime;
}
