import { MongoClient } from 'mongodb';
import { getSecrets } from "./service";



let connection;
export const getConnection = async () => {

    if (!connection) {
        try {
            // Fetch secrets from secretes manager to connect to db
            const secrets = await getSecrets();
            connection = await MongoClient.connect(`${secrets.db_connection_string}/${process.env.DATABASE_NAME}`, {
                //@ts-ignore
                useNewUrlParser: true,
                useUnifiedTopology: true,
                auth: {
                    username: secrets.db_username,
                    password: secrets.db_password,
                }
            })
            console.log('Connection success')
        } catch (error) {
            console.log('Connection error: ', error);
        }
    }

    return connection;
}