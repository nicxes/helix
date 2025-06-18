import Breadcrumb from "@/components/Breadcrumb";
import ModelView from "@/components/Items/ModelView";
import Specs from "@/components/Items/Specs";
import Header from "@/components/Items/Header";

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
              <Header />

            </div>

          </div>
        </div>
      </section>

      <section>
        <div className="container mx-auto max-w-hd px-6">
          <h2 className="font-tungsten text-white text-[56px] uppercase">
            More Weapons
          </h2>

          
        </div>
      </section>
    </main>
  )
}
