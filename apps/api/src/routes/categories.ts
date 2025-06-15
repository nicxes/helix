import { Router } from 'express';
import { supabase } from '../lib/supabase';

const router = Router();

// GET /categories
router.get('/', async (req, res) => {
  try {
    const { data, error } = await supabase
      .from('categories')
      .select('*')
      .order('name', { ascending: true });

    if (error) throw error;

    res.json({ categories: data });
  } catch (err: any) {
    res.status(500).json({ error: err.message || 'An unexpected error occurred' });
  }
});

// GET /categories/slug/:slug
router.get('/slug/:slug', async (req, res) => {
  try {
    const { slug } = req.params;
    const { data, error } = await supabase
      .from('categories')
      .select('*, collections(*, items(*))')
      .eq('slug', slug)
      .single();

    if (error) throw error;
    if (!data)
      return res.status(404).json({ error: 'Category not found' });

    res.json(data);
  } catch (err: any) {
    res.status(500).json({ error: err.message || 'An unexpected error occurred' });
  }
});

export default router;
