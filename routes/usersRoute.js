const NewUser = require('../model/NewUser');
const UserCredentials = require('../model/UserCredentials');
const service = require('../service/usersService');

module.exports.createUser = function(req, res) {
    let user = NewUser.parse(req.body);

    if (user == null) {
        res.status(400).json('Informações do usuário precisam estar no corpo da requisição');
    } else {
        service.createUser(user, (retorno) => {
            res.status(201).json(retorno);
        }, (status, mensagem) => {
            res.status(status).json(mensagem);
        });
    }
}

module.exports.getToken = function(req, res) {
    const credentials = UserCredentials.parse(req.headers);

    if (credentials == null) {
        res.status(400).json('userkey e userpass precisam estar no cabeçalho da requisição');
    } else {
        service.getToken(credentials, (retorno) => {
            res.status(200).json(retorno);
        }, (status, mensagem) => {
            res.status(status).json(mensagem);
        });
    }
}