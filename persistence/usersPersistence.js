const db = require('../database/database-driver');
const dateFormat = require("dateformat");

module.exports.createUser = function(nome, userkey, userpass, sucesso, erro) {
    db.executeQuery("INSERT INTO users (nome, userkey, userpass) VALUES ('"
        + nome + "', '"
        + userkey + "', '"
        + userpass + "')", (rows) => {
            sucesso();
        }, erro);
}

module.exports.saveToken = function(userId, token, expires, result, errorMessage) {
    db.executeQuery("UPDATE users SET access_token = '"+token+"', token_expire = '"
        +dateFormat(expires, 'yyyy-mm-dd HH:MM:ss')+"' WHERE id = "+userId, result, errorMessage);
}

module.exports.getUserByCredentials = function(userkey, userpass, result, errorMessage) {
    db.executeQuery("SELECT * FROM users WHERE userkey LIKE '"+userkey+"' AND userpass LIKE '"+userpass+"'", (users) => {
        if (users && users.length == 1) {
            result(users[0]);
        } else {
            result(null);
        }
    }, errorMessage);
}

module.exports.getExpiresByToken = function(token, result, errorMessage) {
    db.executeQuery("SELECT token_expire FROM users WHERE access_token LIKE '"+token+"'", (queryResult) => {
        if (queryResult && queryResult.length == 1) {
            result(queryResult[0].token_expire);
        } else {
            result(null);
        }
    }, errorMessage);
}
