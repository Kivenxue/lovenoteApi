'use strict';

const Controller = require('egg').Controller;

class HomeController extends Controller {
  async index() {
    const { ctx } = this;
    // ctx.body = await this.service.admin.findAccount();
    ctx.body = this.app.config.crypto
    // ctx.body = 123;
  }
}

module.exports = HomeController;
