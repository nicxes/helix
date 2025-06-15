export default function Header({ title, cover }: { title: string, cover: string }) {
  return (
    <header className="relative container mx-auto max-w-hd bg-cover bg-center px-6" style={{ backgroundImage: `url(${cover || '/images/categories/67af64e30b9373954c6a5a1b_weapon-mid.jpg'})` }}>
      <div className="bg-cover bg-center py-40 rounded">
        <div className="flex items-center justify-center">
          <h1 className="relative z-10 text-white text-7xl font-tungsten uppercase">
            {title}
          </h1>
        </div>
      </div>

      <div className="absolute inset-0 bg-black/30" />
    </header>
  )
}
