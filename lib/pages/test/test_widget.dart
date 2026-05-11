import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'test_model.dart';
export 'test_model.dart';
import '../voirfilm/voirfilm_widget.dart';

import '../ajouterfilm_copy/ajouterfilm_copy_widget.dart';
class TestWidget extends StatefulWidget {
  const TestWidget({
    super.key,
    required this.film,
  });

  final DocumentReference? film;

  static String routeName = 'test';
  static String routePath = '/test';

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  late TestModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TestModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: widget.film!.get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: Color(0xFF0A0A0A),
            body: Center(
              child: SizedBox(
                width: 40.0,
                height: 40.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Color(0xFFE50914),
                  ),
                ),
              ),
            ),
          );
        }

        final filmData = snapshot.data!.data() as Map<String, dynamic>;
        final filmRecord = FilmRecord.getDocumentFromData(filmData, widget.film!);

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: Color(0xFF0A0A0A),
            body: Stack(
              children: [
                // Fond avec gradient
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF1A1A1A),
                        Color(0xFF0A0A0A),
                      ],
                    ),
                  ),
                ),
                
                // Contenu principal
                SafeArea(
                  top: true,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Barre du haut avec boutons
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Bouton retour
                              FlutterFlowIconButton(
                                borderColor: Colors.transparent,
                                borderRadius: 30.0,
                                borderWidth: 1.0,
                                buttonSize: 44.0,
                                fillColor: Color(0xFF1C1C1C),
                                icon: Icon(
                                  Icons.arrow_back_rounded,
                                  color: Colors.white,
                                  size: 24.0,
                                ),
                                onPressed: () async {
                                  Navigator.pop(context);
                                },
                              ),
                              // Boutons admin (supprimer/modifier)
                              if (valueOrDefault(currentUserDocument?.role, '') == '"owner"')
                                Row(
                                  children: [
                                    FFButtonWidget(
                                      onPressed: () async {
                                        await widget.film!.delete();
                                        if (mounted) {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => VoirfilmWidget(),
                                            ),
                                          );
                                        }
                                      },
                                      text: 'Supprimer',
                                      options: FFButtonOptions(
                                        height: 36.0,
                                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                                        color: Color(0xFFE50914),
                                        textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                        ),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                    ),
                                    SizedBox(width: 8.0),
                                    FFButtonWidget(
                                      onPressed: () async {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => AjouterfilmCopyWidget(
                                              filmId: widget.film,
                                            ),
                                          ),
                                        );
                                      },
                                      text: 'Modifier',
                                      options: FFButtonOptions(
                                        height: 36.0,
                                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                                        color: Color(0xFF0E6943),
                                        textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                        ),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                        
                        // ⭐ Affiche du film (PLUS PETITE)
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                          child: Center(
                            child: Hero(
                              tag: 'movie_poster_${filmRecord.reference.id}',
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.4),
                                      blurRadius: 15.0,
                                      offset: Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: Image.network(
                                    filmRecord.afficheUrl,
                                    width: 160.0,  // ⭐ Largeur plus petite
                                    height: 220.0, // ⭐ Hauteur plus petite
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Container(
                                      width: 160.0,
                                      height: 220.0,
                                      color: Color(0xFF2A2A2A),
                                      child: Icon(
                                        Icons.movie,
                                        size: 50.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        
                        // Informations du film
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Titre
                              Center(
                                child: Text(
                                  filmRecord.titre ?? 'Sans titre',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 28.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(height: 20.0),
                              
                              // Description / Synopsis
                              if (filmRecord.description != null && filmRecord.description!.isNotEmpty)
                                Container(
                                  padding: EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF1C1C1C),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.menu_book,
                                            color: Color(0xFFE50914),
                                            size: 20.0,
                                          ),
                                          SizedBox(width: 8.0),
                                          Text(
                                            'Synopsis',
                                            style: GoogleFonts.poppins(
                                              color: Color(0xFFE50914),
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 12.0),
                                      Text(
                                        filmRecord.description!,
                                        style: GoogleFonts.poppins(
                                          color: Color(0xFFCCCCCC),
                                          fontSize: 14.0,
                                          height: 1.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              
                              SizedBox(height: 20.0),
                              
                              // Informations détaillées
                              Container(
                                padding: EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: Color(0xFF1C1C1C),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Column(
                                  children: [
                                    _infoRow(
                                      icon: Icons.calendar_today,
                                      label: 'Année de sortie',
                                      value: filmRecord.anneeSortie != 0 
                                          ? filmRecord.anneeSortie.toString() 
                                          : 'Non renseignée',
                                    ),
                                    Divider(
                                      thickness: 1.0,
                                      color: Color(0xFF333333),
                                    ),
                                    _infoRow(
                                      icon: Icons.person,
                                      label: 'Réalisateur',
                                      value: filmRecord.realisateur ?? 'Non renseigné',
                                    ),
                                    Divider(
                                      thickness: 1.0,
                                      color: Color(0xFF333333),
                                    ),
                                    _infoRow(
                                      icon: Icons.people,
                                      label: 'Acteurs',
                                      value: filmRecord.acteurs ?? 'Non renseigné',
                                    ),
                                    Divider(
                                      thickness: 1.0,
                                      color: Color(0xFF333333),
                                    ),
                                    _infoRow(
                                      icon: Icons.movie_filter,
                                      label: 'Genre',
                                      value: filmRecord.genre ?? 'Non renseigné',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _infoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40.0,
            child: Icon(icon, color: Color(0xFFE50914), size: 22.0),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    color: Color(0xFF888888),
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}