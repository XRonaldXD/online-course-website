<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/WEB-INF/views/layout/_header.jsp" %>
<div class="row justify-content-center"><div class="col-md-8">
<div class="card shadow"><div class="card-header bg-primary text-white"><h4 class="mb-0">&#128218; Create New Lecture</h4></div>
<div class="card-body p-4">
<form action="/teacher/lectures" method="post">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
<div class="mb-3"><label class="form-label fw-bold">Title *</label><input type="text" name="title" class="form-control form-control-lg" required autofocus></div>
<div class="mb-3"><label class="form-label fw-bold">Summary *</label><textarea name="summary" class="form-control" rows="6" required></textarea></div>
<div class="d-flex gap-2"><button type="submit" class="btn btn-primary btn-lg">Create Lecture</button><a href="/teacher/dashboard" class="btn btn-outline-secondary btn-lg">Cancel</a></div>
</form></div></div></div></div>
<%@ include file="/WEB-INF/views/layout/_footer.jsp" %>
