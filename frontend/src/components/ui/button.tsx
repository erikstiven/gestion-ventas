import type { ButtonHTMLAttributes } from "react";
import { twMerge } from "tailwind-merge";
import clsx from "clsx";
type Variant = "primary" | "secondary" | "outline" | "ghost" | "danger";
type Size = "sm" | "md";
const base = "inline-flex items-center justify-center font-medium transition-colors focus:outline-none disabled:opacity-50";
const sizes:Record<Size,string>={ sm:"h-9 px-3 text-sm rounded-lg", md:"h-10 px-4 rounded-xl" };
const variants:Record<Variant,string>={
  primary:"bg-emerald-600 text-white hover:bg-emerald-700",
  secondary:"bg-zinc-900 text-white hover:bg-zinc-800",
  outline:"border border-zinc-300 hover:bg-zinc-50",
  ghost:"hover:bg-zinc-100",
  danger:"border border-red-600 text-red-700 hover:bg-red-50"
};
export default function Button({ className, children, variant="primary", size="md", ...props }:
  ButtonHTMLAttributes<HTMLButtonElement> & {variant?:Variant; size?:Size}) {
  return <button className={twMerge(clsx(base, sizes[size], variants[variant], "btn", className))} {...props}>{children}</button>;
}
