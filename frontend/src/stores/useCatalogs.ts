import { create } from "zustand";
import api from "../api/client";

export type Zone = { id:number; nombre_zona?:string; nombre?:string };
export type Seller = { id:number; nombre:string; email?:string };
export type Product = { id:number; nombre:string; precio:number; stock?:number };
export type ClientLite = { id:number; nombre:string };

type State = {
  zones: Zone[]; sellers: Seller[]; products: Product[]; clients: ClientLite[];
  loading:boolean; fetchAll:()=>Promise<void>;
};

export const useCatalogs = create<State>((set)=>({
  zones:[], sellers:[], products:[], clients:[], loading:false,
  async fetchAll(){
    set({loading:true});
    const [z,s,p,c] = await Promise.all([
      api.get("/zones"), api.get("/sellers"), api.get("/products"), api.get("/clients?per_page=1000")
    ]);
    set({
      zones: z.data.data ?? z.data,
      sellers: s.data.data ?? s.data,
      products: p.data.data ?? p.data,
      clients: (c.data.data ?? c.data)?.data ?? (c.data.data ?? c.data),
      loading:false
    });
  }
}));
