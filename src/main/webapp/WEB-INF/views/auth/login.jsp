<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/WEB-INF/views/layout/_header.jsp" %>

<div class="row justify-content-center">
    <div class="col-md-5">
        <div class="card shadow">
            <div class="card-header bg-dark text-white text-center">
                <h4 class="mb-0">&#128274; Login</h4>
            </div>
            <div class="card-body p-4">
                <c:if test="${param.error != null}">
                    <div class="alert alert-danger">Invalid username or password.</div>
                </c:if>
                <c:if test="${param.logout != null}">
                    <div class="alert alert-success">You have been logged out.</div>
                </c:if>
                <c:if test="${not empty success}">
                    <div class="alert alert-success">${success}</div>
                </c:if>

                <form action="/login" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <div class="mb-3">
                        <label class="form-label fw-bold">Username</label>
                        <input type="text" name="username" class="form-control" placeholder="Enter username" required autofocus>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-bold">Password</label>
                        <input type="password" name="password" class="form-control" placeholder="Enter password" required>
                    </div>
                    <div class="d-grid">
                        <button type="submit" class="btn btn-dark btn-lg">Login</button>
                    </div>
                </form>
            </div>
            <div class="card-footer text-center text-muted">
                Don't have an account? <a href="/register">Register here</a>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/layout/_footer.jsp" %>
