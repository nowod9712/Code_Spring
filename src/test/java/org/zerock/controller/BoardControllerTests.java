package org.zerock.controller;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration({
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml",
		"file:src/main/webapp/WEB-INF/spring/root-context.xml"})

@Log4j
public class BoardControllerTests {
	
	@Autowired
	private WebApplicationContext ctx;
	
	private MockMvc mockMVC;
	
	@Before
	public void setup() {
	    this.mockMVC = MockMvcBuilders.webAppContextSetup(ctx).build();
	}

	
	@Test
	public void testList() throws Exception{
		
		log.info(
				mockMVC.perform(MockMvcRequestBuilders.get("/board/list"))
				.andReturn()
				.getModelAndView()
				.getModelMap());			
	}
	
	@Test
	public void testRegister() throws Exception{
	
		String resultPage
		= mockMVC.perform(MockMvcRequestBuilders.post("/board/register")
			.param("title", "테스트 새글 제목")
			.param("content", "테스트 새글 내용")
			.param("writer", "user00")
			).andReturn().getModelAndView().getViewName();
		
		log.info(resultPage);
	}
	
	@Test
	public void testGet() throws Exception{
		log.info(mockMVC.perform(MockMvcRequestBuilders
				.get("/board/get")
				.param("bno","5"))
				.andReturn()
				.getModelAndView().getModelMap());	
	}
	
	@Test
	public void testModify() throws Exception{
	
		String resultPage
		= mockMVC.perform(MockMvcRequestBuilders.post("/board/modify")
			.param("bno", "8") //데이터 확인
			.param("title", "수정된 테스트 새글 제목")
			.param("content", "수정된 테스트 새글 내용")
			.param("writer", "user00")
			).andReturn().getModelAndView().getViewName();
		
		log.info(resultPage);
	}
	
	@Test
	public void testRemove() throws Exception{
		//삭제 전 데이터베이스에 게시물 번호 확인
		String resultPage
		= mockMVC.perform(MockMvcRequestBuilders.post("/board/remove")	
				.param("bno", "6"))
		.andReturn().getModelAndView().getViewName();
		
		log.info(resultPage);
	}
	
	@Test
	public void testListPaging() throws Exception{
		
		log.info(mockMVC.perform(
				MockMvcRequestBuilders.get("/board/list")
				.param("pageNum", "2")
				.param("amount", "10"))
				.andReturn().getModelAndView().getModelMap());			
	}
	


}
