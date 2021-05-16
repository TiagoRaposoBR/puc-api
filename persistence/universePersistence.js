const db = require('../database/database-driver');

module.exports.createUniverse = function (nome, sucesso, erro) {
    db.executeQuery("INSERT INTO universe (nome) VALUES ('" + nome + "') RETURNING id", (rows) => {
        if (rows && rows.length == 1 && rows[0].id) {
            sucesso(rows[0].id);
        } else {
            erro(500, 'Erro desconhecido ao inserir');
        }
    }, erro);
}

module.exports.listUniverse = function (page, pageSize, sucesso, erro) {
    db.executeQuery("SELECT * FROM universe LIMIT "+pageSize+" OFFSET "+(page * pageSize), (rows) => {
        sucesso(rows);
    }, erro);
}