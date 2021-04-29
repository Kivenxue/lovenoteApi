const BaseController = require('../../base/controller');

class CommunityController extends BaseController {
    async index() {
        const res = await this.service.community.list();
        this.ctx.body = res
    }
}

module.exports = CommunityController;
