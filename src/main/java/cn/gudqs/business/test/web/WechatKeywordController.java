package cn.gudqs.business.test.web;

import cn.gudqs.base.BaseController;
import cn.gudqs.base.ParamVo;
import cn.gudqs.base.ResultBean;
import cn.gudqs.business.test.entity.WechatKeywordModel;
import cn.gudqs.business.test.service.IWechatKeywordService;
import cn.gudqs.exception.ExceptionVo;
import cn.gudqs.util.DateUtils;
import cn.gudqs.util.StringUtil;
import io.swagger.annotations.Api;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.List;


/**
 * @author generate by guddqs
 * @date 2019/05/23 12:13:09
 */
@RestController
@RequestMapping("/admin/wechat/keyword")
@Api(description = "WechatKeywordController")
public class WechatKeywordController extends BaseController {

    @Resource
    private IWechatKeywordService wechatKeywordService;

    @PostMapping("/find")
    public ResultBean<List<WechatKeywordModel>> find(@RequestBody ParamVo paramVo) throws Exception {
        paramVo.desc("updateTime");
        return success(wechatKeywordService.findAll(paramVo));
    }

    @PostMapping("/update")
    public ResultBean update(WechatKeywordModel keywordModel) throws Exception {
        wechatKeywordService.updateSelective(keywordModel);
        return success();
    }

    @PostMapping("/add")
    public ResultBean add(WechatKeywordModel keywordModel, String oldKeyword, Integer oldMatchType) throws Exception {
        String keyword = keywordModel.getKeyword();
        if (StringUtil.isBlank(keyword)) {
            return error(MyError.EMPTY_KEYS);
        }
        if (!keyword.equals(oldKeyword) || !keywordModel.getMatchType().equals(oldMatchType)) {
            WechatKeywordModel model = wechatKeywordService.selectOne(new WechatKeywordModel(keyword, keywordModel.getMatchType()));
            if (model != null) {
                return error(MyError.TOO_MORE_KEYS);
            }
        }

        if (keywordModel.getKeywordId() != null) {
            keywordModel.setUpdateTime(DateUtils.getNowDate());
            wechatKeywordService.updateSelective(keywordModel);
        } else {
            if (keywordModel.getStatus() == null) {
                keywordModel.setStatus(1);
            }
            keywordModel.setUpdateTime(DateUtils.getNowDate());
            wechatKeywordService.insertSelective(keywordModel);
        }
        return success();
    }

    @PostMapping("/delete")
    public ResultBean delete(@RequestBody Object[] ids) throws Exception {
        wechatKeywordService.delete(ids);
        return success();
    }

    private interface MyError {
        ExceptionVo TOO_MORE_KEYS = new ExceptionVo(10001, "同一匹配类型下不可有多个相同关键词");
        ExceptionVo EMPTY_KEYS = new ExceptionVo(10002, "请输入关键词");
    }

}