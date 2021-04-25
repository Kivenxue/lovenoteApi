'use strict';

module.exports = app => {
  const { controller, router } = app;
  router.get('/', controller.home.index);
  router.post('/admin/login', controller.admin.login);// 登录
  router.post('/admin/logout', controller.admin.logout)

  router.get('/admin/captcha/code', controller.captcha.sendCaptchaCode);// 图片验证码
  router.post('/admin/captcha/check', controller.captcha.checkCaptchaCode);// 验证图片验证码

  router.get('/admin/user/list', controller.users.getData)// 获取数据
  router.get('/admin/user/list/one', controller.users.getOneData)// 获取一条数据 渲染单行用
  router.post('/admin/user/ban', controller.users.setBlackList) // 设置黑名单
  router.post('/admin/user/removeban', controller.users.removeBan) // 移除黑名单

  // router.get('/admin/community/list')
};
