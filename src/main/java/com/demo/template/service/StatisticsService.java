package com.demo.template.service;

import com.demo.template.model.vo.StatisticsVO;

/**
 * 统计服务
 *
 */
public interface StatisticsService {

    /**
     * 获取系统统计数据
     *
     * @return 统计数据
     */
    StatisticsVO getStatistics();
}
