import axios from "@/lib/axios";

import Breadcrumb from "@/components/Breadcrumb";
import Intro from "@/components/Collections/Intro";

export default async function page({ params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params;
  const { data: collection } = await axios.get(`/collections/slug/${slug}`)

  return (
    <main>
      <Breadcrumb
        items={[
          { label: 'Collections', href: '/collections' },
          { label: collection.name, href: `/collections/${collection.slug}`, isActive: true }
        ]}
      />

      <Intro
        cover={collection.cover_image}
        avatar={`https://api.dicebear.com/9.x/bottts-neutral/svg?seed=${collection.slug}`}
        name={collection.name}
        category={collection.categories.name}
        description="Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent velit turpis, congue vel purus eu, elementum ornare erat. Integer tincidunt tellus enim, at laoreet neque fringilla ac. Ut commodo odio metus, vitae euismod elit iaculis id. Aenean auctor vehicula mauris non pulvinar. Sed dictum lacus nec neque ultrices, vel cursus turpis molestie. Nulla facilisi. Praesent pharetra, elit a semper rutrum, nunc urna consequat enim, non tristique lorem eros sed lorem. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Sed nunc dui, accumsan vel consectetur et, rhoncus et ante."
        total_volume={collection.volume_24h}
        floor_price={collection.floor_price}
        total_supply={4000}
        total_holders={100}
      />
    </main>
  )
}
