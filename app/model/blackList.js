/** 
 *  与管理员表一对多的关系
 *  与用户表 一对一关系
 *  黑名单模型
 */
module.exports = app => {
    const { STRING, INTEGER } = app.Sequelize
    const BlackList = app.model.define('black_list', {
        id: {
            type: INTEGER,
            autoIncrement: true,
            primaryKey: true
        },
        createAt: { type: INTEGER },
        endAt: { type: INTEGER },
        reason: { type: STRING },
        admin_id: { type: INTEGER },
        uid: { type: INTEGER }
    })
    BlackList.associate = function () {
        app.model.BlackList.belongsTo(app.model.Users, { foreignKey: 'uid', targetKey: 'id' })
    }
    return BlackList
}