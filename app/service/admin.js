const { Service } = require('egg')

class AdminService extends Service {
    constructor(app) {
        super(app)
        this.model = app.model;
    }

    /**
     * 查找用户名
     * @param {String} account 用户名
     */
    async findAccount(account) {
        const res = await this.model.Admin.findOne({
            where: { account }
        });
        return res
    }
}
module.exports = AdminService