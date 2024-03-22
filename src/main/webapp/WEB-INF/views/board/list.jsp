<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@include file="../includes/header.jsp"%>

<div id="page-wrapper">
	<div class="row">
		<div class="col-lg-12">
			<h1 class="page-header">Board List Page</h1>

		</div>
		<!-- /.col-lg-12 -->
	</div>
	<!-- /.row -->
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">
					Board List Page
					<button id='regBtn' type="button" class="btn btn-xs pull-right">Register
						New Board</button>
				</div>
				<!-- /.panel-heading -->
				<div class="panel-body">
					<table width="100%"
						class="table table-striped table-bordered table-hover"
						id="dataTables-example">
						<thead>
							<tr>
								<th>번호</th>
								<th>제목</th>
								<th>작성자</th>
								<th>작성일</th>
								<th>수정일</th>
							</tr>
						</thead>

						<c:forEach items="${list}" var="board">
							<tr>

								<td><c:out value="${board.bno}" /></td>
								
								<td><a class='move' href='<c:out value="${board.bno}"/>'>
										<c:out value="${board.title}" /></a>
								</td>
								
								
								<td><c:out value="${board.writer}" /></td>

								<td><fmt:formatDate pattern="yyyy-MM-dd"
										value="${board.regDate}" /></td>
								<td><fmt:formatDate pattern="yyyy-MM-dd"
										value="${board.updateDate}" /></td>
							</tr>
						</c:forEach>


					</table>
					<div class="pull-right">
						<ul class="pagination">
							<c:if test="${pageMaker.prev}">
								<li class="page-item"><a class="page-link"
									href="${pageMaker.startPage-1}" tabindex="-1">Previous</a></li>
							</c:if>
							<c:forEach begin="${pageMaker.startPage}"
								end="${pageMaker.endPage}" var="num">
								<li class="page-item ${pageMaker.cri.pageNum == num ? "active" : ""} ">
								<!-- 지정된 페이지 번호에서만 활성화 -->	
									<a class="page-link" href="${num}">${num}</a>
								</li>
							</c:forEach>
							<c:if test="${pageMaker.next}">
								<li class="page-item"><a class="page-link"
									href="${pageMaker.endPage+1}" tabindex="-1">Next</a></li>
							</c:if>
						</ul>
					</div>
					<form id='actionForm' action="/board/list" method='get'>
						<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum }'/>
						<input type='hidden' name='amount' value='${pageMaker.cri.amount }'/>
					
					</form>
					<!-- 모달시작 -->

					<div class="modal" tabindex="-1" id="myModal" role="dialog">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title">Modal title</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Close"></button>
								</div>
								<div class="modal-body">
									<p>처리가 완료되었습니다.</p>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-default"
										data-dismiss="modal">Close</button>
									<button type="button" class="btn btn-primary">Save
										changes</button>
								</div>
							</div>
						</div>
					</div>
					<!-- 모달종료 -->
				</div>
				<!-- /.panel-body -->
			</div>
			<!-- /.panel -->
		</div>
		<!-- /.col-lg-6 -->
	</div>
	<!-- /.row -->
</div>
<!-- /.wrapper -->
<script>
	$(document).ready(
			function() {

				let result = '<c:out value="${result}"/>';

				checkModal(result);

				history.replaceState({}, null, null); //히스토리 삭제

				function checkModal(result) {

					if (result === '' || history.state) {
						return;
					}

					if (parseInt(result) > 0) {
						$(".modal-body").html(
								"게시글" + parseInt(result) + " 번이 등록되었습니다.");
					}

					$("#myModal").modal("show");

				}

				$("#regBtn").on("click", function() {

					self.location = "/board/register";

				});
				
				var actionForm = $("#actionForm");
				
				$(".page-link").on("click", function(e){
					e.preventDefault();
					
					var targetPage = $(this).attr("href");
					console.log(targetPage);
					actionForm.find("input[name='pageNum']").val(targetPage);
					actionForm.submit();
					
				});
				
				$(".move").on("click", function(e){
					
					e.preventDefault();
					actionForm.append("<input type='hidden' name='bno' value='"+ $(this).attr("href")+"'>");
					actionForm.attr("action", "/board/get");
					actionForm.submit();
				});
				

			});
</script>
<%@include file="../includes/footer.jsp"%>