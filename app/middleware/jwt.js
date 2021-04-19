/**验证token的中间件 */
const Jwt = require('../utils/jwt')
/**
 * @param {*} options 
 * @returns 
 */

module.exports = options => {
    return async function (ctx, next) {
        // 不需要校验token
        const whiteList = ['/admin/login']
        // 获取header中的token
        const url = ctx.url
        // 不需要验证 token
        if (whiteList.indexOf(url) === -1) {
            const token = ctx.request.header.Authorization;
            
        }
        await next();
    }
}