const BaseController = require('../base/controller');
const Crypto = require('../utils/crypto')
const Jwt = require('../utils/jwt')

class AdminController extends BaseController {
    constructor(app) {
        super(app);
    }
    async login() {
        let { account, password } = this.fetchData()
        password = new Crypto().encrypt(password)
        try {
            let res = await this.service.admin.findAccount(account)
            if (res && res.password == password) {
                // 生成 token
                const token = (new Jwt(res.account).generateToken())
                delete res.password // 删除密码返回给前端
                this.success({ token, userInfo: res }, '登录成功')
            } else {
                this.error('登录失败名，请检查您的用户名与密码')
            }
        } catch (error) {
            this.error('网络原因，登录失败')
        }

    }
}

module.exports = AdminController;

