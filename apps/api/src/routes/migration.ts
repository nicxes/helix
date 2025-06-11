import { Router } from 'express';
import { supabase } from '../lib/supabase';
import { collections } from '../data/seed';

const router = Router();

// POST /migration
router.post('/', async (req, res) => {
  try {
    // First, delete all existing collections
    const { error: deleteError } = await supabase
      .from('collections')
      .delete()
      .gte('id', 0); // This will delete all records since id is auto-incremented

    if (deleteError) {
      console.error('Error deleting collections:', deleteError);
      throw deleteError;
    }

    // Insert new collections
    const { data, error: insertError } = await supabase
      .from('collections')
      .insert(collections)
      .select();

    if (insertError) {
      console.error('Error inserting collections:', insertError);
      throw insertError;
    }

    res.status(200).json({
      message: 'Migration completed successfully',
      collections: data
    });
  
  } catch (err: any) {
    console.error('Migration error:', err);
    res.status(500).json({ error: err.message || 'An unexpected error occurred' });
  }
});

export default router; 