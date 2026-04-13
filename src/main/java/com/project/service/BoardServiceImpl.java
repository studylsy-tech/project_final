package com.project.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.project.dao.BoardMapper;
import com.project.model.BoardDTO;
import com.project.util.Criteria;
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

    @Override
    public List<BoardDTO> getNoticeList() {
        return boardMapper.getNoticeList(); // Mapper에도 해당 쿼리가 정의되어 있어야 합니다
    }

    @Override
    public void updateBoardStatus(int no, String status) {
        boardMapper.updateBoardStatus(no, status);
    }

    @Override
    public int getNoticeCount() {
        // 공지사항 전용 카운트 조회를 위해 기본 SearchCriteria를 생성하여 전달합니다.
        SearchCriteria scri = new SearchCriteria();
        scri.setBoardType("NOTICE");
        return boardMapper.getBoardCount(scri);
    }

    @Override
    public List<BoardDTO> getNoticeListPaging(Criteria cri) {
        SearchCriteria scri = new SearchCriteria();
        scri.setPage(cri.getPage());
        scri.setPerPageNum(cri.getPerPageNum());
        scri.setBoardType("NOTICE");
        
        // 수정 전: return boardMapper.selectBoardListPaging(scri);
        // 수정 후: 상태(STATUS) 조건이 없는 관리자용 쿼리 호출
        return boardMapper.getNoticeListPaging(scri); 
    }

    @Override
    public List<BoardDTO> getQnaListPaging(Criteria cri) {
        SearchCriteria scri = new SearchCriteria();
        scri.setPage(cri.getPage());
        scri.setPerPageNum(cri.getPerPageNum());
        scri.setBoardType("QNA");
        
        return boardMapper.selectBoardListPaging(scri);
    }

    @Override
    public List<BoardDTO> selectQnaListPaging(SearchCriteria scri) {
        return boardMapper.selectQnaListPaging(scri);
    }

	
}