<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ include file="/WEB-INF/views/layout/_header.jsp" %>
<c:if test="${not empty success}"><div class="alert alert-success alert-dismissible fade show">${success} <button type="button" class="btn-close" data-bs-dismiss="alert"></button></div></c:if>
<nav aria-label="breadcrumb"><ol class="breadcrumb"><li class="breadcrumb-item"><a href="/">Home</a></li><li class="breadcrumb-item active">Poll</li></ol></nav>
<div class="card shadow-sm mb-4">
    <div class="card-header bg-success text-white d-flex justify-content-between align-items-center">
        <h3 class="mb-0">&#128202; Poll</h3>
        <sec:authorize access="hasRole('TEACHER')">
            <form action="/teacher/polls/${poll.id}/delete" method="post" class="d-inline" onsubmit="return confirm('Delete this poll?')">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <button class="btn btn-danger btn-sm">Delete Poll</button>
            </form>
        </sec:authorize>
    </div>
    <div class="card-body">
        <h4>${poll.question}</h4>
        <c:set var="total" value="${counts1 + counts2 + counts3 + counts4 + counts5}" />
        <c:if test="${existingVote == null}">
            <form action="/polls/${poll.id}/vote" method="post">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <div class="list-group mb-3">
                    <c:if test="${not empty poll.option1}"><label class="list-group-item list-group-item-action"><input class="form-check-input me-2" type="radio" name="selectedOption" value="1" required>${poll.option1}</label></c:if>
                    <c:if test="${not empty poll.option2}"><label class="list-group-item list-group-item-action"><input class="form-check-input me-2" type="radio" name="selectedOption" value="2">${poll.option2}</label></c:if>
                    <c:if test="${not empty poll.option3}"><label class="list-group-item list-group-item-action"><input class="form-check-input me-2" type="radio" name="selectedOption" value="3">${poll.option3}</label></c:if>
                    <c:if test="${not empty poll.option4}"><label class="list-group-item list-group-item-action"><input class="form-check-input me-2" type="radio" name="selectedOption" value="4">${poll.option4}</label></c:if>
                    <c:if test="${not empty poll.option5}"><label class="list-group-item list-group-item-action"><input class="form-check-input me-2" type="radio" name="selectedOption" value="5">${poll.option5}</label></c:if>
                </div>
                <button type="submit" class="btn btn-success btn-lg">Submit Vote</button>
            </form>
        </c:if>
        <c:if test="${existingVote != null}">
            <div class="alert alert-info mb-3">You voted for option ${existingVote.selectedOption}.</div>
            <h5>Current Results (${total} votes total):</h5>
            <c:if test="${not empty poll.option1}"><div class="mb-2"><div class="d-flex justify-content-between"><span>${poll.option1}</span><strong>${counts1} votes</strong></div><div class="progress"><div class="progress-bar bg-success" style="width: ${total > 0 ? counts1 * 100 / total : 0}%">${total > 0 ? counts1 * 100 / total : 0}%</div></div></div></c:if>
            <c:if test="${not empty poll.option2}"><div class="mb-2"><div class="d-flex justify-content-between"><span>${poll.option2}</span><strong>${counts2} votes</strong></div><div class="progress"><div class="progress-bar bg-info" style="width: ${total > 0 ? counts2 * 100 / total : 0}%">${total > 0 ? counts2 * 100 / total : 0}%</div></div></div></c:if>
            <c:if test="${not empty poll.option3}"><div class="mb-2"><div class="d-flex justify-content-between"><span>${poll.option3}</span><strong>${counts3} votes</strong></div><div class="progress"><div class="progress-bar bg-warning" style="width: ${total > 0 ? counts3 * 100 / total : 0}%">${total > 0 ? counts3 * 100 / total : 0}%</div></div></div></c:if>
            <c:if test="${not empty poll.option4}"><div class="mb-2"><div class="d-flex justify-content-between"><span>${poll.option4}</span><strong>${counts4} votes</strong></div><div class="progress"><div class="progress-bar bg-danger" style="width: ${total > 0 ? counts4 * 100 / total : 0}%">${total > 0 ? counts4 * 100 / total : 0}%</div></div></div></c:if>
            <c:if test="${not empty poll.option5}"><div class="mb-2"><div class="d-flex justify-content-between"><span>${poll.option5}</span><strong>${counts5} votes</strong></div><div class="progress"><div class="progress-bar bg-secondary" style="width: ${total > 0 ? counts5 * 100 / total : 0}%">${total > 0 ? counts5 * 100 / total : 0}%</div></div></div></c:if>
            <div class="mt-3"><h6>Change your vote:</h6>
            <form action="/polls/${poll.id}/vote" method="post" class="d-flex gap-2 flex-wrap">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <c:if test="${not empty poll.option1}"><button type="submit" name="selectedOption" value="1" class="btn btn-outline-success btn-sm">${poll.option1}</button></c:if>
                <c:if test="${not empty poll.option2}"><button type="submit" name="selectedOption" value="2" class="btn btn-outline-info btn-sm">${poll.option2}</button></c:if>
                <c:if test="${not empty poll.option3}"><button type="submit" name="selectedOption" value="3" class="btn btn-outline-warning btn-sm">${poll.option3}</button></c:if>
                <c:if test="${not empty poll.option4}"><button type="submit" name="selectedOption" value="4" class="btn btn-outline-danger btn-sm">${poll.option4}</button></c:if>
                <c:if test="${not empty poll.option5}"><button type="submit" name="selectedOption" value="5" class="btn btn-outline-secondary btn-sm">${poll.option5}</button></c:if>
            </form></div>
        </c:if>
    </div>
</div>
<div class="card shadow-sm">
    <div class="card-header bg-light"><h5 class="mb-0">&#128172; Comments (${comments.size()})</h5></div>
    <div class="card-body">
        <c:forEach var="comment" items="${comments}">
            <div class="d-flex mb-3"><div class="flex-grow-1 ms-3">
                <div class="d-flex justify-content-between"><strong>${comment.author.fullName}</strong><small class="text-muted">${comment.createdAt}</small></div>
                <p class="mb-1">${comment.body}</p>
                <sec:authorize access="hasRole('TEACHER')">
                    <form action="/polls/${poll.id}/comments/${comment.id}/delete" method="post" class="d-inline">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <button class="btn btn-link btn-sm text-danger p-0">Delete</button>
                    </form>
                </sec:authorize>
            </div></div><hr class="my-2">
        </c:forEach>
        <form action="/polls/${poll.id}/comments" method="post" class="mt-3">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <div class="input-group"><textarea name="body" class="form-control" rows="2" placeholder="Add a comment..." required></textarea><button type="submit" class="btn btn-success">Post</button></div>
        </form>
    </div>
</div>
<%@ include file="/WEB-INF/views/layout/_footer.jsp" %>
