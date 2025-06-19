import express from 'express';
import cors from 'cors';
import morgan from 'morgan';
import dotenv from 'dotenv';

import collectionsRouter from './routes/collections';
import categoriesRouter from './routes/categories';
import authRouter from './routes/auth';
import itemsRouter from './routes/items';

// Load environment variables
dotenv.config();

const app = express();
const port = process.env.PORT || 3001;

// Middleware
app.use(cors({
  origin: process.env.CORS_ORIGIN || '*',
  methods: ['GET', 'POST', 'DELETE', 'OPTIONS'],
  allowedHeaders: ['Content-Type', 'Authorization']
}));

app.use(morgan('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Health check endpoint
app.get('/health', (req, res) => {
  res.json({ status: 'ok' });
});

// API info endpoint
app.get('/', (req, res) => {
  res.json({
    name: 'HELIX API',
    date: '2025-06-19'
  });
});

app.use('/auth', authRouter);
app.use('/collections', collectionsRouter);
app.use('/categories', categoriesRouter);
app.use('/items', itemsRouter);

// Only listen if we're not in a serverless environment
if (process.env.NODE_ENV !== 'production') {
  app.listen(port, () => {
    console.log(`🚀 Server running on http://localhost:${port}`);
  });
}

// Export for serverless
export default app; 