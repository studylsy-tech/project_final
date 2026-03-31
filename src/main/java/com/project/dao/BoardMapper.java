package com.project.dao;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.project.model.BoardDTO;
import com.project.util.Criteria; 

@Mapper
public interface BoardMapper {

    List<BoardDTO> selectBoardList(String board_type);
    
    BoardDTO selectBoardDetail(int notice_no);
    
    void insertBoard(BoardDTO board);
    
    void updateCount(int notice_no);

    int getBoardCount(String boardType);

    // MyBatis에서 인자가 2개 이상일 때는 @Param 어노테이션을 붙여주는 것이 안전합니다.
    List<BoardDTO> selectBoardListPaging(
    	    @Param("boardType") String boardType, 
    	    @Param("pageStart") int pageStart, 
    	    @Param("pageEnd") int pageEnd,
    	    @Param("searchType") String searchType, // 추가
    	    @Param("keyword") String keyword       // 추가
    	);
}