package com.project.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.project.dao.BoardMapper;
import com.project.model.BoardDTO;
import com.project.util.SearchCriteria;

@Service
public class BoardServiceImpl implements BoardService {

    @Autowired
    private BoardMapper boardMapper;

    @Override
    public List<BoardDTO> selectBoardList(SearchCriteria scri) {
        return boardMapper.selectBoardList(scri);
    }

    @Override
    public List<BoardDTO> selectBoardListPaging(SearchCriteria scri) {
        // Mapper의 ORDER BY RE_REF DESC, INDATE ASC 정렬 사용
        return boardMapper.selectBoardListPaging(scri);
    }

    @Override
    public int getBoardCount(SearchCriteria scri) {
        return boardMapper.getBoardCount(scri);
    }

    @Override
    public BoardDTO selectBoardDetail(int notice_no) {
        return boardMapper.selectBoardDetail(notice_no);
    }

    @Transactional
    @Override
    public void insertBoard(BoardDTO board) {
    	boardMapper.insertBoard(board);
    }

    @Override
    public void updateCount(int notice_no) {
        boardMapper.updateCount(notice_no);
    }
    
    @Override
    public int deleteBoard(int notice_no) {
        return boardMapper.deleteBoard(notice_no);
    }
    
    @Override
    public int getUnansweredCount() {
        return boardMapper.getUnansweredCount();
    }
}