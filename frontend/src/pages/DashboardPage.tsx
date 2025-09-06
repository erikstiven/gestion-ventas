import { useEffect, useState } from "react";
import api from "../api/client";
import { Card, CardContent, CardHeader } from "../components/ui/card";
import { Table, THead, Th, TBody, Td } from "../components/ui/table";
import Button from "../components/ui/button";
import { Input } from "../components/ui/input";

export default function DashboardPage(){
  const [byZone,setByZone]=useState<any[]>([]);
  const [zonesNoSales,setZonesNoSales]=useState<any[]>([]);
  const [sellersNoSales,setSellersNoSales]=useState<any[]>([]);
  const [byClient,setByClient]=useState<any[]>([]);
  const [range,setRange]=useState({start_date:"",end_date:""}); const [year,setYear]=useState("");

  const load=async()=>{
    const qs = (o:any)=>{ const q=new URLSearchParams(); Object.entries(o).forEach(([k,v])=>{ if(v) q.set(k,String(v)); }); return q.toString()?`?${q.toString()}`:""; };
    const [a,b,c,d] = await Promise.all([
      api.get(`/reports/ventas-por-zona-por-vendedor${qs(range)}`),
      api.get(`/reports/zonas-sin-ventas${qs(range)}`),
      api.get(`/reports/vendedores-sin-ventas${qs(range)}`),
      api.get(`/reports/ventas-por-cliente${qs({year})}`)
    ]);
    setByZone(a.data.data ?? a.data);
    setZonesNoSales(b.data.data ?? b.data);
    setSellersNoSales(c.data.data ?? c.data);
    setByClient(d.data.data ?? d.data);
  };

  useEffect(()=>{ load(); },[]);

  return (
    <div className="space-y-8">
      <Card>
        <CardHeader>
          <div className="space-y-1">
            <h1 className="text-2xl font-semibold">Dashboard</h1>
            <p className="text-zinc-600 text-sm">Reportes clave con filtros de fecha y año.</p>
          </div>
          <div className="flex items-center gap-2">
            <Input type="date" value={range.start_date} onChange={e=>setRange(r=>({...r,start_date:e.target.value}))}/>
            <Input type="date" value={range.end_date} onChange={e=>setRange(r=>({...r,end_date:e.target.value}))}/>
            <Input type="number" placeholder="Año (ventas por cliente)" value={year} onChange={e=>setYear(e.target.value)} />
            <Button variant="outline" onClick={load}>Aplicar</Button>
          </div>
        </CardHeader>
        <CardContent className="space-y-6">
          <section>
            <h2 className="mb-2 text-xl font-semibold">Zonas con más ventas por vendedor</h2>
            <Table>
              <THead><Th>Zona</Th><Th>Vendedor</Th><Th>Ventas</Th><Th>Monto</Th></THead>
              <TBody>{byZone.map((r:any,i:number)=>(
                <tr key={i} className="border-t"><Td>{r.nombre_zona}</Td><Td>{r.vendedor}</Td><Td>{r.total_ventas}</Td><Td>{r.total_monto}</Td></tr>
              ))}</TBody>
            </Table>
          </section>

          <section className="grid gap-6 md:grid-cols-2">
            <div>
              <h2 className="mb-2 text-xl font-semibold">Zonas sin ventas</h2>
              <Table><THead><Th>Zona</Th></THead><TBody>{zonesNoSales.map((z:any,i:number)=>(<tr key={i} className="border-t"><Td>{z.nombre_zona}</Td></tr>))}</TBody></Table>
            </div>
            <div>
              <h2 className="mb-2 text-xl font-semibold">Vendedores sin ventas</h2>
              <Table><THead><Th>Vendedor</Th><Th>Email</Th></THead><TBody>{sellersNoSales.map((v:any,i:number)=>(<tr key={i} className="border-t"><Td>{v.nombre}</Td><Td>{v.email}</Td></tr>))}</TBody></Table>
            </div>
          </section>

          <section>
            <h2 className="mb-2 text-xl font-semibold">Ventas por cliente (2020–2023)</h2>
            <Table>
              <THead><Th>ID Cliente</Th><Th>Cliente</Th><Th>Zona</Th><Th>2020</Th><Th>2021</Th><Th>2022</Th><Th>2023</Th></THead>
              <TBody>{byClient.map((r:any,i:number)=>(
                <tr key={i} className="border-t">
                  <Td>{r.id_cliente}</Td><Td>{r.nombre_cliente}</Td><Td>{r.zona}</Td>
                  <Td>{r.y2020 ?? r.ventas?.["2020"]}</Td>
                  <Td>{r.y2021 ?? r.ventas?.["2021"]}</Td>
                  <Td>{r.y2022 ?? r.ventas?.["2022"]}</Td>
                  <Td>{r.y2023 ?? r.ventas?.["2023"]}</Td>
                </tr>
              ))}</TBody>
            </Table>
          </section>
        </CardContent>
      </Card>
    </div>
  );
}
