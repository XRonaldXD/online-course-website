<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/WEB-INF/views/layout/_header.jsp" %>
<div class="row justify-content-center"><div class="col-md-8">
<div class="card shadow"><div class="card-header bg-success text-white"><h4 class="mb-0">&#128202; Create New Poll</h4></div>
<div class="card-body p-4">
<form action="/teacher/polls" method="post">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
<div class="mb-3"><label class="form-label fw-bold">Question *</label><input type="text" name="question" class="form-control form-control-lg" required autofocus></div>
<div class="mb-3"><label class="form-label fw-bold">Option 1 *</label><input type="text" name="option1" class="form-control" required></div>
<div class="mb-3"><label class="form-label fw-bold">Option 2 *</label><input type="text" name="option2" class="form-control" required></div>
<div class="mb-3"><label class="form-label fw-bold">Option 3</label><input type="text" name="option3" class="form-control"></div>
<div class="mb-3"><label class="form-label fw-bold">Option 4</label><input type="text" name="option4" class="form-control"></div>
<div class="mb-3"><label class="form-label fw-bold">Option 5</label><input type="text" name="option5" class="form-control"></div>
<div class="d-flex gap-2"><button type="submit" class="btn btn-success btn-lg">Create Poll</button><a href="/teacher/dashboard" class="btn btn-outline-secondary btn-lg">Cancel</a></div>
</form></div></div></div></div>
<%@ include file="/WEB-INF/views/layout/_footer.jsp" %>
