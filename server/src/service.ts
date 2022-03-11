import { SecretsManagerClient, GetSecretValueCommand } from "@aws-sdk/client-secrets-manager"
import { getConnection } from './db'

let secretManagerClient;

export const getSecrets = () => {
    if (!secretManagerClient) {
        secretManagerClient = new SecretsManagerClient({ region: process.env.REGION });
    }
    const command = new GetSecretValueCommand({ SecretId: `secrets/${process.env.NODE_ENV}` });
    return secretManagerClient.send(command).then(res => JSON.parse(res.SecretString));
}

export const getEvents = async () => {
    const client = await getConnection();
    return client
        .db(process.env.DATABASE_NAME)
        .collection('events')
        .aggregate([
            {
                $limit: 50,
            }
        ])
        .toArray();
}

export const createEvents = async () => {
    const client = await getConnection();

    return client
        .db(process.env.DATABASE_NAME)
        .collection('events')
        .updateOne(
            {
                date: new Date()
            },
            {
                $push: {
                    events: {
                        $each: [
                            {
                                date: new Date(),
                                value: "value",
                            },
                        ],
                        $position: 0,
                    },
                },
            },
            {
                upsert: true,
            },
        );
}