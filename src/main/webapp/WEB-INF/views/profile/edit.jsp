<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/WEB-INF/views/layout/_header.jsp" %>
<div class="row justify-content-center"><div class="col-md-7">
<c:if test="${not empty success}"><div class="alert alert-success alert-dismissible fade show">${success} <button type="button" class="btn-close" data-bs-dismiss="alert"></button></div></c:if>
<div class="card shadow"><div class="card-header bg-dark text-white"><h4 class="mb-0">Edit Profile</h4></div>
<div class="card-body p-4">
<div class="mb-3"><label class="form-label fw-bold">Username</label><input type="text" class="form-control" value="${user.username}" disabled><small class="text-muted">Username cannot be changed.</small></div>
<div class="mb-3"><label class="form-label fw-bold">Role</label><input type="text" class="form-control" value="${user.role}" disabled></div>
<form action="/profile" method="post">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
<div class="mb-3"><label class="form-label fw-bold">Full Name *</label><input type="text" name="fullName" class="form-control" value="${user.fullName}" required></div>
<div class="mb-3"><label class="form-label fw-bold">Email *</label><input type="email" name="email" class="form-control" value="${user.email}" required></div>
<div class="mb-3"><label class="form-label fw-bold">Phone</label><input type="text" name="phone" class="form-control" value="${user.phone}"></div>
<div class="mb-3"><label class="form-label fw-bold">New Password</label><input type="password" name="password" class="form-control" placeholder="Leave blank to keep current"></div>
<div class="d-grid"><button type="submit" class="btn btn-dark btn-lg">Update Profile</button></div>
</form></div></div></div></div>
<%@ include file="/WEB-INF/views/layout/_footer.jsp" %>
