package cn.ghy.larva.dao;

import cn.ghy.larva.domain.File;

public interface FileMapper {
    int deleteById(Long fileId);

    int insert(File record);

    File selectById(Long fileId);

    int updateById(File record);
}