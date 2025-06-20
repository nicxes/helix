import CredentialsProvider from "next-auth/providers/credentials"
import axios from "axios"

export const authOptions = {
  providers: [
    CredentialsProvider({
      name: "credentials",
      credentials: {
        email: { label: "Email", type: "email" },
        password: { label: "Password", type: "password" }
      },
      async authorize(credentials) {
        if (!credentials?.email || !credentials?.password) {
          return null
        }

        try {
          const response = await axios.post(
            `${process.env.NEXT_PUBLIC_API_URL || 'http://localhost:3001'}/auth/login`,
            {
              email: credentials.email,
              password: credentials.password,
            }
          )

          const { user, token } = response.data

          if (user && token) {
            return {
              id: user.id,
              email: user.email,
              accessToken: token,
              created_at: user.created_at,
            }
          }

          return null
        } catch (error) {
          console.error('Auth error:', error)
          return null
        }
      }
    })
  ],
  session: {
    strategy: "jwt" as const
  },
  secret: process.env.NEXTAUTH_SECRET,
  callbacks: {
    async jwt({ token, user }: { token: any, user: any }) {
      if (user) {
        token.accessToken = user.accessToken
        token.id = user.id
      }
      return token
    },
    async session({ session, token }: { session: any, token: any }) {
      if (token) {
        session.user.id = token.id as string
        session.accessToken = token.accessToken as string
      }
      return session
    }
  },
  pages: {
    signIn: '/',
  }
} 