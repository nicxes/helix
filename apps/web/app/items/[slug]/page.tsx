import Breadcrumb from "@/components/Breadcrumb";
import ModelView from "@/components/Items/ModelView";
import Specs from "@/components/Items/Specs";

export default function ItemPage() {
  return (
    <main>
      <Breadcrumb
        items={[
          { label: 'Items', href: '/' },
          { label: 'PANDA HEX QUEEN SKIN', href: '/items', isActive: true }
        ]}
      />

      <section>
        <div className="container mx-auto max-w-hd px-6">
          <div className="grid grid-cols-2 gap-6">

            <div className="space-y-6">
              <ModelView />
              <Specs />
            </div>

            <div>

            </div>

          </div>
        </div>
      </section>
    </main>
  )
}
