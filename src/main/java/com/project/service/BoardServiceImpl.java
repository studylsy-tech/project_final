package com.project.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.project.dao.BoardMapper; // Mapper 인터페이스 이름 확인 필요
import com.project.model.BoardDTO;

@Service
public class BoardServiceImpl implements BoardService {

    @Autowired
    private BoardMapper boardMapper;

    @Override
    public List<BoardDTO> selectBoardList(String board_type) {
        return boardMapper.selectBoardList(board_type);
    }

    @Override
    public BoardDTO selectBoardDetail(int notice_no) {
        return boardMapper.selectBoardDetail(notice_no);
    }

    @Override
    public void insertBoard(BoardDTO board) {
        boardMapper.insertBoard(board);
    }

    @Override
    public void updateCount(int notice_no) {
        boardMapper.updateCount(notice_no);
    }
}