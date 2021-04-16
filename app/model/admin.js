/**用户模型 */
module.exports = app => {
    const { STRING, INTEGER, TEXT, DATE } = app.Sequelize
    const Admin = app.model.define('admin', {
        id: {
            type: INTEGER,
            autoIncrement: true,
            primaryKey: true
        },
        account: {
            type: STRING(50),
            allowNull: false
        },
        password: {
            type: STRING(128),
            allowNull: false
        },
        email: {
            type: STRING(25),
            allowNull: false
        },
        avatar: {
            type: TEXT,
            defaultValue: "https://imgtu.com/i/ELAeHO",
            allowNull: false
        },
        role_id: {
            type: INTEGER,
            defaultValue: 1,
            allowNull: false
        },
        createdAt: {
            type: DATE,
            allowNull: false
        },
        updatedAt: {
            type: DATE,
            allowNull: false
        }
    })
    return Admin
}