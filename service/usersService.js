const UserCredentials = require('../model/UserCredentials');
const auth = require('../security/auth');
const persist = require('../persistence/usersPersistence');

module.exports.createUser = function(user, retorno, erro) {
    const userkey = auth.gerarChaveAleatoria('md5');
    const userpass = auth.gerarChaveAleatoria('md5');

    persist.createUser(user.name, userkey, userpass, () => {
        retorno(new UserCredentials(userkey, userpass));
    }, erro);
}

module.exports.getToken = function(credentials, retorno, erro) {
    persist.getUserByCredentials(credentials.userkey, credentials.userpass, (user) => {
        if (user) {
            const tokenData = auth.createToken();
        
            persist.saveToken(user.id, tokenData.token, tokenData.expires, () => {
                tokenData.name = user.nome;
                retorno(tokenData);
            }, erro);
        } else {
            erro(401, "Credenciais inválidas");
        }
    }, erro);
}

module.exports.getExpiresByToken = function(token, retorno, erro) {
    persist.getExpiresByToken(token, retorno, erro);
}