type Col<T>={ key: keyof T; label: string; render?:(row:T)=>React.ReactNode };
export default function DataTable<T>({rows, cols}:{rows:T[]; cols:Col<T>[];}){
  return (
    <div className="overflow-x-auto border rounded">
      <table className="min-w-full text-sm">
        <thead className="bg-gray-100">
          <tr>{cols.map(c=> <th key={String(c.key)} className="text-left px-3 py-2">{c.label}</th>)}</tr>
        </thead>
        <tbody>
          {rows.map((r,i)=>(
            <tr key={i} className="odd:bg-white even:bg-gray-50">
              {cols.map(c=> <td key={String(c.key)} className="px-3 py-2">{c.render? c.render(r): String((r as any)[c.key])}</td>)}
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
