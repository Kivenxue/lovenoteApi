/**
 * 数据库 活动表(activity) 模型
 * 与 users 表建立 多对多 的关系 （即 多个用户 参与 多个活动）
 * 
 * @param {*} app 
 */

module.exports = app => {
    const { STRING, INTEGER, DATE } = app.Sequelize
    const Activity = app.model.define('activity', {
        id: { type: INTEGER, primaryKey: true },
        startTime: { type: DATE, },
        endTime: { type: DATE, },
        join_count: { type: INTEGER },
        cover: { type: STRING, }, // 活动封面图片
        content: { type: STRING }, // 活动内容
    })
    Activity.associate = function () {
        // 与 users 表是 多对多的关系
        app.model.Activity.belongsToMany(app.model.Users, {
            through: app.model.ActivityUsers,
            foreignKey: 'activity_id',
            otherKey: 'users_id'
        })
        // 与 comment 表是 一多对的关系
        app.model.Activity.hasMany(app.model.Comment, { foreignKey: 'activity_id', targetKey: 'id' })
    }
    return Activity
}