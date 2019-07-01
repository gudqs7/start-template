package cn.gudqs.business.test.service.impl;

import cn.gudqs.base.CommonServiceImpl;
import cn.gudqs.business.test.entity.WechatKeywordModel;
import cn.gudqs.business.test.mapper.WechatKeywordMapper;
import cn.gudqs.business.test.service.IWechatKeywordService;
import org.jboss.logging.Logger;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

/**
 * @author generate by guddqs
 * @date 2019/05/23 16:50:39
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class WechatKeywordServiceImpl extends CommonServiceImpl<WechatKeywordModel, WechatKeywordMapper> implements IWechatKeywordService {

    private Logger logger = Logger.getLogger(WechatKeywordServiceImpl.class);

    @Resource
    private WechatKeywordMapper wechatKeywordMapper;


}
