const auth = require('./security/auth');
const users = require('./routes/usersRoute');

const express = require('express');
const port = 3000;
const app = express();
app.use(express.json())

app.post('/users', (req, res) => {
    users.createUser(req, res);
})

app.get('/token', (req, res) => {
    users.getToken(req, res);
})

app.get('/', auth.isAuthorized, (req, res) => {
    res.send('Hello World!')
})

app.listen(port, () => {
    console.log(`Serviço iniciado na porta ${port}`);
})