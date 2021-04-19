/**
 * 活动 与 用户 为多对多的关系
 */
module.exports = app => {
    const { INTEGER } = app.Sequelize
    const ActivityUsers = app.model.define('activity_users', {
        activity_id: { type: INTEGER, primaryKey: true },
        users_id: { type: INTEGER, primaryKey: true }
    })
    return ActivityUsers
}