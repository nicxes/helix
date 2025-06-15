import axios from "@/lib/axios";

import Breadcrumb from "@/components/Breadcrumb";
import Header from "@/components/Categories/Header";

export default async function page({ params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params;
  const { data: category } = await axios.get(`/categories/slug/${slug}`)

  return (
    <main>
      <Breadcrumb
        items={[
          { label: 'Categories', href: '/categories' },
          { label: category.name, href: `/categories/${category.slug}`, isActive: true }
        ]}
      />

      <Header
        title={category.name}
        cover={category.image_url}
      />

      <div>
        
      </div>
    </main>
  )
}
