import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'voirfilm_model.dart';
import 'movie_detail_page.dart';
import '../test/test_widget.dart';
import '../ajouterfilm/ajouterfilm_widget.dart';


class VoirfilmWidget extends StatefulWidget {
  const VoirfilmWidget({super.key});

  static String routeName = 'voirfilm';
  static String routePath = '/voirfilm';

  @override
  State<VoirfilmWidget> createState() => _VoirfilmWidgetState();
}

class _VoirfilmWidgetState extends State<VoirfilmWidget> {
  late VoirfilmModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  
  // Liste des films Firebase (à l'affiche)
  List<FilmRecord> _firebaseFilms = [];
  List<FilmRecord> _filteredFilms = [];
  String _selectedGenre = 'Tous';

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VoirfilmModel());
    _model.searchFieldTextController ??= TextEditingController();
    _model.searchFieldFocusNode ??= FocusNode();
    _loadFirebaseFilms();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  // Charger les films depuis Firebase
  Future<void> _loadFirebaseFilms() async {
    final query = await FilmRecord.collection.get();
    setState(() {
      _firebaseFilms = query.docs.map((doc) => FilmRecord.fromSnapshot(doc)).toList();
      _filteredFilms = List.from(_firebaseFilms);
    });
  }

  void _filterByGenre(String genre) {
    setState(() {
      _selectedGenre = genre;
      if (genre == 'Tous') {
        _filteredFilms = List.from(_firebaseFilms);
      } else {
        _filteredFilms = _firebaseFilms.where((film) {
          final filmGenre = film.genre?.toLowerCase() ?? '';
          return filmGenre.contains(genre.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFF0A0A0A),
        appBar: AppBar(
          backgroundColor: Color(0xFF0A0A0A),
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    Navigator.pop(context);
                  },
                  child: RichText(
                    textScaler: MediaQuery.of(context).textScaler,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Cine',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                          ),
                        ),
                        TextSpan(
                          text: 'Max',
                          style: TextStyle(
                            color: Color(0xFFE50914),
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                          ),
                        ),
                      ],
                      style: FlutterFlowTheme.of(context)
                          .headlineMedium
                          .override(
                            font: GoogleFonts.poppins(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .headlineMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .headlineMedium
                                  .fontStyle,
                            ),
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .headlineMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .headlineMedium
                                .fontStyle,
                          ),
                    ),
                  ),
                ),
              ),
            ].divide(SizedBox(width: 4.0)),
          ),
          actions: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  if (valueOrDefault(currentUserDocument?.role, '') == '"owner"')
                    AuthUserStreamWidget(
                      builder: (context) => FFButtonWidget(
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AjouterfilmWidget(),
                            ),
                          );
                        },
                        text: 'ajouter film',
                        options: FFButtonOptions(
                          height: 40.0,
                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                          color: Color(0xFF0E6943),
                          textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                font: GoogleFonts.poppins(
                                  fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                ),
                                color: FlutterFlowTheme.of(context).secondaryText,
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                              ),
                          elevation: 0.0,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                ].divide(SizedBox(width: 4.0)),
              ),
            ),
          ],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(  // ⭐ AJOUTÉ POUR ÉVITER LE DÉBORDEMENT
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                // Barre de recherche
                Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 12.0),
                    child: TextFormField(
                      controller: _model.searchFieldTextController,
                      focusNode: _model.searchFieldFocusNode,
                      onChanged: (_) => EasyDebounce.debounce(
                        '_model.searchFieldTextController',
                        Duration(milliseconds: 500),
                        () => safeSetState(() {}),
                      ),
                      autofocus: false,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: 'Rechercher un film...',
                        hintStyle: FlutterFlowTheme.of(context).bodySmall.override(
                              font: GoogleFonts.poppins(
                                fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                              ),
                              color: Color(0xFF888888),
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                              fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                            ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF2A2A2A), width: 1.0),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFE50914), width: 1.0),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0x00000000), width: 1.0),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0x00000000), width: 1.0),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        filled: true,
                        fillColor: Color(0xFF1C1C1C),
                        contentPadding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                        prefixIcon: Icon(Icons.search_rounded, color: Color(0xFF888888), size: 20.0),
                        suffixIcon: Icon(Icons.mic_rounded, color: Color(0xFF888888), size: 20.0),
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.poppins(
                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                            ),
                            color: Colors.white,
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                          ),
                      validator: _model.searchFieldTextControllerValidator.asValidator(context),
                    ),
                  ),
                ),

                // Barre de genres (scroll horizontal)
                Container(
                  height: 44.0,
                  child: ListView(
                    padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                    scrollDirection: Axis.horizontal,
                    children: [
                      _genreChip('Tous', selected: _selectedGenre == 'Tous', onTap: () => _filterByGenre('Tous')),
                      _genreChip('Action', selected: _selectedGenre == 'Action', onTap: () => _filterByGenre('Action')),
                      _genreChip('Horreur', selected: _selectedGenre == 'Horreur', onTap: () => _filterByGenre('Horreur')),
                      _genreChip('Comédie', selected: _selectedGenre == 'Comédie', onTap: () => _filterByGenre('Comédie')),
                      _genreChip('Drame', selected: _selectedGenre == 'Drame', onTap: () => _filterByGenre('Drame')),
                      _genreChip('Sci-Fi', selected: _selectedGenre == 'Sci-Fi', onTap: () => _filterByGenre('Sci-Fi')),
                      _genreChip('Thriller', selected: _selectedGenre == 'Thriller', onTap: () => _filterByGenre('Thriller')),
                      _genreChip('Animation', selected: _selectedGenre == 'Animation', onTap: () => _filterByGenre('Animation')),
                      _genreChip('Romance', selected: _selectedGenre == 'Romance', onTap: () => _filterByGenre('Romance')),
                      _genreChip('Documentaire', selected: _selectedGenre == 'Documentaire', onTap: () => _filterByGenre('Documentaire')),
                    ],
                  ),
                ),

                // ⭐ TOP 10 DE LA SEMAINE
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 8.0),
                  child: Row(
                    children: [
                      Icon(Icons.trending_up, color: Color(0xFFE50914), size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Top 10 de la semaine',
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 180,
                  child: FutureBuilder<ApiCallResponse>(
                    future: TrendingMoviesCall.call(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(color: Color(0xFFE50914)),
                        );
                      }

                      if (!snapshot.hasData || snapshot.data?.succeeded != true) {
                        return Center(
                          child: Text(
                            'Aucun film tendance',
                            style: TextStyle(color: Colors.white70),
                          ),
                        );
                      }

                      final results = getJsonField(snapshot.data!.jsonBody, r'$.results');
                      final List<dynamic> movies = results is List ? results : [];

                      if (movies.isEmpty) {
                        return Center(
                          child: Text(
                            'Aucun film tendance',
                            style: TextStyle(color: Colors.white70),
                          ),
                        );
                      }

                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        itemCount: movies.take(10).length,
                        itemBuilder: (context, index) {
                          final movie = movies[index];
                          final posterPath = movie['poster_path']?.toString() ?? '';
                          final imageUrl = posterPath.isNotEmpty
                              ? 'https://image.tmdb.org/t/p/w200$posterPath'
                              : '';
                          final int movieId = movie['id'] ?? 0;

                          return Container(
                            width: 120,
                            margin: EdgeInsets.only(right: 12),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MovieDetailPage(
                                      movieId: movieId,
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: imageUrl.isNotEmpty
                                            ? Image.network(
                                                imageUrl,
                                                height: 130,
                                                width: 120,
                                                fit: BoxFit.cover,
                                                errorBuilder: (_, __, ___) => Container(
                                                  height: 130,
                                                  width: 120,
                                                  color: Color(0xFF1C1C1C),
                                                  child: Icon(Icons.movie, color: Colors.grey),
                                                ),
                                              )
                                            : Container(
                                                height: 130,
                                                width: 120,
                                                color: Color(0xFF1C1C1C),
                                                child: Icon(Icons.movie, color: Colors.grey),
                                              ),
                                      ),
                                      Positioned(
                                        top: 6,
                                        left: 6,
                                        child: Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFE50914),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                            child: Text(
                                              '${index + 1}',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 11,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    movie['title'] ?? '',
                                    style: TextStyle(color: Colors.white, fontSize: 11),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),

                // SECTION: À L'AFFICHE AU CINÉMA
                if (_filteredFilms.isNotEmpty) ...[
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 8.0),
                    child: Text(
                      'À l\'affiche au cinéma',
                      style: TextStyle(color: Color(0xFFE50914), fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      itemCount: _filteredFilms.length,
                      itemBuilder: (context, index) {
                        final film = _filteredFilms[index];
                        final imageUrl = film.afficheUrl ?? '';
                        final annee = film.anneeSortie != 0 ? film.anneeSortie.toString() : '';
                        return Container(
                          width: 130,
                          margin: EdgeInsets.only(right: 12),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TestWidget(
                                    film: film.reference,
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: imageUrl.isNotEmpty
                                      ? Image.network(
                                          imageUrl,
                                          height: 150,
                                          width: 130,
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) => Container(
                                            height: 150,
                                            width: 130,
                                            color: Color(0xFF1C1C1C),
                                            child: Icon(Icons.movie, color: Colors.grey),
                                          ),
                                        )
                                      : Container(
                                          height: 150,
                                          width: 130,
                                          color: Color(0xFF1C1C1C),
                                          child: Icon(Icons.movie, color: Colors.grey),
                                        ),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  film.titre ?? 'Sans titre',
                                  style: TextStyle(color: Colors.white, fontSize: 13),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  annee,
                                  style: TextStyle(color: Color(0xFF888888), fontSize: 11),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],

                // SECTION: TOUS LES FILMS (API TMDB)
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 8.0),
                  child: Text(
                    'Tous les films',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),

                // Liste des films TMDB
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,  // ⭐ HAUTEUR RELATIVE
                  child: FutureBuilder<ApiCallResponse>(
                    future: SearchMoviesCall.call(
                      query: _model.searchFieldTextController.text.isEmpty
                          ? 'popular'
                          : _model.searchFieldTextController.text,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(color: Color(0xFFE50914)),
                        );
                      }

                      if (!snapshot.hasData || snapshot.data?.succeeded != true) {
                        return Center(
                          child: Text(
                            'Aucun film trouvé',
                            style: TextStyle(color: Colors.white70),
                          ),
                        );
                      }

                      final results = getJsonField(snapshot.data!.jsonBody, r'$.results');
                      final List<dynamic> movies = results is List ? results : [];

                      if (movies.isEmpty) {
                        return Center(
                          child: Text(
                            'Aucun film trouvé',
                            style: TextStyle(color: Colors.white70),
                          ),
                        );
                      }

                      return ListView.builder(
                        padding: EdgeInsets.all(8.0),
                        itemCount: movies.length,
                        itemBuilder: (context, index) {
                          final movie = movies[index];
                          final posterPath = movie['poster_path']?.toString() ?? '';
                          final imageUrl = posterPath.isNotEmpty
                              ? 'https://image.tmdb.org/t/p/w200$posterPath'
                              : '';
                          final int movieId = movie['id'] ?? 0;

                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12.0),
                              onTap: () async {
                                if (movieId > 0) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MovieDetailPage(
                                        movieId: movieId,
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFF1C1C1C),
                                  borderRadius: BorderRadius.circular(12.0),
                                  border: Border.all(color: Color(0xFF2A2A2A), width: 1.0),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: imageUrl.isNotEmpty
                                          ? Image.network(
                                              imageUrl,
                                              width: 70,
                                              height: 100,
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error, stackTrace) =>
                                                  _placeholderImage(),
                                            )
                                          : _placeholderImage(),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              movie['title'] ?? '',
                                              style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              movie['release_date']?.split('-')[0] ?? '',
                                              style: TextStyle(color: Color(0xFF888888), fontSize: 11),
                                            ),
                                            SizedBox(height: 4),
                                            Row(
                                              children: [
                                                Icon(Icons.star, color: Colors.amber, size: 12),
                                                SizedBox(width: 4),
                                                Text(
                                                  (movie['vote_average'] ?? 0).toStringAsFixed(1),
                                                  style: TextStyle(color: Colors.amber, fontSize: 11),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                SizedBox(height: 20), // Espace en bas
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _genreChip(String label, {required bool selected, required VoidCallback onTap}) {
    return Padding(
      padding: EdgeInsets.only(right: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 36.0,
          decoration: BoxDecoration(
            color: selected ? Color(0xFFE50914) : Color(0xFF1C1C1C),
            borderRadius: BorderRadius.circular(20.0),
            border: selected ? null : Border.all(color: Color(0xFF2A2A2A), width: 1.0),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  color: selected ? Colors.white : Color(0xFFCCCCCC),
                  fontSize: 13.0,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _placeholderImage() {
    return Container(
      width: 70.0,
      height: 100.0,
      color: Color(0xFF2A2A2A),
      child: Icon(Icons.movie, color: Colors.grey, size: 32.0),
    );
  }
}