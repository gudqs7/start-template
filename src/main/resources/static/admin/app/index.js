+function () {

    var getMenuLi = function (menu, index) {

        if (menu.displayOrder < 0) {
            return '';
        }

        if (menu.openType !== -1) {
            return '<a class="menu-url-item" data-id="' + menu.sysMenuId + '" data-type="' + menu.openType + '" data-url="' + menu.menuUrl + '" href="javascript: void(0);">' + menu.menuText + '</a>';
        }

        var first = '';
        if (index === 0) {
            first = '  layui-nav-itemed';
        }
        var menuLi =
            '<li class="layui-nav-item' + first + '">' +
            '   <a class="" href="javascript:;">' + menu.menuText + '</a>';

        if (menu.children && menu.children.length > 0) {
            menuLi += '<dl class="layui-nav-child">';
            for (var i = 0; i < menu.children.length; i++) {
                var child = menu.children[i];
                first = '';
                if (index === 0 && i === 0) {
                    first = 'class="layui-this"';
                }
                menuLi +=
                    '<dd ' + first + '>' +
                    getMenuLi(child, i) +
                    '</dd>';
            }
            menuLi += '</dl>';
        }

        menuLi += '</li>';

        return menuLi;
    };

    var loadMenu = function (common) {
        request.post({
            url: 'admin/menu/findAll',
            async: false,
            success: function (res) {
                if (res.success) {
                    window.menuMap = common.convertData2Map(res.data, 'menuUrl');
                    window.menuIdMap = common.convertData2Map(res.data, 'sysMenuId');
                    var menuTree = window.menuTree = common.convertData2Tree(res.data, 'sysMenuId', 'parentId');
                    var menuLi = '';
                    for (var i = 0; i < menuTree.length; i++) {
                        var menu = menuTree[i];
                        if (menu.openType === -1) {
                            menuLi += getMenuLi(menu, i);
                        }
                    }
                    $('.admin-menu').empty().append(menuLi);

                }
            }
        })
    };

    var init = function (common) {
        loadMenu(common);

        // 处理用户信息
        var user = storage.get('user');
        if (user && user.nickName) {
            $('.admin-nick-name').text(user.nickName);
            $('.admin-avatar').attr('src', user.avatarUrl);
        }

        // 处理路径参数
        var url = $('.layui-this .menu-url-item').data('url');
        if (location.search !== '') {
            var jump = common.getParam(location.search, 'jump');
            if (jump && jump !== '') {
                url = jump;
                if (jump.indexOf('/') === -1) {
                    url = jump + '/' + jump;
                }
            }
        }
        if (!url) {
            url = 'userAuth/userAuth'
        }
        if (window.menuMap && window.menuMap.hasOwnProperty(url)) {
            var id = window.menuMap[url].sysMenuId;
            openPage({url: url, sysMenuId: id});
        } else {
            openPage({url: url});
        }

        initEvent();
    };

    var initEvent = function () {
        // 添加菜单点击事件, 打开模块
        $('.menu-url-item').on('click', function (e) {
            var url = $(this).data('url');
            var type = $(this).data('type');
            var id = $(this).data('id');
            if (!id) {
                if (window.menuMap && window.menuMap.hasOwnProperty(url)) {
                    id = window.menuMap[url].sysMenuId;
                }
            }
            openPage({url: url, type: type, sysMenuId: id});
        });

        // 登出, 清除 token 及用户数据
        $('.logout').on('click', function () {
            localStorage.removeItem('token');
            localStorage.removeItem('__token_time');
            localStorage.removeItem('user');
            openLoginPage();
        });

        // 更新 version
        $('.refresh-version').on('click', function () {
            var version = window.__version;
            version = version + 1;
            storage.set('__version__', version);
            location.reload();
        });
    };

    layui.define(function (exports) {
        exports('index', {
            init: init
        });
    });
}();