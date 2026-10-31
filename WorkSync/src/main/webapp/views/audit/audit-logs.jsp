<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>WorkSync | Audit Logs</title>

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/dashboard.css">

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/audit-logs.css">
</head>

<body>

<div class="app-layout">

    <aside class="sidebar">

        <div class="brand">
            <div class="brand-icon">W</div>
            <h1>Work<span>Sync</span></h1>
        </div>

        <p class="nav-heading">WORKSPACE</p>

        <nav class="navigation">

            <a class="nav-link"
               href="<%= request.getContextPath() %>/dashboard">
                <span class="nav-icon">▦</span>
                Dashboard
            </a>

            <a class="nav-link"
               href="<%= request.getContextPath() %>/employees">
                <span class="nav-icon">♙</span>
                Employees
            </a>

            <a class="nav-link"
               href="<%= request.getContextPath() %>/departments">
                <span class="nav-icon">▤</span>
                Departments
            </a>

            <a class="nav-link"
               href="<%= request.getContextPath() %>/attendance">
                <span class="nav-icon">◷</span>
                Attendance
            </a>

            <a class="nav-link"
               href="<%= request.getContextPath() %>/leave-management">
                <span class="nav-icon">▧</span>
                Leave Management
            </a>

            <a class="nav-link"
               href="<%= request.getContextPath() %>/reports">
                <span class="nav-icon">▥</span>
                Reports
            </a>

            <a class="nav-link active"
               href="<%= request.getContextPath() %>/audit-logs">
                <span class="nav-icon">◉</span>
                Audit Logs
            </a>

        </nav>

        <div class="sidebar-bottom">

            <div class="help-card">
                <div class="help-icon">✦</div>
                <h3>WorkSync Workspace</h3>
                <p>Track important system activities.</p>
            </div>

            <a class="nav-link logout-link"
               href="<%= request.getContextPath() %>/logout">
                <span class="nav-icon">↪</span>
                Logout
            </a>

        </div>

    </aside>

    <main class="main-content">

        <header class="topbar">

            <div class="page-heading">
                <p class="breadcrumb">WORKSPACE / SECURITY</p>
                <h2>Audit Logs</h2>
                <p class="page-subtitle">
                    Review important activities performed in WorkSync.
                </p>
            </div>

            <div class="user-info">

                <div class="user-avatar">
                    <c:out value="${sessionScope.username}"/>
                </div>

                <div class="user-details">
                    <strong>
                        <c:out value="${sessionScope.username}"/>
                    </strong>
                    <span>
                        <c:out value="${sessionScope.role}"/>
                    </span>
                </div>

            </div>

        </header>

        <section class="audit-intro">
            <div>
                <span class="welcome-label">SECURITY &amp; ACCOUNTABILITY</span>
                <h2>System Activity History</h2>
                <p>
                    View who performed an action, what happened,
                    and when it was recorded.
                </p>
            </div>

            <div class="audit-symbol">◉</div>
        </section>

        <section class="content-card audit-filter-card">

            <div class="card-heading">
                <div>
                    <h3>Filter Audit Records</h3>
                    <p>Search by user, description, action, or date.</p>
                </div>
            </div>

            <form method="get"
                  action="<%= request.getContextPath() %>/audit-logs"
                  class="audit-filter-form">

                <label>
                    Search
                    <input type="text"
                           name="search"
                           maxlength="100"
                           placeholder="Username or description"
                           value="<c:out value='${search}'/>">
                </label>

                <label>
                    Action
                    <select name="action">
                        <option value="">All actions</option>

                        <option value="LOGIN"
                                ${selectedAction == 'LOGIN' ? 'selected' : ''}>
                            Login
                        </option>

                        <option value="LOGOUT"
                                ${selectedAction == 'LOGOUT' ? 'selected' : ''}>
                            Logout
                        </option>

                        <option value="EMPLOYEE_CREATED"
                                ${selectedAction == 'EMPLOYEE_CREATED' ? 'selected' : ''}>
                            Employee Created
                        </option>

                        <option value="EMPLOYEE_UPDATED"
                                ${selectedAction == 'EMPLOYEE_UPDATED' ? 'selected' : ''}>
                            Employee Updated
                        </option>

                        <option value="LEAVE_APPROVED"
                                ${selectedAction == 'LEAVE_APPROVED' ? 'selected' : ''}>
                            Leave Approved
                        </option>

                        <option value="DEPARTMENT_CREATED"
                                ${selectedAction == 'DEPARTMENT_CREATED' ? 'selected' : ''}>
                            Department Created
                        </option>
                    </select>
                </label>

                <label>
                    Start Date
                    <input type="date"
                           name="startDate"
                           value="<c:out value='${startDate}'/>">
                </label>

                <label>
                    End Date
                    <input type="date"
                           name="endDate"
                           value="<c:out value='${endDate}'/>">
                </label>

                <button type="submit" class="audit-button">
                    Apply Filters
                </button>

                <a href="<%= request.getContextPath() %>/audit-logs"
                   class="audit-reset-button">
                    Reset
                </a>

            </form>

        </section>

        <section class="content-card audit-table-card">

            <div class="card-heading">
                <div>
                    <h3>Activity Records</h3>
                    <p>Showing up to 500 matching records, newest first.</p>
                </div>
            </div>

            <div class="audit-table-wrapper">

                <table class="audit-table">

                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Date &amp; Time</th>
                        <th>User</th>
                        <th>Action</th>
                        <th>Description</th>
                        <th>IP Address</th>
                    </tr>
                    </thead>

                    <tbody>

                    <c:forEach var="log" items="${logs}">

                        <tr>
                            <td>
                                <c:out value="${log.auditId}"/>
                            </td>

                            <td>
                                <c:out value="${log.createdAt}"/>
                            </td>

                            <td>
                                <strong>
                                    <c:out value="${log.username}"/>
                                </strong>
                                <small class="audit-user-id">
                                    User ID:
                                    <c:out value="${log.userId}"/>
                                </small>
                            </td>

                            <td>
                                <span class="audit-action">
                                    <c:out value="${log.action}"/>
                                </span>
                            </td>

                            <td class="audit-description">
                                <c:out value="${log.description}"/>
                            </td>

                            <td>
                                <c:out value="${log.ipAddress}"/>
                            </td>
                        </tr>

                    </c:forEach>

                    <c:if test="${empty logs}">
                        <tr>
                            <td colspan="6" class="audit-empty">
                                No audit records found.
                                Actions will appear here after logging
                                has been connected to the application.
                            </td>
                        </tr>
                    </c:if>

                    </tbody>

                </table>

            </div>

        </section>

        <footer class="dashboard-footer">
            <span>© 2026 WorkSync</span>
            <span>Audit Logs &amp; Security Monitoring</span>
        </footer>

    </main>

</div>

</body>
</html>
