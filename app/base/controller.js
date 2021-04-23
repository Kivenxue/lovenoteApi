const { Controller } = require('egg');
const Crypto = require('../utils/crypto')


class BaseController extends Controller {
    get crypto() {
        return this.app.config.crypto
    }

    constructor(app) {

        super(app);
    }
    success(data, msg = '') {
        let res = { data, msg, code: '0000' };
        if (this.crypto) {
            res = new Crypto().encrypt(JSON.stringify(res))
        }
        return this.ctx.body = res
    }
    error(msg = "") {
        let res = { msg, code: '0001' };
        if (this.crypto) {
            res = new Crypto().encrypt(JSON.stringify(res))
        }
        return this.ctx.body = res
    }
    /** 从前端获取参数 */
    fetchData() {
        // 请求方式
        const methods = this.ctx.request.method
        let params;
        switch (methods.toLocaleUpperCase()) {
            case 'GET':
                params = this.ctx.query
                break;
            case 'PUT':
            case 'DELETE':
            case 'POST':
                params = this.ctx.request.body
                break;
        }
        // 是否需要解密参数
        if (this.crypto) {
            try {
                params = JSON.parse(new Crypto().decrypt(params.p))
            } catch (error) {
                params = new Crypto().decrypt(params.p)
            }
        }
        return params;
    }
}
module.exports = BaseController;
