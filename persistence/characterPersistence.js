const db = require('../database/database-driver');

module.exports.createCharacter = function (characterData, sucesso, erro) {
    db.executeQuery("INSERT INTO characters (nome, race, gender, creation_date, universe_id) VALUES ('"
        + characterData.name + "', '"
        + characterData.race + "', '"
        + characterData.gender + "', '"
        + characterData.creationDate + "', "
        + characterData.universeId
        + ") RETURNING id", (rows) => {
        if (rows && rows.length == 1 && rows[0].id) {
            const charId = rows[0].id;
            let query = "INSERT INTO characters_group_join (group_id, character_id) VALUES ";
            characterData.groups.forEach(group => {
                query += "(" + group + ", " + charId + "), ";
            });
            query = query.substring(0, query.length - 2);
            db.executeQuery(query, (rowsJoin) => {
                sucesso(charId);
            }, (ignoreGroupError) => {
                sucesso(charId);
            });
        } else {
            erro(500, 'Erro desconhecido ao inserir');
        }
    }, erro);
}