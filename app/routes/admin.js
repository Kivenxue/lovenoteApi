'use strict';

module.exports = app => {
  const { controller, router } = app;
  router.get('/', controller.home.index);
  router.post('/admin/login', controller.admin.login);// 后端登录
};
