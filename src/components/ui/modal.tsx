import * as React from "react";
import { cva, type VariantProps } from "class-variance-authority";
import { cn } from "@/lib/utils";

const modalVariants = cva(
    "fixed inset-0 flex items-center justify-center z-50",
    {
      variants: {
        size: {
          sm: "max-w-sm",
          md: "max-w-md",
          lg: "max-w-lg",
        },
      },
      defaultVariants: {
        size: "md",
      },
    }
  );
  
  export interface ModalProps
    extends React.HTMLAttributes<HTMLDivElement>,
      VariantProps<typeof modalVariants> {
    isOpen: boolean;
    onClose: () => void;
  }
  
  const Modal: React.FC<ModalProps> = ({ isOpen, onClose, children, className, size, ...props }) => {
    if (!isOpen) return null;
    return (
      <div className={cn(modalVariants({ size, className }))} {...props}>
        <div className="bg-white p-6 rounded-lg shadow-lg">
          <button onClick={onClose} className="absolute top-2 right-2">Close</button>
          {children}
        </div>
      </div>
    );
  };
  
  export { Modal, modalVariants };
  