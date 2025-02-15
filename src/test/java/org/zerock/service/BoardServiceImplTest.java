package org.zerock.service;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardServiceImplTest {
	
	@Autowired//단위 테스트 할 때는 집어 넣어야함.
	private BoardService service;
	
	@Test
	public void testExist()	{
		
		log.info(service);
		assertNotNull(service);
		//assertNotNull은 JUnit의 메서드 중 하나로, 주어진 객체가 null이 아님을 확인하는 데 사용.
		//테스트 중에 객체가 null이면 테스트가 실패합니다.
	}	
	
	@Test
	public void testRegister()	{
		
		BoardVO board = new BoardVO();
		board.setTitle("새로 작성하는 글-ser");
		board.setContent("새로 작성하는 글 내용-ser");
		board.setWriter("newbie-ser");
		
		service.register(board);
		
		log.info("생성된 게시물의 번호 : " + board.getBno());
	}
	
	@Test
	public void testGetList()	{
		//service.getList().forEach(board -> log.info(board));
		service.getList(new Criteria(2, 10)).forEach(board -> log.info(board));
	}
	
	@Test
	public void testGet() {
		log.info(service.get(1L));
	}
	
	@Test
	public void testDelete() {
		// 게시물 번호의 존재 여부를 확인하고 테스트.
		log.info("REMOVE RESULT : " + service.remove(2L));
	}
	
	@Test
	public void testUpdate() {
		
		BoardVO board = service.get(1L);
		
		if(board == null) {
			return;
		}
		
		board.setTitle("제목을 수정합니다.");
		log.info("MODIFY RESULT: " + service.modify(board));
		
	}
}
