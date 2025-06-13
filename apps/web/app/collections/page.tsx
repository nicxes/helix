"use client";

import useSWR from 'swr'
import { fetcher } from "@/lib/axios";

import { Collection, CollectionsResponse } from "@/types/collection";

import Breadcrumb from "@/components/Breadcrumb";
import Header from "@/components/Header";
import CollectionCard from "@/components/Collections/Card";

// https://api.dicebear.com/9.x/bottts-neutral/svg?seed=nico

export default function page() {
  const { data } = useSWR<CollectionsResponse>('/collections', fetcher)

  return (
    <main>
      <Breadcrumb
        items={[
          { label: 'Collections', href: '/collections' }
        ]}
      />
      
      <Header />

      <section className="py-10">
        <div className="container mx-auto max-w-hd px-6">
          {/* Filters */}

          <hr className="mt-10 mb-6 border-white/10"/>

          {/* Collections */}
          <div className="grid grid-cols-[repeat(auto-fill,minmax(320px,1fr))] gap-6">
            {data?.collections.map((collection: Collection) => (
              <CollectionCard
                key={collection.id}
                name={collection.name}
                image={collection.cover_image}
                cover={collection.cover_image}
                floor_price={collection.floor_price}
                total_volume={collection.volume_24h}
                isVerified={true}
              />
            ))}
          </div>
        </div>
      </section>
    </main>
  )
}
