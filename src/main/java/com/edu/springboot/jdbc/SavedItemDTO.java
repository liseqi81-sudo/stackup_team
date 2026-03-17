package com.edu.springboot.jdbc;

import lombok.Data;

@Data
public class SavedItemDTO {
    private int savedId;      // SAVED_ID
    private String userId;    // USER_ID
    private String targetType;// TARGET_TYPE
    private String targetId;     // TARGET_ID
    private String targetName;
}
