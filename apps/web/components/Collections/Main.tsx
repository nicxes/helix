"use client";

import { useState } from "react";
import { FaChevronRight } from "react-icons/fa";

import Card from "@/components/Items/Card";

export default function Main({ items }: { items: any[] }) {
  const [isCollapsed, setCollapsed] = useState(false);

  return (
    <section className="border-t border-white/10 mx-6">
      <div className="container mx-auto max-w-hd">
        <div className="flex gap-4">

          {/* Grid Items */}
          <div className="flex-1 grid grid-cols-[repeat(auto-fill,minmax(280px,1fr))] gap-3 py-5">
            {items.map((item) => (
              <Card
                key={item.id}
                image={item.image}
                author={item.user.username}
                name={item.name}
                price={1500}
                supply={50}
                isVerified={item.user.verified}
              />
            ))}
          </div>

          {/* Sidebar */}
          <div className="relative border-l border-white/10">
            {/* Button Collapse - Always visible */}
            <button
              type="button"
              className="absolute top-4 -left-0.5 bg-background w-5 h-10 rounded-r border-y border-r border-white/10 z-10 flex items-center justify-center cursor-pointer group"
              onClick={() => setCollapsed(!isCollapsed)}             
            >
              <FaChevronRight className={`${isCollapsed ? 'rotate-180' : ''} text-white/70 group-hover:text-white text-xs transition-all duration-300 ease-in-out`} />
            </button>
            
            {/* Sidebar Container */}
            <div className={`${isCollapsed ? 'w-0' : 'w-[400px]'} overflow-hidden transition-all duration-150 ease-in-out`}>
              

              <div className="bg-alert h-10">

              </div>
            </div>
          </div>

        </div>
      </div>
    </section>
  )
}