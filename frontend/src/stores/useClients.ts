import { create } from 'zustand';
import api from '../api/client';

export type Client = {
  id: number;
  nombre: string;
  email: string;
  telefono?: string;
  direccion?: string;
};
export type ClientCreate = Omit<Client,"id">;

type State = {
  items: Client[];
  page: number;
  per_page: number;
  total: number;
  loading: boolean;
  search: string;
  error?: string | null;
  fetch: (p?: Partial<{ page:number; per_page:number; search:string; sort:string }>) => Promise<void>;
  create: (payload: ClientCreate) => Promise<Client>;
  update: (id: number, payload: ClientCreate) => Promise<Client>;
  remove: (id: number) => Promise<void>;
};

export const useClients = create<State>((set, get) => ({
  items: [], page: 1, per_page: 10, total: 0, loading: false, search: '', error: null,

  async fetch(p = {}) {
    set({ loading: true, error: null });
    const q = new URLSearchParams({
      page: String(p.page ?? get().page),
      per_page: String(p.per_page ?? get().per_page),
      search: p.search ?? get().search,
      sort: p.sort ?? 'id',
    });
    const { data } = await api.get(`/clients?${q.toString()}`);
    set({
      items: data.data,
      page: data.meta.current_page,
      per_page: data.meta.per_page,
      total: data.meta.total,
      loading: false,
      search: p.search ?? get().search,
    });
  },

  async create(payload) { const { data } = await api.post('/clients', payload); await get().fetch({ page: 1 }); return data.data ?? data; },
  async update(id, payload) { const { data } = await api.put(`/clients/${id}`, payload); await get().fetch(); return data.data ?? data; },
  async remove(id) { await api.delete(`/clients/${id}`); const next = get().items.length===1 && get().page>1 ? get().page-1 : get().page; await get().fetch({ page: next }); },
}));
