const ObjectRef = require('../model/ObjectRef');
const persist = require('../persistence/universePersistence');

module.exports.createUniverse = function(name, retorno, erro) {
    persist.createUniverse(name, (id) => {
        retorno(new ObjectRef(id, name));
    }, erro);
}