package com.member.board.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.web.multipart.MultipartFile;

import java.sql.Timestamp;

@Getter
@Setter
@ToString
public class BoardDTO {
    private Long id;
    private String boardWriter;
    private String boardType;
    private String boardTitle;
    private String boardContents;
    private Timestamp boardCreatedTime;
    private int boardView;
    private Long memberId;
    //private int fileAttached;
    //private MultipartFile boardFile;
    //private String originalFileName;
   // private String storedFileName;
}
