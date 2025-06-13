/* eslint-disable @next/next/no-img-element */
'use client'

import { useState } from "react";

export default function Intro({ cover, avatar }: { cover: string, avatar: string }) {
  const [open, setOpen] = useState(false);

  return (
    <header>
      <div className="container mx-auto max-w-hd px-6">
        {/* Cover */}
        <div>
          <img
            src={cover}
            alt="Cover"
            className="size-full max-h-96 object-cover object-center rounded-lg"
          />
        </div>
        
        <div className="space-y-1 -translate-y-16 transition duration-150 ease-in-out">
          {/* Avatar */}
          <div className="pl-6">
            <img
              src={avatar}
              alt="Avatar"
              className="border-2 border-neutral-900 size-32 rounded-lg"
            />
          </div>

          <div className="grid grid-cols-[auto_320px] gap-6 items-end">
            {/* Title & Description */}
            <div className="space-y-3">
              <h1 className="font-tungsten text-white text-[56px] leading-[62px] uppercase">
                Panda Weapon Pack
              </h1>
              <p className="font-barlow font-semibold leading-[126%]">
                Category: <span className="text-yellow-300">Weapons</span>
              </p>
              <div className={`flex gap-1 ${open ? 'flex-col max-w-full' : 'flex-row items-center max-w-96'}`}>
                <p className={`${open ? 'text-balance' : 'truncate'} text-white/50 font-medium`}>
                  Lorem ipsum, dolor sit amet consectetur adipisicing elit. Reiciendis modi suscipit libero voluptatem enim, voluptatibus eveniet, reprehenderit at odit cupiditate illo cum minus rerum? Est placeat nulla explicabo quam accusantium!
                </p>
                <p className="shrink-0">
                  <a className="text-[#F8684F] capitalize cursor-pointer" onClick={() => setOpen(!open)}>
                    See more
                  </a>
                </p>
              </div>
            </div>

            {/* Stats */}
            <div className="border-white/10 rounded-lg border-2 p-5">
              <ul className="space-y-3.5">
                <li className="flex items-center justify-between gap-2">
                  <span className="text-white/50 font-semibold capitalize">
                    Total volume
                  </span>
                  <span className="text-white font-semibold uppercase flex items-center gap-1">
                    120000
                  </span>
                </li>

                <li className="flex items-center justify-between gap-2">
                  <span className="text-white/50 font-semibold capitalize">
                    Floor price
                  </span>
                  <span className="text-white font-semibold uppercase flex items-center gap-1">
                    120000
                  </span>
                </li>

                <li className="flex items-center justify-between gap-2">
                  <span className="text-white/50 font-semibold capitalize">
                    Total supply
                  </span>
                  <span className="text-white font-semibold uppercase flex items-center gap-1">
                    120000
                  </span>
                </li>

                <li className="flex items-center justify-between gap-2">
                  <span className="text-white/50 font-semibold capitalize">
                    Owners
                  </span>
                  <span className="text-white font-semibold uppercase flex items-center gap-1">
                    120000
                  </span>
                </li>

              </ul>
            </div>
          </div>
            
        </div>
      </div>
    </header>
  )
}
