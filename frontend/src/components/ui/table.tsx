export function Table({ children }:{children:React.ReactNode}){ return <div className="overflow-x-auto rounded-xl border bg-white"><table className="min-w-full text-sm">{children}</table></div>; }
export const THead=({children}:{children:React.ReactNode})=><thead className="bg-zinc-50"><tr>{children}</tr></thead>;
export const Th=({children}:{children:React.ReactNode})=><th className="px-3 py-2 text-left font-semibold">{children}</th>;
export const TBody=({children}:{children:React.ReactNode})=><tbody>{children}</tbody>;
export const Td=({children}:{children:React.ReactNode})=><td className="px-3 py-2">{children}</td>;
