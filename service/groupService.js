const ObjectRef = require('../model/ObjectRef');
const persist = require('../persistence/groupPersistence');

module.exports.createGroup = function(name, retorno, erro) {
    persist.createGroup(name, (id) => {
        retorno(new ObjectRef(id, name));
    }, erro);
}