'use strict';

module.exports = app => {
  const { controller, router } = app;
  router.post('/admin/login', controller.admin.admin.login);// 登录
  router.post('/admin/logout', controller.admin.admin.logout)

  router.get('/admin/captcha/code', controller.admin.captcha.sendCaptchaCode);// 图片验证码
  router.post('/admin/captcha/check', controller.admin.captcha.checkCaptchaCode);// 验证图片验证码

  router.get('/admin/user/list', controller.admin.users.getData)// 获取数据
  router.get('/admin/user/list/one', controller.admin.users.getOneData)// 获取一条数据 渲染单行用
  router.post('/admin/user/ban', controller.admin.users.setBlackList) // 设置黑名单
  router.post('/admin/user/removeban', controller.admin.users.removeBan) // 移除黑名单

  router.get('/admin/community/list', controller.admin.community.index) // 获取文章
  
  router.post('/admin/file/upload',controller.admin.files.upload) // 文件上传
};
