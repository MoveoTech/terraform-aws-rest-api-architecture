import { useEffect, useState } from 'react';
import './App.css';
import Amplify, { Auth } from 'aws-amplify'
import { Authenticator, Heading, useTheme, Text } from '@aws-amplify/ui-react';
import '@aws-amplify/ui-react/styles.css';
import NetworkManager from './NetworkManager';
import { Events } from './events';

Amplify.configure({
  Auth: {
    region: process.env.REACT_APP_AWS_REGION,
    userPoolId: process.env.REACT_APP_AWS_POOL_ID,
    userPoolWebClientId: process.env.REACT_APP_AWS_WEB_CLIENT_ID
  },
})

const components = {
  VerifyUser: {
    Header() {
      const { tokens } = useTheme();
      return (
        <Heading
          padding={`${tokens.space.xl} 0 0 ${tokens.space.xl}`}
          level={3}
        >
          Enter Information:
        </Heading>
      );
    },
    Footer() {
      return <Text>Footer Information</Text>;
    },
  },

  ConfirmVerifyUser: {
    Header() {
      const { tokens } = useTheme();
      return (
        <Heading
          padding={`${tokens.space.xl} 0 0 ${tokens.space.xl}`}
          level={3}
        >
          Enter Information:
        </Heading>
      );
    },
    Footer() {
      return <Text>Footer Information</Text>;
    },
  },
};

export default function App() {
  useEffect(() => NetworkManager.init(), []);
  const [token, setToken] = useState<string>("");

  async function getToken() {
    const session = await Auth.currentSession()
    const accesstoken = session.getAccessToken().getJwtToken();
    setToken(accesstoken)
    const idtoken = session.getIdToken().getJwtToken();
    console.log('idtoken: ', idtoken)
    console.log('accesstoken: ', accesstoken)
  }

  return (
    <Authenticator loginMechanisms={['email']} components={components} hideSignUp={true}>
      {({ signOut, user }) => (
        <main>
          <h1>Hello {user?.username}</h1>

          <div>
            <button onClick={getToken}>Refresh Token </button>
            <button onClick={signOut}>Sign out</button>
          </div>
          <div style={{ width: 400 }}>
            <h3>Access token :</h3>
            <p>{token}</p>
          </div>
          <Events />
        </main>
      )}
    </Authenticator>
  );
}
