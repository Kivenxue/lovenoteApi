/**验证token的中间件 */
const Jwt = require('../utils/jwt')

module.exports = options => {
    return async function (ctx, next) {
        // 不需要校验token
        const whiteList = []
        // 获取header中的token
        const token = ctx.request.header.Authorization;
        const url = ctx.url
        console.log(url);
        // console.log(token);
        await next()
        // 请求方式
        // const method
    }
}