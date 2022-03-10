import axios from 'axios';
import { Auth } from 'aws-amplify';


export interface ApiSuccessResponse {
  status: 'OK';
}

export interface ApiErrorResponse {
  status: number;
  error_custom_code: number;
  message: string;
}

export default class NetworkManager {
  static isInitiate = false;

  static init() {
    if (NetworkManager.isInitiate) return;

    NetworkManager.isInitiate = true;
    //set base url
    axios.defaults.baseURL = `${process.env.REACT_APP_API_BASE_URL}/v1/app`;
  }
}

export const axiosRequestInterceptor = async (config: any) => {
  try {
    if (process.env.REACT_APP_TESTING) return config;
    const session = await Auth.currentSession()
    const accesstoken = session.getAccessToken().getJwtToken();



    if (accesstoken) {
      config.headers.Authorization = `Bearer ${accesstoken}`;
    }
    return config;
  } catch (e) {
    console.log('idle mode check- got an error when trying to find currentSession: ', e);
    Auth.signOut();
  }
};

axios.interceptors.request.use(axiosRequestInterceptor, (e) => Promise.reject(e));
