import Breadcrumb from "@/components/Breadcrumb";
import Header from "@/components/Header";
import CollectionCard from "@/components/Collections/Card";

const collections = [
  {
    id: 1,
    name: "Panda Weapon Pack",
    image: "https://api.dicebear.com/9.x/bottts-neutral/svg?seed=nico",
    cover: "/images/collection-1-cover.png",
    floor_price: 5000,
    total_volume: 1500,
    isVerified: true
  },
  {
    id: 2,
    name: "Panda Weapon Pack",
    image: "https://api.dicebear.com/9.x/bottts-neutral/svg?seed=alex",
    cover: "/images/collection-1-cover.png",
    floor_price: 5000,
    total_volume: 1500,
    isVerified: true
  },
  {
    id: 3,
    name: "Panda Weapon Pack",
    image: "https://api.dicebear.com/9.x/bottts-neutral/svg?seed=mica",
    cover: "/images/collection-1-cover.png",
    floor_price: 5000,
    total_volume: 1500,
    isVerified: true
  },
  {
    id: 4,
    name: "Panda Weapon Pack",
    image: "https://api.dicebear.com/9.x/bottts-neutral/svg?seed=caro",
    cover: "/images/collection-1-cover.png",
    floor_price: 5000,
    total_volume: 1500,
    isVerified: true
  },
  {
    id: 5,
    name: "Panda Weapon Pack",
    image: "https://api.dicebear.com/9.x/bottts-neutral/svg?seed=steve",
    cover: "/images/collection-1-cover.png",
    floor_price: 5000,
    total_volume: 1500,
    isVerified: true
  },
  {
    id: 6,
    name: "Panda Weapon Pack",
    image: "https://api.dicebear.com/9.x/bottts-neutral/svg?seed=john",
    cover: "/images/collection-1-cover.png",
    floor_price: 5000,
    total_volume: 1500,
    isVerified: true
  },
  {
    id: 7,
    name: "Panda Weapon Pack",
    image: "https://api.dicebear.com/9.x/bottts-neutral/svg?seed=dianne",
    cover: "/images/collection-1-cover.png",
    floor_price: 5000,
    total_volume: 1500,
    isVerified: true
  },
  {
    id: 8,
    name: "Panda Weapon Pack",
    image: "https://api.dicebear.com/9.x/bottts-neutral/svg?seed=robert",
    cover: "/images/collection-1-cover.png",
    floor_price: 5000,
    total_volume: 1500,
    isVerified: true
  }
];

export default function page() {
  return (
    <main>
      <Breadcrumb />
      <Header />

      <section className="py-10">
        <div className="container mx-auto max-w-hd px-6">
          {/* Filters */}

          <hr className="mt-10 mb-6 border-white/10"/>

          {/* Collections */}
          <div className="grid grid-cols-[repeat(auto-fill,minmax(320px,1fr))] gap-6">
            {collections.map((collection) => (
              <CollectionCard
                key={collection.id}
                name={collection.name}
                image={collection.image}
                cover={collection.cover}
                floor_price={collection.floor_price}
                total_volume={collection.total_volume}
                isVerified={collection.isVerified}
              />
            ))}
          </div>
        </div>
      </section>
    </main>
  )
}
