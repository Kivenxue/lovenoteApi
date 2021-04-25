/* eslint valid-jsdoc: "off" */

'use strict';

/**
 * @param {Egg.EggAppInfo} appInfo app info
 */
module.exports = appInfo => {
  /**
   * built-in config
   * @type {Egg.EggAppConfig}
   **/
  const config = exports = {
    // 跨域配置
    cors: {
      origin: '*',
      allowMethods: 'GET,HEAD,PUT,POST,DELETE,PATCH,OPTIONS',
      credentials: true,
    },
    // csrf
    security: {
      csrf: {
        enable: false,
      },
      domainWhiteList: ['*'],
    },
    // 数据库配置
    sequelize: {
      dialect: 'mysql', // support: mysql, mariadb, postgres, mssql
      database: 'lovenote',
      host: 'localhost',
      port: 3306,
      username: 'root',
      password: 'lemon123',
      define: {
        timestamps: false,
        freezeTableName: true
      }
    },
    // socket 配置
    io:{

    }
  };
  config.redisCluter = [
    {
      port: 7000,
      host: '127.0.0.1'
    }, {
      port: 7003,
      host: '127.0.0.1'
    }
  ],
    config.redis = {
      port: 6379,
      host: '127.0.0.1'
    }
  // use for cookie sign key, should change to your own and keep security
  config.keys = appInfo.name + '_1618476123471_4871';
  // crypto
  config.crypto = true;
  // add your middleware config here
  config.middleware = ['jwt'];

  // add your user config here
  const userConfig = {
    // myAppName: 'egg',
  };

  return {
    ...config,
    ...userConfig,
  };
};
