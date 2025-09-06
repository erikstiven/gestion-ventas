import { type InputHTMLAttributes, forwardRef } from "react";
import { twMerge } from "tailwind-merge";
export const Input = forwardRef<HTMLInputElement, InputHTMLAttributes<HTMLInputElement>>(
  ({ className, ...props }, ref) => (
    <input ref={ref} className={twMerge("w-full rounded-xl border px-3 py-2 bg-white focus:outline-none focus:ring", className)} {...props}/>
  )
);
Input.displayName = "Input";
