import 'package:flutter/material.dart';

class RecyclingProcessPage extends StatelessWidget {
  const RecyclingProcessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final steps = [
      {
        'title': 'Collection',
        'icon': Icons.delete_outline,
        'description':
            'Waste is collected from various locations and sorted into different categories.',
      },
      {
        'title': 'Sorting',
        'icon': Icons.sort,
        'description':
            'Materials are separated based on type (plastic, metal, organic, etc.).',
      },
      {
        'title': 'Processing',
        'icon': Icons.recycling,
        'description':
            'Each material type undergoes specific recycling processes.',
      },
      {
        'title': 'Quality Check',
        'icon': Icons.check_circle_outline,
        'description':
            'Processed materials are checked for quality and compliance.',
      },
      {
        'title': 'New Products',
        'icon': Icons.inventory_2_outlined,
        'description':
            'Recycled materials are used to create new products.',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recycling Process'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.green.shade400,
                    Colors.green.shade600,
                  ],
                ),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.recycling,
                    size: 64,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Understanding the Recycling Journey',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: steps.length,
              itemBuilder: (context, index) {
                final step = steps[index];
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        step['icon'] as IconData,
                        color: Colors.green,
                        size: 24,
                      ),
                    ),
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        'Step ${index + 1}: ${step['title']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    subtitle: Text(
                      step['description'] as String,
                      style: TextStyle(
                        color: Colors.grey[600],
                        height: 1.5,
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
} 