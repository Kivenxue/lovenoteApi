const Redis = require('ioredis');
const { Service } = require('egg')
class RedisService extends Service {
    constructor(app) {
        super(app)
        try {
            this.redis = new Redis.Cluster(this.config.redisCluter)
        } catch (error) {
            try {
                this.redis = new Redis(this.config.redis)
            } catch (error) {
                throw new Error('redis配置错误，请检查redis配置')
            }
        }
    }
    async set(key, val, maxAge = 0) {
        if (!maxAge) {
            maxAge = 24 * 60 * 60 * 1000;
        }
        this.redis.set(key, val)
        this.redis.expire(key, maxAge)
    }
    async get(key) {
        if (!key) return null;
        return await this.redis.get(key)
    }
    async del(key) {
        if (!key) return null
        return await this.redis.del(key)
    }
}

module.exports = RedisService