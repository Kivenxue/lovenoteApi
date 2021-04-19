'use strict';

module.exports = app => {
  const { controller, router } = app;
  router.get('/', controller.home.index);
  router.post('/admin/login', controller.admin.login);// 后端登录
  router.get('/admin/captcha/code',controller.captcha.sendCaptchaCode);// 图片验证码
};
