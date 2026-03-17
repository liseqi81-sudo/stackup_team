package com.edu.springboot.portfolio;

import java.util.Map;

public class PortfolioSnapshotUpdateRequest {

    private Integer portfolioId;
    private Map<String, Object> snapshotJson;

    public Integer getPortfolioId() {
        return portfolioId;
    }

    public void setPortfolioId(Integer portfolioId) {
        this.portfolioId = portfolioId;
    }

    public Map<String, Object> getSnapshotJson() {
        return snapshotJson;
    }

    public void setSnapshotJson(Map<String, Object> snapshotJson) {
        this.snapshotJson = snapshotJson;
    }
}