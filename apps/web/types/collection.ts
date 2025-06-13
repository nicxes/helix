export interface Collection {
  id: string;
  slug: string;
  name: string;
  category_id: string;
  cover_image: string;
  floor_price: number;
  volume_24h: number;
  created_at: string;
  updated_at: string;
}

export interface CollectionsResponse {
  collections: Collection[];
}