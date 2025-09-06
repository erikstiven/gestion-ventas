import type { HTMLAttributes } from "react";
import { twMerge } from "tailwind-merge";
export function Card(p:HTMLAttributes<HTMLDivElement>){ return <div {...p} className={twMerge("card border bg-white shadow-sm", p.className)} /> }
export function CardHeader(p:HTMLAttributes<HTMLDivElement>){ return <div {...p} className={twMerge("border-b px-4 py-3 flex items-center justify-between", p.className)} /> }
export function CardContent(p:HTMLAttributes<HTMLDivElement>){ return <div {...p} className={twMerge("p-4", p.className)} /> }
