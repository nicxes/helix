import Breadcrumb from "@/components/Breadcrumb";
import ModelView from "@/components/Items/ModelView";
import Specs from "@/components/Items/Specs";
import Header from "@/components/Items/Header";
import MoreItems from "@/components/Items/MoreItems";
import { Item } from "@/types/item";
import { notFound } from "next/navigation";
import axios from "@/lib/axios";

interface PageProps {
  params: Promise<{
    slug: string;
  }>;
}

async function getItem(id: string): Promise<Item | null> {
  try {
    const response = await axios.get(`/items/${id}`);
    return response.data;
  } catch (error: any) {
    if (error.response?.status === 404) {
      return null;
    }
    console.error('Error fetching item:', error);
    return null;
  }
}

export default async function ItemPage({ params }: PageProps) {
  const resolvedParams = await params;
  const item = await getItem(resolvedParams.slug);

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
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">

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
              <Header
                id={item.id}
              />
            </div>

          </div>
        </div>
      </section>

      <MoreItems />
    </main>
  )
}
