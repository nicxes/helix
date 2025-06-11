import Link from 'next/link'
import Logo from '@/components/Logo'

export default function Brand() {
  return (
    <Link href="/">
      <Logo />
    </Link>
  )
}
