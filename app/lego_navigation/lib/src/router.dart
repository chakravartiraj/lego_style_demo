import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:harry_potter/harry_potter.dart';
import 'package:lego_list/lego_list.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LegoListFlow(),
    ),
    GoRoute(
      path: '/universe/hp',
      builder: (context, state) => const HarryPotterFlow(),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(
      title: const Text('Universe Unavailable'),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.construction, size: 64, color: Colors.white54),
          const SizedBox(height: 16),
          Text(
            'The universe "${state.uri.pathSegments.last}" is still under construction.',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    ),
  ),
);
