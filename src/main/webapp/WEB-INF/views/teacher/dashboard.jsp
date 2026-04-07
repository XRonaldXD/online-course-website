<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/WEB-INF/views/layout/_header.jsp" %>
<c:if test="${not empty success}"><div class="alert alert-success alert-dismissible fade show">${success} <button type="button" class="btn-close" data-bs-dismiss="alert"></button></div></c:if>
<c:if test="${not empty error}"><div class="alert alert-danger alert-dismissible fade show">${error} <button type="button" class="btn-close" data-bs-dismiss="alert"></button></div></c:if>
<h2 class="mb-4">Teacher Dashboard</h2>
<div class="row g-3 mb-4">
    <div class="col-md-4"><div class="card text-center shadow-sm border-primary"><div class="card-body"><h1 class="display-4 text-primary">${userCount}</h1><p class="card-text text-muted">Total Users</p><a href="/teacher/users" class="btn btn-primary btn-sm">Manage Users</a></div></div></div>
    <div class="col-md-4"><div class="card text-center shadow-sm border-success"><div class="card-body"><h1 class="display-4 text-success">${lectureCount}</h1><p class="card-text text-muted">Total Lectures</p><a href="/teacher/lectures/new" class="btn btn-success btn-sm">Add Lecture</a></div></div></div>
    <div class="col-md-4"><div class="card text-center shadow-sm border-warning"><div class="card-body"><h1 class="display-4 text-warning">${pollCount}</h1><p class="card-text text-muted">Total Polls</p><a href="/teacher/polls/new" class="btn btn-warning btn-sm">Add Poll</a></div></div></div>
</div>
<div class="row">
<div class="col-md-6"><div class="card shadow-sm mb-4"><div class="card-header bg-primary text-white d-flex justify-content-between align-items-center"><h5 class="mb-0">Lectures</h5><a href="/teacher/lectures/new" class="btn btn-light btn-sm">+ New</a></div>
<div class="list-group list-group-flush">
<c:choose><c:when test="${empty lectures}"><div class="list-group-item text-muted">No lectures yet.</div></c:when>
<c:otherwise><c:forEach var="lecture" items="${lectures}"><div class="list-group-item d-flex justify-content-between align-items-center"><a href="/lectures/${lecture.id}" class="text-decoration-none">${lecture.title}</a>
<form action="/teacher/lectures/${lecture.id}/delete" method="post" onsubmit="return confirm('Delete?')"><input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/><button class="btn btn-outline-danger btn-sm">Delete</button></form></div></c:forEach></c:otherwise></c:choose>
</div></div></div>
<div class="col-md-6"><div class="card shadow-sm mb-4"><div class="card-header bg-warning d-flex justify-content-between align-items-center"><h5 class="mb-0">Polls</h5><a href="/teacher/polls/new" class="btn btn-dark btn-sm">+ New</a></div>
<div class="list-group list-group-flush">
<c:choose><c:when test="${empty polls}"><div class="list-group-item text-muted">No polls yet.</div></c:when>
<c:otherwise><c:forEach var="poll" items="${polls}"><div class="list-group-item d-flex justify-content-between align-items-center"><a href="/polls/${poll.id}" class="text-decoration-none">${poll.question}</a>
<form action="/teacher/polls/${poll.id}/delete" method="post" onsubmit="return confirm('Delete?')"><input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/><button class="btn btn-outline-danger btn-sm">Delete</button></form></div></c:forEach></c:otherwise></c:choose>
</div></div></div>
</div>
<%@ include file="/WEB-INF/views/layout/_footer.jsp" %>
