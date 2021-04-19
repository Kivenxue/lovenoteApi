/**
 * 数据库 评论表(comment) 数据模型
 * 与 活动表 建立 一对多的关系 (即 一场活动 对应 多个评论)
 * 与 社区表 建立 一对多的关系 (即 一篇社区帖子 对应 多个评论)
 * 与 用户表 建立 一对一的关系 （即 一个用户 只有 一个评论）
 * 自关联 id 与 parent_id (一个评论 下面有 多个回复评论)
 */
module.exports = app => {
    const { INTEGER, TEXT, DATE } = app.Sequelize
    const Comment = app.model.define('comment', {
        id: { type: INTEGER, primaryKey: true },
        uid: { type: INTEGER },
        content: { type: TEXT },
        parent_id: { type: INTEGER },
        createTime: { type: DATE },
        community_id: { type: INTEGER },
        activity_id: { type: INTEGER }
    })
    Comment.associate = function () {
        // 与 用户 的关系
        app.model.Comment.belongsTo(app.model.Users, { foreignKey: 'uid', targetKey: 'id' })
        // 与 活动 的关系
        app.model.Comment.belongsTo(app.model.Activity, { foreignKey: 'activity_id', targetKey: 'id' })
        // 与 社区帖子 的关系
        app.model.Comment.belongsTo(app.model.Community, { foreignKey: 'community_id', targetKey: 'id' })
        // 与 自身的 parent_id 关联
        app.model.Comment.hasMany(app.model.Comment, { foreignKey: 'parent_id', through: null })
    }
    return Comment

}