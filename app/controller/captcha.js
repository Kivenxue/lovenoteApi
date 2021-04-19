const BaseController = require('../base/controller')
const createCode = require('../utils/captcha')

class CaptchController extends BaseController {
    // 向前端发送图片验证码
    async sendCaptchaCode() {
        const { ctx } = this
        let { text, data } = createCode()// 生成验证码
        if (this.service.redis.get('captchaCode')) { this.service.redis.del('captchaCode') }
        await this.service.redis.set('captchaCode', text.toLocaleLowerCase(), 120000)
        ctx.set('content-type', 'image/svg+xml')
        this.success(data)
    }
}
module.exports = CaptchController