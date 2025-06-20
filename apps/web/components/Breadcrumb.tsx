import Link from "next/link";

export default function Breadcrumb({ items }: { items?: { label: string, href: string, isActive?: boolean }[] }) {
  return (
    <section className="py-7">
      <div className="container mx-auto max-w-hd px-6">
        <ul className="flex items-center gap-2">
          <li className="group">
            <Link href="/">
              <svg className={`${(items && items.length > 1) ? 'fill-white/50' : 'fill-white'} size-6 hover:fill-white transition duration-150 ease-in-out`} viewBox="0 0 24 24">
                <path d="M10.0001 19V14H14.0001V19C14.0001 19.55 14.4501 20 15.0001 20H18.0001C18.5501 20 19.0001 19.55 19.0001 19V12H20.7001C21.1601 12 21.3801 11.43 21.0301 11.13L12.6701 3.59997C12.2901 3.25997 11.7101 3.25997 11.3301 3.59997L2.9701 11.13C2.6301 11.43 2.8401 12 3.3001 12H5.0001V19C5.0001 19.55 5.4501 20 6.0001 20H9.0001C9.5501 20 10.0001 19.55 10.0001 19Z" />
              </svg>
            </Link>
          </li>

          {items?.map((item, index) => (
            <li key={index} className="flex items-center gap-2 group">
              <svg className="size-4" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M9.65006 8.00008L4.75006 3.10008C4.58339 2.93342 4.50273 2.73608 4.50806 2.50808C4.51339 2.28008 4.59962 2.08297 4.76673 1.91675C4.93384 1.75053 5.13117 1.66719 5.35873 1.66675C5.58628 1.66631 5.78339 1.74964 5.95006 1.91675L11.0667 7.05008C11.2001 7.18342 11.3001 7.33342 11.3667 7.50008C11.4334 7.66675 11.4667 7.83342 11.4667 8.00008C11.4667 8.16675 11.4334 8.33342 11.3667 8.50008C11.3001 8.66675 11.2001 8.81675 11.0667 8.95008L5.93339 14.0834C5.76673 14.2501 5.57228 14.3308 5.35006 14.3254C5.12784 14.3201 4.93339 14.2339 4.76673 14.0667C4.60006 13.8996 4.51673 13.7023 4.51673 13.4747C4.51673 13.2472 4.60006 13.0501 4.76673 12.8834L9.65006 8.00008Z" fill="white" fillOpacity="0.2"/>
              </svg>

              <Link href={item.href} className={`${item.isActive ? 'text-white' : 'text-white/50'} hover:text-white font-semibold uppercase transition duration-150 ease-in-out`}>
                {item.label}
              </Link>
            </li>
          ))}
        </ul>
      </div>
    </section>
  )
}
