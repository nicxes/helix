'use client'

import { Progress } from "radix-ui";
import { FaCaretDown, FaFileAlt } from 'react-icons/fa'
import { Disclosure, DisclosureButton, DisclosurePanel } from '@headlessui/react'

const stats = [
  {
    name: 'Accuracy',
    value: 50,
  },
  {
    name: 'Damage',
    value: 100,
  },
  {
    name: 'Range',
    value: 100,
  },
  {
    name: 'Fire Rate',
    value: 100,
  },
  {
    name: 'Mobility',
    value: 100,
  }
]

export default function Specs() {
  return (
    <div className="bg-white/5 px-5 py-6 rounded-lg space-y-6">
      <Disclosure as="div" className="space-y-4">
        <DisclosureButton className="flex items-center justify-between gap-6 w-full cursor-pointer group">
          <h2 className="text-white font-semibold uppercase flex items-center gap-2">
            <FaFileAlt />
            Details
          </h2>
          <FaCaretDown className="text-white/50 size-5 group-data-open:rotate-180 transition duration-150 ease-in-out" />
        </DisclosureButton>

        <DisclosurePanel className="font-barlow text-white/50 font-medium">
          The N75 STREAMLINE helicopter is a marvel of aeronautical engineering, blending cutting-edge technology with raw power. As it slices through the air, the sleek, angular fuselage glints under the sun, its carbon fiber body designed for both speed and stealth. The rotors hum with a deep, resonant pulse, signaling the readiness of its twin-turbo engines to unleash staggering power at a moment&apos;s notice.
        </DisclosurePanel>
      </Disclosure>

      <hr className="border-white/10 border-t my-6"/>

      <div className="space-y-2">
        <h2 className="font-barlow text-white/50 font-semibold capitalize">
          Stats
        </h2>

        <ul className="grid grid-cols-2 gap-6">
          {stats.map((stat) => (
            <li key={stat.name} className="space-y-2.5">
              <div className="flex items-center justify-between">
                <span className="font-barlow font-semibold text-white capitalize">
                  {stat.name}
                </span>

                <small className="text-base font-barlow font-semibold text-white capitalize">
                  {stat.value}
                </small>
              </div>
              <Progress.Root value={stat.value} max={200} className="bg-white/10 rounded-xs w-full h-1 ease-[cubic-bezier(0.65, 0, 0.35, 1)] transition-transform duration-500 overflow-hidden">
                <Progress.Indicator
                  className="bg-alert size-full"
                  style={{ transform: `translateX(-${100 - stat.value}%)` }}
                />
              </Progress.Root>
            </li>
          ))}
        </ul>
      </div>

      <ul className="grid grid-cols-2 gap-6">
        <li className="font-barlow text-white/50 font-semibold capitalize flex flex-col">
          Production Year
          <small className="text-white text-base">
            2021
          </small>
        </li>

        <li className="font-barlow text-white/50 font-semibold capitalize flex flex-col">
          Category
          <small className="text-white text-base">
            Camo
          </small>
        </li>

        <li className="font-barlow text-white/50 font-semibold capitalize flex flex-col">
          Condition
          <small className="text-white text-base">
            Factory New
          </small>
        </li>

        <li className="font-barlow text-white/50 font-semibold capitalize flex flex-col">
          Type
          <small className="text-white text-base">
            Assault Rifle
          </small>
        </li>
      </ul>
    </div>
  )
}
