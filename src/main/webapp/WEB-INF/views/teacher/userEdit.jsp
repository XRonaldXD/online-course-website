<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/WEB-INF/views/layout/_header.jsp" %>
<div class="row justify-content-center"><div class="col-md-7">
<div class="card shadow"><div class="card-header bg-warning"><h4 class="mb-0">&#9998; Edit User: ${user.username}</h4></div>
<div class="card-body p-4">
<div class="mb-3"><label class="form-label fw-bold">Username</label><input type="text" class="form-control" value="${user.username}" disabled></div>
<form action="/teacher/users/${user.id}" method="post">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
<div class="mb-3"><label class="form-label fw-bold">Full Name *</label><input type="text" name="fullName" class="form-control" value="${user.fullName}" required></div>
<div class="mb-3"><label class="form-label fw-bold">Email *</label><input type="email" name="email" class="form-control" value="${user.email}" required></div>
<div class="mb-3"><label class="form-label fw-bold">Phone</label><input type="text" name="phone" class="form-control" value="${user.phone}"></div>
<div class="mb-3"><label class="form-label fw-bold">Role *</label><select name="role" class="form-select" required><option value="STUDENT" ${user.role == 'STUDENT' ? 'selected' : ''}>Student</option><option value="TEACHER" ${user.role == 'TEACHER' ? 'selected' : ''}>Teacher</option></select></div>
<div class="mb-3"><label class="form-label fw-bold">New Password</label><input type="password" name="password" class="form-control" placeholder="Leave blank to keep current"></div>
<div class="d-flex gap-2"><button type="submit" class="btn btn-warning btn-lg">Update User</button><a href="/teacher/users" class="btn btn-outline-secondary btn-lg">Cancel</a></div>
</form></div></div></div></div>
<%@ include file="/WEB-INF/views/layout/_footer.jsp" %>
