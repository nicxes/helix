import axios from "@/lib/axios";

import Breadcrumb from "@/components/Breadcrumb";
import Intro from "@/components/Collections/Intro";

export default async function page({ params }: { params: { slug: string } }) {
  const { data: collection } = await axios.get(`/collections/slug/${params.slug}`)

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
      />
    </main>
  )
}
