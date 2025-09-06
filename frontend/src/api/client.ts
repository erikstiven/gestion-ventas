import axios from 'axios';

const api = axios.create({
  baseURL: import.meta.env.VITE_API_URL || 'http://localhost:8000/api/v1',
  timeout: 15000,
});

api.interceptors.response.use(
  r => r,
  err => {
    console.error(err.response?.data || err.message);
    return Promise.reject(err);
  }
);

export default api;
