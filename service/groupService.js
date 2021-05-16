const ObjectRef = require('../model/ObjectRef');
const persist = require('../persistence/groupPersistence');

module.exports.createGroup = function(name, retorno, erro) {
    persist.createGroup(name, (id) => {
        retorno(new ObjectRef(id, name));
    }, erro);
}

module.exports.listGroup = function(page, pageSize, retorno, erro) {
    persist.listGroup(page, pageSize, (groupList) => {
        groupList.forEach(group => {
            group = new ObjectRef(group.id, group.name);
        });
        retorno(groupList);
    }, erro);
}