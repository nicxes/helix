import Breadcrumb from "@/components/Breadcrumb";
import ModelView from "@/components/Items/ModelView";
import Specs from "@/components/Items/Specs";
import Header from "@/components/Items/Header";
import MoreItems from "@/components/Items/MoreItems";
import { Item } from "@/types/item";
import { notFound } from "next/navigation";

interface PageProps {
  params: {
    slug: string;
  };
}

async function getItem(id: string): Promise<Item | null> {
  try {
    const apiUrl = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:3001';
    const response = await fetch(`${apiUrl}/items/${id}`, {
      // Next.js 13+ server-side fetch configuration
      cache: 'no-store', // Always fetch fresh data, or use 'force-cache' for caching
    });

    if (!response.ok) {
      if (response.status === 404) {
        return null;
      }
      throw new Error(`Failed to fetch item: ${response.status}`);
    }

    const item = await response.json();
    return item;
  } catch (error) {
    console.error('Error fetching item:', error);
    return null;
  }
}

export default async function ItemPage({ params }: PageProps) {
  const item = await getItem(params.slug);

  console.log(item)

  if (!item) {
    notFound();
  }

  return (
    <main>
      <Breadcrumb
        items={[
          { label: 'Items', href: '/' },
          { label: item.name, href: `/items/${item.id}`, isActive: true }
        ]}
      />

      <section>
        <div className="container mx-auto max-w-hd px-6">
          <div className="grid grid-cols-2 gap-6">

            <div>
              <div className="sticky top-6 space-y-6">
                <ModelView />
                <Specs
                  description={item.description}
                  productionYear={item.attributes.productionYear}
                  category={item.attributes.category}
                  condition={item.attributes.condition}
                  type={item.attributes.type}
                />
              </div>
            </div>

            <div>
              <Header />
            </div>

          </div>
        </div>
      </section>

      <MoreItems />
    </main>
  )
}
