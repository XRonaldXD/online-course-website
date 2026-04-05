<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ include file="/WEB-INF/views/layout/_header.jsp" %>

<div class="row mb-4">
    <div class="col">
        <h1 class="display-5 fw-bold">Welcome to COMP 3800</h1>
        <p class="lead text-muted">Online Course Website &mdash; Lectures, Polls, and Community Discussion</p>
    </div>
</div>

<sec:authorize access="!isAuthenticated()">
    <div class="alert alert-info">
        <strong>Welcome!</strong> Please <a href="/login" class="alert-link">log in</a> or
        <a href="/register" class="alert-link">register</a> to access lectures, polls, and participate in discussions.
    </div>
</sec:authorize>

<c:if test="${not empty success}">
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        ${success}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<div class="row">
    <div class="col-md-6">
        <div class="card shadow-sm mb-4">
            <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                <h5 class="mb-0">&#128218; Lectures</h5>
                <span class="badge bg-light text-primary">${lectures.size()} total</span>
            </div>
            <div class="list-group list-group-flush">
                <c:choose>
                    <c:when test="${empty lectures}">
                        <div class="list-group-item text-muted">No lectures yet.</div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="lecture" items="${lectures}">
                            <a href="/lectures/${lecture.id}" class="list-group-item list-group-item-action">
                                <div class="d-flex justify-content-between">
                                    <strong>${lecture.title}</strong>
                                    <small class="text-muted">${lecture.files.size()} file(s)</small>
                                </div>
                                <small class="text-muted">${lecture.summary.length() > 80 ? lecture.summary.substring(0,80).concat('...') : lecture.summary}</small>
                            </a>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <div class="col-md-6">
        <div class="card shadow-sm mb-4">
            <div class="card-header bg-success text-white d-flex justify-content-between align-items-center">
                <h5 class="mb-0">&#128202; Polls</h5>
                <span class="badge bg-light text-success">${polls.size()} total</span>
            </div>
            <div class="list-group list-group-flush">
                <c:choose>
                    <c:when test="${empty polls}">
                        <div class="list-group-item text-muted">No polls yet.</div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="poll" items="${polls}">
                            <a href="/polls/${poll.id}" class="list-group-item list-group-item-action">
                                <strong>${poll.question}</strong>
                                <br><small class="text-muted">Click to vote or view results</small>
                            </a>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/layout/_footer.jsp" %>
