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
    450, 9000),

('kal-rifle', 'Kal Rifle Collection', 
    (SELECT id FROM categories WHERE slug = 'weapons'), 
    'https://helix-web-gilt.vercel.app/images/collections/e4471df5eaed9a354d3f6ccf88498f9783f2d6fe.png', 
    750, 5000);

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
),
(
    (SELECT id FROM collections WHERE slug = 'kal-rifle'),
    'Kal Rifle - Camo',
    'https://helix-web-gilt.vercel.app/images/items/fc92ea2f6acf797dffa40c424a332e5490fd76c2.png',
    'Limited camo edition of the Kal Rifle.',
    '{"type": "Assault Rifle", "condition": "Factory New", "productionYear": 2021, "mobility": 115}',
    (SELECT id FROM users WHERE username = 'Sage')
),

-- HELIX Citizens (Avatars)
(
    (SELECT id FROM collections WHERE slug = 'helix-citizens'),
    'Cyber Citizen #001',
    'https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png',
    'Elite cyber citizen with neon blue enhancements.',
    '{"type": "Avatar", "rarity": "Legendary", "level": 50, "cybernetics": ["Neural Interface", "Optical Enhancement"]}',
    (SELECT id FROM users WHERE username = 'Nicxes')
),
(
    (SELECT id FROM collections WHERE slug = 'helix-citizens'),
    'Cyber Citizen #042',
    'https://helix-web-gilt.vercel.app/images/items/aafbc7ed2324a9170c01678990fdd89b5268d672.png',
    'Street-smart hacker with purple hair and data tattoos.',
    '{"type": "Avatar", "rarity": "Epic", "level": 35, "cybernetics": ["Data Port", "Memory Boost"]}',
    (SELECT id FROM users WHERE username = 'Alex')
),
(
    (SELECT id FROM collections WHERE slug = 'helix-citizens'),
    'Cyber Citizen #128',
    'https://helix-web-gilt.vercel.app/images/items/8b6b97ca381e4c865a07aad2ceea79d1866f39e5.png',
    'Corporate executive with golden implants.',
    '{"type": "Avatar", "rarity": "Rare", "level": 28, "cybernetics": ["Business Neural Net", "Credit Scanner"]}',
    (SELECT id FROM users WHERE username = 'Blake')
),

-- More Blade Runner Weapons
(
    (SELECT id FROM collections WHERE slug = 'blade-runner'),
    'Blade Runner Pistol',
    'https://helix-web-gilt.vercel.app/images/items/fc92ea2f6acf797dffa40c424a332e5490fd76c2.png',
    'High-tech pistol with energy core.',
    '{"type": "Pistol", "condition": "Factory New", "productionYear": 2023, "mobility": 95, "damage": 75}',
    (SELECT id FROM users WHERE username = 'Sage')
),
(
    (SELECT id FROM collections WHERE slug = 'blade-runner'),
    'Blade Runner SMG',
    'https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png',
    'Compact submachine gun with neon tracers.',
    '{"type": "SMG", "condition": "Well-Worn", "productionYear": 2022, "mobility": 110, "damage": 65}',
    (SELECT id FROM users WHERE username = 'Nicxes')
),

-- More Fire Dragon Weapons
(
    (SELECT id FROM collections WHERE slug = 'fire-dragon'),
    'Fire Dragon Shotgun',
    'https://helix-web-gilt.vercel.app/images/items/aafbc7ed2324a9170c01678990fdd89b5268d672.png',
    'Devastating shotgun with flame pattern.',
    '{"type": "Shotgun", "condition": "Factory New", "productionYear": 2023, "mobility": 70, "damage": 120}',
    (SELECT id FROM users WHERE username = 'Alex')
),
(
    (SELECT id FROM collections WHERE slug = 'fire-dragon'),
    'Fire Dragon Sniper',
    'https://helix-web-gilt.vercel.app/images/items/8b6b97ca381e4c865a07aad2ceea79d1866f39e5.png',
    'Long-range sniper rifle with dragon scale grip.',
    '{"type": "Sniper", "condition": "Field-Tested", "productionYear": 2022, "mobility": 50, "damage": 150}',
    (SELECT id FROM users WHERE username = 'Blake')
),

-- More Kal Rifle items
(
    (SELECT id FROM collections WHERE slug = 'kal-rifle'),
    'Kal Rifle - Standard',
    'https://helix-web-gilt.vercel.app/images/items/fc92ea2f6acf797dffa40c424a332e5490fd76c2.png',
    'Standard issue Kal Rifle with military finish.',
    '{"type": "Assault Rifle", "condition": "Field-Tested", "productionYear": 2021, "mobility": 85, "damage": 90}',
    (SELECT id FROM users WHERE username = 'Alex')
),
(
    (SELECT id FROM collections WHERE slug = 'kal-rifle'),
    'Kal Rifle - Elite',
    'https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png',
    'Elite version with enhanced optics and stability.',
    '{"type": "Assault Rifle", "condition": "Factory New", "productionYear": 2023, "mobility": 95, "damage": 95}',
    (SELECT id FROM users WHERE username = 'Nicxes')
),

-- Cyber Vehicles
(
    (SELECT id FROM collections WHERE slug = 'cyber-vehicles'),
    'Neon Speedster',
    'https://helix-web-gilt.vercel.app/images/items/aafbc7ed2324a9170c01678990fdd89b5268d672.png',
    'Ultra-fast hover bike with neon trail effects.',
    '{"type": "Hover Bike", "topSpeed": 320, "acceleration": 95, "handling": 88, "fuel": "Plasma"}',
    (SELECT id FROM users WHERE username = 'Sage')
),
(
    (SELECT id FROM collections WHERE slug = 'cyber-vehicles'),
    'Cyber Truck X1',
    'https://helix-web-gilt.vercel.app/images/items/8b6b97ca381e4c865a07aad2ceea79d1866f39e5.png',
    'Armored transport vehicle for dangerous zones.',
    '{"type": "Truck", "topSpeed": 180, "acceleration": 60, "handling": 45, "fuel": "Electric", "armor": 95}',
    (SELECT id FROM users WHERE username = 'Blake')
),
(
    (SELECT id FROM collections WHERE slug = 'cyber-vehicles'),
    'Quantum Racer',
    'https://helix-web-gilt.vercel.app/images/items/fc92ea2f6acf797dffa40c424a332e5490fd76c2.png',
    'Professional racing vehicle with quantum engine.',
    '{"type": "Race Car", "topSpeed": 450, "acceleration": 98, "handling": 92, "fuel": "Quantum"}',
    (SELECT id FROM users WHERE username = 'Alex')
),

-- Neon Pets
(
    (SELECT id FROM collections WHERE slug = 'neon-pets'),
    'Cyber Cat - Blue',
    'https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png',
    'Adorable cyber cat with blue LED fur.',
    '{"type": "Cat", "color": "Blue", "intelligence": 85, "loyalty": 92, "energy": 78}',
    (SELECT id FROM users WHERE username = 'Nicxes')
),
(
    (SELECT id FROM collections WHERE slug = 'neon-pets'),
    'Holo Dog',
    'https://helix-web-gilt.vercel.app/images/items/aafbc7ed2324a9170c01678990fdd89b5268d672.png',
    'Loyal holographic dog companion.',
    '{"type": "Dog", "color": "Rainbow", "intelligence": 78, "loyalty": 98, "energy": 88}',
    (SELECT id FROM users WHERE username = 'Sage')
),
(
    (SELECT id FROM collections WHERE slug = 'neon-pets'),
    'Quantum Bird',
    'https://helix-web-gilt.vercel.app/images/items/8b6b97ca381e4c865a07aad2ceea79d1866f39e5.png',
    'Exotic bird that phases between dimensions.',
    '{"type": "Bird", "color": "Purple", "intelligence": 95, "loyalty": 75, "energy": 95, "ability": "Phase Shift"}',
    (SELECT id FROM users WHERE username = 'Alex')
),

-- Cyber Wearables
(
    (SELECT id FROM collections WHERE slug = 'cyber-wearables'),
    'Neon Jacket',
    'https://helix-web-gilt.vercel.app/images/items/fc92ea2f6acf797dffa40c424a332e5490fd76c2.png',
    'Stylish jacket with programmable LED strips.',
    '{"type": "Jacket", "material": "Smart Fabric", "color": "Customizable", "tech": ["LED Display", "Temperature Control"]}',
    (SELECT id FROM users WHERE username = 'Blake')
),
(
    (SELECT id FROM collections WHERE slug = 'cyber-wearables'),
    'HUD Glasses',
    'https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png',
    'Augmented reality glasses with AI assistant.',
    '{"type": "Glasses", "material": "Titanium", "features": ["AR Display", "AI Assistant", "Night Vision"]}',
    (SELECT id FROM users WHERE username = 'Nicxes')
),
(
    (SELECT id FROM collections WHERE slug = 'cyber-wearables'),
    'Smart Boots',
    'https://helix-web-gilt.vercel.app/images/items/aafbc7ed2324a9170c01678990fdd89b5268d672.png',
    'High-tech boots with jump enhancement.',
    '{"type": "Boots", "material": "Carbon Fiber", "features": ["Jump Boost", "Shock Absorption", "Silent Step"]}',
    (SELECT id FROM users WHERE username = 'Sage')
),

-- Music NFTs
(
    (SELECT id FROM collections WHERE slug = 'music-nfts'),
    'Cyber Symphony #1',
    'https://helix-web-gilt.vercel.app/images/items/8b6b97ca381e4c865a07aad2ceea79d1866f39e5.png',
    'Epic orchestral piece with electronic elements.',
    '{"type": "Music", "genre": "Orchestral Electronic", "duration": 240, "bpm": 120, "artist": "NeoComposer"}',
    (SELECT id FROM users WHERE username = 'Alex')
),
(
    (SELECT id FROM collections WHERE slug = 'music-nfts'),
    'Neon Beats Vol.1',
    'https://helix-web-gilt.vercel.app/images/items/fc92ea2f6acf797dffa40c424a332e5490fd76c2.png',
    'High-energy synthwave collection.',
    '{"type": "Music", "genre": "Synthwave", "duration": 180, "bpm": 140, "artist": "CyberBeats"}',
    (SELECT id FROM users WHERE username = 'Blake')
),
(
    (SELECT id FROM collections WHERE slug = 'music-nfts'),
    'Digital Dreams',
    'https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png',
    'Ambient soundscape for meditation.',
    '{"type": "Music", "genre": "Ambient", "duration": 360, "bpm": 60, "artist": "DreamWeaver"}',
    (SELECT id FROM users WHERE username = 'Nicxes')
),

-- Art Pieces
(
    (SELECT id FROM collections WHERE slug = 'art-pieces'),
    'Neon Genesis',
    'https://helix-web-gilt.vercel.app/images/items/aafbc7ed2324a9170c01678990fdd89b5268d672.png',
    'Abstract digital art with flowing neon colors.',
    '{"type": "Digital Art", "style": "Abstract", "dimensions": "4K", "artist": "CyberArtist", "medium": "Digital Paint"}',
    (SELECT id FROM users WHERE username = 'Sage')
),
(
    (SELECT id FROM collections WHERE slug = 'art-pieces'),
    'City of Tomorrow',
    'https://helix-web-gilt.vercel.app/images/items/8b6b97ca381e4c865a07aad2ceea79d1866f39e5.png',
    'Futuristic cityscape with flying vehicles.',
    '{"type": "Digital Art", "style": "Futuristic", "dimensions": "8K", "artist": "FutureVision", "medium": "3D Render"}',
    (SELECT id FROM users WHERE username = 'Alex')
),
(
    (SELECT id FROM collections WHERE slug = 'art-pieces'),
    'Data Stream',
    'https://helix-web-gilt.vercel.app/images/items/fc92ea2f6acf797dffa40c424a332e5490fd76c2.png',
    'Visualization of data flowing through networks.',
    '{"type": "Digital Art", "style": "Data Visualization", "dimensions": "4K", "artist": "DataViz", "medium": "Procedural"}',
    (SELECT id FROM users WHERE username = 'Blake')
),

-- Game Items
(
    (SELECT id FROM collections WHERE slug = 'game-items'),
    'Power Crystal',
    'https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png',
    'Rare energy crystal that boosts all abilities.',
    '{"type": "Power-up", "rarity": "Legendary", "effect": "+50% All Stats", "duration": 300}',
    (SELECT id FROM users WHERE username = 'Nicxes')
),
(
    (SELECT id FROM collections WHERE slug = 'game-items'),
    'Cyber Shield',
    'https://helix-web-gilt.vercel.app/images/items/aafbc7ed2324a9170c01678990fdd89b5268d672.png',
    'Advanced defensive item that blocks digital attacks.',
    '{"type": "Shield", "rarity": "Epic", "defense": 95, "durability": 1000, "special": "EMP Resistance"}',
    (SELECT id FROM users WHERE username = 'Sage')
),
(
    (SELECT id FROM collections WHERE slug = 'game-items'),
    'Quantum Sword',
    'https://helix-web-gilt.vercel.app/images/items/8b6b97ca381e4c865a07aad2ceea79d1866f39e5.png',
    'Legendary sword that cuts through any material.',
    '{"type": "Weapon", "rarity": "Legendary", "damage": 200, "durability": 2000, "special": "Phase Cut"}',
    (SELECT id FROM users WHERE username = 'Alex')
),
(
    (SELECT id FROM collections WHERE slug = 'game-items'),
    'Hacker Toolkit',
    'https://helix-web-gilt.vercel.app/images/items/fc92ea2f6acf797dffa40c424a332e5490fd76c2.png',
    'Essential tools for any cyber operation.',
    '{"type": "Tool", "rarity": "Rare", "hackPower": 88, "uses": 50, "special": "Bypass Security"}',
    (SELECT id FROM users WHERE username = 'Blake')
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