const persist = require('../persistence/comicPersistence');
const characterService = require('./characterService');
const moment = require('moment');

const ObjectRef = require('../model/ObjectRef');
const Comic = require('../model/Comic');


module.exports.createComic = function(comic, retorno, erro) {
    persist.createComic(comic, (id) => {
        retorno(new ObjectRef(id, comic.title));
    }, erro);
}

module.exports.getComic = function(id, retorno, erro) {
    const comic = new Comic();

    persist.getComic(id, (returnComic) => {
        if (!returnComic) {
            erro(404, 'Quadrinho de id ' + id + ' não foi encontrado');
        } else {
            comic.title = returnComic.title;
            comic.issueNumber = returnComic.issue_number;
            comic.releaseDate = moment(returnComic.release_date).format('MMMM YYYY');
            comic.group = new ObjectRef(
                returnComic.group_id,
                returnComic.group_name
            );
            comic.universe = new ObjectRef(
                returnComic.universe_id,
                returnComic.universe_name
            );

            characterService.getCharactersByComic(id, (returnCharacters) => {
                comic.characters = [];
                returnCharacters.forEach(character => {
                    comic.characters.push(new ObjectRef(
                        character.id,
                        character.nome
                    ))
                });
                retorno(comic);
            }, erro);
        }
    }, erro);
}