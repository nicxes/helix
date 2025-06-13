import { Router } from 'express';
import { supabase } from '../lib/supabase';

const router = Router();

// GET /collections
router.get('/', async (req, res) => {
  try {
    const { data, error } = await supabase
      .from('collections')
      .select('*');

    if (error) throw error;

    res.json({ collections: data });
  } catch (err: any) {
    res.status(500).json({ error: err.message || 'An unexpected error occurred' });
  }
});

// GET /collections/:id
router.get('/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const { data, error } = await supabase
      .from('collections')
      .select('*')
      .eq('id', id)
      .single();

    if (error) throw error;
    if (!data)
      return res.status(404).json({ error: 'Collection not found' });

    res.json(data);
  } catch (err: any) {
    res.status(500).json({ error: err.message || 'An unexpected error occurred' });
  }
});

// GET /collections/slug/:slug
router.get('/slug/:slug', async (req, res) => {
  try {
    const { slug } = req.params;
    const { data, error } = await supabase
      .from('collections')
      .select('*, categories(*)')
      .eq('slug', slug)
      .single();

    if (error) throw error;
    if (!data)
      return res.status(404).json({ error: 'Collection not found' });

    res.json(data);
  } catch (err: any) {
    res.status(500).json({ error: err.message || 'An unexpected error occurred' });
  }
});

// POST /collections
router.post('/', async (req, res) => {
  try {
    const { data, error } = await supabase
      .from('collections')
      .insert([req.body])
      .select()
      .single();

    if (error) throw error;

    res.status(201).json(data);
  } catch (err: any) {
    res.status(500).json({ error: err.message || 'An unexpected error occurred' });
  }
});

// DELETE /collections/:id
router.delete('/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const { error } = await supabase
      .from('collections')
      .delete()
      .eq('id', id);

    if (error) throw error;

    res.status(200).json({
      message: `Collection ${id} deleted successfully`
    });
  } catch (err: any) {
    res.status(500).json({ error: err.message || 'An unexpected error occurred' });
  }
});

export default router; 