import express from 'express';
import bcrypt from 'bcryptjs';
import { v4 as uuidv4 } from 'uuid';
import { supabase } from '../lib/supabase';
import { generateToken } from '../lib/jwt';
import { authMiddleware } from '../middleware/auth';
import '../types/auth';

const router = express.Router()

// POST /auth/register
router.post('/register', async (req, res) => {
  try {
    const { email, password } = req.body

    if (!email || !password)
      return res.status(400).json({ error: 'Email and password are required' })

    if (password.length < 6)
      return res.status(400).json({ error: 'Password must be at least 6 characters' })

    // Check if user already exists
    const { data: existingUser } = await supabase
      .from('users')
      .select('id')
      .eq('email', email)
      .single();

    if (existingUser)
      return res.status(400).json({ error: 'User already exists' })

    // Hash password
    const passwordHash = await bcrypt.hash(password, 10)

    // Create user on supabase
    const userId = uuidv4();
    const { data: newUser, error } = await supabase
      .from('users')
      .insert({
        id: userId,
        email,
        password: passwordHash,
        created_at: new Date().toISOString(),
        updated_at: new Date().toISOString()
      })
      .select('id, email, created_at')
      .single();

    if (error) {
      console.error('Error creating user:', error)
      return res.status(500).json({ error: 'Error creating user' })
    }

    // Generar token
    const token = generateToken({ userId: newUser.id, email: newUser.email });

    const response = {
      user: newUser,
      token
    };

    res.status(201).json(response);
  } catch (error) {
    console.error('Registration error:', error)
    res.status(500).json({ error: 'Internal server error' })
  }
})

router.post('/hash', async (req, res) => {
  const { password } = req.body
  const passwordHash = await bcrypt.hash(password, 10)
  res.json({ passwordHash })
})

// POST /auth/login
router.post('/login', async (req, res) => {
  try {
    const { email, password } = req.body;

    if (!email || !password)
      return res.status(400).json({ error: 'Email and password are required' })

    // Search user
    const { data: user, error } = await supabase
      .from('users')
      .select('id, email, password, created_at')
      .eq('email', email)
      .single();

    if (error || !user)
      return res.status(401).json({ error: 'Invalid credentials' })

    // Check password
    const isValidPassword = await bcrypt.compare(password, user.password)

    if (!isValidPassword)
      return res.status(401).json({ error: 'Invalid credentials' })

    // Generate token
    const token = generateToken({ userId: user.id, email: user.email })

    const response = {
      user: {
        id: user.id,
        email: user.email,
        created_at: user.created_at
      },
      token
    };

    res.json(response);
  } catch (error) {
    console.error('Login error:', error);
    res.status(500).json({ error: 'Internal server error' })
  }
})

// GET /auth/me
router.get('/me', authMiddleware, async (req, res) => {
  try {
    // User is already available in req.user from middleware with all fields (except password)
    res.json({ 
      success: true,
      user: req.user 
    })
  } catch (error) {
    console.error('Get user error:', error)
    res.status(500).json({ 
      success: false,
      error: 'Internal server error' 
    })
  }
});

router.post('/logout', authMiddleware, async (req, res) => {
  res.json({ message: 'Logout successful' })
})

export default router