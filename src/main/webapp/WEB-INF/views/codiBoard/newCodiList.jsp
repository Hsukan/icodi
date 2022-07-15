<%@page import="com.kh.icodi.myCodi.model.dto.MyCodi"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	int totalPage = (int) request.getAttribute("totalPage");
%>
<script src="<%= request.getContextPath()%>/js/jquery-3.6.0.js"></script>
	<main>
		<section>
			<article>
				<div class="header-wrap">
					<div id="hot">인기</div>
					<div id="new" onclick="goToNewCodi();">최신</div>
				</div>
				<div class="content-wrap"></div>
				<div id="btn-more-content">
					<button id="btn-more">MORE</button>
				</div>
			</article>
		</section>
	</main>
<script>
const goToNewCode = () => {
	location.href = "<%= request.getContextPath()%>/codi/newCodiList"
}
document.querySelector("#btn-more").addEventListener('click', (e) => {
	const cPage = Number(document.querySelector("#cPage"))+1;
	getPage(cPage);
});

const getPage = (cPage) => {
	$.ajax({
		url : '<%= request.getContextPath()%>/codi/newCodiMore',
		data : {cPage},
		success(response) {
			const content = document.querySelector(".content-wrap");
			response.forEach((response) => {
				const {codiBoardNo, codiBoardContent, codiBoardRegDate, likeCount, myCodiList} = response;
				
				myCodiList.forEach((myCodi) => {
					const {memberId, myCodiRegDate, myCodiFilename, codiNo} = myCodi;
					
					const codi = `
						<div class="myCodi">
							<img src="<%= request.getContextPath()%>/upload/codiboard/\${myCodiFilename}" />
							<p class="info">
								<span id="\${codiBoardNo}" class="like">❤</span>
								<span id="likeCount">받은 좋아요 \${likeCount}</span>
								<span id="writer">\${memberId}</span>
								<span id="regDate">\${myCodiRegDate}</span>
							</p>
						</div>
					`
					content.insertAdjacentHTML('beforeend', codi);
				});
			 });
		},
		error : console.log,
		complete() {
			if(cPage == <%= totalPage %>) {
				document.querySelector("#btn-more").disabled = true;
			}
			
			document.querySelectorAll(".like").forEach((no) => {
				no.onclick = (e) => {
					likeIt(e);
				}
			});
		}
	});
};
getPage(1);

const likeIt = (e) => {
	const target = e.target;
	const codiBoardNo = target.id;
	const memberId = target.nextElementSibling.nextElementSibling.innerHTML;
	
	target.classList.forEach((list) => {
		if(list.indexOf('on') == -1) {
			target.classList.add('on');
			$.ajax({
				url : '<%= request.getContextPath() %>/codiBoard/likeInsert',
				method : 'POST',
				data : {
					codiBoardNo : codiBoardNo,
					memberId : memberId
				},
				success(response) {
					console.log(response)
				},
				error : console.log
			});
		} else {
			target.classList.remove('on');
			$.ajax({
				url : '<%= request.getContextPath()%>/codiBoard/likeDelete',
				method : 'POST',
				data : {
					codiBoardNo : codiBoardNo,
					memberId : memberId
				},
				success(response) {
					console.log(response);
				},
				error : console.log
			});
		}
	});
};
</script>
</body>
</html>