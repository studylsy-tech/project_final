package com.project.dao;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.project.model.BoardDTO;

@Mapper // MyBatis 매퍼 인터페이스임을 명시
public interface BoardMapper {

    // 게시판 목록 조회
    List<BoardDTO> selectBoardList(String board_type);
    
    // 게시글 상세 조회
    BoardDTO selectBoardDetail(int notice_no);
    
    // 게시글 등록
    void insertBoard(BoardDTO board);
    
    // 조회수 증가
    void updateCount(int notice_no);
}