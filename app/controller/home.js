'use strict';

const Controller = require('egg').Controller;
const Redis = require('ioredis')

class HomeController extends Controller {
  async index() {
    const { ctx } = this;
    // ctx.body = await this.service.admin.findAccount();
    // ctx.body = this.app.config.crypto
    // await this.service.redis.set('123', '123')
    // ctx.body = await this.service.redis.get('123')
    // ctx.session.userInfo = "123"
    ctx.body = ctx.session
    // ctx.body = 123;
  }
}

module.exports = HomeController;
