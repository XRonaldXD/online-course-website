<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/WEB-INF/views/layout/_header.jsp" %>
<h2 class="mb-4">&#128202; My Voting History</h2>
<div class="card shadow-sm">
<c:choose><c:when test="${empty votes}"><div class="card-body text-center text-muted py-5"><h4>No votes yet.</h4><p>Go to <a href="/">the home page</a> to find polls and cast your vote!</p></div></c:when>
<c:otherwise><div class="table-responsive"><table class="table table-hover mb-0">
<thead class="table-dark"><tr><th>#</th><th>Poll Question</th><th>Your Vote</th><th>Voted At</th><th>Action</th></tr></thead>
<tbody><c:forEach var="vote" items="${votes}" varStatus="status"><tr>
<td>${status.index + 1}</td><td>${vote.poll.question}</td>
<td><span class="badge bg-success">Option ${vote.selectedOption}:
<c:choose><c:when test="${vote.selectedOption == 1}">${vote.poll.option1}</c:when><c:when test="${vote.selectedOption == 2}">${vote.poll.option2}</c:when><c:when test="${vote.selectedOption == 3}">${vote.poll.option3}</c:when><c:when test="${vote.selectedOption == 4}">${vote.poll.option4}</c:when><c:when test="${vote.selectedOption == 5}">${vote.poll.option5}</c:when></c:choose>
</span></td>
<td><small class="text-muted">${vote.updatedAt}</small></td>
<td><a href="/polls/${vote.poll.id}" class="btn btn-outline-primary btn-sm">View Poll</a></td>
</tr></c:forEach></tbody>
</table></div></c:otherwise></c:choose>
</div>
<%@ include file="/WEB-INF/views/layout/_footer.jsp" %>
