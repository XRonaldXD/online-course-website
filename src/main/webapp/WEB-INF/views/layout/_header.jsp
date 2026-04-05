<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>COMP 3800 - Online Course Website</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { padding-top: 70px; }
        .navbar-brand { font-weight: bold; }
        footer { margin-top: 40px; padding: 20px 0; background: #f8f9fa; border-top: 1px solid #dee2e6; }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container">
        <a class="navbar-brand" href="/">&#127979; COMP 3800</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="/">Home</a></li>
                <sec:authorize access="isAuthenticated()">
                    <li class="nav-item"><a class="nav-link" href="/history/votes">My Votes</a></li>
                    <li class="nav-item"><a class="nav-link" href="/history/comments">My Comments</a></li>
                </sec:authorize>
                <sec:authorize access="hasRole('TEACHER')">
                    <li class="nav-item"><a class="nav-link" href="/teacher/dashboard">&#128187; Teacher Dashboard</a></li>
                </sec:authorize>
            </ul>
            <ul class="navbar-nav">
                <sec:authorize access="isAuthenticated()">
                    <li class="nav-item">
                        <a class="nav-link" href="/profile">
                            &#128100; <sec:authentication property="name" />
                        </a>
                    </li>
                    <li class="nav-item">
                        <form action="/logout" method="post" class="d-inline">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            <button type="submit" class="btn btn-outline-light btn-sm ms-2 mt-1">Logout</button>
                        </form>
                    </li>
                </sec:authorize>
                <sec:authorize access="!isAuthenticated()">
                    <li class="nav-item"><a class="nav-link" href="/login">Login</a></li>
                    <li class="nav-item"><a class="nav-link" href="/register">Register</a></li>
                </sec:authorize>
            </ul>
        </div>
    </div>
</nav>
<div class="container mt-3">
