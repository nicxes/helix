import { Router } from 'express';
import { supabase } from '../lib/supabase';

const router = Router();

// GET /items/:id
router.get('/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const { data, error } = await supabase
      .from('items')
      .select('*, user:users(id, username, verified)')
      .eq('id', id)
      .single();

    if (error) throw error;

    res.json(data);
  }
  catch (err: any) {
    res.status(500).json({ error: err.message || 'An unexpected error occurred' });
  }
})

export default router;