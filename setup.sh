#!/bin/bash

# Hotel Booking Rails Demo - Setup Script

echo "🏨 Hotel Booking Rails Demo Setup"
echo "=================================="
echo ""

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Please install Docker first."
    exit 1
fi

echo "✅ Docker found"
echo ""

# Build and run
echo "🔨 Building Docker image..."
docker-compose build

echo ""
echo "🚀 Starting application..."
docker-compose up

echo ""
echo "✅ Application is running at http://localhost:3000"
