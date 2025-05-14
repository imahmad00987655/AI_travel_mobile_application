import 'package:flutter/material.dart';

class PackingItem {
  final String name;
  final String category;
  final IconData icon;
  bool isPacked;

  PackingItem(this.name, this.category, this.icon, {this.isPacked = false});

  PackingItem copyWith({bool? isPacked}) {
    return PackingItem(
      name,
      category,
      icon,
      isPacked: isPacked ?? this.isPacked,
    );
  }
}

class PackingList {
  final String id;
  final String name;
  final List<PackingItem> items;
  final DateTime createdAt;
  final DateTime lastModified;

  PackingList({
    required this.id,
    required this.name,
    required this.items,
    required this.createdAt,
    required this.lastModified,
  });

  PackingList copyWith({
    String? id,
    String? name,
    List<PackingItem>? items,
    DateTime? createdAt,
    DateTime? lastModified,
  }) {
    return PackingList(
      id: id ?? this.id,
      name: name ?? this.name,
      items: items ?? this.items,
      createdAt: createdAt ?? this.createdAt,
      lastModified: lastModified ?? this.lastModified,
    );
  }
} 