const { Service } = require('egg')
const { Op } = require('sequelize')
class UsersService extends Service {
    constructor(app) {
        super(app);
        this.UsersModel = this.app.model.Users;
        this.BlackListModel = this.app.model.BlackList
    }
    // 查询
    async list(page = 1, where = {}) {
        const limit = 10;
        const offset = (page - 1) * limit
        const { id, account } = where
        if (id) {
            where = { id }
        } else if (account) {
            // 套娃 ( account like '%?%' or nickname like '%?%')
            where = { [Op.or]: [{ account: { [Op.like]: `%${account}%` } }, { nickname: { [Op.like]: `%${account}%` } }] }
        } else {
            where = {}
        }
        const res = await this.UsersModel.findAndCountAll({
            include: [{ model: this.BlackListModel }, { model: this.UsersModel }],
            offset,
            limit,
            where,
        })
        return res
    }
    // 查询一条数据 渲染单行用
    async findOne(id) {
        const res = this.UsersModel.findOne({
            include: [{ model: this.BlackListModel }, { model: this.UsersModel }],
            where: { id }
        })
        return res
    }
    // 将某人列入黑名单
    async blackListed(data) {
        // 获取数据
        const { admin_id, uid, reason, endAt } = data
        const res = this.BlackListModel.create({
            createAt: Date.parse(new Date()) / 1000,
            admin_id, uid, reason,
            endAt: endAt != 0 ? parseInt(new Date().setDate(new Date().getDate() + endAt) / 1000) : 0
        })
        return res
    }
    // 移除黑名单
    async removeBlackList(id) {
        const res = this.BlackListModel.destroy(
            {
                where: { uid: id, endAt: { [Op.not]: 0 } }
            }
        )
        return res
    }
}
module.exports = UsersService