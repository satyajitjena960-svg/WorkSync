package com.worksync.controller;

import com.worksync.service.AuditLogService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/audit-logs")
public class AuditLogServlet extends HttpServlet {

    private final AuditLogService auditLogService =
            new AuditLogService();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
                session.getAttribute("userId") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login"
            );
            return;
        }

        String role = String.valueOf(
                session.getAttribute("role")
        );

        if (!"SUPER_ADMIN".equals(role) &&
                !"AUDITOR".equals(role)) {

            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "You are not authorized to view audit logs."
            );
            return;
        }

        String search = request.getParameter("search");
        String action = request.getParameter("action");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");

        try {

            request.setAttribute(
                    "logs",
                    auditLogService.getLogs(
                            search,
                            action,
                            startDate,
                            endDate
                    )
            );

            request.setAttribute("search", search);
            request.setAttribute("selectedAction", action);
            request.setAttribute("startDate", startDate);
            request.setAttribute("endDate", endDate);

            request.getRequestDispatcher(
                    "/views/audit/audit-logs.jsp"
            ).forward(request, response);

        } catch (IllegalArgumentException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid date filter. Please use YYYY-MM-DD."
            );

        } catch (SQLException e) {

            throw new ServletException(
                    "Unable to load audit logs.", e
            );
        }
    }
}
