#!/bin/bash

set -e

echo "🏗️  Building nathanhessler.com..."

# 1. Clean dist
echo "Cleaning dist folder..."
rm -rf dist
mkdir -p dist

# 2. Build main Astro site
echo "Building main site..."
cd site
npm install
npm run build
cd ..

# 3. Copy site output to root dist
echo "Copying site output..."
cp -r site/dist/* dist/

# 4. Build published talks
echo "🎤 Building talks..."
node build-scripts/build-talks.js

echo "✅ Build complete! Ready to deploy dist/"
