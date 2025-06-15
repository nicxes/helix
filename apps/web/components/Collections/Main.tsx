"use client";

import { useState } from "react";
import { FaChevronRight } from "react-icons/fa";

import Card from "@/components/Items/Card";

export default function Main() {
  const [isCollapsed, setCollapsed] = useState(false);

  return (
    <section className="border-t border-white/10 mx-6">
      <div className="container mx-auto max-w-hd">
        <div className={`grid divide-x divide-white/10 gap-4 ${isCollapsed ? 'grid-cols-[1fr]' : 'grid-cols-[1fr_400px]'} transition duration-150 ease-in-out will-change-auto`}>

          {/* Grid Items */}
          <div className="grid grid-cols-[repeat(auto-fill,minmax(280px,1fr))] gap-3 pr-4 py-5">
            <Card
              image="/images/01b8792575f2710d62a4b031a9e0e25c39927609.png"
              author="Parallel City Land"
              name="HELIX - PARALLEL CITY LAND #2405 - 660 WEST 85TH STREET"
              price={1500}
              supply={50}
              isVerified
            />

            <Card
              image="/images/01b8792575f2710d62a4b031a9e0e25c39927609.png"
              author="Parallel City Land"
              name="HELIX - PARALLEL CITY LAND #2405 - 660 WEST 85TH STREET"
              price={1500}
              supply={50}
              isVerified
            />

            <Card
              image="/images/01b8792575f2710d62a4b031a9e0e25c39927609.png"
              author="Parallel City Land"
              name="HELIX - PARALLEL CITY LAND #2405 - 660 WEST 85TH STREET"
              price={1500}
              supply={50}
              isVerified
            />

            <Card
              image="/images/01b8792575f2710d62a4b031a9e0e25c39927609.png"
              author="Parallel City Land"
              name="HELIX - PARALLEL CITY LAND #2405 - 660 WEST 85TH STREET"
              price={1500}
              supply={50}
              isVerified
            />

            <Card
              image="/images/01b8792575f2710d62a4b031a9e0e25c39927609.png"
              author="Parallel City Land"
              name="HELIX - PARALLEL CITY LAND #2405 - 660 WEST 85TH STREET"
              price={1500}
              supply={50}
              isVerified
            />

            <Card
              image="/images/01b8792575f2710d62a4b031a9e0e25c39927609.png"
              author="Parallel City Land"
              name="HELIX - PARALLEL CITY LAND #2405 - 660 WEST 85TH STREET"
              price={1500}
              supply={50}
              isVerified
            />

            <Card
              image="/images/01b8792575f2710d62a4b031a9e0e25c39927609.png"
              author="Parallel City Land"
              name="HELIX - PARALLEL CITY LAND #2405 - 660 WEST 85TH STREET"
              price={1500}
              supply={50}
              isVerified
            />

            <Card
              image="/images/01b8792575f2710d62a4b031a9e0e25c39927609.png"
              author="Parallel City Land"
              name="HELIX - PARALLEL CITY LAND #2405 - 660 WEST 85TH STREET"
              price={1500}
              supply={50}
              isVerified
            />
          </div>

          {/* Sidebar */}
          <div className="relative">
            {/* Button Collapse */}
            <button
              type="button"
              className="absolute top-4 -left-4.5 bg-background w-4 h-10 rounded-r-md border-r border-white/10 border-y"
              onClick={() => setCollapsed(!isCollapsed)}             
            >
              <FaChevronRight className="text-white/50 hover:text-white text-xs transition duration-150 ease-in-out cursor-pointer" />
            </button>
          </div>

        </div>
      </div>
    </section>
  )
}