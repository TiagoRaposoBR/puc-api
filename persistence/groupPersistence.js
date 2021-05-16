const db = require('../database/database-driver');

module.exports.createGroup = function (nome, sucesso, erro) {
    db.executeQuery("INSERT INTO char_group (nome) VALUES ('" + nome + "') RETURNING id", (rows) => {
        if (rows && rows.length == 1 && rows[0].id) {
            sucesso(rows[0].id);
        } else {
            erro(500, 'Erro desconhecido ao inserir');
        }
    }, erro);
}

module.exports.listGroup = function (page, pageSize, sucesso, erro) {
    db.executeQuery("SELECT * FROM char_group LIMIT "+pageSize+" OFFSET "+(page * pageSize), (rows) => {
        sucesso(rows);
    }, erro);
}