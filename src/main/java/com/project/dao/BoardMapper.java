package com.project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
<<<<<<< HEAD
import org.apache.ibatis.annotations.Param;
=======

>>>>>>> branch 'develop' of https://github.com/studylsy-tech/project_final.git
import com.project.model.BoardDTO;
<<<<<<< HEAD
import com.project.util.Criteria; 
=======
import com.project.util.SearchCriteria;
>>>>>>> branch 'develop' of https://github.com/studylsy-tech/project_final.git

@Mapper
public interface BoardMapper {

    List<BoardDTO> selectBoardList(String board_type);
    
    BoardDTO selectBoardDetail(int notice_no);
    
    void insertBoard(BoardDTO board);
    
    void updateCount(int notice_no);
<<<<<<< HEAD

    int getBoardCount(String boardType);

    // MyBatis에서 인자가 2개 이상일 때는 @Param 어노테이션을 붙여주는 것이 안전합니다.
    List<BoardDTO> selectBoardListPaging(
    	    @Param("boardType") String boardType, 
    	    @Param("pageStart") int pageStart, 
    	    @Param("pageEnd") int pageEnd,
    	    @Param("searchType") String searchType, // 추가
    	    @Param("keyword") String keyword       // 추가
    	);
=======
    
	 
    // 검색 및 페이징 처리
	 List<BoardDTO> selectBoardListPaging(SearchCriteria scri);
	 int getBoardCount(SearchCriteria scri);
    
    
>>>>>>> branch 'develop' of https://github.com/studylsy-tech/project_final.git
}