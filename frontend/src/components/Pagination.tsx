type Props={page:number; perPage:number; total:number; onPage:(p:number)=>void};
export default function Pagination({page,perPage,total,onPage}:Props){
  const pages = Math.max(1, Math.ceil(total/perPage));
  return (
    <div className="mt-4 flex items-center gap-2">
      <button className="rounded-lg border px-3 py-1" disabled={page<=1} onClick={()=>onPage(page-1)}>Anterior</button>
      <span className="text-sm">{page}/{pages}</span>
      <button className="rounded-lg border px-3 py-1" disabled={page>=pages} onClick={()=>onPage(page+1)}>Siguiente</button>
    </div>
  );
}
