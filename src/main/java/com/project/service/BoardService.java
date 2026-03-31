package com.project.service;

import java.util.List;
import com.project.model.BoardDTO; 
import com.project.util.Criteria;

public interface BoardService {
    // 1. 게시판 목록 조회
    List<BoardDTO> selectBoardList(String board_type);
    
    // 2. 게시글 상세 조회
    BoardDTO selectBoardDetail(int notice_no);
    
    // 3. 게시글 등록
    void insertBoard(BoardDTO board);
    
    // 4. 조회수 증가
    void updateCount(int notice_no);

    // 5. 전체 게시글 개수 조회
    int getBoardCount(String boardType);

    // 6. 페이징 처리된 목록 조회
    List<BoardDTO> selectBoardListPaging(String boardType, Criteria cri);
}