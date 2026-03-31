package com.project.service;

import java.util.List;
import com.project.model.BoardDTO;

public interface BoardService {
    // 게시판 목록 조회 (NOTICE 또는 QNA)
    List<BoardDTO> selectBoardList(String board_type);
    
    // 게시글 상세 조회
    BoardDTO selectBoardDetail(int notice_no);
    
    // 게시글 등록
    void insertBoard(BoardDTO board);
    
    // 조회수 증가
    void updateCount(int notice_no);
}