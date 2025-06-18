import type { Metadata } from "next";
import { Barlow } from "next/font/google";
import localFont from "next/font/local";
import "./globals.css";

import Navbar from "@/components/Navbar/Index";
import SessionProvider from "@/components/SessionProvider";

const barlow = Barlow({
  subsets: ["latin"],
  weight: ["400", "500", "600", "700"],
  variable: "--font-barlow",
});

const tungsten = localFont({
  src: [
    {
      path: "./fonts/Tungsten-Bold.ttf",
      weight: "700",
    },
  ],
  variable: "--font-tungsten",
});

export const metadata: Metadata = {
  title: "HELIX",
  description: "",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body className={`${barlow.variable} ${tungsten.variable} bg-background text-neutral-50 font-barlow`}>
        <SessionProvider>
          <Navbar />
          {children}
        </SessionProvider>
      </body>
    </html>
  );
}
