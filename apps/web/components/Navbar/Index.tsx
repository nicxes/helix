"use client";

import Link from "next/link";
import config from "@/configs/config";
import { usePathname } from "next/navigation";
import { useSession } from "next-auth/react";

import Brand from "@/components/Navbar/Brand";
import Search from "@/components/Navbar/Search";
import Guestbox from "@/components/Navbar/Guestbox";
import Userbox from "@/components/Navbar/Userbox";

export default function Navbar() {
  const pathname = usePathname()
  const { data: session } = useSession()

  return (
    <nav>
      <div className="h-[72px]">
        <div className="container mx-auto max-w-hd px-6 h-full">

          <div className="grid grid-cols-[1fr_486px_1fr] items-center justify-between h-full">
            <Brand />
            <Search />
            {session ? <Userbox /> : <Guestbox />}
          </div>
        </div>
      </div>

      <div className="h-14 bg-white/5 border-y border-white/5">
        <div className="container mx-auto max-w-hd px-6 h-full">
          <div className="flex items-center justify-center gap-5 h-full">
            {config.links.map((link) => (
              <Link
                href={link.href}
                key={link.label}
                className={`${pathname === link.href ? 'text-white' : 'text-white/50'} hover:text-white font-semibold uppercase transition duration-150 ease-in-out`}
              >
                {link.label}
              </Link>
            ))}
          </div>
        </div>
      </div>
    </nav>
  )
}