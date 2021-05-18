const auth = require('./security/auth');
const checkLimit = require('./middleware/connectionLimit');
const cacheInHeader = require('./middleware/cacheHeader');
const checkCache = require('./middleware/cacheRequests').check;

const users = require('./routes/usersRoute');
const universe = require('./routes/universeRoute');
const group = require('./routes/groupRoute');
const character = require('./routes/characterRoute');
const comic = require('./routes/comicRoute');

const express = require('express');
const port = 3000;
const app = express();

app.set('trust proxy', true);
app.use(express.json());
app.use(checkLimit);

/********************** USERS ***************************/
app.post('/api/v1/users', (req, res) => {
    users.createUser(req, res);
})

app.get('/api/v1/token', (req, res) => {
    users.getToken(req, res);
})

app.get('/api/v1/', auth.isAuthorized, cacheInHeader, checkCache, (req, res) => {
    res.send('Hello World!')
})

/********************** UNIVERSE *************************/
app.get('/api/v1/universe/', auth.isAuthorized, cacheInHeader, checkCache, (req, res) => {
    universe.listUniverse(req, res);
})

app.get('/api/v1/universe/:id', auth.isAuthorized, cacheInHeader, checkCache, (req, res) => {
    universe.getUniverse(req, res);
})

/********************** GROUP ****************************/
app.get('/api/v1/group/', auth.isAuthorized, cacheInHeader, checkCache, (req, res) => {
    group.listGroup(req, res);
})

/********************** CHARACTERS ***********************/

/********************** COMICS ***************************/
app.get('/api/v1/comics/:id', auth.isAuthorized, cacheInHeader, checkCache, (req, res) => {
    comic.getComic(req, res);
})

/********************** YEAR *****************************/

/********************** ADMIN ****************************/
app.post('/api/v1/universe', auth.isAdmin, (req, res) => {
    universe.createUniverse(req, res);
})

app.post('/api/v1/group', auth.isAdmin, (req, res) => {
    group.createGroup(req, res);
})

app.post('/api/v1/character', auth.isAdmin, (req, res) => {
    character.createCharacter(req, res);
})

app.post('/api/v1/comic', auth.isAdmin, (req, res) => {
    comic.createComic(req, res);
})

//--------------------- INIT ------------------------------
app.listen(port, () => {
    console.log(`Serviço iniciado na porta ${port}`);
})