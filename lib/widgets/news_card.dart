import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import '../models/news.dart';

class NewsCard extends StatelessWidget {
  final News news;

  const NewsCard({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    final categoryIcons = {
      NewsCategory.macro: '🌍',
      NewsCategory.industry: '🏭',
      NewsCategory.company: '🏢',
      NewsCategory.policy: '📋',
      NewsCategory.international: '🌐',
      NewsCategory.sentiment: '😊',
      NewsCategory.finance: '💰',
    };

    final importanceColors = {
      NewsImportance.minor: Colors.grey,
      NewsImportance.normal: Colors.blue,
      NewsImportance.major: Colors.orange,
      NewsImportance.critical: Colors.red,
    };

    return fluent.Card(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(categoryIcons[news.category] ?? '📰', style: const TextStyle(fontSize: 24)),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  news.title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: importanceColors[news.importance],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  news.importance.name.toUpperCase(),
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(news.content),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                '${news.publishTime.hour}:${news.publishTime.minute.toString().padLeft(2, '0')}',
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              const SizedBox(width: 16),
              if (news.affectedIndustries.isNotEmpty)
                Expanded(
                  child: Wrap(
                    spacing: 4,
                    children: news.affectedIndustries.map((i) => 
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(i, style: const TextStyle(fontSize: 12)),
                      )
                    ).toList(),
                  ),
                ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: news.marketEffect >= 0 ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${news.marketEffect >= 0 ? '+' : ''}${news.marketEffect.toStringAsFixed(1)}%',
                  style: TextStyle(
                    color: news.marketEffect >= 0 ? Colors.green : Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
