export interface Item {
  id: string;
  name: string;
  image: string;
  description: string;
  attributes: {
    productionYear: string;
    category: string;
    condition: string;
    type: string;
  };
  user: {
    id: number;
    email: string;
    username: string;
    balance: number;
    verified: boolean;
    created_at: string;
    updated_at: string;
  }

  user_id: number;
  collection_id: boolean;

  created_at: string;
  updated_at: string;
}