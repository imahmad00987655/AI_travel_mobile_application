import 'package:flutter/material.dart';
import 'package:travel_advisor/models/destination.dart';

final List<Destination> featuredDestinations = [
  Destination(
    name: 'Paris, France',
    description: 'The City of Light, known for its art, fashion, and culture.',
    image: 'assets/images/paris.jpg',
    rating: 4.8,
    price: 1200,
    reviews: 1200,
  ),
  Destination(
    name: 'Tokyo, Japan',
    description: 'A vibrant mix of traditional and modern culture.',
    image: 'assets/images/tokyo.jpg',
    rating: 4.7,
    price: 1500,
    reviews: 980,
  ),
  Destination(
    name: 'New York, USA',
    description: 'The city that never sleeps, full of iconic landmarks.',
    image: 'assets/images/newyork.jpg',
    rating: 4.6,
    price: 1000,
    reviews: 1500,
  ),
];

final List<Destination> trendingDestinations = [
  Destination(
    name: 'Bali, Indonesia',
    description: 'Tropical paradise with beautiful beaches and culture.',
    image: 'assets/images/bali.jpg',
    rating: 4.9,
    price: 800,
    reviews: 2000,
  ),
  Destination(
    name: 'Rome, Italy',
    description: 'Ancient history meets modern Italian culture.',
    image: 'assets/images/rome.jpg',
    rating: 4.7,
    price: 1100,
    reviews: 1300,
  ),
  Destination(
    name: 'Dubai, UAE',
    description: 'Ultra-modern city with luxury shopping and architecture.',
    image: 'assets/images/dubai.jpg',
    rating: 4.5,
    price: 1300,
    reviews: 1100,
  ),
]; 