'use strict';

/** @type Egg.EggPlugin */
module.exports = {
  // had enabled by egg
  // static: {
  //   enable: true,
  // }
  /** 跨域 */
  cors: {
    enable: true,
    package: 'egg-cors',
  },
  /** egg-sequelize */
  sequelize: {
    enable: true,
    package: 'egg-sequelize',
  },
  io: {
    enable: true,
    package: 'egg-socket.io'
  }

};
