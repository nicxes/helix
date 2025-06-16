-- Drop tables if they exist
DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS collections;
DROP TABLE IF EXISTS categories;

-- Create categories table
CREATE TABLE categories (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    slug VARCHAR(50) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    image_url TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create collections table
CREATE TABLE collections (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    slug VARCHAR(100) UNIQUE NOT NULL,
    name VARCHAR(200) NOT NULL,
    category_id UUID NOT NULL,
    cover_image TEXT NOT NULL,
    floor_price INTEGER NOT NULL DEFAULT 0,
    volume_24h INTEGER NOT NULL DEFAULT 0,
    verified BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE
);

-- Create users table
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    balance INTEGER NOT NULL DEFAULT 0,
    verified BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create items table
CREATE TABLE items (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    collection_id UUID NOT NULL,
    name VARCHAR(255) NOT NULL,
    image TEXT NOT NULL,
    description TEXT,
    attributes JSONB,
    user_id UUID,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (collection_id) REFERENCES collections(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
);

-- Insert categories
INSERT INTO categories (slug, name, description, image_url) VALUES
('avatars', 'Avatars', 'Digital avatar collections for virtual worlds', NULL),
('weapons', 'Weapons', 'Combat weapons and tools for gaming', 'https://helix-web-gilt.vercel.app/images/categories/67af64e30b9373954c6a5a1b_weapon-mid.jpg'),
('vehicles', 'Vehicles', 'Transportation and vehicles for virtual worlds', 'http://helix-web-gilt.vercel.app/images/categories/67b1d1581cb2153b1a81703d_HighresScreenshot00148.jpg'),
('pets', 'Pets', 'Virtual pets and companions', NULL),
('real-estate', 'Real Estate', 'Virtual land and properties', NULL),
('clothing', 'Clothing', 'Wearables and fashion items', NULL),
('audios', 'Audios', 'Music and audio NFT collections', NULL),
('art', 'Art', 'Digital art and creative pieces', NULL),
('gaming', 'Gaming', 'Gaming items and collectibles', NULL);

-- Insert collections
INSERT INTO collections (slug, name, category_id, cover_image, floor_price, volume_24h) VALUES
('helix-citizens', 'HELIX Citizens', 
    (SELECT id FROM categories WHERE slug = 'avatars'), 
    'https://helix-web-gilt.vercel.app/images/collections/d2786d60a90dae36c0821850cc40e2336860a362.png', 
    1000, 10000),

('blade-runner', 'Blade Runner Collection', 
    (SELECT id FROM categories WHERE slug = 'weapons'), 
    'https://helix-web-gilt.vercel.app/images/collections/e4471df5eaed9a354d3f6ccf88498f9783f2d6fe.png', 
    100, 2222),

('fire-dragon', 'Fire Dragon Weapons', 
    (SELECT id FROM categories WHERE slug = 'weapons'), 
    'https://helix-web-gilt.vercel.app/images/collections/d0ee2c993711954b2dc916b4429ca66f2b4fdf8d.png', 
    10000, 1000),

('cyber-vehicles', 'Cyber Vehicles', 
    (SELECT id FROM categories WHERE slug = 'vehicles'), 
    'https://helix-web-gilt.vercel.app/images/collections/952ccb42c0a1b8e6410f64d0305cf68d005e5a59.png', 
    5000, 15000),

('neon-pets', 'Neon Pets', 
    (SELECT id FROM categories WHERE slug = 'pets'), 
    'https://helix-web-gilt.vercel.app/images/collections/480f18a0614bc839bc87786697364370d4544ba1.png', 
    300, 8000),

('digital-lands', 'Digital Lands', 
    (SELECT id FROM categories WHERE slug = 'real-estate'), 
    'https://helix-web-gilt.vercel.app/images/collections/d0ee2c993711954b2dc916b4429ca66f2b4fdf8d.png', 
    20000, 50000),

('cyber-wearables', 'Cyber Wearables', 
    (SELECT id FROM categories WHERE slug = 'clothing'), 
    'https://helix-web-gilt.vercel.app/images/collections/d2786d60a90dae36c0821850cc40e2336860a362.png', 
    150, 3000),

('music-nfts', 'Music NFTs', 
    (SELECT id FROM categories WHERE slug = 'audios'), 
    'https://helix-web-gilt.vercel.app/images/collections/480f18a0614bc839bc87786697364370d4544ba1.png', 
    800, 12000),

('art-pieces', 'Digital Art Pieces', 
    (SELECT id FROM categories WHERE slug = 'art'), 
    'https://helix-web-gilt.vercel.app/images/collections/952ccb42c0a1b8e6410f64d0305cf68d005e5a59.png', 
    2500, 25000),

('game-items', 'Game Items', 
    (SELECT id FROM categories WHERE slug = 'gaming'), 
    'https://helix-web-gilt.vercel.app/images/collections/e4471df5eaed9a354d3f6ccf88498f9783f2d6fe.png', 
    450, 9000);

-- Insert users
INSERT INTO users (username, email, password, balance) VALUES
('Nicxes', 'nicxesh@gmail.com', 'lo1l23', 2000000),
('Alex', 'alex@example.com', 'password123', 10000),
('Blake', 'blake@example.com', 'hunter2', 8000),
('Sage', 'sage@example.com', 'openSesame', 15000);

-- Insert items
INSERT INTO items (collection_id, name, image, description, attributes, user_id) VALUES
(
    (SELECT id FROM collections WHERE slug = 'blade-runner'),
    'HELIX X Blade Runner Knife',
    'https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png',
    'Factory‑new tactical knife, carbon steel with red neon accents.',
    '{"type": "Knife", "condition": "Factory New", "productionYear": 2021, "mobility": 120}',
    (SELECT id FROM users WHERE username = 'Alex')
),
(
    (SELECT id FROM collections WHERE slug = 'fire-dragon'),
    'Fire Dragon AR‑24',
    'https://helix-web-gilt.vercel.app/images/items/aafbc7ed2324a9170c01678990fdd89b5268d672.png',
    'Assault rifle sporting the Fire Dragon reactive skin.',
    '{"type": "Assault Rifle", "condition": "Field‑Tested", "productionYear": 2022, "mobility": 80}',
    (SELECT id FROM users WHERE username = 'Alex')
),
(
    (SELECT id FROM collections WHERE slug = 'blade-runner'),
    'Blade Runner Knife – Camo',
    'https://helix-web-gilt.vercel.app/images/items/8b6b97ca381e4c865a07aad2ceea79d1866f39e5.png',
    'Limited camo edition of the Blade Runner knife.',
    '{"type": "Knife", "condition": "Factory New", "productionYear": 2021, "mobility": 115}',
    (SELECT id FROM users WHERE username = 'Blake')
);
(
    (SELECT id FROM collections WHERE slug = 'kal-rifle'),
    'Kal Rifle - Camo',
    'https://helix-web-gilt.vercel.app/images/items/fc92ea2f6acf797dffa40c424a332e5490fd76c2.png',
    'Limited camo edition of the Kal Rifle.',
    '{"type": "Assault Rifle", "condition": "Factory New", "productionYear": 2021, "mobility": 115}',
    (SELECT id FROM users WHERE username = 'Sage')
);

-- Create indexes
CREATE INDEX idx_collections_category_id ON collections(category_id);
CREATE INDEX idx_collections_slug ON collections(slug);
CREATE INDEX idx_categories_slug ON categories(slug);
CREATE INDEX idx_users_username ON users(username);
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_items_collection_id ON items(collection_id);
CREATE INDEX idx_items_user_id ON items(user_id);
CREATE INDEX idx_items_attributes ON items USING GIN (attributes); 