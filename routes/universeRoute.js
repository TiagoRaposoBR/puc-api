const ObjectRef = require('../model/ObjectRef');
const addToCache = require('../middleware/cacheRequests').add;
const service = require('../service/universeService');

module.exports.createUniverse = function(req, res) {
    const name = req.body?.name;

    if (!name) {
        res.status(400).json('Nome do universo precisa estar no corpo da requisição');
    } else {
        service.createUniverse(name, (retorno) => {
            const fullUrl = req.protocol + '://' + req.get('host') + req.originalUrl;
            retorno.url = fullUrl + '/' + retorno.id;
            res.status(201).json(retorno);
        }, (status, mensagem) => {
            res.status(status).json(mensagem);
        });
    }
}

module.exports.listUniverse = function(req, res) {
    const page = req.query.page || 0;
    const pageSize = req.query.pageSize || 10;

    service.listUniverse(page, pageSize, (retorno) => {
        const fullUrl = req.protocol + '://' + req.get('host') + req.originalUrl;
        retorno.forEach(universo => {
            universo.url = fullUrl + '/' + universo.id;
        });

        addToCache(req, retorno);
        
        res.status(200).json(retorno);
    }, (status, mensagem) => {
        res.status(status).json(mensagem);
    });
}

module.exports.getUniverse = function(req, res) {
    res.status(501).json('not implemented');
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