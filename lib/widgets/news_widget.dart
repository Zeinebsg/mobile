import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'package:flutter/services.dart';  // ← AJOUTER CET IMPORT


class NewsWidget extends StatefulWidget {
  const NewsWidget({super.key});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  late Future<List<Map<String, dynamic>>> _newsFuture;

  @override
  void initState() {
    super.initState();
    _newsFuture = _fetchMovieNews();
  }

  Future<List<Map<String, dynamic>>> _fetchMovieNews() async {
    const apiKey = '0dd66c0c4a184c759b392f1efdf80d62';
    final url = Uri.parse(
      'https://newsapi.org/v2/everything?q=cinema+OR+film+OR+movie&language=fr&sortBy=publishedAt&apiKey=$apiKey&pageSize=10'
    );
    
    try {
      final response = await http.get(url);
      print('📰 NewsAPI - Status: ${response.statusCode}');
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> articles = data['articles'] ?? [];
        
        // Filtrer les articles avec des URLs valides
        final validArticles = articles.where((article) {
          final url = article['url'] as String?;
          return url != null && url.isNotEmpty && url.startsWith('http');
        }).toList();
        
        print('📰 Articles valides: ${validArticles.length}');
        
        return validArticles.map((article) {
          return {
            'title': article['title'] ?? 'Titre indisponible',
            'description': article['description'] ?? '',
            'url': article['url'] ?? '',
            'imageUrl': article['urlToImage'] ?? '',
            'publishedAt': article['publishedAt'] ?? '',
            'source': article['source']?['name'] ?? 'Source inconnue',
          };
        }).toList();
      } else {
        print('❌ Erreur NewsAPI: ${response.statusCode}');
        print('Réponse: ${response.body}');
        return [];
      }
    } catch (e) {
      print('❌ Exception NewsAPI: $e');
      return [];
    }
  }

  Future<void> _openArticle(String url) async {
    if (url.isEmpty) {
      print('❌ URL vide');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lien de l\'article indisponible'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }
    
    print('🔗 Tentative d\'ouverture: $url');
    
    try {
      final Uri uri = Uri.parse(url);
      
      // Vérifier si l'URL est valide
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        print('✅ Ouverture réussie');
      } else {
        print('❌ Impossible d\'ouvrir: $url');
        
        // Essayons avec un navigateur webview intégré
        await launchUrl(uri, mode: LaunchMode.platformDefault);
      }
    } catch (e) {
      print('❌ Erreur lors de l\'ouverture: $e');
      
      // Afficher l'URL à l'utilisateur
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: const Color(0xFF1A1A1A),
            title: const Text('Ouvrir dans le navigateur', style: TextStyle(color: Colors.white)),
            content: Text(
              'Impossible d\'ouvrir automatiquement le lien.\n\nURL: $url',
              style: const TextStyle(color: Colors.white70),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Annuler', style: TextStyle(color: Colors.grey)),
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.pop(context);
                  await Clipboard.setData(ClipboardData(text: url));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('URL copiée dans le presse-papier'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFE50914)),
                child: const Text('Copier le lien'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _newsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: Color(0xFFE50914)),
                SizedBox(height: 12),
                Text('Chargement des actualités...', style: TextStyle(color: Colors.white70)),
              ],
            ),
          );
        }
        
        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Color(0xFFE50914), size: 48),
                const SizedBox(height: 12),
                Text('Erreur: ${snapshot.error}', style: const TextStyle(color: Colors.white70)),
              ],
            ),
          );
        }
        
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.newspaper, color: Colors.white54, size: 48),
                SizedBox(height: 12),
                Text('Aucune actualité disponible', style: TextStyle(color: Colors.white70)),
              ],
            ),
          );
        }

        final news = snapshot.data!;
        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: news.length,
          itemBuilder: (context, index) {
            final article = news[index];
            return _buildNewsCard(article);
          },
        );
      },
    );
  }
  
  Widget _buildNewsCard(Map<String, dynamic> article) {
    final String articleUrl = article['url'] ?? '';
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF333333)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _openArticle(articleUrl),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: article['imageUrl'] != null && article['imageUrl'].isNotEmpty
                      ? Image.network(
                          article['imageUrl'],
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            width: 80,
                            height: 80,
                            color: const Color(0xFF2A2A2A),
                            child: const Icon(Icons.image_not_supported, color: Colors.white54, size: 32),
                          ),
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              width: 80,
                              height: 80,
                              color: const Color(0xFF2A2A2A),
                              child: const Center(
                                child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFFE50914)),
                              ),
                            );
                          },
                        )
                      : Container(
                          width: 80,
                          height: 80,
                          color: const Color(0xFF2A2A2A),
                          child: const Icon(Icons.movie, color: Colors.white54, size: 32),
                        ),
                ),
                const SizedBox(width: 12),
                
                // Contenu
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article['title'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        article['description'],
                        style: const TextStyle(color: Colors.white70, fontSize: 11),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE50914).withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              article['source'],
                              style: const TextStyle(color: Color(0xFFE50914), fontSize: 9, fontWeight: FontWeight.w500),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.chevron_right, color: Colors.grey, size: 16),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}