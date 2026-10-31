package com.worksync.service;

import com.worksync.dao.AuditLogDAO;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public class AuditLogService {

    private final AuditLogDAO auditLogDAO = new AuditLogDAO();

    public void record(Integer userId,
                       String username,
                       String action,
                       String description,
                       String ipAddress) throws SQLException {

        if (username == null || username.trim().isEmpty()) {
            username = "Unknown";
        }

        if (action == null || action.trim().isEmpty()) {
            throw new IllegalArgumentException(
                    "Audit action is required."
            );
        }

        if (description != null && description.length() > 500) {
            description = description.substring(0, 500);
        }

        if (ipAddress != null && ipAddress.length() > 45) {
            ipAddress = ipAddress.substring(0, 45);
        }

        auditLogDAO.saveLog(
                userId,
                username,
                action,
                description,
                ipAddress
        );
    }

    public List<Map<String, Object>> getLogs(
            String search,
            String action,
            String startDate,
            String endDate) throws SQLException {

        return auditLogDAO.findLogs(
                search,
                action,
                startDate,
                endDate
        );
    }
}
