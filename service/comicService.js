const ObjectRef = require('../model/ObjectRef');
const persist = require('../persistence/comicPersistence');

module.exports.createComic = function(comic, retorno, erro) {
    persist.createComic(comic, (id) => {
        retorno(new ObjectRef(id, comic.title));
    }, erro);
}