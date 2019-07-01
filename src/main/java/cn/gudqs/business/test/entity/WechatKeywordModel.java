package cn.gudqs.business.test.entity;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * @author wq
 * @date 2019-4-26
 * @description 公众号关键词回复表
 */
@Data
@Table(name = "wechat_keyword")
public class WechatKeywordModel {

    @Id
    @GeneratedValue(generator = "JDBC")
    private Integer keywordId;
    /**
     * 关键词
     */
    @ApiModelProperty("关键词")
    private String keyword;
    /**
     * 匹配方式: 1.完全等于 2.关键词包含用户输入 3.用户输入包含关键词
     */
    @ApiModelProperty("匹配方式: 1.完全等于 2.关键词包含用户输入 3.用户输入包含关键词")
    private Integer matchType;
    /**
     * 回复消息类型: 1.普通文本 2.可带小程序链接文本 3.图片 4.图文信息 5.小程序
     */
    @ApiModelProperty("回复消息类型: 1.普通文本 2.可带小程序链接文本 3.图片 4.图文信息 5.小程序")
    private Integer replyType;
    /**
     * 回复内容, json 格式
     */
    @ApiModelProperty("回复内容, json 格式")
    private String replyData;
    /**
     * 更新时间
     */
    @ApiModelProperty("更新时间")
    private String updateTime;
    /**
     * 0|1
     */
    @ApiModelProperty("0|1")
    private Integer status;
    /**
     * 备注
     */
    private String memo;

    public WechatKeywordModel() {
    }

    public WechatKeywordModel(String keyword, Integer matchType) {
        this.keyword = keyword;
        this.matchType = matchType;
    }
}


