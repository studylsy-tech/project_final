package com.project.service;

import java.util.List;
import com.project.model.BoardDTO;
import com.project.util.Criteria;
import com.project.util.SearchCriteria;

public interface BoardService {
    // SearchCriteria 하나로 통합
    List<BoardDTO> selectBoardListPaging(SearchCriteria scri);
    int getBoardCount(SearchCriteria scri);
    List<BoardDTO> selectQnaListPaging(SearchCriteria scri);

    BoardDTO selectBoardDetail(int notice_no);
    void insertBoard(BoardDTO board);
    void updateCount(int notice_no);
    List<BoardDTO> selectBoardList(SearchCriteria scri);
	int deleteBoard(int notice_no);
	int getUnansweredCount();
	List<BoardDTO> getNoticeList();
	void updateBoardStatus(int no, String status);
	int getNoticeCount();
	List<BoardDTO> getNoticeListPaging(Criteria cri);
	List<BoardDTO> getQnaListPaging(Criteria cri);
	void updateBoard(BoardDTO board);
}