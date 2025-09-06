import axios from 'axios';
import { toast } from 'sonner';

const api = axios.create({
  baseURL: import.meta.env.VITE_API_URL || 'http://localhost:8000/api/v1',
  timeout: 15000,
});

// Que Laravel responda JSON siempre
api.defaults.headers.common['Accept'] = 'application/json';

api.interceptors.response.use(
  (r) => r,
  (err) => {
    const status = err?.response?.status;
    const data = err?.response?.data;

    if (status === 422) {
      // Estructura típica de Laravel: { message, errors: { campo: [msg,msg] } }
      const lines: string[] = [];
      if (data?.errors && typeof data.errors === 'object') {
        for (const [k, v] of Object.entries<any>(data.errors)) {
          if (Array.isArray(v)) lines.push(`${k}: ${v.join(', ')}`);
        }
      }
      toast.error(lines.length ? lines.join('\n') : (data?.message || 'Error de validación (422)'));
    } else if (data?.message) {
      toast.error(data.message);
    } else if (err?.message) {
      toast.error(err.message);
    }
    return Promise.reject(err);
  }
);

export default api;
