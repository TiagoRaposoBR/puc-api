const NewComic = require('../model/NewComic');
const ObjectRef = require('../model/ObjectRef');
const service = require('../service/comicService');

module.exports.createComic = function(req, res) {
    let comic = NewComic.parse(req.body);

    if (!comic) {
        res.status(400).json('Dados do quadrinho precisa estar no corpo da requisição');
    } else {
        service.createComic(comic, (retorno) => {
            const fullUrl = req.protocol + '://' + req.get('host') + req.originalUrl;
            retorno.url = fullUrl + '/' + retorno.id;
            res.status(201).json(retorno);
        }, (status, mensagem) => {
            res.status(status).json(mensagem);
        });
    }
}

module.exports.getComic = function(req, res) {
    const id = req.params.id;

    if (!id) {
        res.status(400).json('Endpoint de quadrinho, mas sem id');
    } else {
        service.getComic(id, (retorno) => {
            let rootUrl = req.protocol + '://' + req.get('host') + req.originalUrl;
            rootUrl = rootUrl.substring(0, rootUrl.indexOf('/comics/'));

            retorno.group.url = rootUrl + '/group/' + retorno.group.id;
            retorno.universe.url = rootUrl + '/universe/' + retorno.universe.id;
            
            const charUrl = rootUrl + '/character/';
            retorno.characters.forEach(char => {
                char.url = charUrl + char.id
            });
            res.status(200).json(retorno);
        }, (status, mensagem) => {
            res.status(status).json(mensagem);
        });
    }
}