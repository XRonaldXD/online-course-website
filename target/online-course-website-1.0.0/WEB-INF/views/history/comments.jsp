<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/WEB-INF/views/layout/_header.jsp" %>
<h2 class="mb-4">&#128172; My Comment History</h2>
<div class="card shadow-sm">
<c:choose><c:when test="${empty comments}"><div class="card-body text-center text-muted py-5"><h4>No comments yet.</h4><p>Go to <a href="/">the home page</a> to view lectures and polls and leave a comment!</p></div></c:when>
<c:otherwise><div class="list-group list-group-flush"><c:forEach var="comment" items="${comments}">
<div class="list-group-item">
<div class="d-flex justify-content-between align-items-start">
<div><span class="badge ${comment.targetType == 'LECTURE' ? 'bg-primary' : 'bg-success'} me-2">${comment.targetType}</span>
<c:choose><c:when test="${comment.targetType == 'LECTURE'}"><a href="/lectures/${comment.targetId}">View Lecture</a></c:when><c:otherwise><a href="/polls/${comment.targetId}">View Poll</a></c:otherwise></c:choose></div>
<small class="text-muted">${comment.createdAt}</small></div>
<p class="mb-0 mt-2">${comment.body}</p>
</div></c:forEach></div></c:otherwise></c:choose>
</div>
<%@ include file="/WEB-INF/views/layout/_footer.jsp" %>
