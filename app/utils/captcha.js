const captcha = require('svg-captcha')

module.exports = function createCode() {
    return captcha.create({
        size: 4,
        ignoreChars: "0o1iIl",
        height:47,
        noise: 3,
        color: true,
        background: '#fff',
        fontSize: 60
    })
}