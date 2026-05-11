import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/success_payment/success_payment_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'stripe_payment_model.dart';
export 'stripe_payment_model.dart';

class StripePaymentWidget extends StatefulWidget {
  const StripePaymentWidget({
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

  static String routeName = 'StripePayment';
  static String routePath = '/stripePayment';

  @override
  State<StripePaymentWidget> createState() => _StripePaymentWidgetState();
}

class _StripePaymentWidgetState extends State<StripePaymentWidget> {
  late StripePaymentModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StripePaymentModel());
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
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_rounded,
              color: FlutterFlowTheme.of(context).primaryText,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'Paiement',
            style: FlutterFlowTheme.of(context).titleLarge.override(
                  font: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                  ),
                  color: FlutterFlowTheme.of(context).primaryText,
                ),
          ),
          centerTitle: false,
          elevation: 0.0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Résumé de la commande',
                style: FlutterFlowTheme.of(context).titleMedium.override(
                      font: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                      ),
                      color: FlutterFlowTheme.of(context).primaryText,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24.0),
              Text(
                'Nombre de billets: ${widget.ticketCount}',
                style: FlutterFlowTheme.of(context).bodyLarge.override(
                      font: GoogleFonts.poppins(),
                      color: FlutterFlowTheme.of(context).primaryText,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12.0),
              Text(
                'Total: ${widget.total.toStringAsFixed(2)} DT',
                style: FlutterFlowTheme.of(context).titleMedium.override(
                      font: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                      ),
                      color: FlutterFlowTheme.of(context).primary,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 64.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SuccessPaymentWidget(
                        ticketCount: widget.ticketCount,
                        total: widget.total,
                        film: widget.film,
                        seat: widget.seat,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: FlutterFlowTheme.of(context).error,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: Text(
                  'Payer maintenant',
                  style: FlutterFlowTheme.of(context).titleMedium.override(
                        font: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                        ),
                        color: Colors.white,
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
