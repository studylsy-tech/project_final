package com.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.dao.BoardMapper;
import com.project.model.BoardDTO;
import com.project.util.SearchCriteria;

@Service
public class BoardServiceImpl implements BoardService {

    @Autowired
    private BoardMapper boardMapper;

    // 인터페이스에서 요구하는 selectBoardList(SearchCriteria) 구현
    @Override
    public List<BoardDTO> selectBoardList(SearchCriteria scri) {
        return boardMapper.selectBoardList(scri);
    }

    // 기존 페이징 목록 조회
    @Override
    public List<BoardDTO> selectBoardListPaging(SearchCriteria scri) {
        return boardMapper.selectBoardListPaging(scri);
    }

    // 기존 게시글 개수 조회
    @Override
    public int getBoardCount(SearchCriteria scri) {
        return boardMapper.getBoardCount(scri);
    }

    // 상세 조회, 등록, 조회수 증가 메서드 (기존 유지)
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