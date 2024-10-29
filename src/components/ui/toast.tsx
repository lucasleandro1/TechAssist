import * as React from "react";
import { cva } from "class-variance-authority";
import { cn } from "@/lib/utils";

const toastVariants = cva(
  "fixed bottom-4 right-4 p-4 rounded-md shadow-lg",
  {
    variants: {
      variant: {
        info: "bg-blue-100 text-blue-800",
        success: "bg-green-100 text-green-800",
        error: "bg-red-100 text-red-800",
      },
    },
    defaultVariants: {
      variant: "info",
    },
  }
);

export interface ToastProps {
  variant?: "info" | "success" | "error";
  message: string;
}

const Toast: React.FC<ToastProps> = ({ variant = "info", message }) => {
  return (
    <div className={cn(toastVariants({ variant }))}>
      {message}
    </div>
  );
};

export { Toast };
