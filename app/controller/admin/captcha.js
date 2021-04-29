const BaseController = require('../../base/controller')
const createCode = require('../../utils/captcha')

class CaptchController extends BaseController {
    // 向前端发送图片验证码
    async sendCaptchaCode() {
        const { ctx } = this
        const { data, text } = createCode()// 生成验证码
        const key = Math.random().toString(36).slice(-4)
        this.service.redis.set(key, text.toLocaleLowerCase(), 120000)
        ctx.set('content-type', 'image/svg+xml')
        this.success({ data, key })
    }
    // 验证图片验证码
    async checkCaptchaCode() {
        const { key, value } = this.fetchData()
        const captchCode = await this.service.redis.get(key)
        if (captchCode !== value) {
            return this.error('验证码错误')
        }
        return this.success(1)
    }
}
module.exports = CaptchController