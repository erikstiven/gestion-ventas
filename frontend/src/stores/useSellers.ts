import { create } from "zustand";
import api from "../api/client";

export type Seller = {
  id: number;
  nombre: string;
  email: string;
  telefono?: string | null;
  documento?: string | null;
};

export type SellerCreate = Omit<Seller, "id">;

type State = {
  items: Seller[];
  page: number;
  per_page: number;
  total: number;
  loading: boolean;
  search: string;
  error?: string | null;

  fetch: (p?: Partial<{ page: number; per_page: number; search: string; sort: string }>) => Promise<void>;
  create: (payload: SellerCreate) => Promise<Seller>;
  update: (id: number, payload: SellerCreate) => Promise<Seller>;
  remove: (id: number) => Promise<void>;
};

export const useSellers = create<State>((set, get) => ({
  items: [],
  page: 1,
  per_page: 10,
  total: 0,
  loading: false,
  search: "",
  error: null,

  async fetch(p = {}) {
    set({ loading: true, error: null });
    const q = new URLSearchParams({
      page: String(p.page ?? get().page),
      per_page: String(p.per_page ?? get().per_page),
      search: p.search ?? get().search,
      sort: p.sort ?? "id",
    });

    const { data } = await api.get(`/sellers?${q.toString()}`);
    set({
      items: data.data,
      page: data.meta.current_page,
      per_page: data.meta.per_page,
      total: data.meta.total,
      loading: false,
      search: p.search ?? get().search,
    });
  },

  async create(payload) {
    const { data } = await api.post("/sellers", payload);
    await get().fetch({ page: 1 });
    return data.data ?? data;
  },

  async update(id, payload) {
    const { data } = await api.put(`/sellers/${id}`, payload);
    await get().fetch();
    return data.data ?? data;
  },

  async remove(id) {
    await api.delete(`/sellers/${id}`);
    const next = get().items.length === 1 && get().page > 1 ? get().page - 1 : get().page;
    await get().fetch({ page: next });
  },
}));
