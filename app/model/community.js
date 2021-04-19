/**
 * 数据库 社区（帖子）表 (community) 数据模型
 * 与 用户表 建立 一对多的关系 （即 一个用户 发布 多篇文章）
 */
module.exports = app => {
    const { INTEGER, STRING } = app.Sequelize
    const Community = app.model.define('community', {
        id: { type: INTEGER, primaryKey: true },
        title: { type: STRING },
        img: { type: STRING },
        likes: { type: INTEGER },
        uid: { type: INTEGER },
        message: { type: STRING }
    })
    Community.associate = function () {
        // 与 评论 的关系
        app.model.Community.hasMany(app.model.Comment, { foreignKey: 'community_id', targetKey: 'id' })
        // 与 用户 的关系
        app.model.Community.belongsTo(app.model.Users, { foreignKey: 'uid', targetKey: 'id' })
    }
    return Community
}