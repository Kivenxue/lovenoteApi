'use strict';

module.exports = app => {
  const { controller, router } = app;
  router.get('/', controller.home.index);
  router.post('/admin/login', controller.admin.login);// 登录
  router.post('/admin/logout', controller.admin.logout)
  router.get('/admin/captcha/code', controller.captcha.sendCaptchaCode);// 图片验证码
};
