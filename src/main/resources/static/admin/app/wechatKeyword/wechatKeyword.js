+function () {
    var moduleName = 'wechatKeyword';
    var moduleReqUrlPrefix = 'admin/wechat/keyword/';
    var moduleDesc = '关键词';
    var idField = 'keywordId';

    commonDefine([].concat(window.commonRequireArray), moduleName, {
        init: function ($this, $options) {
            init($this, $options);
        }
    });

    var $ = layui.jquery, common = layui.common;

    var init = function (_$this, _$options) {
        var statusMap = {
            '0': '未启用',
            '1': '已启用'
        };
        var typeMap = {
            '1': '完全等于',
            '2': '关键词包含输入',
            '4': '匹配扫码事件',
            '5': '匹配菜单点击及关注事件',
            '3': '输入包含关键词'
        };

        var replyTypeMap = {
            '1': '普通文字',
            '2': '含小程序文字',
            '3': '图片',
            '5': '小程序卡片',
            '4': '图文链接'
        };

        var grid = _$this.find('.banner-list').grid({
            url: moduleReqUrlPrefix + 'find',
            idField: idField,
            afterLoad: function () {
                layui.form.on('switch', function (data) {
                    var checked = data.elem.checked;
                    var id = data.elem.dataset.id;

                    $.confirm({
                        title: '确认变更状态吗?'
                    }, function () {
                        var statusData = {
                            status: checked ? 1 : 0
                        };
                        statusData[idField] = id;
                        request.post({
                            url: moduleReqUrlPrefix + 'update',
                            data: statusData,
                            success: function (res) {
                                if (res.success) {
                                    $.tip.success('修改成功');
                                }
                            }
                        });
                    }, function () {
                        data.elem.checked = !data.elem.checked;
                        layui.form.render();
                    });
                });
            },
            doubleClick: function (tr, record) {
                openModal(grid, record, function ($modal) {
                    if (record.replyType === 2) {
                        record.replyType = 1;
                    }
                    $modal.find('select[name=replyType]').val(record.replyType);
                    $modal.find('select[name=matchType]').val(record.matchType);
                });
            },
            columns: [
                {
                    text: '关键词',
                    dataIndex: 'keyword'
                }, {
                    text: '备注',
                    dataIndex: 'memo'
                }, {
                    text: '匹配类型',
                    dataIndex: 'matchType',
                    renderer: function (data) {
                        return typeMap[data];
                    },
                    filter: {
                        type: 'radio',
                        store: common.convertMap2Store(typeMap)
                    }
                }, {
                    text: '回复类型',
                    dataIndex: 'replyType',
                    renderer: function (data) {
                        return replyTypeMap[data];
                    },
                    filter: {
                        type: 'radio',
                        store: common.convertMap2Store(replyTypeMap)
                    }
                }, {
                    text: '回复数据',
                    dataIndex: 'replyData',
                    renderer: function (data, record) {
                        if (record.replyType < 3) {
                            var $span = $('<span>' + data + '</span>');
                            $span.find('a').addClass('my-link');
                            $span.find('a').attr('target', '_blank');
                            $span.find('a[data-miniprogram-appid]').addClass('mini-link');
                            return $span;
                        } else {
                            var text = '';
                            if (record.replyType === 3) {
                                return $('<a target="_blank" href="' + data + '"><img src="' + data + '" width="100px" style="max-height: 100px;" /></a>');
                            }

                            var replyData = JSON.parse(record.replyData);
                            if (record.replyType === 4) {
                                text += ('图文标题: ' + replyData.newsTitle + '<br/>');
                                text += ('图文详细: ' + replyData.newsDesc + '<br/>');
                                text += ('图文链接: ' + replyData.newsUrl + '<br/>');
                                text += ('图文缩略图: ' + replyData.newsPic + '<br/>');
                            }
                            if (record.replyType === 5) {
                                text += ('卡片标题: ' + replyData.miniTitle + '<br/>');
                                text += ('卡片预览图: ' + replyData.miniPic + '<br/>');
                                text += ('小程序 id: ' + replyData.miniAppId + '<br/>');
                                text += ('小程序路径: ' + replyData.miniPath + '<br/>');
                            }
                            return text;
                        }
                    }
                }, {
                    text: '状态',
                    dataIndex: 'status',
                    filter: {
                        type: 'radio',
                        store: common.convertMap2Store(statusMap)
                    },
                    renderer: function (data, record) {
                        var checked = data === 1 ? 'checked' : '';
                        return $('<input data-id="' + record[idField] + '" type="checkbox" name="status" ' + checked + ' lay-skin="switch">');
                    }
                }
            ]
        });

        initEvent(_$this, _$options, grid);
    };

    var openModal = function (grid, _data, callback) {
        if (_data) {
            if (_data.replyType >= 4) {
                var replyData = JSON.parse(_data.replyData);
                _data = $.extend({}, _data, replyData);
            }
        }

        var content = $.loadEditHTML(moduleName, _data);

        var title = '添加' + moduleDesc;
        if (_data) {
            title = '修改' + moduleDesc;
        }

        $.modal({
            title: title,
            width: 500,
            height: 550,
            content: content,
            open: function ($modal) {
                if (callback) {
                    callback($modal);
                }
                var changeType = function () {
                    var replyType = parseInt($modal.find('select[name=replyType]').val());
                    if (replyType === 1 || replyType === 2) {
                        $modal.find('.text-data').show();
                        $modal.find('.img-data').hide();
                        $modal.find('.news-data').hide();
                        $modal.find('.mini-data').hide();
                    } else if (replyType === 3) {
                        $modal.find('.img-data').show();
                        $modal.find('.text-data').hide();
                        $modal.find('.news-data').hide();
                        $modal.find('.mini-data').hide();
                    } else if (replyType === 4) {
                        $modal.find('.news-data').show();
                        $modal.find('.text-data').hide();
                        $modal.find('.img-data').hide();
                        $modal.find('.mini-data').hide();
                    } else if (replyType === 5) {
                        $modal.find('.mini-data').show();
                        $modal.find('.text-data').hide();
                        $modal.find('.img-data').hide();
                        $modal.find('.news-data').hide();
                    }
                };
                changeType();
                layui.form.on('select(replyType)', function (data) {
                    changeType();
                });
                $modal.find('.btn-insert-mini').click(function () {
                    $modal.find('textarea[name=replyData]').val($modal.find('textarea[name=replyData]').val() + "<a href='http://qq.com' data-miniprogram-appid='wx8e700f87f34fdd5d' data-miniprogram-path='pages/home/home'>点击进入小程序</a>");
                });
                layui.form.render();
            },
            ok: function ($modal, close) {
                var data = $modal.find('.banner-form').serializeArray().toModel();
                var replyType = parseInt(data.replyType);
                var replyData = null;

                if (replyType === 1) {
                    var $content = $('<span>' + data.replyData + '</span>');
                    if ($content.find('a[data-miniprogram-appid]').length > 0) {
                        data.replyType = 2;
                    }

                }
                if (replyType === 3) {
                    data.replyData = data.imgUrl;
                }
                if (replyType === 4) {
                    replyData = {
                        newsTitle: data.newsTitle,
                        newsDesc: data.newsDesc,
                        newsUrl: data.newsUrl,
                        newsPic: data.newsPic
                    }
                }
                if (replyType === 5) {
                    replyData = {
                        miniTitle: data.miniTitle,
                        miniPic: data.miniPic,
                        miniPath: data.miniPath,
                        miniAppId: data.miniAppId
                    }
                }
                if (replyData) {
                    data.replyData = JSON.stringify(replyData);
                }
                if (_data) {
                    data[idField] = _data[idField];
                    data.status = _data.status;
                    data.oldMatchType = _data.matchType;
                    data.oldKeyword = _data.keyword;
                }
                request.post({
                    url: moduleReqUrlPrefix + 'add',
                    data: data,
                    callback: function (data) {
                        $.tip.success('保存成功!');
                        grid.refresh();
                        close();
                    }
                })
            }
        })
    };
    var initEvent = function (_$this, _$options, grid) {
        _$this.find('.btn-add').click(function () {
            openModal(grid);
        });

        _$this.find('.btn-delete').click(function () {
            var checkedItems = grid.getCheckedItems('keyword');
            for (var i = 0; i < checkedItems.length; i++) {
                var checkedItem = checkedItems[i];
                if (checkedItem.indexOf('SYSTEM_') !== -1) {
                    $.tip.error('不能删除系统自带的哦!');
                    return false;
                }
            }
            common.delete({
                url: moduleReqUrlPrefix + 'delete',
                grid: grid
            })
        });

    };
}();