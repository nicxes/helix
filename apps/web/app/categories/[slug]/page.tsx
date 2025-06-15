import axios from "@/lib/axios";

import Breadcrumb from "@/components/Breadcrumb";
import Header from "@/components/Categories/Header";

export default async function page({ params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params;
  const { data: collection } = await axios.get(`/categories/slug/${slug}`)

  return (
    <main>
      <Breadcrumb
        items={[
          { label: 'Categories', href: '/categories' },
          { label: collection.name, href: `/categories/${collection.slug}`, isActive: true }
        ]}
      />

      <Header
        title={collection.name}
        cover=""
      />

      <div>
        
      </div>
    </main>
  )
}
