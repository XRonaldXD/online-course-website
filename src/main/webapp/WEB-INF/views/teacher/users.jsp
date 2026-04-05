<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/WEB-INF/views/layout/_header.jsp" %>
<c:if test="${not empty success}"><div class="alert alert-success alert-dismissible fade show">${success} <button type="button" class="btn-close" data-bs-dismiss="alert"></button></div></c:if>
<c:if test="${not empty error}"><div class="alert alert-danger alert-dismissible fade show">${error} <button type="button" class="btn-close" data-bs-dismiss="alert"></button></div></c:if>
<div class="d-flex justify-content-between align-items-center mb-4"><h2>&#128101; User Management</h2><a href="/teacher/users/new" class="btn btn-primary">+ Add User</a></div>
<div class="card shadow-sm"><div class="table-responsive"><table class="table table-hover mb-0">
<thead class="table-dark"><tr><th>#</th><th>Username</th><th>Full Name</th><th>Email</th><th>Phone</th><th>Role</th><th>Actions</th></tr></thead>
<tbody><c:forEach var="user" items="${users}"><tr>
<td>${user.id}</td><td><strong>${user.username}</strong></td><td>${user.fullName}</td><td>${user.email}</td><td>${user.phone}</td>
<td><span class="badge ${user.role == 'TEACHER' ? 'bg-warning text-dark' : 'bg-info'}">${user.role}</span></td>
<td><a href="/teacher/users/${user.id}/edit" class="btn btn-outline-primary btn-sm">Edit</a>
<form action="/teacher/users/${user.id}/delete" method="post" class="d-inline" onsubmit="return confirm('Delete user?')"><input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/><button class="btn btn-outline-danger btn-sm">Delete</button></form></td>
</tr></c:forEach></tbody>
</table></div></div>
<div class="mt-3"><a href="/teacher/dashboard" class="btn btn-outline-secondary">&#8592; Back to Dashboard</a></div>
<%@ include file="/WEB-INF/views/layout/_footer.jsp" %>
