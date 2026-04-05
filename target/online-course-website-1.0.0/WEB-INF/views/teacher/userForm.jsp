<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/WEB-INF/views/layout/_header.jsp" %>
<div class="row justify-content-center"><div class="col-md-7">
<div class="card shadow"><div class="card-header bg-primary text-white"><h4 class="mb-0">&#128100; Create New User</h4></div>
<div class="card-body p-4"><form action="/teacher/users" method="post">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
<div class="mb-3"><label class="form-label fw-bold">Username *</label><input type="text" name="username" class="form-control" required autofocus></div>
<div class="mb-3"><label class="form-label fw-bold">Password *</label><input type="password" name="password" class="form-control" required></div>
<div class="mb-3"><label class="form-label fw-bold">Full Name *</label><input type="text" name="fullName" class="form-control" required></div>
<div class="mb-3"><label class="form-label fw-bold">Email *</label><input type="email" name="email" class="form-control" required></div>
<div class="mb-3"><label class="form-label fw-bold">Phone</label><input type="text" name="phone" class="form-control"></div>
<div class="mb-3"><label class="form-label fw-bold">Role *</label><select name="role" class="form-select" required><option value="STUDENT">Student</option><option value="TEACHER">Teacher</option></select></div>
<div class="d-flex gap-2"><button type="submit" class="btn btn-primary btn-lg">Create User</button><a href="/teacher/users" class="btn btn-outline-secondary btn-lg">Cancel</a></div>
</form></div></div></div></div>
<%@ include file="/WEB-INF/views/layout/_footer.jsp" %>
