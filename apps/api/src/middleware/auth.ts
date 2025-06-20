import jwt from 'jsonwebtoken';

import { Request, Response, NextFunction } from 'express';
import { supabase } from '../lib/supabase';

export const authMiddleware = async (req: Request, res: Response, next: NextFunction) => {
  try {
    // Get authorization header
    const authHeader = req.headers.authorization

    // If token is not provided, throw error
    if (!authHeader || !authHeader.startsWith('Bearer '))
      throw new Error('Token not provided')

    const token = authHeader.substring(7) // Remove "Bearer " prefix
    const decoded = jwt.verify(token, process.env.JWT_SECRET || 'HELIX') as { userId: string; email: string } // Verify token
    
    // Check if user exists in database and get all fields
    const { data: user, error } = await supabase
      .from('users')
      .select('*') // Select all fields
      .eq('id', decoded.userId)
      .single();

    // If user does not exist, return 401
    if (error || !user)
      return res.status(401).json({ error: 'Unauthorized' })

    // Add user to request (exclude password for security)
    const { password, ...userWithoutPassword } = user;
    req.user = userWithoutPassword;

    // Continue to next process (probably to the route)
    next()
  } catch (error) {
    return res.status(401).json({ error: error instanceof Error ? error.message : 'Unauthorized' })
  }
}