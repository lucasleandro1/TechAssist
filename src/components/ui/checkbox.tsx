import * as React from "react";
import { cva } from "class-variance-authority";
import { cn } from "@/lib/utils";

const checkboxVariants = cva(
  "h-4 w-4 border rounded-md focus:ring-2 focus:ring-blue-500",
  {
    variants: {
      variant: {
        default: "bg-white border-gray-300",
        error: "bg-red-100 border-red-500",
      },
    },
    defaultVariants: {
      variant: "default",
    },
  }
);

export interface CheckboxProps extends React.InputHTMLAttributes<HTMLInputElement> {
  label?: string;
}

const Checkbox: React.FC<CheckboxProps> = ({ label, ...props }) => {
  return (
    <label className="inline-flex items-center">
      <input type="checkbox" className={cn(checkboxVariants())} {...props} />
      {label && <span className="ml-2">{label}</span>}
    </label>
  );
};

export { Checkbox };
