package org.zerock.service;

import java.util.List;

import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

public interface BoardService {
	
	public void register(BoardVO board);//등록
	
	public BoardVO get(Long bno);//선택 조회
	
	public boolean modify(BoardVO board);//수정

	public boolean remove(Long bno);//삭제
	
	//public List<BoardVO> getList();//전체 조회
	
	public List<BoardVO> getList(Criteria cri);//해당 페이지 조회
	
	public int getTotal(Criteria cri); //전체 데이터의 개수 처리
}
