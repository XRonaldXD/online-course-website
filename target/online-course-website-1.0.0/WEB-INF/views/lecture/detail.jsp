<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ include file="/WEB-INF/views/layout/_header.jsp" %>
<c:if test="${not empty success}"><div class="alert alert-success alert-dismissible fade show">${success} <button type="button" class="btn-close" data-bs-dismiss="alert"></button></div></c:if>
<nav aria-label="breadcrumb"><ol class="breadcrumb"><li class="breadcrumb-item"><a href="/">Home</a></li><li class="breadcrumb-item active">Lecture</li></ol></nav>
<div class="card shadow-sm mb-4">
    <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
        <h3 class="mb-0">&#128218; ${lecture.title}</h3>
        <sec:authorize access="hasRole('TEACHER')">
            <form action="/teacher/lectures/${lecture.id}/delete" method="post" class="d-inline" onsubmit="return confirm('Delete this lecture?')">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <button class="btn btn-danger btn-sm">Delete Lecture</button>
            </form>
        </sec:authorize>
    </div>
    <div class="card-body"><p class="lead">${lecture.summary}</p><small class="text-muted">Created: ${lecture.createdAt}</small></div>
</div>
<div class="card shadow-sm mb-4">
    <div class="card-header bg-secondary text-white"><h5 class="mb-0">&#128196; Course Materials</h5></div>
    <div class="card-body">
        <c:choose>
            <c:when test="${empty lecture.files}"><p class="text-muted">No files uploaded yet.</p></c:when>
            <c:otherwise>
                <ul class="list-group list-group-flush">
                    <c:forEach var="file" items="${lecture.files}">
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <a href="/files/${file.id}" class="text-decoration-none">&#128196; ${file.filename}</a>
                            <div>
                                <small class="text-muted me-3">${file.uploadedAt}</small>
                                <sec:authorize access="hasRole('TEACHER')">
                                    <form action="/teacher/lectures/${lecture.id}/files/${file.id}/delete" method="post" class="d-inline" onsubmit="return confirm('Delete this file?')">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                        <button class="btn btn-outline-danger btn-sm">&#128465;</button>
                                    </form>
                                </sec:authorize>
                            </div>
                        </li>
                    </c:forEach>
                </ul>
            </c:otherwise>
        </c:choose>
        <sec:authorize access="hasRole('TEACHER')">
            <hr>
            <form action="/teacher/lectures/${lecture.id}/upload" method="post" enctype="multipart/form-data">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <div class="input-group">
                    <input type="file" name="file" class="form-control" required>
                    <button type="submit" class="btn btn-secondary">Upload File</button>
                </div>
            </form>
        </sec:authorize>
    </div>
</div>
<div class="card shadow-sm">
    <div class="card-header bg-light"><h5 class="mb-0">&#128172; Comments (${comments.size()})</h5></div>
    <div class="card-body">
        <c:forEach var="comment" items="${comments}">
            <div class="d-flex mb-3">
                <div class="flex-grow-1 ms-3">
                    <div class="d-flex justify-content-between"><strong>${comment.author.fullName}</strong><small class="text-muted">${comment.createdAt}</small></div>
                    <p class="mb-1">${comment.body}</p>
                    <sec:authorize access="hasRole('TEACHER')">
                        <form action="/lectures/${lecture.id}/comments/${comment.id}/delete" method="post" class="d-inline">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            <button class="btn btn-link btn-sm text-danger p-0">Delete</button>
                        </form>
                    </sec:authorize>
                </div>
            </div><hr class="my-2">
        </c:forEach>
        <form action="/lectures/${lecture.id}/comments" method="post" class="mt-3">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <div class="input-group">
                <textarea name="body" class="form-control" rows="2" placeholder="Add a comment..." required></textarea>
                <button type="submit" class="btn btn-primary">Post</button>
            </div>
        </form>
    </div>
</div>
<%@ include file="/WEB-INF/views/layout/_footer.jsp" %>
