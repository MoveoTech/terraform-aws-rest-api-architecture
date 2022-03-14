import { MongoClient } from 'mongodb';
import { getSecrets } from "./service";



let connection;
export const getConnection = async () => {

    if (!connection) {
        // Fetch secrets from secretes manager to connect to db
        const secrets = await getSecrets();
        // connection = await MongoClient.connect(`${secrets.db_connection_string}/${process.env.DATABASE_NAME}`, {
        connection = await MongoClient.connect(`mongodb+srv://terraform-moveo.l7mku.mongodb.net/terraform-moveo-production`, {
            //@ts-ignore
            useNewUrlParser: true,
            useUnifiedTopology: true,
            auth: {
                username: "terraform-moveo_production_user",
                password: "0st0WbJv<x*{eJh):mVwKnBq",
            }
        })
            .then(res => {
                console.log('Connection success')
                return res;
            })
            .catch(error => {
                console.log('Connection error: ', error);
                throw error;
            });
    }

    return connection;
}