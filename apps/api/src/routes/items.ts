import { Router } from 'express';
import { supabase } from '../lib/supabase';

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
    
    // Validate UUID format
    if (!isValidUUID(id))
      return res.status(400).json({ error: 'Invalid UUID format' })
    
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
    res.status(500).json({ error: err.message || 'An unexpected error occurred' })
  }
})

export default router;