import * as React from "react";
import { cva } from "class-variance-authority";
import { cn } from "@/lib/utils";

const textareaVariants = cva(
  "border rounded-md p-2 w-full resize-none",
  {
    variants: {
      variant: {
        default: "border-gray-300",
        error: "border-red-500",
      },
    },
    defaultVariants: {
      variant: "default",
    },
  }
);

export interface TextareaProps extends React.TextareaHTMLAttributes<HTMLTextAreaElement> {
  label?: string;
  variant?: "default" | "error";
}

const Textarea: React.FC<TextareaProps> = ({ label, variant, className, ...props }) => {
  return (
    <div className={className}>
      {label && <label className="block mb-2">{label}</label>}
      <textarea className={cn(textareaVariants({ variant }))} {...props} />
    </div>
  );
};

export { Textarea };
