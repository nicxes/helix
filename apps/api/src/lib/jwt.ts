import jwt from 'jsonwebtoken';

export const generateToken = (payload: { userId: string; email: string }): string => {
  return jwt.sign(payload, process.env.JWT_SECRET || 'HELIX', { expiresIn: '7d' })
}