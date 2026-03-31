package com.project.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.project.dao.BoardMapper; // Mapper 인터페이스 이름 확인 필요
import com.project.model.BoardDTO;
import com.project.util.Criteria;
import com.project.util.SearchCriteria;

@Service
public class BoardServiceImpl implements BoardService {

    @Autowired
    private BoardMapper boardMapper;

 // BoardServiceImpl.java 예시
 // BoardServiceImpl.java 수정
    @Override
    public List<BoardDTO> selectBoardListPaging(String boardType, Criteria cri) {
        int pageEnd = cri.getPage() * cri.getPerPageNum();
        int pageStart = (cri.getPage() - 1) * cri.getPerPageNum() + 1;
        
        // 검색 조건이 없는 기본 Criteria를 사용 중이라면 null을 전달하여 에러 방지
        String searchType = null;
        String keyword = null;
        
        // 만약 SearchCriteria를 사용 중이라면 값을 추출
        if (cri instanceof SearchCriteria) {
            searchType = ((SearchCriteria) cri).getSearchType();
            keyword = ((SearchCriteria) cri).getKeyword();
        }

        return boardMapper.selectBoardListPaging(boardType, pageStart, pageEnd, searchType, keyword);
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

    @Override
    public int getBoardCount(String boardType) {
        // boardMapper의 getBoardCount를 호출하여 실제 게시글 개수를 반환합니다.
        return boardMapper.getBoardCount(boardType); //
    }

 // 기존 전체 목록 조회 (필요 시 유지)
    @Override
    public List<BoardDTO> selectBoardList(String board_type) {
        return boardMapper.selectBoardList(board_type);
    }
}