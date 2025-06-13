import axios from 'axios';

const instance = axios.create({
  baseURL: process.env.NEXT_PUBLIC_API_URL || 'http://localhost:3001',
  headers: {
    'Content-Type': 'application/json',
  },
});

export const fetcher = (url: string) => {
  console.log('🚀 Fetching:', `${instance.defaults.baseURL}${url}`);
  return instance.get(url)
    .then(res => {
      console.log('✅ Response:', res.data);
      return res.data;
    })
    .catch(err => {
      console.error('❌ Error:', err);
      throw err;
    });
};

export default instance; 