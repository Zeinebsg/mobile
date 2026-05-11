import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import '/pages/panierr/panierr_widget.dart';
import '/pages/cinema_location/cinema_location_widget.dart';
import '/pages/trailer/trailer_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'billet_user_model.dart';
export 'billet_user_model.dart';

// ⭐ IMPORT POUR HOMEXWIDGET ⭐
import '/pages/homex/homex_widget.dart';
// ⭐ IMPORT POUR ADMINBilletWidget ⭐
import '/pages/admin_billet/admin_billet_widget.dart';

class BilletUserWidget extends StatefulWidget {
  const BilletUserWidget({super.key});

  static String routeName = 'billet_user';
  static String routePath = '/billetUser';

  @override
  State<BilletUserWidget> createState() => _BilletUserWidgetState();
}

class _BilletUserWidgetState extends State<BilletUserWidget> {
  late BilletUserModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BilletUserModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
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
        backgroundColor: const Color(0xFFF5F5F5),
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 22.0,
            borderWidth: 0.0,
            buttonSize: 44.0,
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Color(0xFF1A1A1A),
              size: 24.0,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomexWidget(),
                ),
              );
            },
          ),
          title: Text(
            'Billets',
            style: FlutterFlowTheme.of(context).titleMedium.override(
                  font: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                  ),
                  color: const Color(0xFF1A1A1A),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
          ),
          actions: [
            // ⭐⭐⭐ BOUTON ADMIN (AJOUTER BILLET) ⭐⭐⭐
            if (currentUserDocument?.role == 'owner' || currentUserDocument?.role == '"owner"')
              FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 22.0,
                borderWidth: 0.0,
                buttonSize: 44.0,
                fillColor: Colors.transparent,
                icon: const Icon(
                  Icons.add_circle_outline,
                  color: Color(0xFFCC0000),
                  size: 24.0,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdminBilletWidget(),
                    ),
                  );
                },
              ),
            // Bouton panier
            FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 22.0,
              borderWidth: 0.0,
              buttonSize: 44.0,
              fillColor: Colors.transparent,
              icon: const Icon(
                Icons.shopping_cart_outlined,
                color: Color(0xFF1A1A1A),
                size: 24.0,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PanierrWidget(),
                  ),
                );
              },
            ),
          ],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: double.infinity,
                  height: 1.0,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE0E0E0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
                  child: StreamBuilder<List<BilletRecord>>(
                    stream: queryBilletRecord(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: SizedBox(
                            width: 40.0,
                            height: 40.0,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                FlutterFlowTheme.of(context).primary,
                              ),
                            ),
                          ),
                        );
                      }
                      final List<BilletRecord> listViewBilletRecordList = snapshot.data!;

                      if (listViewBilletRecordList.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.confirmation_number_outlined,
                                size: 80,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Aucun billet trouvé',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 24),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const HomexWidget(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFCC0000),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: const Text(
                                  'Réserver un film',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: listViewBilletRecordList.length,
                        itemBuilder: (context, listViewIndex) {
                          final listViewBilletRecord = listViewBilletRecordList[listViewIndex];
                          return Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
                            child: Container(
                              width: double.infinity,
                              height: 150.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 8.0,
                                    color: Color(0x1A000000),
                                    offset: Offset(0.0, 2.0),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Builder(
                                      builder: (context) {
                                        if (listViewBilletRecord.hasImageUrl() && listViewBilletRecord.imageUrl.isNotEmpty) {
                                          return ClipRRect(
                                            borderRadius: BorderRadius.circular(12.0),
                                            child: CachedNetworkImage(
                                              fadeInDuration: const Duration(milliseconds: 0),
                                              fadeOutDuration: const Duration(milliseconds: 0),
                                              imageUrl: listViewBilletRecord.imageUrl,
                                              width: 48.0,
                                              height: 48.0,
                                              fit: BoxFit.cover,
                                            ),
                                          );
                                        }
                                        return Container(
                                          width: 48.0,
                                          height: 48.0,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFFFE5E5),
                                            borderRadius: BorderRadius.circular(12.0),
                                          ),
                                          child: const Align(
                                            alignment: AlignmentDirectional(0.0, 0.0),
                                            child: Icon(
                                              Icons.local_movies_rounded,
                                              color: Color(0xFFE53935),
                                              size: 26.0,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              listViewBilletRecord.film,
                                              maxLines: 1,
                                              style: FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .override(
                                                    font: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                    color: const Color(0xFF1A1A1A),
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    const Icon(
                                                      Icons.event_seat_rounded,
                                                      color: Color(0xFF757575),
                                                      size: 14.0,
                                                    ),
                                                    Text(
                                                      listViewBilletRecord.numeroSiege,
                                                      style: const TextStyle(
                                                        color: Color(0xFF757575),
                                                        fontSize: 13.0,
                                                      ),
                                                    ),
                                                  ].divide(const SizedBox(width: 4.0)),
                                                ),
                                                Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    const Icon(
                                                      Icons.attach_money_rounded,
                                                      color: Color(0xFF757575),
                                                      size: 14.0,
                                                    ),
                                                    Text(
                                                      listViewBilletRecord.prix.toString(),
                                                      style: const TextStyle(
                                                        color: Color(0xFF757575),
                                                        fontSize: 13.0,
                                                      ),
                                                    ),
                                                  ].divide(const SizedBox(width: 4.0)),
                                                ),
                                              ].divide(const SizedBox(width: 16.0)),
                                            ),
                                            Container(
                                              width: 80.0,
                                              height: 24.0,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFE8F5E9),
                                                borderRadius: BorderRadius.circular(20.0),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                                child: Text(
                                                  listViewBilletRecord.statut,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    color: Color(0xFF2E7D32),
                                                    fontSize: 11.0,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // ⭐ BOUTON LOCALISATION (MAP) ⭐
                                            Align(
                                              alignment: const AlignmentDirectional(0.0, 1.0),
                                              child: FlutterFlowIconButton(
                                                borderRadius: 8.0,
                                                buttonSize: 30.0,
                                                fillColor: FlutterFlowTheme.of(context).primary,
                                                icon: const Icon(
                                                  Icons.location_on,
                                                  color: Colors.white,
                                                  size: 15.0,
                                                ),
                                                onPressed: () async {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => const CinemaLocationWidget(),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ].divide(const SizedBox(height: 6.0)),
                                        ),
                                      ),
                                    ),
                                    // ⭐ BOUTON AJOUTER AU PANIER ⭐
                                    FlutterFlowIconButton(
                                      borderColor: Colors.transparent,
                                      borderRadius: 40.0,
                                      borderWidth: 0.0,
                                      buttonSize: 35.0,
                                      fillColor: const Color(0xFFE53935),
                                      icon: const Icon(
                                        Icons.shopping_cart_rounded,
                                        color: Colors.white,
                                        size: 20.0,
                                      ),
                                      onPressed: () async {
                                        await Panier1Record.collection.doc().set({
                                          ...createPanier1RecordData(
                                            billetRef: listViewBilletRecord.reference,
                                            userRef: currentUserReference,
                                            film: listViewBilletRecord.film,
                                            numeroSiege: listViewBilletRecord.numeroSiege,
                                            prix: listViewBilletRecord.prix,
                                            youtubeUrl: listViewBilletRecord.youtubeUrl,
                                          ),
                                          ...mapToFirestore({
                                            'created_time': FieldValue.serverTimestamp(),
                                          }),
                                        });

                                        await listViewBilletRecord.reference.update({
                                          'statut': 'reserved',
                                        });

                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text('Billet ajouté au panier'),
                                            duration: Duration(milliseconds: 2000),
                                          ),
                                        );
                                      },
                                    ),
                                    // ⭐ BOUTON BANDE-ANNONCE (TRAILER) ⭐
                                    Align(
                                      alignment: const AlignmentDirectional(-1.0, 0.0),
                                      child: FlutterFlowIconButton(
                                        borderRadius: 8.0,
                                        buttonSize: 30.0,
                                        fillColor: FlutterFlowTheme.of(context).primary,
                                        icon: const Icon(
                                          Icons.play_circle,
                                          color: Colors.white,
                                          size: 15.0,
                                        ),
                                        onPressed: () async {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => TrailerWidget(
                                                film: listViewBilletRecord.film,
                                                youtubeUrl: listViewBilletRecord.youtubeUrl,
                                              ),
                                            ),
                                          );
                                        },
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}