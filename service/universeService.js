const ObjectRef = require('../model/ObjectRef');
const persist = require('../persistence/universePersistence');

module.exports.createUniverse = function(name, retorno, erro) {
    persist.createUniverse(name, (id) => {
        retorno(new ObjectRef(id, name));
    }, erro);
}

module.exports.listUniverse = function(page, pageSize, retorno, erro) {
    persist.listUniverse(page, pageSize, (universeList) => {
        universeList.forEach(universe => {
            universe = new ObjectRef(universe.id, universe.name);
        });
        retorno(universeList);
    }, erro);
}