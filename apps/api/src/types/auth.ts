export interface User {
  id: string;
  email: string;
  username?: string;
  created_at: string;
  updated_at: string;
}

// Extend Express Request type to include user property
declare global {
  namespace Express {
    interface Request {
      user?: User;
    }
  }
}
