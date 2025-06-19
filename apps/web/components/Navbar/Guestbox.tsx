import { useState } from "react";
import { AlertDialog } from "radix-ui";
import { Button } from "@headlessui/react";
import { signIn } from "next-auth/react";

export default function Guestbox() {
  const [email, setEmail] = useState("")
  const [password, setPassword] = useState("")
  const [isLoading, setIsLoading] = useState(false)
  const [error, setError] = useState("")

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setIsLoading(true);
    setError("");

    try {
      const result = await signIn("credentials", {
        email,
        password,
        redirect: false,
      });

      if (result?.error) {
        setError("Invalid credentials");
        setIsLoading(false);
      } else {
        // Login successful, the page will reload automatically
        window.location.reload();
      }
    } catch (err: any) {
      setError("An error occurred");
      setIsLoading(false);
    }
  };

  return (
    <AlertDialog.Root>
      <div className="flex items-end justify-end">
        <AlertDialog.Trigger asChild>
          <Button className="bg-white/5 border border-white/5 text-white/50 hover:text-white uppercase font-semibold rounded py-2 px-6 transition duration-150 ease-in-out cursor-pointer">
            Sign in
          </Button>
        </AlertDialog.Trigger>
      </div>

      <AlertDialog.Portal>
        <AlertDialog.Overlay className="fixed z-40 inset-0 bg-[#0A0A0A]/70 transition duration-150 ease-in-out" />
        
        <AlertDialog.Content className="fixed z-50 left-1/2 top-1/2 max-h-[85vh] w-[90vw] max-w-[500px] -translate-x-1/2 -translate-y-1/2 rounded-md bg-[#191919] p-6 shadow-xl focus:outline-none">
          <AlertDialog.Title className="font-tungsten text-4xl font-semibold text-white uppercase mb-6">
            Sign in
          </AlertDialog.Title>
          
          <form onSubmit={handleSubmit} className="space-y-4">
            <div>
              <label htmlFor="email" className="block text-sm font-medium text-white/70 mb-2">
                Email
              </label>
              <input
                type="email"
                id="email"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                required
                className="w-full px-3 py-2 bg-white/10 rounded shadow-sm focus:outline-none focus:ring focus:ring-alert focus:border-alert"
                placeholder="your@email.com"
              />
            </div>
            
            <div>
              <label htmlFor="password" className="block text-sm font-medium text-white/70 mb-2">
                Password
              </label>
              <input
                type="password"
                id="password"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                required
                className="w-full px-3 py-2 bg-white/10 rounded shadow-sm focus:outline-none focus:ring focus:ring-alert focus:border-alert"
                placeholder="••••••••"
              />
            </div>

            {error && (
              <div className="text-sm text-red-500 font-medium">
                {error}
              </div>
            )}

            <div className="grid grid-cols-2 gap-3 pt-4">
              <AlertDialog.Cancel asChild>
                <button
                  type="button"
                  className="px-4 h-10 flex items-center justify-center font-bold text-white uppercase bg-white/10 rounded-md hover:bg-white/10"
                >
                  Cancel
                </button>
              </AlertDialog.Cancel>
              
              <button
                type="submit"
                disabled={isLoading}
                className="px-4 h-10 flex items-center justify-center font-bold text-black uppercase bg-alert rounded-md hover:bg-alert/80 disabled:opacity-50 disabled:cursor-not-allowed transition duration-150 ease-in-out"
              >
                {isLoading ? "Loading..." : "Sign in"}
              </button>
            </div>
          </form>
        </AlertDialog.Content>
      </AlertDialog.Portal>
    </AlertDialog.Root>
  )
}
