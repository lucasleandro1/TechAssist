import * as React from "react";
import { cva, type VariantProps } from "class-variance-authority";
import { cn } from "@/lib/utils";

const cardVariants = cva(
    "rounded-lg overflow-hidden transition-shadow",
    {
        variants: {
            shadow: {
                none: "shadow-none",
                sm: "shadow-sm",
                md: "shadow-md",
                lg: "shadow-lg",
            },
        },
        defaultVariants: {
            shadow: "md",
        },
    }   
);

export interface CardProps
    extends React.HTMLAttributes<HTMLDivElement>,
        VariantProps<typeof cardVariants> {}
    
const Card: React.FC<CardProps> = ({ className, shadow, children, ...props}) => (
    <div className={cn(cardVariants({ shadow, className }))} {...props}>
        {children}
     </div>
);
export {Card, cardVariants};
