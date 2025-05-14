import 'package:flutter/material.dart';

class Activity {
  final String id;
  final String title;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final String location;
  final double cost;
  final String? notes;
  final bool hasReminder;
  final String? weatherInfo;
  final String? transportationInfo;

  Activity({
    required this.id,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.cost,
    this.notes,
    this.hasReminder = false,
    this.weatherInfo,
    this.transportationInfo,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'location': location,
      'cost': cost,
      'notes': notes,
      'hasReminder': hasReminder,
      'weatherInfo': weatherInfo,
      'transportationInfo': transportationInfo,
    };
  }

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      location: json['location'],
      cost: json['cost'],
      notes: json['notes'],
      hasReminder: json['hasReminder'] ?? false,
      weatherInfo: json['weatherInfo'],
      transportationInfo: json['transportationInfo'],
    );
  }
}

class DayPlan {
  final String id;
  final DateTime date;
  final List<Activity> activities;
  final double totalBudget;
  final String? notes;
  final String? weatherForecast;

  DayPlan({
    required this.id,
    required this.date,
    required this.activities,
    required this.totalBudget,
    this.notes,
    this.weatherForecast,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'activities': activities.map((a) => a.toJson()).toList(),
      'totalBudget': totalBudget,
      'notes': notes,
      'weatherForecast': weatherForecast,
    };
  }

  factory DayPlan.fromJson(Map<String, dynamic> json) {
    return DayPlan(
      id: json['id'],
      date: DateTime.parse(json['date']),
      activities: (json['activities'] as List)
          .map((a) => Activity.fromJson(a))
          .toList(),
      totalBudget: json['totalBudget'],
      notes: json['notes'],
      weatherForecast: json['weatherForecast'],
    );
  }
}

class TravelItinerary {
  final String id;
  final String title;
  final String destination;
  final DateTime startDate;
  final DateTime endDate;
  final List<DayPlan> dayPlans;
  final double totalBudget;
  final List<String> sharedWith;
  final String? notes;
  final bool isOfflineAvailable;

  TravelItinerary({
    required this.id,
    required this.title,
    required this.destination,
    required this.startDate,
    required this.endDate,
    required this.dayPlans,
    required this.totalBudget,
    required this.sharedWith,
    this.notes,
    this.isOfflineAvailable = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'destination': destination,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'dayPlans': dayPlans.map((d) => d.toJson()).toList(),
      'totalBudget': totalBudget,
      'sharedWith': sharedWith,
      'notes': notes,
      'isOfflineAvailable': isOfflineAvailable,
    };
  }

  factory TravelItinerary.fromJson(Map<String, dynamic> json) {
    return TravelItinerary(
      id: json['id'],
      title: json['title'],
      destination: json['destination'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      dayPlans: (json['dayPlans'] as List)
          .map((d) => DayPlan.fromJson(d))
          .toList(),
      totalBudget: json['totalBudget'],
      sharedWith: List<String>.from(json['sharedWith']),
      notes: json['notes'],
      isOfflineAvailable: json['isOfflineAvailable'] ?? false,
    );
  }
} 