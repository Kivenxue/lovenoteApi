const BaseController = require('../base/controller')

class UsersController extends BaseController {
    constructor(app) {
        super(app)
    }
    // 获取数据并返回给前端
    async getData() {
        const { page, where } = this.fetchData()
        const res = await this.service.users.list(page, where)
        this.success(res)
    }
    // 获取一条用户信息
    async getOneData() {
        const { id } = this.fetchData()
        const res = await this.service.users.findOne(id)
        this.success(res)
    }
    // 封禁用户
    async setBlackList() {
        const data = this.fetchData()
        try {
            await this.service.users.blackListed(data)
            this.success(1, '封禁成功')
        } catch (error) {
            this.error('非法请求')
        }
    }
    // 移除黑名单
    async removeBan() {
        const id = this.fetchData()
        try {
            const res = await this.service.users.removeBlackList(id);

            if (res) {
                return this.success(res, '解封成功')
            }
            return this.error('解封失败')
        } catch (error) {
            this.error("非法请求")
        }
    }
}
module.exports = UsersController