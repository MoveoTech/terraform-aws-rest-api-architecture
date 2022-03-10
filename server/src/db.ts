import { MongoClient } from 'mongodb';
import { getSecrets } from "./service";



let connection;
export const getConnection = async () => {

    if (!connection) {
        // Fetch secrets from secretes manager to connect to db
        const secrets = await getSecrets();
        // connection = await MongoClient.connect(`${secrets.db_connection_string}/${process.env.DATABASE_NAME}`, {
        connection = await MongoClient.connect(`mongodb+srv://heka-develop:m45U1wcPncTrLqHL@cluster-develop.3z8tr.mongodb.net/test2?authSource=admin&replicaSet=atlas-7gt1we-shard-0&readPreference=primary&ssl=true`, {
            //@ts-ignore
            useNewUrlParser: true,
            useUnifiedTopology: true,
            // auth: {
            //     username: secrets.db_username,
            //     password: secrets.db_password,
            // }
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