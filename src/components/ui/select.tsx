import * as React from "react";
import { cva, type VariantProps } from "class-variance-authority";
import { cn } from "@/lib/utils";

const selectVariants = cva(
  "border rounded-md p-2 text-sm transition-colors focus-visible:outline-none focus-visible:ring-2",
  {
    variants: {
      variant: {
        default: "border-gray-300 bg-white text-gray-900",
        error: "border-red-500 bg-red-100 text-red-900",
      },
    },
    defaultVariants: {
      variant: "default",
    },
  }
);

export interface SelectProps extends React.SelectHTMLAttributes<HTMLSelectElement>, VariantProps<typeof selectVariants> {}

const Select = React.forwardRef<HTMLSelectElement, SelectProps>(
  ({ className, variant, children, ...props }, ref) => {
    return (
      <select className={cn(selectVariants({ variant, className }))} ref={ref} {...props}>
        {children}
      </select>
    );
  }
);
Select.displayName = "Select";

export { Select, selectVariants };
