+function () {
    commonDefine(['layer', 'grid', 'form', 'ztree'], 'userAuth', {
        init: function ($this, $options) {
            _$this = $this;
            _$options = $options;
            init();
        }
    });
    var _$this, _$options, grid;
    var $ = layui.jquery, common = layui.common;
    var _sysRoleId;

    var doMenu = function (url, id) {
        request.post({
            url: url,
            async: false,
            data: {
                sysMenuId: id,
                sysRoleId: _sysRoleId
            },
            success: function (res) {
                if (res.success) {
                    $.tip.success('操作成功');
                } else {
                    $.tip.error(res.result);
                }
            }
        })
    };

    var doOperation = function (url, id) {
        request.post({
            url: url,
            async: false,
            data: {
                sysAuthId: id,
                sysRoleId: _sysRoleId
            },
            success: function (res) {
                if (res.success) {
                    $.tip.success('操作成功');
                } else {
                    $.tip.error(res.result);
                }
            }
        })
    };

    var loadAuth = function (sysRoleId) {
        var operationData = {};
        request.post({
            url: 'admin/auth/findByRole',
            data: {
                sysRoleId: sysRoleId
            },
            async: false,
            success: function (res) {
                if (res.success) {
                    operationData = res.data;
                }
            }
        });
        return operationData;
    };

    var loadMenu = function (sysRoleId) {
        var menuData = {};
        request.post({
            url: 'admin/auth/findMenu',
            async: false,
            data: {
                sysRoleId: sysRoleId
            },
            success: function (res) {
                if (res.success) {
                    menuData = res.data;
                }
            }
        });
        return menuData;
    };

    var renderAuth = function (menu, auth, $body) {
        $body.find('.menu-item').removeClass('active');
        $body.find('.operation-item').removeClass('active');
        $body.find('input[type=checkbox]').each(function () {
            this.checked = false;
        });
        menu = common.convertData2Map(menu, 'sysMenuId');
        auth = common.convertData2Map(auth, 'sysAuthId');
        $body.find('.menu-item').each(function () {
            var $menu = $(this);
            var id = $menu.data('id');
            if (menu.hasOwnProperty(id)) {
                $menu.addClass('active');
            }
        });
        $body.find('.operation-item').each(function () {
            var $operation = $(this);
            var id = $operation.data('id');
            if (auth.hasOwnProperty(id)) {
                $operation.addClass('active');
            }
        });
        $body.find('input[type=checkbox]').each(function () {
            var $input = $(this);
            var menuLength = $input.parent().find('.menu-item').length;
            var menuActiveLength = $input.parent().find('.menu-item.active').length;
            var operationLength = $input.parent().find('.operation-item').length;
            var operationActiveLength = $input.parent().find('.operation-item.active').length;
            if (menuLength <= menuActiveLength && operationActiveLength >= operationLength) {
                this.checked = true;
            }
        });
        layui.form.render();
        var $liFirst = $body.find('.menu-list li:first');
        $liFirst.removeClass('close');
        $liFirst.find('span.title:first i').removeClass('layui-icon-right').addClass('layui-icon-down');
        $liFirst.find('.menu-list li:first').removeClass('close');
        $liFirst.find('.menu-list li:first').find('span.title:first i').removeClass('layui-icon-right').addClass('layui-icon-down');
    };

    var init = function () {
        var $operation = _$this.find('.user-menu-operation');

        grid = _$this.find('.user-list').grid({
            url: 'admin/role/find',
            idField: 'sysRoleId',
            afterLoad: function (that) {
                that.$body.find('table tbody tr:eq(0)').click();
            },
            doubleClick: function (tr, record) {
                openModal(record, function ($modal) {

                });
            },
            callback: function (tr, record, that) {
                if (tr) {
                    _$this.find('.user-list').removeClass('layui-col-md12').addClass('layui-col-md6');

                    var userMenu = loadMenu((record.sysRoleId));
                    var userAuth = loadAuth((record.sysRoleId));
                    _sysRoleId = record.sysRoleId;

                    $operation.find('.user-nick-name').text(record.roleName);

                    renderAuth(userMenu, userAuth, $operation);

                    $operation.show();
                }
            },
            columns: [
                {
                    text: '角色名',
                    dataIndex: 'roleName'
                }, {
                    text: '操作',
                    dataIndex: '',
                    renderer: function () {
                        return $('<span class="my-link">点击管理权限</span>');
                    }
                }
            ]
        });

        var operationTextMap = {
            'find': '查看列表',
            'add': '新增',
            'delete': '删除',
            'update': '修改',
            'addMenu': '可添加菜单权限',
            'findMenu': '可查看菜单',
            'delMenu': '可删除菜单权限',
            'findLoginUser': '可查看用户列表'
        };

        var getOperationTextMap = function (menu) {
            var textMap0 = {};
            if (menu) {
                var url = menu.menuUrl;
                var resourceUrl = webConfig.appDir + url + ".json?v=" + window.__version;
                $.ajax({
                    url: resourceUrl,
                    async: false,
                    dataType: 'json',
                    success: function (res) {
                        textMap0 = res;
                    }
                });
            }
            return $.extend({}, operationTextMap, textMap0);
        };

        var getMenu = function (menu) {
            var menuLi = '<li class="close"> <span class="title"> <i class="layui-icon layui-icon-right"></i> </span> &ensp; <input type="checkbox" lay-skin="primary"><span class="menu-item" data-id="' + menu.sysMenuId + '"> ' + menu.menuText + '</span>';

            if (operationData.hasOwnProperty(menu.sysMenuId)) {
                menuLi += '<ul class="operation-list">';
                var textMap = getOperationTextMap(menuIdMap[menu.sysMenuId]);
                $.each(operationData[menu.sysMenuId], function (code, operation) {
                    var operationText = textMap[operation.code];
                    operationText = operationText || operation.code;
                    menuLi += ('<li class="operation-item" data-id="' + operation.sysAuthId + '">' + (operationText) + '</li>');
                });
                menuLi += '</ul>'
            }

            menuLi += '</li>';

            return menuLi;
        };

        var getOperationMenu = function (menu) {

            if (menu.openType !== -1) {
                return getMenu(menu);
            }

            var menuList = '';

            if (menu.children && menu.children.length > 0) {
                menuList += ('<li class="close"> <span class="title"> <i class="layui-icon layui-icon-right"></i> </span> &ensp; <input type="checkbox" lay-skin="primary" ><span class="menu-item" data-id="' + menu.sysMenuId + '"> ' + menu.menuText + '</span>');
                menuList += '<ul class="menu-list">';
                for (var i = 0; i < menu.children.length; i++) {
                    var child = menu.children[i];
                    menuList += getOperationMenu(child);
                }
                menuList += '</ul>';
                menuList += '</li>';
            }

            return menuList;
        };

        var bindEvent = function () {
            layui.form.render();
            $operation.find('.menu-list li .title').click(function () {
                var $parent = $(this).parent();
                var hasClose = $parent.hasClass('close');
                if (hasClose) {
                    $(this).find('i').removeClass('layui-icon-right').addClass('layui-icon-down');
                    $parent.removeClass('close');
                } else {
                    $(this).find('i').removeClass('layui-icon-down').addClass('layui-icon-right');
                    $parent.addClass('close');
                }
            });
            $operation.find('.menu-item').click(function () {
                var $menu = $(this);
                var id = $menu.data('id');
                var has = $menu.hasClass('active');
                if (has) {
                    $menu.removeClass('active');
                    doMenu('admin/auth/delMenu', id);
                } else {
                    $menu.addClass('active');
                    doMenu('admin/auth/addMenu', id);
                }

            });
            $operation.find('.operation-item').click(function () {
                var $operation = $(this);
                var id = $operation.data('id');
                var has = $operation.hasClass('active');
                if (has) {
                    $operation.removeClass('active');
                    doOperation('admin/auth/delete', id);
                } else {
                    $operation.addClass('active');
                    doOperation('admin/auth/add', id);
                }
            });
            layui.form.on('checkbox', function (e) {
                var nowStatus = e.elem.checked;
                var $input = $(e.elem);
                $input.parent().find('input[type=checkbox]').each(function () {
                    this.checked = nowStatus;
                });
                layui.form.render();
                var $menuItems = $input.parent().find('.menu-item');
                var $operations = $input.parent().find('.operation-item');
                $menuItems.each(function () {
                    var id = $(this).data('id');
                    var has = $(this).hasClass('active');
                    if (nowStatus) {
                        if (!has) {
                            $(this).addClass('active');
                            doMenu('admin/auth/addMenu', id);
                        }
                    } else {
                        if (has) {
                            $(this).removeClass('active');
                            doMenu('admin/auth/delMenu', id);
                        }
                    }
                });
                $operations.each(function () {
                    var id = $(this).data('id');
                    var has = $(this).hasClass('active');
                    if (nowStatus) {
                        if (!has) {
                            $(this).addClass('active');
                            doOperation('admin/auth/add', id);
                        }
                    } else {
                        if (has) {
                            $(this).removeClass('active');
                            doOperation('admin/auth/delete', id);
                        }
                    }
                });
            })
        };

        var menuAll = loadMenu();
        var operationData = loadAuth();
        operationData = common.dataGroup(operationData, 'sysMenuId', 'code');
        menuAll = common.convertData2Tree(menuAll, 'sysMenuId', 'parentId');
        var menuLi = '<ul class="menu-list">';
        for (var i = 0; i < menuAll.length; i++) {
            var obj = menuAll[i];
            menuLi += getOperationMenu(obj);
        }
        $operation.find('.menu-container').empty().append(menuLi + "</ul>");
        bindEvent();

        layui.form.render();
        initEvent();
    };


    var openModal = function (_data, callback) {
        var content = $.loadTemplate({
            url: 'userAuth/edit',
            data: _data
        });

        var title = '添加 系统角色';
        if (_data) {
            title = '修改 系统角色';
        }

        $.modal({
            title: title,
            width: 350,
            height: 210,
            content: content,
            open: function ($modal) {
                if (callback) {
                    callback($modal);
                }
                layui.form.render();
            },
            ok: function ($modal, close) {
                var data = $modal.find('.role-form').serializeArray().toModel();
                if (_data) {
                    data.sysRoleId = _data.sysRoleId;
                }
                request.post({
                    url: 'admin/role/add',
                    data: data,
                    callback: function (data) {
                        $.tip.success('保存成功!');
                        grid.refresh();
                        close();
                    }
                });
            }
        })
    };

    var initEvent = function () {
        _$this.find('.btn-add').click(function () {
            openModal();
        });

        _$this.find('.btn-delete').click(function () {
            common.delete({
                url: 'admin/role/delete',
                grid: grid
            })
        });

    };

}();