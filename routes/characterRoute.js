const NewCharacter = require('../model/NewCharacter');
const ObjectRef = require('../model/ObjectRef');
const service = require('../service/characterService');

module.exports.createCharacter = function(req, res) {
    let character = NewCharacter.parse(req.body);

    if (!character) {
        res.status(400).json('Dados do personagem precisam estar no corpo da requisição');
    } else {
        service.createCharacter(character, (retorno) => {
            const fullUrl = req.protocol + '://' + req.get('host') + req.originalUrl;
            retorno.url = fullUrl + '/' + retorno.id;
            res.status(201).json(retorno);
        }, (status, mensagem) => {
            res.status(status).json(mensagem);
        });
    }
}

module.exports.getGroup = function(req, res) {
    res.status(501).send('not implemented');
    // const id = req.params.id;

    // if (!id) {
    //     res.status(400).json('Endpoint de universo, mas sem id');
    // } else {
    //     service.getUniverse(id, (retorno) => {
    //         const fullUrl = req.protocol + '://' + req.get('host') + req.originalUrl;
    //         retorno.url = fullUrl + '/' + retorno.id;
    //         res.status(201).json(retorno);
    //     }, (status, mensagem) => {
    //         res.status(status).json(mensagem);
    //     });
    // }
}