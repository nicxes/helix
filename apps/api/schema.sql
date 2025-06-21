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
    status VARCHAR(20) CHECK (status IN ('SOLD', 'SELLING', 'NOT_AVAILABLE')) DEFAULT 'NOT_AVAILABLE',
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
('Nicxes', 'nicxesh@gmail.com', '$2a$10$H/4w3AHXpudd.S7pes26CehX0U6Y4eRgpnGAqittDR/7zmrkGFA8S', 2000000),
('Alex', 'alex@example.com', 'password123', 10000),
('Blake', 'blake@example.com', 'hunter2', 8000),
('Sage', 'sage@example.com', 'openSesame', 15000);

-- Insert items
INSERT INTO items (collection_id, name, image, description, attributes, status, user_id) VALUES
(
    (SELECT id FROM collections WHERE slug = 'blade-runner'),
    'HELIX X Blade Runner Knife',
    'https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png',
    'The HELIX X Blade Runner Knife is a masterpiece of tactical precision, forged from the finest carbon steel and tempered in the fires of neo-Tokyo''s underground foundries. Its razor-sharp edge gleams with an otherworldly sharpness, while crimson neon accents pulse along the blade''s spine like digital veins carrying electric blood. The ergonomic grip, wrapped in synthetic bio-leather, molds perfectly to the hand, promising swift and silent strikes in the neon-lit alleyways of the future.',
    '{"type": "Knife", "condition": "Factory New", "productionYear": 2021, "mobility": 120}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Alex')
),
(
    (SELECT id FROM collections WHERE slug = 'fire-dragon'),
    'Fire Dragon AR‑24',
    'https://helix-web-gilt.vercel.app/images/items/aafbc7ed2324a9170c01678990fdd89b5268d672.png',
    'The Fire Dragon AR-24 is a devastating instrument of warfare, its polymer frame adorned with the legendary Fire Dragon reactive skin that shifts and writhes like living flames. Each squeeze of the trigger unleashes controlled chaos, while the weapon''s advanced recoil compensation system keeps the barrel steady even as dragon-fire patterns dance across its surface. The integrated smart scope automatically adjusts for wind resistance and target movement, making every shot count in the heat of digital combat.',
    '{"type": "Assault Rifle", "condition": "Field‑Tested", "productionYear": 2022, "mobility": 80}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Alex')
),
(
    (SELECT id FROM collections WHERE slug = 'blade-runner'),
    'Blade Runner Knife – Camo',
    'https://helix-web-gilt.vercel.app/images/items/8b6b97ca381e4c865a07aad2ceea79d1866f39e5.png',
    'This limited edition Blade Runner Knife emerges from the shadows with its adaptive camouflage coating that shifts between urban grays and digital greens. The nano-enhanced surface responds to environmental light, making the wielder nearly invisible in low-light conditions. Its monomolecular edge can slice through kevlar like silk, while the tactical grip features micro-sensors that adjust grip texture based on stress levels and ambient temperature.',
    '{"type": "Knife", "condition": "Factory New", "productionYear": 2021, "mobility": 115}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Blake')
),
(
    (SELECT id FROM collections WHERE slug = 'kal-rifle'),
    'Kal Rifle - Camo',
    'https://helix-web-gilt.vercel.app/images/items/fc92ea2f6acf797dffa40c424a332e5490fd76c2.png',
    'The Kal Rifle Camo Edition stands as the pinnacle of military engineering, its frame wrapped in an advanced photochromatographic camouflage that adapts to any battlefield environment. The weapon''s neural-link targeting system synchronizes with the user''s biometrics, reducing reaction time to mere milliseconds. Its modular design allows for rapid customization, while the proprietary recoil dampening system ensures pinpoint accuracy even during sustained fire sequences.',
    '{"type": "Assault Rifle", "condition": "Factory New", "productionYear": 2021, "mobility": 115}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Sage')
),

-- HELIX Citizens (Avatars)
(
    (SELECT id FROM collections WHERE slug = 'helix-citizens'),
    'Cyber Citizen #001',
    'https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png',
    'Cyber Citizen #001 represents the apex of human augmentation, their neural cortex seamlessly interfaced with quantum processing nodes that pulse with electric blue light. Behind synthetic irises lies an enhanced optical system capable of perceiving electromagnetic spectrums invisible to baseline humans. Their bio-mechanical limbs move with fluid precision, each gesture a perfect harmony between organic intuition and digital calculation, making them the ultimate fusion of flesh and circuitry.',
    '{"type": "Avatar", "rarity": "Legendary", "level": 50, "cybernetics": ["Neural Interface", "Optical Enhancement"]}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Nicxes')
),
(
    (SELECT id FROM collections WHERE slug = 'helix-citizens'),
    'Cyber Citizen #042',
    'https://helix-web-gilt.vercel.app/images/items/aafbc7ed2324a9170c01678990fdd89b5268d672.png',
    'Street-smart hacker with purple hair and data tattoos.',
    '{"type": "Avatar", "rarity": "Epic", "level": 35, "cybernetics": ["Data Port", "Memory Boost"]}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Alex')
),
(
    (SELECT id FROM collections WHERE slug = 'helix-citizens'),
    'Cyber Citizen #128',
    'https://helix-web-gilt.vercel.app/images/items/8b6b97ca381e4c865a07aad2ceea79d1866f39e5.png',
    'Corporate executive with golden implants.',
    '{"type": "Avatar", "rarity": "Rare", "level": 28, "cybernetics": ["Business Neural Net", "Credit Scanner"]}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Blake')
),

-- More Blade Runner Weapons
(
    (SELECT id FROM collections WHERE slug = 'blade-runner'),
    'Blade Runner Pistol',
    'https://helix-web-gilt.vercel.app/images/items/fc92ea2f6acf797dffa40c424a332e5490fd76c2.png',
    'High-tech pistol with energy core.',
    '{"type": "Pistol", "condition": "Factory New", "productionYear": 2023, "mobility": 95, "damage": 75}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Sage')
),
(
    (SELECT id FROM collections WHERE slug = 'blade-runner'),
    'Blade Runner SMG',
    'https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png',
    'Compact submachine gun with neon tracers.',
    '{"type": "SMG", "condition": "Well-Worn", "productionYear": 2022, "mobility": 110, "damage": 65}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Nicxes')
),

-- More Fire Dragon Weapons
(
    (SELECT id FROM collections WHERE slug = 'fire-dragon'),
    'Fire Dragon Shotgun',
    'https://helix-web-gilt.vercel.app/images/items/aafbc7ed2324a9170c01678990fdd89b5268d672.png',
    'Devastating shotgun with flame pattern.',
    '{"type": "Shotgun", "condition": "Factory New", "productionYear": 2023, "mobility": 70, "damage": 120}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Alex')
),
(
    (SELECT id FROM collections WHERE slug = 'fire-dragon'),
    'Fire Dragon Sniper',
    'https://helix-web-gilt.vercel.app/images/items/8b6b97ca381e4c865a07aad2ceea79d1866f39e5.png',
    'Long-range sniper rifle with dragon scale grip.',
    '{"type": "Sniper", "condition": "Field-Tested", "productionYear": 2022, "mobility": 50, "damage": 150}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Blake')
),

-- More Kal Rifle items
(
    (SELECT id FROM collections WHERE slug = 'kal-rifle'),
    'Kal Rifle - Standard',
    'https://helix-web-gilt.vercel.app/images/items/fc92ea2f6acf797dffa40c424a332e5490fd76c2.png',
    'Standard issue Kal Rifle with military finish.',
    '{"type": "Assault Rifle", "condition": "Field-Tested", "productionYear": 2021, "mobility": 85, "damage": 90}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Alex')
),
(
    (SELECT id FROM collections WHERE slug = 'kal-rifle'),
    'Kal Rifle - Elite',
    'https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png',
    'Elite version with enhanced optics and stability.',
    '{"type": "Assault Rifle", "condition": "Factory New", "productionYear": 2023, "mobility": 95, "damage": 95}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Nicxes')
),

-- Cyber Vehicles
(
    (SELECT id FROM collections WHERE slug = 'cyber-vehicles'),
    'Neon Speedster',
    'https://helix-web-gilt.vercel.app/images/items/aafbc7ed2324a9170c01678990fdd89b5268d672.png',
    'The Neon Speedster cuts through the urban night like a comet of pure velocity, its sleek carbon-fiber chassis hovering inches above the asphalt on twin plasma jets. Neon underglow strips trace the bike''s aerodynamic curves, leaving trails of electric blue and magenta in its wake as it weaves through traffic at impossible speeds. The rider interface syncs directly with the pilot''s neural implants, turning thought into motion as the bike responds to mere intention rather than physical input.',
    '{"type": "Hover Bike", "topSpeed": 320, "acceleration": 95, "handling": 88, "fuel": "Plasma"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Sage')
),
(
    (SELECT id FROM collections WHERE slug = 'cyber-vehicles'),
    'Cyber Truck X1',
    'https://helix-web-gilt.vercel.app/images/items/8b6b97ca381e4c865a07aad2ceea79d1866f39e5.png',
    'Armored transport vehicle for dangerous zones.',
    '{"type": "Truck", "topSpeed": 180, "acceleration": 60, "handling": 45, "fuel": "Electric", "armor": 95}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Blake')
),
(
    (SELECT id FROM collections WHERE slug = 'cyber-vehicles'),
    'Quantum Racer',
    'https://helix-web-gilt.vercel.app/images/items/fc92ea2f6acf797dffa40c424a332e5490fd76c2.png',
    'Professional racing vehicle with quantum engine.',
    '{"type": "Race Car", "topSpeed": 450, "acceleration": 98, "handling": 92, "fuel": "Quantum"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Alex')
),

-- Neon Pets
(
    (SELECT id FROM collections WHERE slug = 'neon-pets'),
    'Cyber Cat - Blue',
    'https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png',
    'This enchanting Cyber Cat moves with the grace of its organic ancestors, yet pulses with the electric soul of tomorrow. Thousands of microscopic LED fibers woven throughout its synthetic fur create a constellation of sapphire light that shifts with its mood and movements. Its emerald-green optical sensors track every gesture with loving attention, while an advanced AI personality core gives it the curiosity of a kitten and the wisdom of an ancient companion.',
    '{"type": "Cat", "color": "Blue", "intelligence": 85, "loyalty": 92, "energy": 78}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Nicxes')
),
(
    (SELECT id FROM collections WHERE slug = 'neon-pets'),
    'Holo Dog',
    'https://helix-web-gilt.vercel.app/images/items/aafbc7ed2324a9170c01678990fdd89b5268d672.png',
    'Loyal holographic dog companion.',
    '{"type": "Dog", "color": "Rainbow", "intelligence": 78, "loyalty": 98, "energy": 88}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Sage')
),
(
    (SELECT id FROM collections WHERE slug = 'neon-pets'),
    'Quantum Bird',
    'https://helix-web-gilt.vercel.app/images/items/8b6b97ca381e4c865a07aad2ceea79d1866f39e5.png',
    'Exotic bird that phases between dimensions.',
    '{"type": "Bird", "color": "Purple", "intelligence": 95, "loyalty": 75, "energy": 95, "ability": "Phase Shift"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Alex')
),

-- Cyber Wearables
(
    (SELECT id FROM collections WHERE slug = 'cyber-wearables'),
    'Neon Jacket',
    'https://helix-web-gilt.vercel.app/images/items/fc92ea2f6acf797dffa40c424a332e5490fd76c2.png',
    'Stylish jacket with programmable LED strips.',
    '{"type": "Jacket", "material": "Smart Fabric", "color": "Customizable", "tech": ["LED Display", "Temperature Control"]}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Blake')
),
(
    (SELECT id FROM collections WHERE slug = 'cyber-wearables'),
    'HUD Glasses',
    'https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png',
    'Augmented reality glasses with AI assistant.',
    '{"type": "Glasses", "material": "Titanium", "features": ["AR Display", "AI Assistant", "Night Vision"]}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Nicxes')
),
(
    (SELECT id FROM collections WHERE slug = 'cyber-wearables'),
    'Smart Boots',
    'https://helix-web-gilt.vercel.app/images/items/aafbc7ed2324a9170c01678990fdd89b5268d672.png',
    'High-tech boots with jump enhancement.',
    '{"type": "Boots", "material": "Carbon Fiber", "features": ["Jump Boost", "Shock Absorption", "Silent Step"]}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Sage')
),

-- Music NFTs
(
    (SELECT id FROM collections WHERE slug = 'music-nfts'),
    'Cyber Symphony #1',
    'https://helix-web-gilt.vercel.app/images/items/8b6b97ca381e4c865a07aad2ceea79d1866f39e5.png',
    'Epic orchestral piece with electronic elements.',
    '{"type": "Music", "genre": "Orchestral Electronic", "duration": 240, "bpm": 120, "artist": "NeoComposer"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Alex')
),
(
    (SELECT id FROM collections WHERE slug = 'music-nfts'),
    'Neon Beats Vol.1',
    'https://helix-web-gilt.vercel.app/images/items/fc92ea2f6acf797dffa40c424a332e5490fd76c2.png',
    'High-energy synthwave collection.',
    '{"type": "Music", "genre": "Synthwave", "duration": 180, "bpm": 140, "artist": "CyberBeats"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Blake')
),
(
    (SELECT id FROM collections WHERE slug = 'music-nfts'),
    'Digital Dreams',
    'https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png',
    'Ambient soundscape for meditation.',
    '{"type": "Music", "genre": "Ambient", "duration": 360, "bpm": 60, "artist": "DreamWeaver"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Nicxes')
),

-- Art Pieces
(
    (SELECT id FROM collections WHERE slug = 'art-pieces'),
    'Neon Genesis',
    'https://helix-web-gilt.vercel.app/images/items/aafbc7ed2324a9170c01678990fdd89b5268d672.png',
    'Abstract digital art with flowing neon colors.',
    '{"type": "Digital Art", "style": "Abstract", "dimensions": "4K", "artist": "CyberArtist", "medium": "Digital Paint"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Sage')
),
(
    (SELECT id FROM collections WHERE slug = 'art-pieces'),
    'City of Tomorrow',
    'https://helix-web-gilt.vercel.app/images/items/8b6b97ca381e4c865a07aad2ceea79d1866f39e5.png',
    'Futuristic cityscape with flying vehicles.',
    '{"type": "Digital Art", "style": "Futuristic", "dimensions": "8K", "artist": "FutureVision", "medium": "3D Render"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Alex')
),
(
    (SELECT id FROM collections WHERE slug = 'art-pieces'),
    'Data Stream',
    'https://helix-web-gilt.vercel.app/images/items/fc92ea2f6acf797dffa40c424a332e5490fd76c2.png',
    'Visualization of data flowing through networks.',
    '{"type": "Digital Art", "style": "Data Visualization", "dimensions": "4K", "artist": "DataViz", "medium": "Procedural"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Blake')
),

-- Game Items
(
    (SELECT id FROM collections WHERE slug = 'game-items'),
    'Power Crystal',
    'https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png',
    'The Power Crystal radiates with an inner fire that seems to bend reality itself around its crystalline facets. This legendary artifact pulses with raw energy harvested from quantum storms, its surface crackling with miniature lightning that dances between dimensions. When activated, it floods the user''s bio-systems with pure power, enhancing every synapse, every reflex, every fiber of being to superhuman levels. The crystal''s otherworldly hum resonates in frequencies that touch the very fabric of digital space.',
    '{"type": "Power-up", "rarity": "Legendary", "effect": "+50% All Stats", "duration": 300}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Nicxes')
),
(
    (SELECT id FROM collections WHERE slug = 'game-items'),
    'Cyber Shield',
    'https://helix-web-gilt.vercel.app/images/items/aafbc7ed2324a9170c01678990fdd89b5268d672.png',
    'Advanced defensive item that blocks digital attacks.',
    '{"type": "Shield", "rarity": "Epic", "defense": 95, "durability": 1000, "special": "EMP Resistance"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Sage')
),
(
    (SELECT id FROM collections WHERE slug = 'game-items'),
    'Quantum Sword',
    'https://helix-web-gilt.vercel.app/images/items/8b6b97ca381e4c865a07aad2ceea79d1866f39e5.png',
    'Legendary sword that cuts through any material.',
    '{"type": "Weapon", "rarity": "Legendary", "damage": 200, "durability": 2000, "special": "Phase Cut"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Alex')
),
(
    (SELECT id FROM collections WHERE slug = 'game-items'),
    'Hacker Toolkit',
    'https://helix-web-gilt.vercel.app/images/items/fc92ea2f6acf797dffa40c424a332e5490fd76c2.png',
    'Essential tools for any cyber operation.',
    '{"type": "Tool", "rarity": "Rare", "hackPower": 88, "uses": 50, "special": "Bypass Security"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Blake')
),

-- More HELIX Citizens (Avatars) - Total: 15 items
(
    (SELECT id FROM collections WHERE slug = 'helix-citizens'),
    'Cyber Citizen #205',
    'https://helix-web-gilt.vercel.app/images/items/fc92ea2f6acf797dffa40c424a332e5490fd76c2.png',
    'Military-grade augmented soldier with tactical implants.',
    '{"type": "Avatar", "rarity": "Epic", "level": 45, "cybernetics": ["Combat Systems", "Tactical HUD"]}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Sage')
),
(
    (SELECT id FROM collections WHERE slug = 'helix-citizens'),
    'Cyber Citizen #311',
    'https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png',
    'Artist with creative neural pathways enhanced for digital art.',
    '{"type": "Avatar", "rarity": "Rare", "level": 32, "cybernetics": ["Creative Cortex", "Color Vision+"]}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Alex')
),
(
    (SELECT id FROM collections WHERE slug = 'helix-citizens'),
    'Cyber Citizen #447',
    'https://helix-web-gilt.vercel.app/images/items/aafbc7ed2324a9170c01678990fdd89b5268d672.png',
    'Street medic with bio-healing capabilities.',
    '{"type": "Avatar", "rarity": "Epic", "level": 40, "cybernetics": ["Med Scanner", "Bio Synthesizer"]}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Blake')
),
(
    (SELECT id FROM collections WHERE slug = 'helix-citizens'),
    'Cyber Citizen #589',
    'https://helix-web-gilt.vercel.app/images/items/8b6b97ca381e4c865a07aad2ceea79d1866f39e5.png',
    'Engineer with mechanical augmentations.',
    '{"type": "Avatar", "rarity": "Rare", "level": 38, "cybernetics": ["Tool Interface", "Blueprint Vision"]}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Nicxes')
),
(
    (SELECT id FROM collections WHERE slug = 'helix-citizens'),
    'Cyber Citizen #672',
    'https://helix-web-gilt.vercel.app/images/items/fc92ea2f6acf797dffa40c424a332e5490fd76c2.png',
    'Pilot with enhanced reflexes and spatial awareness.',
    '{"type": "Avatar", "rarity": "Epic", "level": 42, "cybernetics": ["Flight Computer", "G-Force Compensation"]}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Sage')
),
(
    (SELECT id FROM collections WHERE slug = 'helix-citizens'),
    'Cyber Citizen #758',
    'https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png',
    'Trader with market analysis implants.',
    '{"type": "Avatar", "rarity": "Rare", "level": 29, "cybernetics": ["Market Scanner", "Price Predictor"]}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Alex')
),
(
    (SELECT id FROM collections WHERE slug = 'helix-citizens'),
    'Cyber Citizen #823',
    'https://helix-web-gilt.vercel.app/images/items/aafbc7ed2324a9170c01678990fdd89b5268d672.png',
    'Security specialist with threat detection systems.',
    '{"type": "Avatar", "rarity": "Epic", "level": 48, "cybernetics": ["Threat Scanner", "Combat Protocols"]}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Blake')
),
(
    (SELECT id FROM collections WHERE slug = 'helix-citizens'),
    'Cyber Citizen #901',
    'https://helix-web-gilt.vercel.app/images/items/8b6b97ca381e4c865a07aad2ceea79d1866f39e5.png',
    'Researcher with enhanced cognitive processing.',
    '{"type": "Avatar", "rarity": "Legendary", "level": 52, "cybernetics": ["Quantum Brain", "Data Archive"]}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Nicxes')
),
(
    (SELECT id FROM collections WHERE slug = 'helix-citizens'),
    'Cyber Citizen #104',
    'https://helix-web-gilt.vercel.app/images/items/fc92ea2f6acf797dffa40c424a332e5490fd76c2.png',
    'Explorer with environmental adaptation systems.',
    '{"type": "Avatar", "rarity": "Rare", "level": 33, "cybernetics": ["Climate Control", "Terrain Scanner"]}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Sage')
),
(
    (SELECT id FROM collections WHERE slug = 'helix-citizens'),
    'Cyber Citizen #256',
    'https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png',
    'Mechanic with tool-integrated limbs.',
    '{"type": "Avatar", "rarity": "Epic", "level": 41, "cybernetics": ["Multi-Tool Arms", "Diagnostic Vision"]}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Alex')
),
(
    (SELECT id FROM collections WHERE slug = 'helix-citizens'),
    'Cyber Citizen #367',
    'https://helix-web-gilt.vercel.app/images/items/aafbc7ed2324a9170c01678990fdd89b5268d672.png',
    'DJ with audio processing implants.',
    '{"type": "Avatar", "rarity": "Rare", "level": 35, "cybernetics": ["Sound Synthesizer", "Beat Detector"]}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Blake')
),
(
    (SELECT id FROM collections WHERE slug = 'helix-citizens'),
    'Cyber Citizen #499',
    'https://helix-web-gilt.vercel.app/images/items/8b6b97ca381e4c865a07aad2ceea79d1866f39e5.png',
    'Chef with enhanced taste and smell sensors.',
    '{"type": "Avatar", "rarity": "Rare", "level": 31, "cybernetics": ["Flavor Analyzer", "Nutrition Scanner"]}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Nicxes')
),

-- More Blade Runner Weapons - Total: 12 items
(
    (SELECT id FROM collections WHERE slug = 'blade-runner'),
    'Blade Runner Katana',
    'https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png',
    'Traditional katana with molecular-sharp edge.',
    '{"type": "Sword", "condition": "Factory New", "productionYear": 2023, "mobility": 105, "damage": 95}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Alex')
),
(
    (SELECT id FROM collections WHERE slug = 'blade-runner'),
    'Blade Runner Rifle',
    'https://helix-web-gilt.vercel.app/images/items/aafbc7ed2324a9170c01678990fdd89b5268d672.png',
    'Advanced rifle with smart targeting system.',
    '{"type": "Rifle", "condition": "Factory New", "productionYear": 2023, "mobility": 75, "damage": 110}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Blake')
),
(
    (SELECT id FROM collections WHERE slug = 'blade-runner'),
    'Blade Runner Axe',
    'https://helix-web-gilt.vercel.app/images/items/8b6b97ca381e4c865a07aad2ceea79d1866f39e5.png',
    'Heavy axe with energy core enhancement.',
    '{"type": "Axe", "condition": "Field-Tested", "productionYear": 2022, "mobility": 65, "damage": 125}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Sage')
),
(
    (SELECT id FROM collections WHERE slug = 'blade-runner'),
    'Blade Runner Dagger',
    'https://helix-web-gilt.vercel.app/images/items/fc92ea2f6acf797dffa40c424a332e5490fd76c2.png',
    'Lightweight dagger perfect for stealth operations.',
    '{"type": "Dagger", "condition": "Factory New", "productionYear": 2023, "mobility": 125, "damage": 60}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Nicxes')
),
(
    (SELECT id FROM collections WHERE slug = 'blade-runner'),
    'Blade Runner Crossbow',
    'https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png',
    'Silent crossbow with explosive bolts.',
    '{"type": "Crossbow", "condition": "Well-Worn", "productionYear": 2021, "mobility": 85, "damage": 88}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Alex')
),
(
    (SELECT id FROM collections WHERE slug = 'blade-runner'),
    'Blade Runner Grenade',
    'https://helix-web-gilt.vercel.app/images/items/aafbc7ed2324a9170c01678990fdd89b5268d672.png',
    'EMP grenade with area effect damage.',
    '{"type": "Grenade", "condition": "Factory New", "productionYear": 2023, "mobility": 95, "damage": 140}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Blake')
),
(
    (SELECT id FROM collections WHERE slug = 'blade-runner'),
    'Blade Runner Shield',
    'https://helix-web-gilt.vercel.app/images/items/8b6b97ca381e4c865a07aad2ceea79d1866f39e5.png',
    'Energy shield that deflects projectiles.',
    '{"type": "Shield", "condition": "Factory New", "productionYear": 2023, "mobility": 90, "defense": 85}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Sage')
),
(
    (SELECT id FROM collections WHERE slug = 'blade-runner'),
    'Blade Runner Hammer',
    'https://helix-web-gilt.vercel.app/images/items/fc92ea2f6acf797dffa40c424a332e5490fd76c2.png',
    'Devastating hammer with shock wave generation.',
    '{"type": "Hammer", "condition": "Field-Tested", "productionYear": 2022, "mobility": 55, "damage": 135}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Nicxes')
),

-- More Fire Dragon Weapons - Total: 10 items
(
    (SELECT id FROM collections WHERE slug = 'fire-dragon'),
    'Fire Dragon Pistol',
    'https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png',
    'Compact pistol with flame ammunition.',
    '{"type": "Pistol", "condition": "Factory New", "productionYear": 2023, "mobility": 98, "damage": 70}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Alex')
),
(
    (SELECT id FROM collections WHERE slug = 'fire-dragon'),
    'Fire Dragon SMG',
    'https://helix-web-gilt.vercel.app/images/items/aafbc7ed2324a9170c01678990fdd89b5268d672.png',
    'Rapid-fire SMG with incendiary rounds.',
    '{"type": "SMG", "condition": "Field-Tested", "productionYear": 2022, "mobility": 112, "damage": 68}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Blake')
),
(
    (SELECT id FROM collections WHERE slug = 'fire-dragon'),
    'Fire Dragon Blade',
    'https://helix-web-gilt.vercel.app/images/items/8b6b97ca381e4c865a07aad2ceea79d1866f39e5.png',
    'Flaming sword that burns enemies on contact.',
    '{"type": "Sword", "condition": "Factory New", "productionYear": 2023, "mobility": 108, "damage": 105}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Sage')
),
(
    (SELECT id FROM collections WHERE slug = 'fire-dragon'),
    'Fire Dragon Launcher',
    'https://helix-web-gilt.vercel.app/images/items/fc92ea2f6acf797dffa40c424a332e5490fd76c2.png',
    'Rocket launcher with napalm warheads.',
    '{"type": "Launcher", "condition": "Factory New", "productionYear": 2023, "mobility": 45, "damage": 175}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Nicxes')
),
(
    (SELECT id FROM collections WHERE slug = 'fire-dragon'),
    'Fire Dragon Bow',
    'https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png',
    'Mystical bow that shoots fire arrows.',
    '{"type": "Bow", "condition": "Field-Tested", "productionYear": 2022, "mobility": 88, "damage": 92}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Alex')
),
(
    (SELECT id FROM collections WHERE slug = 'fire-dragon'),
    'Fire Dragon Gauntlets',
    'https://helix-web-gilt.vercel.app/images/items/aafbc7ed2324a9170c01678990fdd89b5268d672.png',
    'Armored gauntlets that channel flame energy.',
    '{"type": "Gauntlets", "condition": "Factory New", "productionYear": 2023, "mobility": 95, "damage": 78}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Blake')
),
(
    (SELECT id FROM collections WHERE slug = 'fire-dragon'),
    'Fire Dragon Staff',
    'https://helix-web-gilt.vercel.app/images/items/8b6b97ca381e4c865a07aad2ceea79d1866f39e5.png',
    'Magical staff that commands fire elements.',
    '{"type": "Staff", "condition": "Factory New", "productionYear": 2023, "mobility": 82, "damage": 115}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Sage')
),

-- More Kal Rifle items - Total: 12 items
(
    (SELECT id FROM collections WHERE slug = 'kal-rifle'),
    'Kal Rifle - Tactical',
    'https://helix-web-gilt.vercel.app/images/items/fc92ea2f6acf797dffa40c424a332e5490fd76c2.png',
    'Tactical variant with advanced scope and grip.',
    '{"type": "Assault Rifle", "condition": "Factory New", "productionYear": 2023, "mobility": 88, "damage": 92}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Blake')
),
(
    (SELECT id FROM collections WHERE slug = 'kal-rifle'),
    'Kal Rifle - Stealth',
    'https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png',
    'Silenced version for covert operations.',
    '{"type": "Assault Rifle", "condition": "Field-Tested", "productionYear": 2022, "mobility": 92, "damage": 85}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Sage')
),
(
    (SELECT id FROM collections WHERE slug = 'kal-rifle'),
    'Kal Rifle - Heavy',
    'https://helix-web-gilt.vercel.app/images/items/aafbc7ed2324a9170c01678990fdd89b5268d672.png',
    'Heavy variant with increased firepower.',
    '{"type": "Assault Rifle", "condition": "Factory New", "productionYear": 2023, "mobility": 75, "damage": 105}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Alex')
),
(
    (SELECT id FROM collections WHERE slug = 'kal-rifle'),
    'Kal Rifle - Scout',
    'https://helix-web-gilt.vercel.app/images/items/8b6b97ca381e4c865a07aad2ceea79d1866f39e5.png',
    'Lightweight scout version for mobility.',
    '{"type": "Assault Rifle", "condition": "Well-Worn", "productionYear": 2021, "mobility": 98, "damage": 78}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Nicxes')
),
(
    (SELECT id FROM collections WHERE slug = 'kal-rifle'),
    'Kal Rifle - Sniper',
    'https://helix-web-gilt.vercel.app/images/items/fc92ea2f6acf797dffa40c424a332e5490fd76c2.png',
    'Long-range sniper configuration.',
    '{"type": "Sniper Rifle", "condition": "Factory New", "productionYear": 2023, "mobility": 65, "damage": 125}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Blake')
),
(
    (SELECT id FROM collections WHERE slug = 'kal-rifle'),
    'Kal Rifle - CQB',
    'https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png',
    'Close quarters battle variant.',
    '{"type": "Assault Rifle", "condition": "Field-Tested", "productionYear": 2022, "mobility": 95, "damage": 88}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Sage')
),
(
    (SELECT id FROM collections WHERE slug = 'kal-rifle'),
    'Kal Rifle - DMR',
    'https://helix-web-gilt.vercel.app/images/items/aafbc7ed2324a9170c01678990fdd89b5268d672.png',
    'Designated marksman rifle with precision optics.',
    '{"type": "DMR", "condition": "Factory New", "productionYear": 2023, "mobility": 78, "damage": 98}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Alex')
),
(
    (SELECT id FROM collections WHERE slug = 'kal-rifle'),
    'Kal Rifle - Burst',
    'https://helix-web-gilt.vercel.app/images/items/8b6b97ca381e4c865a07aad2ceea79d1866f39e5.png',
    'Burst-fire variant for controlled shooting.',
    '{"type": "Assault Rifle", "condition": "Field-Tested", "productionYear": 2022, "mobility": 85, "damage": 90}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Nicxes')
),
(
    (SELECT id FROM collections WHERE slug = 'kal-rifle'),
    'Kal Rifle - Auto',
    'https://helix-web-gilt.vercel.app/images/items/fc92ea2f6acf797dffa40c424a332e5490fd76c2.png',
    'Full-auto variant with drum magazine.',
    '{"type": "LMG", "condition": "Factory New", "productionYear": 2023, "mobility": 68, "damage": 95}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Blake')
),

-- More Cyber Vehicles - Total: 15 items
(
    (SELECT id FROM collections WHERE slug = 'cyber-vehicles'),
    'Hover Sedan',
    'https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png',
    'Luxury hover sedan for city cruising.',
    '{"type": "Sedan", "topSpeed": 200, "acceleration": 75, "handling": 82, "fuel": "Electric", "passengers": 4}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Nicxes')
),
(
    (SELECT id FROM collections WHERE slug = 'cyber-vehicles'),
    'Cyber Motorcycle',
    'https://helix-web-gilt.vercel.app/images/items/aafbc7ed2324a9170c01678990fdd89b5268d672.png',
    'High-speed motorcycle with AI navigation.',
    '{"type": "Motorcycle", "topSpeed": 280, "acceleration": 92, "handling": 95, "fuel": "Fusion"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Alex')
),
(
    (SELECT id FROM collections WHERE slug = 'cyber-vehicles'),
    'Stealth Fighter',
    'https://helix-web-gilt.vercel.app/images/items/8b6b97ca381e4c865a07aad2ceea79d1866f39e5.png',
    'Advanced stealth aircraft for aerial combat.',
    '{"type": "Aircraft", "topSpeed": 1200, "acceleration": 85, "handling": 78, "fuel": "Plasma", "stealth": true}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Sage')
),
(
    (SELECT id FROM collections WHERE slug = 'cyber-vehicles'),
    'Submersible Pod',
    'https://helix-web-gilt.vercel.app/images/items/fc92ea2f6acf797dffa40c424a332e5490fd76c2.png',
    'Underwater exploration vehicle.',
    '{"type": "Submarine", "topSpeed": 120, "acceleration": 55, "handling": 68, "fuel": "Nuclear", "depth": 5000}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Blake')
),
(
    (SELECT id FROM collections WHERE slug = 'cyber-vehicles'),
    'Mech Walker',
    'https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png',
    'Bipedal mech for heavy combat operations.',
    '{"type": "Mech", "topSpeed": 80, "acceleration": 45, "handling": 35, "fuel": "Fusion", "weapons": true}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Nicxes')
),
(
    (SELECT id FROM collections WHERE slug = 'cyber-vehicles'),
    'Racing Drone',
    'https://helix-web-gilt.vercel.app/images/items/aafbc7ed2324a9170c01678990fdd89b5268d672.png',
    'Ultra-fast racing drone for competitions.',
    '{"type": "Drone", "topSpeed": 350, "acceleration": 98, "handling": 95, "fuel": "Battery"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Alex')
),
(
    (SELECT id FROM collections WHERE slug = 'cyber-vehicles'),
    'Cargo Hauler',
    'https://helix-web-gilt.vercel.app/images/items/8b6b97ca381e4c865a07aad2ceea79d1866f39e5.png',
    'Heavy-duty cargo transport vehicle.',
    '{"type": "Truck", "topSpeed": 150, "acceleration": 40, "handling": 25, "fuel": "Hybrid", "cargo": 15000}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Sage')
),
(
    (SELECT id FROM collections WHERE slug = 'cyber-vehicles'),
    'Sports Coupe',
    'https://helix-web-gilt.vercel.app/images/items/fc92ea2f6acf797dffa40c424a332e5490fd76c2.png',
    'High-performance sports car with neural link.',
    '{"type": "Sports Car", "topSpeed": 380, "acceleration": 90, "handling": 88, "fuel": "Hydrogen"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Blake')
),
(
    (SELECT id FROM collections WHERE slug = 'cyber-vehicles'),
    'Utility ATV',
    'https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png',
    'All-terrain vehicle for rough environments.',
    '{"type": "ATV", "topSpeed": 160, "acceleration": 70, "handling": 85, "fuel": "Electric", "terrain": "All"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Nicxes')
),
(
    (SELECT id FROM collections WHERE slug = 'cyber-vehicles'),
    'Luxury Yacht',
    'https://helix-web-gilt.vercel.app/images/items/aafbc7ed2324a9170c01678990fdd89b5268d672.png',
    'High-tech yacht for water exploration.',
    '{"type": "Yacht", "topSpeed": 95, "acceleration": 35, "handling": 45, "fuel": "Solar", "luxury": true}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Alex')
),
(
    (SELECT id FROM collections WHERE slug = 'cyber-vehicles'),
    'Space Shuttle',
    'https://helix-web-gilt.vercel.app/images/items/8b6b97ca381e4c865a07aad2ceea79d1866f39e5.png',
    'Interplanetary transport vehicle.',
    '{"type": "Spacecraft", "topSpeed": 25000, "acceleration": 60, "handling": 55, "fuel": "Antimatter"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Sage')
),
(
    (SELECT id FROM collections WHERE slug = 'cyber-vehicles'),
    'Battle Tank',
    'https://helix-web-gilt.vercel.app/images/items/fc92ea2f6acf797dffa40c424a332e5490fd76c2.png',
    'Heavily armored combat vehicle.',
    '{"type": "Tank", "topSpeed": 70, "acceleration": 25, "handling": 15, "fuel": "Diesel", "armor": 98}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Blake')
),

-- More Neon Pets - Total: 18 items
(
    (SELECT id FROM collections WHERE slug = 'neon-pets'),
    'Cyber Wolf',
    'https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png',
    'Loyal wolf companion with pack instincts.',
    '{"type": "Wolf", "color": "Silver", "intelligence": 88, "loyalty": 95, "energy": 90}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Blake')
),
(
    (SELECT id FROM collections WHERE slug = 'neon-pets'),
    'Digital Dragon',
    'https://helix-web-gilt.vercel.app/images/items/aafbc7ed2324a9170c01678990fdd89b5268d672.png',
    'Majestic dragon with fire breath ability.',
    '{"type": "Dragon", "color": "Red", "intelligence": 98, "loyalty": 85, "energy": 95, "ability": "Fire Breath"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Nicxes')
),
(
    (SELECT id FROM collections WHERE slug = 'neon-pets'),
    'Neon Tiger',
    'https://helix-web-gilt.vercel.app/images/items/8b6b97ca381e4c865a07aad2ceea79d1866f39e5.png',
    'Fierce tiger with electric stripes.',
    '{"type": "Tiger", "color": "Orange", "intelligence": 82, "loyalty": 78, "energy": 88}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Sage')
),
(
    (SELECT id FROM collections WHERE slug = 'neon-pets'),
    'Plasma Fox',
    'https://helix-web-gilt.vercel.app/images/items/fc92ea2f6acf797dffa40c424a332e5490fd76c2.png',
    'Cunning fox with plasma tail effects.',
    '{"type": "Fox", "color": "Blue", "intelligence": 92, "loyalty": 75, "energy": 85}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Alex')
),
(
    (SELECT id FROM collections WHERE slug = 'neon-pets'),
    'Cyber Hawk',
    'https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png',
    'Swift hawk with enhanced vision.',
    '{"type": "Hawk", "color": "Brown", "intelligence": 85, "loyalty": 88, "energy": 92, "ability": "Eagle Eye"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Blake')
),
(
    (SELECT id FROM collections WHERE slug = 'neon-pets'),
    'Holo Snake',
    'https://helix-web-gilt.vercel.app/images/items/aafbc7ed2324a9170c01678990fdd89b5268d672.png',
    'Mysterious snake that phases in and out.',
    '{"type": "Snake", "color": "Green", "intelligence": 78, "loyalty": 65, "energy": 75, "ability": "Phase"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Nicxes')
),
(
    (SELECT id FROM collections WHERE slug = 'neon-pets'),
    'Digital Rabbit',
    'https://helix-web-gilt.vercel.app/images/items/8b6b97ca381e4c865a07aad2ceea79d1866f39e5.png',
    'Quick rabbit with jump boost ability.',
    '{"type": "Rabbit", "color": "White", "intelligence": 72, "loyalty": 85, "energy": 95, "ability": "Super Jump"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Sage')
),
(
    (SELECT id FROM collections WHERE slug = 'neon-pets'),
    'Neon Owl',
    'https://helix-web-gilt.vercel.app/images/items/fc92ea2f6acf797dffa40c424a332e5490fd76c2.png',
    'Wise owl with night vision capabilities.',
    '{"type": "Owl", "color": "Purple", "intelligence": 95, "loyalty": 82, "energy": 68, "ability": "Night Vision"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Alex')
),
(
    (SELECT id FROM collections WHERE slug = 'neon-pets'),
    'Cyber Bear',
    'https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png',
    'Strong bear with protective instincts.',
    '{"type": "Bear", "color": "Black", "intelligence": 80, "loyalty": 92, "energy": 78}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Blake')
),
(
    (SELECT id FROM collections WHERE slug = 'neon-pets'),
    'Plasma Dolphin',
    'https://helix-web-gilt.vercel.app/images/items/aafbc7ed2324a9170c01678990fdd89b5268d672.png',
    'Intelligent dolphin with sonic abilities.',
    '{"type": "Dolphin", "color": "Blue", "intelligence": 92, "loyalty": 88, "energy": 82, "ability": "Sonar"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Nicxes')
),
(
    (SELECT id FROM collections WHERE slug = 'neon-pets'),
    'Digital Monkey',
    'https://helix-web-gilt.vercel.app/images/items/8b6b97ca381e4c865a07aad2ceea79d1866f39e5.png',
    'Playful monkey with acrobatic skills.',
    '{"type": "Monkey", "color": "Brown", "intelligence": 88, "loyalty": 75, "energy": 95}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Sage')
),
(
    (SELECT id FROM collections WHERE slug = 'neon-pets'),
    'Neon Turtle',
    'https://helix-web-gilt.vercel.app/images/items/fc92ea2f6acf797dffa40c424a332e5490fd76c2.png',
    'Wise turtle with defensive capabilities.',
    '{"type": "Turtle", "color": "Green", "intelligence": 85, "loyalty": 95, "energy": 45, "ability": "Shell Shield"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Alex')
),
(
    (SELECT id FROM collections WHERE slug = 'neon-pets'),
    'Cyber Panther',
    'https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png',
    'Stealthy panther with invisibility cloak.',
    '{"type": "Panther", "color": "Black", "intelligence": 90, "loyalty": 82, "energy": 88, "ability": "Stealth"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Blake')
),
(
    (SELECT id FROM collections WHERE slug = 'neon-pets'),
    'Holo Penguin',
    'https://helix-web-gilt.vercel.app/images/items/aafbc7ed2324a9170c01678990fdd89b5268d672.png',
    'Adorable penguin with ice abilities.',
    '{"type": "Penguin", "color": "Black-White", "intelligence": 75, "loyalty": 88, "energy": 72, "ability": "Ice Slide"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Nicxes')
),
(
    (SELECT id FROM collections WHERE slug = 'neon-pets'),
    'Digital Spider',
    'https://helix-web-gilt.vercel.app/images/items/8b6b97ca381e4c865a07aad2ceea79d1866f39e5.png',
    'Agile spider with web-weaving skills.',
    '{"type": "Spider", "color": "Red", "intelligence": 78, "loyalty": 65, "energy": 85, "ability": "Web Trap"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Sage')
),

-- More Cyber Wearables - Total: 20 items
(
    (SELECT id FROM collections WHERE slug = 'cyber-wearables'),
    'Neural Headband',
    'https://helix-web-gilt.vercel.app/images/items/fc92ea2f6acf797dffa40c424a332e5490fd76c2.png',
    'Headband that enhances mental processing power.',
    '{"type": "Headband", "material": "Titanium", "features": ["Brain Boost", "Memory Enhancement", "Focus Mode"]}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Alex')
),
(
    (SELECT id FROM collections WHERE slug = 'cyber-wearables'),
    'Power Gloves',
    'https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png',
    'Gloves that amplify physical strength.',
    '{"type": "Gloves", "material": "Carbon Fiber", "features": ["Strength Boost", "Grip Enhancement", "Shock Absorption"]}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Blake')
),
(
    (SELECT id FROM collections WHERE slug = 'cyber-wearables'),
    'Stealth Cloak',
    'https://helix-web-gilt.vercel.app/images/items/aafbc7ed2324a9170c01678990fdd89b5268d672.png',
    'Cloak that provides optical invisibility.',
    '{"type": "Cloak", "material": "Meta-material", "features": ["Optical Camouflage", "Thermal Masking", "Sound Dampening"]}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Sage')
),
(
    (SELECT id FROM collections WHERE slug = 'cyber-wearables'),
    'Cyber Mask',
    'https://helix-web-gilt.vercel.app/images/items/8b6b97ca381e4c865a07aad2ceea79d1866f39e5.png',
    'Mask with air filtration and voice modulation.',
    '{"type": "Mask", "material": "Polymer", "features": ["Air Filter", "Voice Changer", "Gas Protection"]}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Nicxes')
),
(
    (SELECT id FROM collections WHERE slug = 'cyber-wearables'),
    'Energy Shield Belt',
    'https://helix-web-gilt.vercel.app/images/items/fc92ea2f6acf797dffa40c424a332e5490fd76c2.png',
    'Belt that generates personal energy shields.',
    '{"type": "Belt", "material": "Alloy", "features": ["Energy Shield", "Power Storage", "Quick Deploy"]}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Alex')
),
(
    (SELECT id FROM collections WHERE slug = 'cyber-wearables'),
    'Hover Backpack',
    'https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png',
    'Backpack with anti-gravity capabilities.',
    '{"type": "Backpack", "material": "Composite", "features": ["Anti-Gravity", "Extra Storage", "Weight Reduction"]}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Blake')
),
(
    (SELECT id FROM collections WHERE slug = 'cyber-wearables'),
    'Thermal Suit',
    'https://helix-web-gilt.vercel.app/images/items/aafbc7ed2324a9170c01678990fdd89b5268d672.png',
    'Suit that regulates body temperature.',
    '{"type": "Suit", "material": "Smart Fabric", "features": ["Temperature Control", "Insulation", "Breathability"]}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Sage')
),
(
    (SELECT id FROM collections WHERE slug = 'cyber-wearables'),
    'Speed Shoes',
    'https://helix-web-gilt.vercel.app/images/items/8b6b97ca381e4c865a07aad2ceea79d1866f39e5.png',
    'Shoes that enhance running speed.',
    '{"type": "Shoes", "material": "Nanomaterial", "features": ["Speed Boost", "Traction Control", "Energy Return"]}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Nicxes')
),
(
    (SELECT id FROM collections WHERE slug = 'cyber-wearables'),
    'Data Wristband',
    'https://helix-web-gilt.vercel.app/images/items/fc92ea2f6acf797dffa40c424a332e5490fd76c2.png',
    'Wristband with data processing capabilities.',
    '{"type": "Wristband", "material": "Silicon", "features": ["Data Storage", "Wireless Transfer", "Biometric Scanner"]}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Alex')
),
(
    (SELECT id FROM collections WHERE slug = 'cyber-wearables'),
    'Tactical Vest',
    'https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png',
    'Armored vest with utility pockets.',
    '{"type": "Vest", "material": "Kevlar", "features": ["Bullet Resistance", "Storage Pockets", "Lightweight"]}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Blake')
),
(
    (SELECT id FROM collections WHERE slug = 'cyber-wearables'),
    'Vision Visor',
    'https://helix-web-gilt.vercel.app/images/items/aafbc7ed2324a9170c01678990fdd89b5268d672.png',
    'Visor with enhanced vision modes.',
    '{"type": "Visor", "material": "Crystal", "features": ["X-Ray Vision", "Thermal Vision", "Zoom Function"]}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Sage')
),
(
    (SELECT id FROM collections WHERE slug = 'cyber-wearables'),
    'Cyber Earpiece',
    'https://helix-web-gilt.vercel.app/images/items/8b6b97ca381e4c865a07aad2ceea79d1866f39e5.png',
    'Earpiece with communication and translation.',
    '{"type": "Earpiece", "material": "Titanium", "features": ["Comm Link", "Language Translation", "Noise Canceling"]}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Nicxes')
),
(
    (SELECT id FROM collections WHERE slug = 'cyber-wearables'),
    'Smart Ring',
    'https://helix-web-gilt.vercel.app/images/items/fc92ea2f6acf797dffa40c424a332e5490fd76c2.png',
    'Ring with digital interface capabilities.',
    '{"type": "Ring", "material": "Gold Alloy", "features": ["Holographic Display", "Gesture Control", "Biometric Lock"]}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Alex')
),
(
    (SELECT id FROM collections WHERE slug = 'cyber-wearables'),
    'Nano Shirt',
    'https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png',
    'Shirt made of programmable nanobots.',
    '{"type": "Shirt", "material": "Nanobots", "features": ["Self-Repair", "Color Change", "Adaptive Fit"]}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Blake')
),
(
    (SELECT id FROM collections WHERE slug = 'cyber-wearables'),
    'Magnetic Bracelet',
    'https://helix-web-gilt.vercel.app/images/items/aafbc7ed2324a9170c01678990fdd89b5268d672.png',
    'Bracelet that manipulates magnetic fields.',
    '{"type": "Bracelet", "material": "Magnetic Alloy", "features": ["Magnetic Control", "Metal Detection", "Field Generation"]}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Sage')
),
(
    (SELECT id FROM collections WHERE slug = 'cyber-wearables'),
    'Quantum Watch',
    'https://helix-web-gilt.vercel.app/images/items/8b6b97ca381e4c865a07aad2ceea79d1866f39e5.png',
    'Watch that can manipulate time perception.',
    '{"type": "Watch", "material": "Quantum Crystal", "features": ["Time Dilation", "Dimensional Clock", "Temporal Shield"]}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Nicxes')
),
(
    (SELECT id FROM collections WHERE slug = 'cyber-wearables'),
    'Holographic Hat',
    'https://helix-web-gilt.vercel.app/images/items/fc92ea2f6acf797dffa40c424a332e5490fd76c2.png',
    'Hat that projects holographic displays.',
    '{"type": "Hat", "material": "Smart Fabric", "features": ["Hologram Projector", "Weather Protection", "Style Changer"]}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Alex')
),

-- More Music NFTs - Total: 25 items
(
    (SELECT id FROM collections WHERE slug = 'music-nfts'),
    'Bass Drop Revolution',
    'https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png',
    'Hard-hitting electronic track with massive bass drops.',
    '{"type": "Music", "genre": "Electronic", "duration": 210, "bpm": 128, "artist": "BassKing"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Blake')
),
(
    (SELECT id FROM collections WHERE slug = 'music-nfts'),
    'Quantum Jazz Fusion',
    'https://helix-web-gilt.vercel.app/images/items/aafbc7ed2324a9170c01678990fdd89b5268d672.png',
    'Experimental jazz with quantum sound effects.',
    '{"type": "Music", "genre": "Jazz Fusion", "duration": 320, "bpm": 90, "artist": "QuantumJazz"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Sage')
),
(
    (SELECT id FROM collections WHERE slug = 'music-nfts'),
    'Cyber Punk Anthem',
    'https://helix-web-gilt.vercel.app/images/items/8b6b97ca381e4c865a07aad2ceea79d1866f39e5.png',
    'Aggressive punk rock with cyber elements.',
    '{"type": "Music", "genre": "Cyber Punk", "duration": 190, "bpm": 160, "artist": "NeonRebel"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Nicxes')
),
(
    (SELECT id FROM collections WHERE slug = 'music-nfts'),
    'Digital Orchestra Suite',
    'https://helix-web-gilt.vercel.app/images/items/fc92ea2f6acf797dffa40c424a332e5490fd76c2.png',
    'Classical orchestra enhanced with digital instruments.',
    '{"type": "Music", "genre": "Digital Classical", "duration": 480, "bpm": 72, "artist": "DigiMaestro"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Alex')
),
(
    (SELECT id FROM collections WHERE slug = 'music-nfts'),
    'Techno Underground',
    'https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png',
    'Underground techno with hypnotic beats.',
    '{"type": "Music", "genre": "Techno", "duration": 360, "bpm": 135, "artist": "UndergroundTech"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Blake')
),
(
    (SELECT id FROM collections WHERE slug = 'music-nfts'),
    'Ambient Space Journey',
    'https://helix-web-gilt.vercel.app/images/items/aafbc7ed2324a9170c01678990fdd89b5268d672.png',
    'Ambient soundscape inspired by space exploration.',
    '{"type": "Music", "genre": "Ambient", "duration": 600, "bpm": 50, "artist": "CosmicSounds"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Sage')
),
(
    (SELECT id FROM collections WHERE slug = 'music-nfts'),
    'Glitch Hop Experiment',
    'https://helix-web-gilt.vercel.app/images/items/8b6b97ca381e4c865a07aad2ceea79d1866f39e5.png',
    'Experimental glitch hop with unique sound design.',
    '{"type": "Music", "genre": "Glitch Hop", "duration": 255, "bpm": 110, "artist": "GlitchMaster"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Nicxes')
),
(
    (SELECT id FROM collections WHERE slug = 'music-nfts'),
    'Synthwave Memories',
    'https://helix-web-gilt.vercel.app/images/items/fc92ea2f6acf797dffa40c424a332e5490fd76c2.png',
    'Nostalgic synthwave track reminiscent of the 80s.',
    '{"type": "Music", "genre": "Synthwave", "duration": 275, "bpm": 118, "artist": "RetroWave"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Alex')
),
(
    (SELECT id FROM collections WHERE slug = 'music-nfts'),
    'Drum and Bass Velocity',
    'https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png',
    'High-energy drum and bass with rapid breakbeats.',
    '{"type": "Music", "genre": "Drum and Bass", "duration": 285, "bpm": 174, "artist": "VelocityDnB"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Blake')
),
(
    (SELECT id FROM collections WHERE slug = 'music-nfts'),
    'Chill Trap Vibes',
    'https://helix-web-gilt.vercel.app/images/items/aafbc7ed2324a9170c01678990fdd89b5268d672.png',
    'Relaxed trap beats with chill atmosphere.',
    '{"type": "Music", "genre": "Chill Trap", "duration": 220, "bpm": 85, "artist": "ChillTrapLord"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Sage')
),
(
    (SELECT id FROM collections WHERE slug = 'music-nfts'),
    'Industrial Metal Core',
    'https://helix-web-gilt.vercel.app/images/items/8b6b97ca381e4c865a07aad2ceea79d1866f39e5.png',
    'Heavy industrial metal with electronic elements.',
    '{"type": "Music", "genre": "Industrial Metal", "duration": 240, "bpm": 145, "artist": "MetalCore"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Nicxes')
),
(
    (SELECT id FROM collections WHERE slug = 'music-nfts'),
    'Future Bass Evolution',
    'https://helix-web-gilt.vercel.app/images/items/fc92ea2f6acf797dffa40c424a332e5490fd76c2.png',
    'Melodic future bass with emotional drops.',
    '{"type": "Music", "genre": "Future Bass", "duration": 195, "bpm": 140, "artist": "FutureBeat"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Alex')
),
(
    (SELECT id FROM collections WHERE slug = 'music-nfts'),
    'Dubstep Destruction',
    'https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png',
    'Aggressive dubstep with heavy wobbles.',
    '{"type": "Music", "genre": "Dubstep", "duration": 265, "bpm": 140, "artist": "DubDestroyer"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Blake')
),
(
    (SELECT id FROM collections WHERE slug = 'music-nfts'),
    'Lo-Fi Hip Hop Study',
    'https://helix-web-gilt.vercel.app/images/items/aafbc7ed2324a9170c01678990fdd89b5268d672.png',
    'Relaxing lo-fi hip hop perfect for studying.',
    '{"type": "Music", "genre": "Lo-Fi Hip Hop", "duration": 180, "bpm": 70, "artist": "LoFiStudy"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Sage')
),
(
    (SELECT id FROM collections WHERE slug = 'music-nfts'),
    'Psytrance Journey',
    'https://helix-web-gilt.vercel.app/images/items/8b6b97ca381e4c865a07aad2ceea79d1866f39e5.png',
    'Mind-bending psytrance with psychedelic elements.',
    '{"type": "Music", "genre": "Psytrance", "duration": 420, "bpm": 145, "artist": "PsyMind"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Nicxes')
),
(
    (SELECT id FROM collections WHERE slug = 'music-nfts'),
    'Hardstyle Energy',
    'https://helix-web-gilt.vercel.app/images/items/fc92ea2f6acf797dffa40c424a332e5490fd76c2.png',
    'High-energy hardstyle with powerful kicks.',
    '{"type": "Music", "genre": "Hardstyle", "duration": 300, "bpm": 150, "artist": "HardEnergy"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Alex')
),
(
    (SELECT id FROM collections WHERE slug = 'music-nfts'),
    'Atmospheric Breakbeat',
    'https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png',
    'Atmospheric breakbeat with cinematic elements.',
    '{"type": "Music", "genre": "Breakbeat", "duration": 315, "bpm": 125, "artist": "AtmoBreak"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Blake')
),
(
    (SELECT id FROM collections WHERE slug = 'music-nfts'),
    'Minimal Techno Loop',
    'https://helix-web-gilt.vercel.app/images/items/aafbc7ed2324a9170c01678990fdd89b5268d672.png',
    'Minimalist techno with hypnotic loops.',
    '{"type": "Music", "genre": "Minimal Techno", "duration": 480, "bpm": 125, "artist": "MinimalLoop"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Sage')
),
(
    (SELECT id FROM collections WHERE slug = 'music-nfts'),
    'House Music Classic',
    'https://helix-web-gilt.vercel.app/images/items/8b6b97ca381e4c865a07aad2ceea79d1866f39e5.png',
    'Classic house music with soulful vocals.',
    '{"type": "Music", "genre": "House", "duration": 360, "bpm": 122, "artist": "HouseClassic"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Nicxes')
),
(
    (SELECT id FROM collections WHERE slug = 'music-nfts'),
    'Trap Metal Fusion',
    'https://helix-web-gilt.vercel.app/images/items/fc92ea2f6acf797dffa40c424a332e5490fd76c2.png',
    'Aggressive fusion of trap and metal elements.',
    '{"type": "Music", "genre": "Trap Metal", "duration": 175, "bpm": 155, "artist": "TrapMetal"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Alex')
),
(
    (SELECT id FROM collections WHERE slug = 'music-nfts'),
    'Cinematic Score Epic',
    'https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png',
    'Epic cinematic score with orchestral arrangements.',
    '{"type": "Music", "genre": "Cinematic", "duration": 540, "bpm": 80, "artist": "EpicScore"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Blake')
),
(
    (SELECT id FROM collections WHERE slug = 'music-nfts'),
    'Vaporwave Aesthetic',
    'https://helix-web-gilt.vercel.app/images/items/aafbc7ed2324a9170c01678990fdd89b5268d672.png',
    'Aesthetic vaporwave with retro vibes.',
    '{"type": "Music", "genre": "Vaporwave", "duration": 290, "bpm": 65, "artist": "VaporAesthetic"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Sage')
),

-- More Art Pieces - Total: 22 items
(
    (SELECT id FROM collections WHERE slug = 'art-pieces'),
    'Fractal Dreams',
    'https://helix-web-gilt.vercel.app/images/items/8b6b97ca381e4c865a07aad2ceea79d1866f39e5.png',
    'Infinite fractal patterns in vivid colors.',
    '{"type": "Digital Art", "style": "Fractal", "dimensions": "4K", "artist": "FractalDreamer", "medium": "Algorithmic"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Nicxes')
),
(
    (SELECT id FROM collections WHERE slug = 'art-pieces'),
    'Neural Network Portrait',
    'https://helix-web-gilt.vercel.app/images/items/fc92ea2f6acf797dffa40c424a332e5490fd76c2.png',
    'AI-generated portrait using neural networks.',
    '{"type": "Digital Art", "style": "AI Generated", "dimensions": "8K", "artist": "NeuralArt", "medium": "Machine Learning"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Alex')
),
(
    (SELECT id FROM collections WHERE slug = 'art-pieces'),
    'Holographic Sculpture',
    'https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png',
    'Three-dimensional holographic art piece.',
    '{"type": "Digital Art", "style": "3D Hologram", "dimensions": "Volumetric", "artist": "HoloArtist", "medium": "Holography"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Blake')
),
(
    (SELECT id FROM collections WHERE slug = 'art-pieces'),
    'Pixel Art Masterpiece',
    'https://helix-web-gilt.vercel.app/images/items/aafbc7ed2324a9170c01678990fdd89b5268d672.png',
    'Detailed pixel art with retro gaming aesthetic.',
    '{"type": "Digital Art", "style": "Pixel Art", "dimensions": "1024x1024", "artist": "PixelMaster", "medium": "Digital Pixels"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Sage')
),
(
    (SELECT id FROM collections WHERE slug = 'art-pieces'),
    'Cyberpunk Cityscape',
    'https://helix-web-gilt.vercel.app/images/items/8b6b97ca381e4c865a07aad2ceea79d1866f39e5.png',
    'Neon-lit cyberpunk city with flying cars.',
    '{"type": "Digital Art", "style": "Cyberpunk", "dimensions": "8K", "artist": "CyberScape", "medium": "Digital Paint"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Nicxes')
),
(
    (SELECT id FROM collections WHERE slug = 'art-pieces'),
    'Abstract Motion',
    'https://helix-web-gilt.vercel.app/images/items/fc92ea2f6acf797dffa40c424a332e5490fd76c2.png',
    'Dynamic abstract art with flowing movements.',
    '{"type": "Digital Art", "style": "Abstract", "dimensions": "4K", "artist": "MotionArt", "medium": "Motion Graphics"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Alex')
),
(
    (SELECT id FROM collections WHERE slug = 'art-pieces'),
    'Glitch Art Error',
    'https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png',
    'Intentional digital glitches creating art.',
    '{"type": "Digital Art", "style": "Glitch Art", "dimensions": "4K", "artist": "GlitchError", "medium": "Data Corruption"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Blake')
),
(
    (SELECT id FROM collections WHERE slug = 'art-pieces'),
    'Surreal Landscape',
    'https://helix-web-gilt.vercel.app/images/items/aafbc7ed2324a9170c01678990fdd89b5268d672.png',
    'Dreamlike surreal landscape with impossible geometry.',
    '{"type": "Digital Art", "style": "Surrealism", "dimensions": "8K", "artist": "SurrealDream", "medium": "Digital Paint"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Sage')
),
(
    (SELECT id FROM collections WHERE slug = 'art-pieces'),
    'Minimalist Geometry',
    'https://helix-web-gilt.vercel.app/images/items/8b6b97ca381e4c865a07aad2ceea79d1866f39e5.png',
    'Clean minimalist design with geometric shapes.',
    '{"type": "Digital Art", "style": "Minimalism", "dimensions": "4K", "artist": "MinimalGeo", "medium": "Vector Art"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Nicxes')
),
(
    (SELECT id FROM collections WHERE slug = 'art-pieces'),
    'Photorealistic Portrait',
    'https://helix-web-gilt.vercel.app/images/items/fc92ea2f6acf797dffa40c424a332e5490fd76c2.png',
    'Incredibly detailed photorealistic digital portrait.',
    '{"type": "Digital Art", "style": "Photorealism", "dimensions": "8K", "artist": "PhotoReal", "medium": "Digital Paint"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Alex')
),
(
    (SELECT id FROM collections WHERE slug = 'art-pieces'),
    'Pop Art Digital',
    'https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png',
    'Modern pop art with digital twist.',
    '{"type": "Digital Art", "style": "Pop Art", "dimensions": "4K", "artist": "DigitalPop", "medium": "Digital Collage"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Blake')
),
(
    (SELECT id FROM collections WHERE slug = 'art-pieces'),
    'Conceptual Installation',
    'https://helix-web-gilt.vercel.app/images/items/aafbc7ed2324a9170c01678990fdd89b5268d672.png',
    'Interactive conceptual art installation.',
    '{"type": "Digital Art", "style": "Conceptual", "dimensions": "Interactive", "artist": "ConceptArt", "medium": "Mixed Media"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Sage')
),
(
    (SELECT id FROM collections WHERE slug = 'art-pieces'),
    'Atmospheric Landscape',
    'https://helix-web-gilt.vercel.app/images/items/8b6b97ca381e4c865a07aad2ceea79d1866f39e5.png',
    'Moody atmospheric landscape with dramatic lighting.',
    '{"type": "Digital Art", "style": "Atmospheric", "dimensions": "8K", "artist": "AtmoScape", "medium": "Digital Paint"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Nicxes')
),
(
    (SELECT id FROM collections WHERE slug = 'art-pieces'),
    'Retro Futurism',
    'https://helix-web-gilt.vercel.app/images/items/fc92ea2f6acf797dffa40c424a332e5490fd76c2.png',
    'Retro-futuristic vision of tomorrow.',
    '{"type": "Digital Art", "style": "Retro Futurism", "dimensions": "4K", "artist": "RetroFuture", "medium": "Digital Paint"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Alex')
),
(
    (SELECT id FROM collections WHERE slug = 'art-pieces'),
    'Biomechanical Fusion',
    'https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png',
    'Fusion of biological and mechanical forms.',
    '{"type": "Digital Art", "style": "Biomechanical", "dimensions": "8K", "artist": "BioMech", "medium": "3D Render"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Blake')
),
(
    (SELECT id FROM collections WHERE slug = 'art-pieces'),
    'Psychedelic Patterns',
    'https://helix-web-gilt.vercel.app/images/items/aafbc7ed2324a9170c01678990fdd89b5268d672.png',
    'Mind-bending psychedelic patterns and colors.',
    '{"type": "Digital Art", "style": "Psychedelic", "dimensions": "4K", "artist": "PsycheArt", "medium": "Digital Pattern"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Sage')
),
(
    (SELECT id FROM collections WHERE slug = 'art-pieces'),
    'Gothic Architecture',
    'https://helix-web-gilt.vercel.app/images/items/8b6b97ca381e4c865a07aad2ceea79d1866f39e5.png',
    'Dark gothic architectural visualization.',
    '{"type": "Digital Art", "style": "Gothic", "dimensions": "8K", "artist": "GothicArch", "medium": "3D Render"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Nicxes')
),
(
    (SELECT id FROM collections WHERE slug = 'art-pieces'),
    'Nature Macro Detail',
    'https://helix-web-gilt.vercel.app/images/items/fc92ea2f6acf797dffa40c424a332e5490fd76c2.png',
    'Extreme close-up of natural textures and patterns.',
    '{"type": "Digital Art", "style": "Nature Macro", "dimensions": "8K", "artist": "MacroNature", "medium": "Digital Photography"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Alex')
),
(
    (SELECT id FROM collections WHERE slug = 'art-pieces'),
    'Steampunk Machinery',
    'https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png',
    'Intricate steampunk mechanical contraptions.',
    '{"type": "Digital Art", "style": "Steampunk", "dimensions": "4K", "artist": "SteamMech", "medium": "3D Render"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Blake')
),

-- More Game Items - Total: 30 items
(
    (SELECT id FROM collections WHERE slug = 'game-items'),
    'Energy Potion',
    'https://helix-web-gilt.vercel.app/images/items/aafbc7ed2324a9170c01678990fdd89b5268d672.png',
    'Restores energy and stamina instantly.',
    '{"type": "Consumable", "rarity": "Common", "effect": "+25% Energy", "duration": 120}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Sage')
),
(
    (SELECT id FROM collections WHERE slug = 'game-items'),
    'Health Pack',
    'https://helix-web-gilt.vercel.app/images/items/8b6b97ca381e4c865a07aad2ceea79d1866f39e5.png',
    'Emergency medical kit for quick healing.',
    '{"type": "Consumable", "rarity": "Common", "effect": "+50 Health", "duration": 0}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Nicxes')
),
(
    (SELECT id FROM collections WHERE slug = 'game-items'),
    'Speed Boost Module',
    'https://helix-web-gilt.vercel.app/images/items/fc92ea2f6acf797dffa40c424a332e5490fd76c2.png',
    'Temporarily increases movement speed.',
    '{"type": "Power-up", "rarity": "Rare", "effect": "+35% Speed", "duration": 180}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Alex')
),
(
    (SELECT id FROM collections WHERE slug = 'game-items'),
    'Armor Plating',
    'https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png',
    'Additional protective armor layer.',
    '{"type": "Armor", "rarity": "Epic", "defense": 75, "durability": 500}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Blake')
),
(
    (SELECT id FROM collections WHERE slug = 'game-items'),
    'Invisibility Cloak',
    'https://helix-web-gilt.vercel.app/images/items/aafbc7ed2324a9170c01678990fdd89b5268d672.png',
    'Grants temporary invisibility to the user.',
    '{"type": "Power-up", "rarity": "Legendary", "effect": "Invisibility", "duration": 60}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Sage')
),
(
    (SELECT id FROM collections WHERE slug = 'game-items'),
    'Damage Amplifier',
    'https://helix-web-gilt.vercel.app/images/items/8b6b97ca381e4c865a07aad2ceea79d1866f39e5.png',
    'Increases weapon damage output.',
    '{"type": "Enhancement", "rarity": "Epic", "effect": "+40% Damage", "duration": 240}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Nicxes')
),
(
    (SELECT id FROM collections WHERE slug = 'game-items'),
    'Scanner Device',
    'https://helix-web-gilt.vercel.app/images/items/fc92ea2f6acf797dffa40c424a332e5490fd76c2.png',
    'Reveals hidden enemies and objects.',
    '{"type": "Tool", "rarity": "Rare", "range": 100, "uses": 25, "special": "Enemy Detection"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Alex')
),
(
    (SELECT id FROM collections WHERE slug = 'game-items'),
    'Jump Boots',
    'https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png',
    'Boots that enable super high jumps.',
    '{"type": "Equipment", "rarity": "Rare", "jumpHeight": 200, "durability": 300}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Blake')
),
(
    (SELECT id FROM collections WHERE slug = 'game-items'),
    'Mana Crystal',
    'https://helix-web-gilt.vercel.app/images/items/aafbc7ed2324a9170c01678990fdd89b5268d672.png',
    'Restores magical energy for spellcasting.',
    '{"type": "Consumable", "rarity": "Uncommon", "effect": "+75 Mana", "duration": 0}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Sage')
),
(
    (SELECT id FROM collections WHERE slug = 'game-items'),
    'Teleporter Device',
    'https://helix-web-gilt.vercel.app/images/items/8b6b97ca381e4c865a07aad2ceea79d1866f39e5.png',
    'Allows instant teleportation to marked locations.',
    '{"type": "Tool", "rarity": "Legendary", "range": 1000, "uses": 5, "special": "Teleportation"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Nicxes')
),
(
    (SELECT id FROM collections WHERE slug = 'game-items'),
    'Fire Resistance Potion',
    'https://helix-web-gilt.vercel.app/images/items/fc92ea2f6acf797dffa40c424a332e5490fd76c2.png',
    'Provides immunity to fire damage.',
    '{"type": "Consumable", "rarity": "Uncommon", "effect": "Fire Immunity", "duration": 300}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Alex')
),
(
    (SELECT id FROM collections WHERE slug = 'game-items'),
    'Lock Pick Set',
    'https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png',
    'Professional tools for bypassing locks.',
    '{"type": "Tool", "rarity": "Common", "successRate": 85, "uses": 50}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Blake')
),
(
    (SELECT id FROM collections WHERE slug = 'game-items'),
    'Night Vision Goggles',
    'https://helix-web-gilt.vercel.app/images/items/aafbc7ed2324a9170c01678990fdd89b5268d672.png',
    'Enables clear vision in darkness.',
    '{"type": "Equipment", "rarity": "Rare", "visionRange": 50, "durability": 200}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Sage')
),
(
    (SELECT id FROM collections WHERE slug = 'game-items'),
    'Grappling Hook',
    'https://helix-web-gilt.vercel.app/images/items/8b6b97ca381e4c865a07aad2ceea79d1866f39e5.png',
    'Tool for climbing and swinging across gaps.',
    '{"type": "Tool", "rarity": "Uncommon", "range": 30, "durability": 150}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Nicxes')
),
(
    (SELECT id FROM collections WHERE slug = 'game-items'),
    'EMP Grenade',
    'https://helix-web-gilt.vercel.app/images/items/fc92ea2f6acf797dffa40c424a332e5490fd76c2.png',
    'Disables electronic devices in blast radius.',
    '{"type": "Weapon", "rarity": "Epic", "damage": 0, "radius": 15, "special": "EMP Effect"}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Alex')
),
(
    (SELECT id FROM collections WHERE slug = 'game-items'),
    'Resurrection Orb',
    'https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png',
    'Brings fallen teammates back to life.',
    '{"type": "Consumable", "rarity": "Legendary", "effect": "Resurrect", "uses": 1}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Blake')
),
(
    (SELECT id FROM collections WHERE slug = 'game-items'),
    'Freeze Ray',
    'https://helix-web-gilt.vercel.app/images/items/aafbc7ed2324a9170c01678990fdd89b5268d672.png',
    'Weapon that freezes enemies solid.',
    '{"type": "Weapon", "rarity": "Epic", "damage": 60, "special": "Freeze Effect", "duration": 5}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Sage')
),
(
    (SELECT id FROM collections WHERE slug = 'game-items'),
    'Stealth Generator',
    'https://helix-web-gilt.vercel.app/images/items/8b6b97ca381e4c865a07aad2ceea79d1866f39e5.png',
    'Creates a stealth field around the user.',
    '{"type": "Equipment", "rarity": "Epic", "effect": "Stealth Field", "duration": 45}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Nicxes')
),
(
    (SELECT id FROM collections WHERE slug = 'game-items'),
    'Adrenaline Shot',
    'https://helix-web-gilt.vercel.app/images/items/fc92ea2f6acf797dffa40c424a332e5490fd76c2.png',
    'Boosts all combat abilities temporarily.',
    '{"type": "Consumable", "rarity": "Rare", "effect": "+30% All Combat Stats", "duration": 90}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Alex')
),
(
    (SELECT id FROM collections WHERE slug = 'game-items'),
    'Force Field Generator',
    'https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png',
    'Creates a protective energy barrier.',
    '{"type": "Defense", "rarity": "Legendary", "shield": 500, "duration": 30}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Blake')
),
(
    (SELECT id FROM collections WHERE slug = 'game-items'),
    'Mind Control Device',
    'https://helix-web-gilt.vercel.app/images/items/aafbc7ed2324a9170c01678990fdd89b5268d672.png',
    'Temporarily controls enemy actions.',
    '{"type": "Tool", "rarity": "Legendary", "controlDuration": 15, "uses": 3}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Sage')
),
(
    (SELECT id FROM collections WHERE slug = 'game-items'),
    'Plasma Cutter',
    'https://helix-web-gilt.vercel.app/images/items/8b6b97ca381e4c865a07aad2ceea79d1866f39e5.png',
    'Industrial tool that cuts through any material.',
    '{"type": "Tool", "rarity": "Epic", "cuttingPower": 95, "durability": 100}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Nicxes')
),
(
    (SELECT id FROM collections WHERE slug = 'game-items'),
    'Holographic Decoy',
    'https://helix-web-gilt.vercel.app/images/items/fc92ea2f6acf797dffa40c424a332e5490fd76c2.png',
    'Creates a holographic duplicate to confuse enemies.',
    '{"type": "Tool", "rarity": "Rare", "decoyDuration": 20, "uses": 10}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Alex')
),
(
    (SELECT id FROM collections WHERE slug = 'game-items'),
    'Gravity Manipulator',
    'https://helix-web-gilt.vercel.app/images/items/01b8792575f2710d62a4b031a9e0e25c39927609.png',
    'Device that can alter local gravity fields.',
    '{"type": "Tool", "rarity": "Legendary", "gravityRange": 20, "uses": 8}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Blake')
),
(
    (SELECT id FROM collections WHERE slug = 'game-items'),
    'Time Dilation Field',
    'https://helix-web-gilt.vercel.app/images/items/aafbc7ed2324a9170c01678990fdd89b5268d672.png',
    'Slows down time in a localized area.',
    '{"type": "Power-up", "rarity": "Legendary", "effect": "Time Slow", "duration": 10, "radius": 25}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Sage')
),
(
    (SELECT id FROM collections WHERE slug = 'game-items'),
    'Nano Repair Kit',
    'https://helix-web-gilt.vercel.app/images/items/8b6b97ca381e4c865a07aad2ceea79d1866f39e5.png',
    'Nanobots that repair damaged equipment.',
    '{"type": "Tool", "rarity": "Epic", "repairAmount": 75, "uses": 15}',
    'SELLING',
    (SELECT id FROM users WHERE username = 'Nicxes')
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