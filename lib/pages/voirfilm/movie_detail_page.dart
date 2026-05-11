import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/backend/api_requests/api_calls.dart';

class MovieDetailPage extends StatefulWidget {
  final int movieId;
  
  const MovieDetailPage({
    super.key, 
    required this.movieId,
  });

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  Map<String, dynamic>? _movie;
  bool _isLoading = true;
  bool _isLoadingTrailer = true;
  String? _trailerKey;
  String? _error;

  final String apiKey = '81678c3f61130b7140ec8c6c51cab856';

  @override
  void initState() {
    super.initState();
    _fetchMovieDetails();
    _fetchTrailer();
  }

  Future<void> _fetchMovieDetails() async {
    try {
      final url = 'https://api.themoviedb.org/3/movie/${widget.movieId}?api_key=$apiKey&language=fr-FR&append_to_response=credits';
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        setState(() {
          _movie = json.decode(response.body);
          _isLoading = false;
        });
      } else {
        setState(() {
          _error = 'Erreur: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Erreur de connexion: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchTrailer() async {
    try {
      final response = await MovieVideosCall.call(widget.movieId);
      if (response.succeeded) {
        final videos = getJsonField(response.jsonBody, r'$.results');
        final List<dynamic> trailers = (videos as List?)?.where((v) => v['type'] == 'Trailer' && v['site'] == 'YouTube').toList() ?? [];
        if (trailers.isNotEmpty) {
          setState(() {
            _trailerKey = trailers.first['key'];
            _isLoadingTrailer = false;
          });
        } else {
          setState(() {
            _isLoadingTrailer = false;
          });
        }
      } else {
        setState(() {
          _isLoadingTrailer = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoadingTrailer = false;
      });
    }
  }

  Future<void> _openTrailer() async {
    if (_trailerKey != null) {
      final url = Uri.parse('https://www.youtube.com/watch?v=${_trailerKey!}');
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Impossible d\'ouvrir la vidéo')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Color(0xFF0A0A0A),
        elevation: 0,
        title: Text(
          'Détails du film',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Color(0xFFE50914),
              ),
            )
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _error!,
                        style: TextStyle(color: Colors.red),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _fetchMovieDetails,
                        child: Text('Réessayer'),
                      ),
                    ],
                  ),
                )
              : _movie == null
                  ? Center(
                      child: Text(
                        'Film non trouvé',
                        style: TextStyle(color: Colors.white70),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Backdrop avec overlay
                          if (_movie!['backdrop_path'] != null)
                            Stack(
                              children: [
                                Image.network(
                                  'https://image.tmdb.org/t/p/w500${_movie!['backdrop_path']}',
                                  height: 220,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(
                                    height: 220,
                                    color: Color(0xFF1C1C1C),
                                    child: Center(
                                      child: Icon(
                                        Icons.image_not_supported,
                                        color: Colors.grey,
                                        size: 40,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 220,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Color(0xFF0A0A0A),
                                      ],
                                    ),
                                  ),
                                ),
                                // Affiche superposée (petite)
                                Positioned(
                                  bottom: -40,
                                  left: 16,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.3),
                                          blurRadius: 10,
                                          offset: Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        'https://image.tmdb.org/t/p/w200${_movie!['poster_path']}',
                                        width: 100,
                                        height: 150,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) => Container(
                                          width: 100,
                                          height: 150,
                                          color: Color(0xFF1C1C1C),
                                          child: Icon(Icons.movie, color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          
                          SizedBox(height: 60),
                          
                          // Titre et infos sous l'affiche
                          Padding(
                            padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Titre
                                Text(
                                  _movie!['title'] ?? 'Sans titre',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                // Tagline
                                if (_movie!['tagline'] != null && _movie!['tagline'].toString().isNotEmpty)
                                  Text(
                                    _movie!['tagline'],
                                    style: GoogleFonts.poppins(
                                      color: Color(0xFFE50914),
                                      fontSize: 13,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                SizedBox(height: 12),
                                // Date et note
                                Wrap(
                                  spacing: 12,
                                  runSpacing: 8,
                                  children: [
                                    if (_movie!['release_date'] != null)
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                        decoration: BoxDecoration(
                                          color: Color(0xFF1C1C1C),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.calendar_today, size: 14, color: Color(0xFF888888)),
                                            SizedBox(width: 6),
                                            Text(
                                              _movie!['release_date'].toString().split('-').first,
                                              style: TextStyle(color: Colors.white70, fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: Color(0xFF1C1C1C),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.star, color: Colors.amber, size: 14),
                                          SizedBox(width: 6),
                                          Text(
                                            _movie!['vote_average']?.toStringAsFixed(1) ?? '0',
                                            style: TextStyle(color: Colors.amber, fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (_movie!['runtime'] != null)
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                        decoration: BoxDecoration(
                                          color: Color(0xFF1C1C1C),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.access_time, size: 14, color: Color(0xFF888888)),
                                            SizedBox(width: 6),
                                            Text(
                                              '${_movie!['runtime']} min',
                                              style: TextStyle(color: Colors.white70, fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          
                          // ============================================================
                          // ⭐ BANDE-ANNONCE (VERSION PETITE ET AMÉLIORÉE)
                          // ============================================================
                          if (!_isLoadingTrailer && _trailerKey != null)
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              child: InkWell(
                                onTap: _openTrailer,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFF1C1C1C),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Color(0xFFE50914).withOpacity(0.3),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      // Miniature de la vidéo (plus petite)
                                      Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.horizontal(
                                              left: Radius.circular(12),
                                            ),
                                            child: Image.network(
                                              'https://img.youtube.com/vi/${_trailerKey!}/mqdefault.jpg',
                                              width: 120,
                                              height: 80,
                                              fit: BoxFit.cover,
                                              errorBuilder: (_, __, ___) => Container(
                                                width: 120,
                                                height: 80,
                                                color: Color(0xFF2A2A2A),
                                                child: Icon(Icons.videocam, color: Colors.grey, size: 30),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 0,
                                            right: 0,
                                            top: 0,
                                            bottom: 0,
                                            child: Center(
                                              child: Container(
                                                padding: EdgeInsets.all(6),
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFE50914),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
                                                  Icons.play_arrow,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      // Texte
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 12),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                'Bande-annonce',
                                                style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                'Regarder la bande-annonce',
                                                style: GoogleFonts.poppins(
                                                  color: Color(0xFFE50914),
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 12),
                                        child: Icon(
                                          Icons.chevron_right,
                                          color: Color(0xFF888888),
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          
                          if (!_isLoadingTrailer && _trailerKey == null)
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Color(0xFF1C1C1C),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.videocam_off, color: Color(0xFF888888), size: 20),
                                  SizedBox(width: 12),
                                  Text(
                                    'Aucune bande-annonce disponible',
                                    style: TextStyle(color: Color(0xFF888888), fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                          
                          if (_isLoadingTrailer)
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              height: 80,
                              decoration: BoxDecoration(
                                color: Color(0xFF1C1C1C),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Color(0xFFE50914),
                                  ),
                                ),
                              ),
                            ),

                          // ============================================================
                          // SECTION SYNOPSIS
                          // ============================================================
                          if (_movie!['overview'] != null && _movie!['overview'].toString().isNotEmpty)
                            Padding(
                              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Synopsis',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    _movie!['overview'],
                                    style: GoogleFonts.poppins(
                                      color: Color(0xFFAAAAAA),
                                      fontSize: 13,
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          // ============================================================
                          // SECTION GENRES
                          // ============================================================
                          if (_movie!['genres'] != null && (_movie!['genres'] as List).isNotEmpty)
                            Padding(
                              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Genres',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: (_movie!['genres'] as List).map((genre) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: Color(0xFF1C1C1C),
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(
                                            color: Color(0xFFE50914).withOpacity(0.3),
                                          ),
                                        ),
                                        child: Text(
                                          genre['name'],
                                          style: GoogleFonts.poppins(
                                            color: Colors.white70,
                                            fontSize: 12,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),

                          // ============================================================
                          // SECTION ACTEURS
                          // ============================================================
                          if (_movie!['credits'] != null && 
                              _movie!['credits']['cast'] != null &&
                              (_movie!['credits']['cast'] as List).isNotEmpty)
                            Padding(
                              padding: EdgeInsets.fromLTRB(16, 16, 16, 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Distribution',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  SizedBox(
                                    height: 100,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: (_movie!['credits']['cast'] as List).take(10).length,
                                      itemBuilder: (context, index) {
                                        final actor = (_movie!['credits']['cast'] as List)[index];
                                        return Container(
                                          width: 80,
                                          margin: EdgeInsets.only(right: 12),
                                          child: Column(
                                            children: [
                                              CircleAvatar(
                                                radius: 30,
                                                backgroundColor: Color(0xFF1C1C1C),
                                                backgroundImage: actor['profile_path'] != null
                                                    ? NetworkImage('https://image.tmdb.org/t/p/w185${actor['profile_path']}')
                                                    : null,
                                                child: actor['profile_path'] == null
                                                    ? Icon(Icons.person, size: 30, color: Colors.grey)
                                                    : null,
                                              ),
                                              SizedBox(height: 6),
                                              Text(
                                                actor['name'] ?? '',
                                                style: GoogleFonts.poppins(
                                                  color: Colors.white70,
                                                  fontSize: 11,
                                                ),
                                                textAlign: TextAlign.center,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
    );
  }
}