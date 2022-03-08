const express = require('express')

// ES5 example
import { getEvents, createEvents, getSecrets } from "./service"

const app = express()
const port = process.env.PORT;

app.get('/v1/app/events', async (req, res) => {
    const events = await getEvents();
    return res.json(events)
})
app.post('/v1/app/events', async (req, res) => {
    const events = await createEvents();
    return res.json(events)
})





app.listen(port, async () => {
    const secrets = await getSecrets();
    console.log(`Example app listening on port ${port}`)
    console.log(`CONNECTION STRING: ${secrets.db_connection_string}`)
    console.log(`CONNECTION PASS: ${secrets.db_password}`)
    console.log(`CONNECTION USER: ${secrets.db_username}`)
    console.log(`database name: ${process.env.DATABASE_NAME}`)

})