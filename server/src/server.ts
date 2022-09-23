import { Request, Response, NextFunction } from 'express';
import * as express from 'express';
var axios = require('axios');
const cors = require('cors')

// ES5 example
import { getEvents, createEvents, getSecrets } from "./service"
const accessControlMiddleware = (request: Request, response: Response, next: NextFunction) => {
    console.log('inside accessControlMiddleware')
    response.header('Access-Control-Allow-Origin', ['*']);
    response.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept');
    response.header('Access-Control-Allow-Methods', 'OPTIONS,POST,GET');
    next();
};

const app = express()
app.use(cors())
app.use(accessControlMiddleware);
const port = process.env.PORT || 3001;

app.get('/v1/app/internet/ping', async (req, res) => {
    var config = {
        method: 'get',
        url: 'https://www.google.com/search?q=PASTA+VIA+%7C+Ibn+Gabirol'
    };
    axios(config)
        .then(function (response) {
            throw new Error('Problem!')
            return res.json(response.data)
        })
        .catch(function (error) {
            console.log(error)
            return res.json(error.message)
        });
})

app.get('/v1/app/events', async (req, res) => {
    console.log(req?.headers);
    const events = await getEvents();
    return res.json(events)
})
app.post('/v1/app/events', async (req, res) => {
    console.log(req?.headers);
    const events = await createEvents();
    return res.json(events)
})





app.listen(port, async () => {
    try {
        const secrets = await getSecrets();

        console.log(`Example app listening on port ${port}`)
        console.log(`CONNECTION STRING: ${secrets.db_connection_string}`)
        console.log(`CONNECTION PASS: ${secrets.db_password}`)
        console.log(`CONNECTION USER: ${secrets.db_username}`)
        console.log(`database name: ${process.env.DATABASE_NAME}`)
    } catch (error) {
        console.log(error)
    }


})