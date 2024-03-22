<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@include file="../includes/header.jsp"%>

<div id="page-wrapper">
	<div class="row">
		<div class="col-lg-12">
			<h1 class="page-header">Board Modify page</h1>
		</div>
		<!-- /.col-lg-12 -->
	</div>
	<!-- /.row -->
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">Board Modify page</div>
				<!-- /.panel-heading -->
				<div class="panel-body">
					<form>
						<div class="form-group">
						<!-- 페이지 이동 내용 추가 -->
						<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
						<input type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
				
							<label>Bno</label> <input class="form-control" name="bno"
								value='<c:out value="${board.bno}"/>' readonly="readonly">
						</div>

						<div class="form-group">
							<label>Title</label> <input class="form-control" name="title"
								value='<c:out value="${board.title}"/>'>
						</div>
						<div class="form-group">
							<label>Text area</label>
							<textarea class="form-control" row="3" name="content"
								><c:out value="${board.content}" /></textarea>
							<!--textarea태그는 2줄로 만들면 버그가 발생하곤 하니 한 줄로 만들어야 한다.-->
						</div>
						<div class="form-group">
							<label>Writer</label> <input class="form-control" name="writer"
								value='<c:out value="${board.writer}"/>' readonly="readonly">
						</div>
						<div class="form-group">
							<label>regDate</label> <input class="form-control" name="regDate"
								value='<fmt:formatDate pattern = "yyyy/MM/dd"
						value="${board.regDate}"/>'
								readonly="readonly">
						</div>
						<div class="form-group">
							<label>updateDate</label> <input class="form-control"
								name="updateDate"
								value='<fmt:formatDate pattern = "yyyy/MM/dd"
						value="${board.updateDate}"/>'
								readonly="readonly">
						</div>

						<button type="submit" data-oper='modify' class="btn btn-default">Modify</button>
						<button type="submit" data-oper='remove' class="btn btn-danger">Remove</button>
						<button type="submit" data-oper='list' class="btn btn-info">List</button>

					</form>
				</div>
				<!-- /.panel-body -->
			</div>
			<!-- /.panel -->
		</div>
		<!-- /.col-lg-6 -->
	</div>
	<!-- /.row -->

</div>
<!-- /#wrapper -->
<script>
	$(document).ready(function() {

		let formObj = $("form");

		$('button').on("click", function(e) {

			e.preventDefault();

			let operation = $(this).data("oper");

			if (operation === 'list') {

				//move to list
				formObj.attr("action", "/board/list").attr("method", "get");
				var pageNumTag = $("input[name='pageNum']").clone();
				var amountTag = $("input[name='amount']").clone();

				formObj.empty();
				formObj.append(pageNumTag);
				formObj.append(amountTag);
				
			} else if (operation === 'remove') {
				formObj.attr("action", "/board/remove")
					   .attr("method", "post");
				
			} else if (operation === 'modify') {
				formObj.attr("action", "/board/modify")
				       .attr("method", "post");
			}
			
			formObj.submit();	

		});

	});
</script>
<%@include file="../includes/footer.jsp"%>