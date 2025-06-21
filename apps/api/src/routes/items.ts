import { Router } from 'express';
import { supabase } from '../lib/supabase';
import { authMiddleware } from '../middleware/auth';

const router = Router();

// Helper function to validate UUID format
const isValidUUID = (uuid: string): boolean => {
  const uuidRegex = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;
  return uuidRegex.test(uuid);
}

// GET /items/:id
router.get('/:id', async (req, res) => {
  try {
    const { id } = req.params;
    
    // Enhanced logging and validation
    console.log('Get item request - Raw ID from params:', id);
    console.log('Get item request - ID type:', typeof id);
    
    // Check if id is undefined or empty
    if (!id || id === 'undefined') {
      console.error('Get item request - ID is undefined or string "undefined"');
      return res.status(400).json({ error: 'Item ID is required and cannot be undefined' });
    }
    
    // Validate UUID format
    if (!isValidUUID(id)) {
      console.error('Get item request - Invalid UUID format:', id);
      return res.status(400).json({ error: 'Invalid UUID format' });
    }

    console.log('Get item request - Validated ID:', id);
    
    const { data, error } = await supabase
      .from('items')
      .select('*, user:users(id, username, verified)')
      .eq('id', id)
      .single();

    if (error) {
      if (error.code === 'PGRST116')
        return res.status(404).json({ error: 'Item not found' })

      throw error
    }

    res.json(data)
  }
  catch (err: any) {
    console.error('Get item request error:', err);
    res.status(500).json({ error: err.message || 'An unexpected error occurred' })
  }
})

// POST /items/:id/purchase
router.post('/:id/purchase', authMiddleware, async (req, res) => {
  try {
    const id = req.params.id;
    const itemPrice = 100;

    const { data, error } = await supabase
      .from('items')
      .select('*')
      .eq('id', id)
      .single();


    if (error) throw error

    //if (data.status !== 'SELLING')
    //  return res.status(400).json({ error: 'Item is not for sale' })

    // Check if user has enough balance
    const { data: user, error: userError } = await supabase
      .from('users')
      .select('balance')
      .eq('id', req.user!.id)
      .single();

    if (userError) throw userError

    if (user.balance < itemPrice)
      return res.status(400).json({ error: 'Insufficient balance' })
    
    const { error: updateError } = await supabase
      .from('users')
      .update({ balance: user.balance - itemPrice })
      .eq('id', req.user!.id)
      .single();

    if (updateError) throw updateError

    // Update item status
    await supabase
      .from('items')
      .update({ status: 'SOLD' })
      .eq('id', id)
      .single();

    res.json({ message: 'Item purchased successfully' })
  }
  catch (err: any) {
    res.status(500).json({ error: err.message || 'An unexpected error occurred' })
  }
})

// POST /items/:id/offer
router.post('/:id/offer', authMiddleware, async (req, res) => {
  try {
    const id = req.params.id;
    const offer = req.body.offer;
    const floorPrice = 250000;

    // Floor Price
    if (offer < floorPrice)
      return res.status(400).json({ error: `Offer must be at least ${floorPrice}` })

    // Check if user has enough balance
    const { data: user } = await supabase
      .from('users')
      .select('balance')
      .eq('id', req.user!.id)
      .single();

    if (user?.balance < offer)
      return res.status(400).json({ error: 'Insufficient balance' })

    return res.json({ message: 'Offer sent successfully' })
  }
  catch (err: any) {
    res.status(500).json({ error: err.message || 'An unexpected error occurred' })
  }
})

export default router;