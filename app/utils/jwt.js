/**
 * token的操作
 */
const { sign, verify } = require('jsonwebtoken')
const { readFileSync } = require('fs')
const { join } = require("path")

module.exports = class Jwt {
    constructor(data) {
        this.data = data
    }

    generateToken() {
        const data = this.data
        const created = Math.floor(Date.now() / 1000)
        // 读取密钥文件
        const cert = readFileSync(join(__dirname, '../../private_key.pem'));
        //生成token
        const token = sign({ data, exp: created + 60 * 30 }, cert, { algorithm: 'RS256' })
        return token
    }

    verifyToken() {
        const token = this.data
        const cert = readFileSync(join(__dirname, '../../private_key.pem'))
        let res;
        try {
            const result = verify(token, cert, { algorithms: "RS256" })
            const { exp = 0 } = result;
            const current = Math.floor(Date.now() / 1000)
            if (current <= exp) {
                res = result.data || {}
            }
        } catch (error) {
            res = 0
        }
        return res
    }

}