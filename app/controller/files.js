const BaseController = require('../base/controller')
const path = require('path')
const fs = require('fs')

// 异步二进制 写入流
const awaitWriteStream = require('await-stream-ready').write
// 异步二进制 读取流
const awaitReadStream = require('await-stream-ready').read
// 管道读入一个虫洞
const sendToWormhole = require('stream-wormhole')
// 获取当前天数
const dayjs = require('dayjs')


// 文件上传
class FilesController extends BaseController {
    async upload() {

        const stream = await this.ctx.getFileStream();
        // 基础的目录
        const uplaodBasePath = 'app/public';
        // 生成文件名
        const filename = `${Date.now()}-${path.extname(stream.filename).toLocaleLowerCase()}`;
        // 生成文件夹
        const dirname = dayjs(Date.now()).format('YYYY/MM/DD');
        function mkdirsSync(dirname) {
            if (fs.existsSync(dirname)) {
                return true;
            } else {
                if (mkdirsSync(path.dirname(dirname))) {
                    fs.mkdirSync(dirname);
                    return true;
                }
            }
        }
        mkdirsSync(path.join(uplaodBasePath, dirname));
        // 生成写入路径
        const target = path.join(uplaodBasePath, dirname, filename);
        // 写入流
        const writeStream = fs.createWriteStream(target);
        try {
            //异步把文件流 写入
            await awaitWriteStream(stream.pipe(writeStream));
        } catch (err) {
            //如果出现错误，关闭管道
            await sendToWormhole(stream);
            this.error();
        }
        this.success({ url: path.join('/public/video', dirname, filename) });
    }
}
module.exports = FilesController