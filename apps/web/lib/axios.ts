import axios from 'axios';
import { getSession } from 'next-auth/react';

const instance = axios.create({
  baseURL: process.env.NEXT_PUBLIC_API_URL || 'http://localhost:3001',
  headers: {
    'Content-Type': 'application/json',
  },
});

// Request interceptor to add auth token
instance.interceptors.request.use(
  async (config) => {
    const session = await getSession();
    if ((session as any)?.accessToken) {
      config.headers.Authorization = `Bearer ${(session as any).accessToken}`;
    }
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

// Response interceptor to handle auth errors
instance.interceptors.response.use(
  (response) => response,
  (error) => {
    if (error.response?.status === 401) {
      // Token expired or invalid, could trigger logout here
      console.warn('Unauthorized request, consider refreshing session');
    }
    return Promise.reject(error);
  }
);

// Fetcher function for swr
export const fetcher = (url: string) => {
  return instance.get(url)
    .then(res => {
      console.log(res.data);
      return res.data;
    })
    .catch(err => {
      console.error(err.message);
      throw err;
    });
};

export default instance; 