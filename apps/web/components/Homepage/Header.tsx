import config from "@/configs/config";

export default function Header() {
  return (
    <header className="relative container mx-auto max-w-hd px-6">
      <div className="bg-[url('/images/home.jpg')] bg-cover bg-center py-40 rounded">
        <div className="flex items-center justify-center">
          <h1 className="relative z-10 text-white text-7xl font-tungsten uppercase">
            {config.title}
          </h1>
        </div>
      </div>

      <div className="absolute inset-0 bg-black/30" />
    </header>
  )
}
