import axios from 'axios';

const instance = axios.create({
  baseURL: process.env.NEXT_PUBLIC_API_URL || 'http://localhost:3001',
  headers: {
    'Content-Type': 'application/json',
  },
});

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