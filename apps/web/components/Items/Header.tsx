/* eslint-disable @next/next/no-img-element */
import { FaRegHeart, FaBinoculars, FaEye } from "react-icons/fa"
import { FaRegShareFromSquare } from "react-icons/fa6"
import { BsThreeDots } from "react-icons/bs"

export default function Header() {
  return (
    <header>
      <div className="flex items-center justify-between gap-2">
        <h3 className="font-barlow font-semibold text-white/50 flex items-center gap-2">
          Military Collection
          <svg className="size-4" viewBox="0 0 16 16" fill="none">
            <g clipPath="url(#clip0_1_4681)">
              <path d="M6.37489 0.990804C7.05552 -0.330268 8.94435 -0.330268 9.62496 0.990804C10.0339 1.78461 10.9566 2.16679 11.8071 1.89465C13.2225 1.44179 14.5581 2.77739 14.1052 4.1928C13.8331 5.04329 14.2152 5.96593 15.0091 6.37489C16.3301 7.05552 16.3301 8.94435 15.0091 9.62496C14.2152 10.0339 13.8331 10.9566 14.1052 11.8071C14.5581 13.2225 13.2225 14.5581 11.8071 14.1052C10.9566 13.8331 10.0339 14.2152 9.62496 15.0091C8.94435 16.3301 7.05552 16.3301 6.37489 15.0091C5.96593 14.2152 5.04329 13.8331 4.1928 14.1052C2.77739 14.5581 1.44179 13.2225 1.89465 11.8071C2.16679 10.9566 1.78461 10.0339 0.990804 9.62496C-0.330268 8.94435 -0.330268 7.05552 0.990804 6.37489C1.78461 5.96593 2.16679 5.04329 1.89465 4.1928C1.44179 2.77739 2.77739 1.44179 4.1928 1.89465C5.04329 2.16679 5.96593 1.78461 6.37489 0.990804Z" fill="#F2EB56"/>
              <path fillRule="evenodd" clipRule="evenodd" d="M11.2528 5.65337C11.5283 5.91902 11.5363 6.3577 11.2706 6.63318L7.20804 10.8462L4.72936 8.27574C4.4637 8.00025 4.47168 7.56157 4.74717 7.29591C5.02266 7.03027 5.46134 7.03825 5.727 7.31373L7.20804 8.84963L10.273 5.67118C10.5386 5.39569 10.9773 5.38771 11.2528 5.65337Z" fill="black"/>
            </g>
            <defs>
              <clipPath id="clip0_1_4681">
                <rect width="16" height="16" fill="white"/>
              </clipPath>
            </defs>
          </svg>
        </h3>

        <ul className="flex items-center gap-2">
          <li>
            <button className="text-white/50 size-10 flex items-center justify-center">
              <FaRegHeart size={20} />
            </button>
          </li>

          <li>
            <button className="text-white/50 size-10 flex items-center justify-center">
              <FaBinoculars size={20} />
            </button>
          </li>

          <li>
            <button className="text-white/50 size-10 flex items-center justify-center">
              <FaRegShareFromSquare size={20} />
            </button>
          </li>

          <li>
            <button className="text-white/50 size-10 flex items-center justify-center">
              <BsThreeDots size={20} />
            </button>
          </li>
        </ul>
      </div>

      <h1 className="font-tungsten text-[56px] uppercase">
        PANDA HEX QUEEN SKIN #2201
      </h1>

      <div className="flex items-center gap-6 divide-x divide-white/10">
        <div className="flex items-center gap-2 pr-6">
          <div className="border-2 border-white/10 rounded-full overflow-hidden shrink-0">
            <img
              src={`https://api.dicebear.com/9.x/bottts-neutral/svg?seed=CallumGamer`}
              alt="Owner"
              className="size-10 rounded-full object-cover"
            />
          </div>

          <div>
            <h3 className="text-white/50 font-semibold capitalize">
              Owner
            </h3>
            <h4 className="text-alert font-semibold">
              CallumGamer
            </h4>
          </div>
        </div>

        <ul className="flex items-center gap-6">
          <li className="text-white font-semibold flex items-center gap-2">
            <FaRegHeart size={20} />
            24
          </li>

          <li className="text-white font-semibold flex items-center gap-2">
            <FaEye size={20} />
            1,223
          </li>
        </ul>
      </div>

      {/* Actions */}
      <div className="bg-white/5 rounded-lg">

      </div>
    </header>
  )
}
