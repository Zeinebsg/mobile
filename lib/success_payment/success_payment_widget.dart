import '/components/summary_row_widget.dart';
import '/custom_code/widgets/api_ninjas_qr_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'success_payment_model.dart';
export 'success_payment_model.dart';

/// Create a payment success page in French for a cinema ticket booking app.
///
/// Use a clean white background with red and black accents. Add a large red
/// circular success check icon at the top. Add the title "Paiement Réussi" in
/// bold black text and the subtitle "Vos billets ont été réservés avec
/// succès." Add a rounded summary card with placeholder text: "Commande
/// confirmée", "Nombre de billets: 0", and "Total payé: 0.00 DT". Add a large
/// red button labeled "Retour aux billets" and a secondary outlined button
/// labeled "Voir mon panier". Make the design modern, centered,
/// mobile-friendly, with rounded corners and good spacing.
class SuccessPaymentWidget extends StatefulWidget {
  const SuccessPaymentWidget({
    super.key,
    int? ticketCount,
    double? total,
    String? film,
    String? seat,
  })  : this.ticketCount = ticketCount ?? 0,
        this.total = total ?? 0.0,
        this.film = film ?? 'Inconnu',
        this.seat = seat ?? 'N/A';

  final int ticketCount;
  final double total;
  final String film;
  final String seat;

  static String routeName = 'success_payment';
  static String routePath = '/successPayment';

  @override
  State<SuccessPaymentWidget> createState() => _SuccessPaymentWidgetState();
}

class _SuccessPaymentWidgetState extends State<SuccessPaymentWidget> {
  late SuccessPaymentModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SuccessPaymentModel());
    _model.quotesFuture = _model.fetchDailyQuote();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filmDisplay =
        (widget.film != null && widget.film!.isNotEmpty && widget.film != 'Inconnu')
            ? widget.film
            : 'Fricasse Cinema';
    final seatDisplay =
        (widget.seat != null && widget.seat!.isNotEmpty && widget.seat != 'N/A')
            ? widget.seat
            : 'N/A';
    final qrPayload = [
      'Ticket#1230',
      'Film: $filmDisplay',
      'Siège: $seatDisplay',
      'Total: ${widget.total.toStringAsFixed(2)} DT',
      'Statut: Payé',
    ].join('\n');

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SingleChildScrollView(
          primary: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.all(32.0),
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              color: Color(0x1A2ECC71),
                              borderRadius: BorderRadius.circular(9999.0),
                              shape: BoxShape.rectangle,
                            ),
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Icon(
                              Icons.check_circle_rounded,
                              color: Color(0xFF2ECC71),
                              size: 72.0,
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Paiement Réussi',
                                style: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .override(
                                      font: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .headlineMedium
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .headlineMedium
                                          .fontStyle,
                                      lineHeight: 1.4,
                                    ),
                              ),
                              Text(
                                'Vos billets ont été réservés avec succès.',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .bodyLarge
                                    .override(
                                      font: GoogleFonts.poppins(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .fontStyle,
                                      lineHeight: 1.4,
                                    ),
                              ),
                            ].divide(SizedBox(height: 8.0)),
                          ),
                        ].divide(SizedBox(height: 24.0)),
                      ),
                      Container(
                        width: double.infinity,
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Container(
                          width: 220.0,
                          height: 220.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            borderRadius: BorderRadius.circular(18.0),
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).alternate,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14.0),
                            child: ApiNinjasQrWidget(
                              qrData: qrPayload,
                              width: 220.0,
                              height: 220.0,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: FutureBuilder<Map<String, dynamic>?>(
                          future: _model.quotesFuture,
                          builder: (context, snapshot) {
                            String quoteText = 'Merci pour votre réservation.';
                            String authorText = '';
                            String workText = '';

                            if (snapshot.hasData && snapshot.data != null) {
                              quoteText = snapshot.data!['quote'] as String? ?? quoteText;
                              authorText = snapshot.data!['author'] as String? ?? '';
                              workText = snapshot.data!['work'] as String? ?? '';
                            }

                            return Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(18.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(24.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      'Citation du jour',
                                      style: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .override(
                                            font: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    SizedBox(height: 12.0),
                                    Text(
                                      '\"$quoteText\"',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.poppins(
                                              fontStyle: FontStyle.italic,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 0.0,
                                            fontStyle: FontStyle.italic,
                                          ),
                                      textAlign: TextAlign.center,
                                    ),
                                    if (authorText.isNotEmpty)
                                      Padding(
                                        padding: EdgeInsetsDirectional
                                            .fromSTEB(0.0, 12.0, 0.0, 0.0),
                                        child: Text(
                                          '— $authorText',
                                          style: FlutterFlowTheme.of(context)
                                              .labelMedium
                                              .override(
                                                font: GoogleFonts.poppins(),
                                                color: FlutterFlowTheme.of(
                                                        context)
                                                    .accent3,
                                                letterSpacing: 0.0,
                                              ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    if (workText.isNotEmpty)
                                      Padding(
                                        padding: EdgeInsetsDirectional
                                            .fromSTEB(0.0, 8.0, 0.0, 0.0),
                                        child: Text(
                                          workText,
                                          style: FlutterFlowTheme.of(context)
                                              .labelSmall
                                              .override(
                                                font: GoogleFonts.poppins(),
                                                color: FlutterFlowTheme.of(
                                                        context)
                                                    .secondaryText,
                                                letterSpacing: 0.0,
                                              ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(24.0),
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: FlutterFlowTheme.of(context).alternate,
                            width: 1.0,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.check_circle_rounded,
                                      color:
                                          FlutterFlowTheme.of(context).success,
                                      size: 20.0,
                                    ),
                                    Text(
                                      'Commande confirmée',
                                      style: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .override(
                                            font: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleMedium
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleMedium
                                                    .fontStyle,
                                            lineHeight: 1.4,
                                          ),
                                    ),
                                  ].divide(SizedBox(width: 8.0)),
                                ),
                                Divider(
                                  height: 16.0,
                                  thickness: 1.0,
                                  indent: 0.0,
                                  endIndent: 0.0,
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                                wrapWithModel(
                                  model: _model.summaryRowModel1,
                                  updateCallback: () => safeSetState(() {}),
                                  child: SummaryRowWidget(
                                    label: 'Nombre de billets',
                                    value: widget.ticketCount.toString(),
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.summaryRowModel2,
                                  updateCallback: () => safeSetState(() {}),
                                  child: SummaryRowWidget(
                                    label: 'Total payé',
                                    value:
                                        '${widget.total.toStringAsFixed(2)} DT',
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.summaryRowModel3,
                                  updateCallback: () => safeSetState(() {}),
                                  child: SummaryRowWidget(
                                    label: 'Mode de paiement',
                                    value: 'Carte Bancaire',
                                  ),
                                ),
                              ].divide(SizedBox(height: 16.0)),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Container(
                          width: 0.0,
                          height: 0.0,
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 32.0, 0.0, 0.0),
                          child: Container(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.help_outline_rounded,
                                  color: FlutterFlowTheme.of(context).accent3,
                                  size: 16.0,
                                ),
                                Text(
                                  'Besoin d\'aide ? Contactez le support',
                                  style: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        font: GoogleFonts.poppins(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                        lineHeight: 1.4,
                                      ),
                                ),
                              ].divide(SizedBox(width: 4.0)),
                            ),
                          ),
                        ),
                      ),
                    ].divide(SizedBox(height: 32.0)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
