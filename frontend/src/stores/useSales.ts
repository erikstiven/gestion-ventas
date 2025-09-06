import { create } from 'zustand';
import api from '../api/client';

export type Sale = {
  id:number; fecha:string; monto_total:number;
  cliente:{id:number; nombre:string};
  vendedor:{id:number; nombre:string};
  zona:{id:number; nombre:string};
};
export type SaleItemInput = { product_id:number; cantidad:number; precio_unitario:number };
export type SaleCreate = {
  client_id:number; seller_id:number; zone_id:number;
  fecha:string; metodo_pago?:string; detalles:SaleItemInput[];
};

type Filters = { search?:string; start_date?:string; end_date?:string; year?:string };
type State = {
  items:Sale[]; page:number; per_page:number; total:number; loading:boolean; filters:Filters; error?:string|null;
  fetch:(p?:Partial<Filters>&{page?:number; per_page?:number; sort?:string})=>Promise<void>;
  create:(payload:SaleCreate)=>Promise<Sale>;
  remove:(id:number)=>Promise<void>;
};

export const useSales = create<State>((set, get) => ({
  items:[], page:1, per_page:10, total:0, loading:false, filters:{}, error:null,

  async fetch(p={}){
    set({loading:true, error:null});
    const f={...get().filters, ...p};
    const q=new URLSearchParams();
    if(p.page) q.set('page', String(p.page));
    q.set('per_page', String(p.per_page ?? get().per_page));
    if(f.search) q.set('search', f.search);
    if(f.start_date) q.set('start_date', f.start_date);
    if(f.end_date) q.set('end_date', f.end_date);
    if(f.year) q.set('year', f.year);
    if((p as any).sort) q.set('sort', (p as any).sort);

    const { data } = await api.get(`/sales?${q.toString()}`);
    set({ items: data.data, page: data.meta.current_page, per_page: data.meta.per_page, total: data.meta.total, loading:false, filters: f });
  },

  async create(payload){ const { data } = await api.post('/sales', payload); await get().fetch({page:1}); return data.data ?? data; },
  async remove(id){ await api.delete(`/sales/${id}`); const next=get().items.length===1&&get().page>1?get().page-1:get().page; await get().fetch({page:next}); },
}));
