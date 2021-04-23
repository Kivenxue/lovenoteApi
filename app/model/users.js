/**
 * 数据库 用户表(users) 数据模型
 * id 与 myfollow 建立一对多 的关系 即（一位用户 关注 多个用户）,
 * id 与 loverid   建立 一对一 的关系 即（一位用户 只能有 一个爱人）
 * 
 */
module.exports = app => {
    const { BOOLEAN, INTEGER, STRING, DATE, DOUBLE } = app.Sequelize
    const Users = app.model.define('users', {
        id: { type: INTEGER, primaryKey: true },
        account: { type: STRING },
        password: { type: STRING },
        avatar: { type: STRING },
        nickname: { type: STRING },
        sex: {
            type: BOOLEAN, get() {
                if (this.getDataValue('sex')) {
                    return '男'
                } else {
                    return '女'
                }
            }
        },
        state: {
            type: BOOLEAN, get() {
                if (this.getDataValue('state')) {
                    return '在线'
                } else {
                    return '离线'
                }
            }
        },
        loverid: { type: INTEGER, },
        pay: { type: DOUBLE },
        isvip: { type: BOOLEAN },
        lovetime: { type: DATE },
        myfollow: { type: INTEGER },
    })
    Users.associate = function () {
        // 与 活动表 建立的 多对多 关系
        app.model.Users.belongsToMany(app.model.Activity, {
            through: app.model.ActivityUsers,
            foreignKey: 'users_id',
            otherKey: 'activity_id'
        })
        // 与 黑名单 建立 一对多 关系
        app.model.Users.hasOne(app.model.BlackList, { foreignKey: 'uid' })
        // 与 评论 表建立的 一对一 关系
        app.model.Users.hasOne(app.model.Comment, { foreignKey: 'uid' })
        // 与 社区帖子 建立 一对多 关系
        app.model.Users.hasMany(app.model.Community, { foreignKey: 'uid', targetKey: 'id' })
        // 与 自身 的loverid 建立 一对一的关系
        app.model.Users.hasOne(app.model.Users, { foreignKey: 'loverid' })
        // 与 自身 的myfollow 建立 一对多的关系
        app.model.Users.hasMany(app.model.Users, { foreignKey: 'myfollow', targetKey: 'id' })
    }
    return Users
}