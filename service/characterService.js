const ObjectRef = require('../model/ObjectRef');
const persist = require('../persistence/characterPersistence');

module.exports.createCharacter = function(character, retorno, erro) {
    persist.createCharacter(character, (id) => {
        retorno(new ObjectRef(id, character.name));
    }, erro);
}