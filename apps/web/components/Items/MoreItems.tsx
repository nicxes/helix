"use client"

import { FaAngleRight } from "react-icons/fa";
import { Swiper, SwiperSlide } from "swiper/react";

import "swiper/css";
import "swiper/css/autoplay";

import ItemCard from "@/components/Items/Card";

export default function MoreItems() {
  return (
    <section className="pt-20 pb-10">
      <div className="container mx-auto max-w-hd px-6">
        <div className="flex items-center justify-between">
          <h2 className="font-tungsten text-white text-[56px] uppercase">
            More Weapons
          </h2>

          <button className="text-white font-bold uppercase flex items-center gap-2 bg-white/5 rounded px-4 h-10 cursor-pointer">
            View More <FaAngleRight size={16} />
          </button>
        </div>
      </div>

      <div className="relative container mx-auto max-w-hd pl-6">
        <div className="absolute right-0 top-0 bottom-0 z-10 w-28 from-transparent to-background bg-gradient-to-r"/>
        
        <Swiper
          initialSlide={2}
          slidesPerView={5}
          spaceBetween={16}
        >
          <SwiperSlide>
            <ItemCard
              id="1"
              image="/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png"
              author="CallumGamer"
              name="PANDA HEX QUEEN SKIN"
              price={100}
              supply={100}
              isVerified={true}
            />
          </SwiperSlide>

          <SwiperSlide>
            <ItemCard
              id="1"
              image="/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png"
              author="CallumGamer"
              name="PANDA HEX QUEEN SKIN"
              price={100}
              supply={100}
              isVerified={true}
            />
          </SwiperSlide>

          <SwiperSlide>
            <ItemCard
              id="1"
              image="/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png"
              author="CallumGamer"
              name="PANDA HEX QUEEN SKIN"
              price={100}
              supply={100}
              isVerified={true}
            />
          </SwiperSlide>

          <SwiperSlide>
            <ItemCard
              id="1"
              image="/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png"
              author="CallumGamer"
              name="PANDA HEX QUEEN SKIN"
              price={100}
              supply={100}
              isVerified={true}
            />
          </SwiperSlide>

          <SwiperSlide>
            <ItemCard
              id="1"
              image="/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png"
              author="CallumGamer"
              name="PANDA HEX QUEEN SKIN"
              price={100}
              supply={100}
              isVerified={true}
            />
          </SwiperSlide>

          <SwiperSlide>
            <ItemCard
              id="1"
              image="/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png"
              author="CallumGamer"
              name="PANDA HEX QUEEN SKIN"
              price={100}
              supply={100}
              isVerified={true}
            />
          </SwiperSlide>
        </Swiper>
      </div>
    </section>
  )
}
