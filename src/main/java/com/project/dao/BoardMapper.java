package com.project.dao;
import org.apache.ibatis.annotations.Param;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.project.model.BoardDTO;
import com.project.util.SearchCriteria;

@Mapper
public interface BoardMapper {
    // SearchCriteria를 사용하여 페이징 및 검색 처리
    List<BoardDTO> selectBoardListPaging(SearchCriteria scri);
    
    // SearchCriteria를 사용하여 게시글 개수 조회
    int getBoardCount(SearchCriteria scri);
    
    // 기존 상세 조회 및 삽입/조회수 메서드 유지
    BoardDTO selectBoardDetail(int notice_no);
    void insertBoard(BoardDTO board);
    void updateCount(int notice_no);
    
    List<BoardDTO> selectBoardList(SearchCriteria scri);
    
    void updateReRef(int notice_no);
    
    int deleteBoard(int notice_no);

	int getUnansweredCount();

	List<BoardDTO> getNoticeList();

	void updateBoardStatus(@Param("notice_no") int no, @Param("status") String status);

	List<BoardDTO> getNoticeListPaging(SearchCriteria scri);

	List<BoardDTO> selectQnaListPaging(SearchCriteria scri);
	void updateReplyStatus(int parent_no);
	void updateBoard(BoardDTO board);
}