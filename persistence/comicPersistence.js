const db = require('../database/database-driver');

module.exports.createComic = function (comicData, sucesso, erro) {
    db.executeQuery("INSERT INTO comics (title, issue_number, release_date, group_id, universe_id) VALUES ('"
        + comicData.title + "', '"
        + comicData.issueNumber + "', '"
        + comicData.releaseDate + "', "
        + comicData.groupId + ", "
        + comicData.universeId
        + ") RETURNING id", (rows) => {
        if (rows && rows.length == 1 && rows[0].id) {
            const comicId = rows[0].id;
            let query = "INSERT INTO comics_characters_join (comic_id, character_id) VALUES ";
            comicData.characters.forEach(character => {
                query += "(" + comicId + ", " + character + "), ";
            });
            query = query.substring(0, query.length - 2);
            db.executeQuery(query, (rowsJoin) => {
                sucesso(comicId);
            }, (ignoreCharacterError) => {
                sucesso(comicId);
            });
        } else {
            erro(500, 'Erro desconhecido ao inserir');
        }
    }, erro);
}