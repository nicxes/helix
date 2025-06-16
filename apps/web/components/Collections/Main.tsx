/* eslint-disable @next/next/no-img-element */
"use client";

import { useState } from "react";
import { FaChevronRight, FaClock, FaTag } from "react-icons/fa";

import { Item } from "@/types/item";

import Card from "@/components/Items/Card";
import SalesChart from "@/components/Charts/SalesChart";

const data = [
  {
    time: "23h",
    image: "https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png",
    price: 1500000,
    user: 'Callum City Land',
    action: 'Sold'
  },
  {
    time: "23h",
    image: "https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png",
    price: 1500000,
    user: 'Parallel City Land',
    action: 'Listed'
  },
  {
    time: "23h",
    image: "https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png",
    price: 1500000,
    user: 'Parallel City Land',
    action: 'Offer'
  },
  {
    time: "23h",
    image: "https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png",
    price: 1500000,
    user: 'Parallel City Land',
    action: 'Sold'
  },
  {
    time: "23h",
    image: "https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png",
    price: 1500000,
    user: 'Parallel City Land',
    action: 'Sold'
  },
  {
    time: "23h",
    image: "https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png",
    price: 1500000,
    user: 'Callum City Land',
    action: 'Sold'
  },
  {
    time: "23h",
    image: "https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png",
    price: 1500000,
    user: 'Parallel City Land',
    action: 'Listed'
  },
  {
    time: "23h",
    image: "https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png",
    price: 1500000,
    user: 'Parallel City Land',
    action: 'Offer'
  },
  {
    time: "23h",
    image: "https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png",
    price: 1500000,
    user: 'Parallel City Land',
    action: 'Sold'
  },
  {
    time: "23h",
    image: "https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png",
    price: 1500000,
    user: 'Parallel City Land',
    action: 'Sold'
  }
]

export default function Main({ items }: { items: Item[] }) {
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
                id={item.id}
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
            
            {/* Sidebar Content */}
            <div className={`${isCollapsed ? 'w-0' : 'w-[400px]'} overflow-hidden transition-all duration-150 ease-in-out`}>
              
              {/* Activity */}
              <div className="px-8 py-6 border-b border-white/10">
                <div className="h-96 overflow-y-auto">
                  <div className="pb-2">
                    <h2 className="text-white font-semibold uppercase flex items-center gap-2">
                      <svg className="size-5" viewBox="0 0 20 20" fill="none">
                        <g clipPath="url(#clip0_19_13264)">
                          <path d="M17.8267 18.5471C17.8267 16.6689 16.305 15.1473 14.4268 15.1473C12.5487 15.1473 11.027 16.67 11.027 18.5471C11.027 18.5471 11.9983 20.0875 14.4268 20.0875C16.8554 20.0875 17.8267 18.5471 17.8267 18.5471Z" fill="white"/>
                          <path d="M16.176 12.8385C16.176 13.8046 15.3924 14.5872 14.4263 14.5883C13.9619 14.5883 13.5172 14.4038 13.1886 14.0752C12.861 13.7476 12.6765 13.3019 12.6765 12.8385C12.6765 12.3741 12.861 11.9294 13.1886 11.6008C13.5172 11.2722 13.9619 11.0887 14.4263 11.0887C15.3924 11.0887 16.176 11.8714 16.176 12.8385Z" fill="white"/>
                          <path d="M9.6316 7.37177C9.6316 5.4935 8.1099 3.97192 6.23175 3.97192C4.35361 3.97192 2.83191 5.49466 2.83191 7.37177C2.83191 7.37177 3.80319 8.91213 6.23175 8.91213C8.66031 8.91213 9.6316 7.37177 9.6316 7.37177Z" fill="white"/>
                          <path d="M7.98096 1.66223C7.98096 2.62832 7.19731 3.41199 6.2312 3.41199C5.76682 3.41199 5.32212 3.22748 4.99352 2.89992C4.66492 2.57132 4.48145 2.12662 4.48145 1.66223C4.48145 1.19888 4.66492 0.753149 4.99352 0.425584C5.32212 0.0969834 5.76682 -0.0875244 6.2312 -0.0875244C7.19729 -0.0875244 7.98096 0.696122 7.98096 1.66223Z" fill="white"/>
                          <path d="M3.03129 10.895C2.93488 10.9904 2.88098 11.121 2.88098 11.2568C2.88098 14.8403 5.79786 17.7561 9.38134 17.7572V17.7561C9.51713 17.7561 9.64774 17.7022 9.74415 17.6069C9.83951 17.5105 9.89341 17.3799 9.89341 17.2441C9.89341 17.1083 9.83951 16.9787 9.74415 16.8823C9.64775 16.7869 9.51714 16.733 9.38134 16.733C6.35141 16.733 3.90502 14.2877 3.90502 11.2567H3.90606C3.90606 11.1209 3.85112 10.9903 3.75575 10.8939C3.65935 10.7985 3.52874 10.7446 3.39295 10.7446C3.25715 10.7446 3.12769 10.7986 3.03129 10.895Z" fill="white"/>
                          <path d="M17.6251 9.10591C17.7215 9.0095 17.7754 8.87993 17.7754 8.74413C17.7754 5.16066 14.8596 2.24377 11.275 2.24377C10.992 2.24377 10.7629 2.47286 10.7629 2.75585C10.7629 3.03883 10.992 3.26792 11.275 3.26792C14.306 3.26792 16.7513 5.7132 16.7513 8.74424C16.7513 8.88003 16.8052 9.0096 16.9016 9.10601C16.997 9.20138 17.1276 9.25528 17.2634 9.25528C17.3992 9.25528 17.5297 9.20127 17.6251 9.10591Z" fill="white"/>
                          <path d="M18.9592 7.90854L17.4022 10.0263C17.2903 10.1393 17.1078 10.1393 16.9959 10.0263L15.4389 7.90957C15.3705 7.81628 15.4151 7.68774 15.5312 7.68774H18.869C18.984 7.68774 19.0431 7.82768 18.9612 7.90957L18.9592 7.90854Z" fill="white"/>
                          <path d="M5.21404 12.0913L3.6571 9.97353C3.54514 9.86055 3.3627 9.86055 3.25077 9.97353L1.69383 12.0902C1.62541 12.1835 1.66999 12.3121 1.78608 12.3121H5.12383C5.23889 12.3121 5.29798 12.1721 5.21609 12.0902L5.21404 12.0913Z" fill="white"/>
                        </g>
                        <defs>
                          <clipPath id="clip0_19_13264">
                            <rect className="size-5" fill="white"/>
                          </clipPath>
                        </defs>
                      </svg>

                      Activity
                    </h2>
                  </div>

                  <table className="w-full h-[200px] overflow-y-auto">
                    <thead className="text-white/50 text-sm font-semibold uppercase border-y border-white/10 h-11">
                      <tr>
                        <th align="left">
                          <FaClock />
                        </th>
                        <th align="center">
                          Item
                        </th>
                        <th align="center">
                          Price
                        </th>
                        <th align="left">
                          User
                        </th>
                        <th align="right">
                          Action
                        </th>
                      </tr>
                    </thead>
                    <tbody>
                      {data.map((item, index) => (
                        <tr key={index} className="h-14">
                          <td className="text-[#62DFD8] font-semibold">
                            {item.time}
                          </td>
                          <td align="center">
                            <img src={item.image} alt="" className="size-10 rounded" />
                          </td>
                          <td align="center" className="text-white font-semibold">
                            {item.price.toLocaleString()}
                          </td>
                          <td className="text-alert font-semibold truncate max-w-11">
                            {item.user}
                          </td>
                          <td align="right" className="text-white font-semibold">
                            {item.action}
                          </td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              </div>

              {/* Sales Graph */}
              <div className="px-8 py-6">
                <h2 className="text-white font-semibold uppercase flex items-center gap-2 pb-6">
                  <FaTag />
                  Sales Graph
                </h2>

                <SalesChart />                
              </div>
            </div>
          </div>

        </div>
      </div>
    </section>
  )
}