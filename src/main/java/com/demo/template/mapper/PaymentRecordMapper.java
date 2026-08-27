package com.demo.template.mapper;

import com.mybatisflex.core.BaseMapper;
import com.demo.template.model.entity.PaymentRecord;
import org.apache.ibatis.annotations.Mapper;

/**
 * 支付记录 Mapper
 *
 */
@Mapper
public interface PaymentRecordMapper extends BaseMapper<PaymentRecord> {
}
