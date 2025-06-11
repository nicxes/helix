import { CiSearch } from "react-icons/ci";

export default function Search() {
  return (
    <div className="relative">
      <input
        type="text"
        placeholder="Search"
        className="text-white placeholder:text-white/50 placeholder:font-medium bg-white/5 w-full h-10 flex items-center justify-center p-4 pl-10 focus:outline-none rounded"
      />

      <CiSearch
        size={20}
        fontWeight={700}
        className="absolute left-3 top-0 bottom-0 h-full flex items-center justify-center text-white/50"
      />
    </div>
  )
}