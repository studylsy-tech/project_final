package com.project.dao;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.project.model.BoardDTO;
import com.project.util.SearchCriteria; // Using the more robust criteria object

@Mapper
public interface BoardMapper {

    List<BoardDTO> selectBoardList(String board_type);
    
    BoardDTO selectBoardDetail(int notice_no);
    
    void insertBoard(BoardDTO board);
    
    void updateCount(int notice_no);
    
    // Using the SearchCriteria object for cleaner pagination and searching
    List<BoardDTO> selectBoardListPaging(SearchCriteria scri);
    
    int getBoardCount(SearchCriteria scri);

	List<BoardDTO> selectBoardListPaging(String boardType, int pageStart, int pageEnd, String searchType,
			String keyword);

	int getBoardCount(String boardType);
}