package com.edu.springboot.jdbc;

import lombok.Data;

@Data
public class SocialLinkDTO {
    private String label;
    private String url;
    private String icon;

    public String getLabel() { return label; }
    public void setLabel(String label) { this.label = label; }

    public String getUrl() { return url; }
    public void setUrl(String url) { this.url = url; }

    public String getIcon() { return icon; }
    public void setIcon(String icon) { this.icon = icon; }
}