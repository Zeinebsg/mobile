import '/components/info_row2_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'stripe_payment_widget.dart' show StripePaymentWidget;
import 'package:flutter/material.dart';

class StripePaymentModel extends FlutterFlowModel<StripePaymentWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for InfoRow.
  late InfoRow2Model infoRowModel1;
  // Model for InfoRow.
  late InfoRow2Model infoRowModel2;

  @override
  void initState(BuildContext context) {
    infoRowModel1 = createModel(context, () => InfoRow2Model());
    infoRowModel2 = createModel(context, () => InfoRow2Model());
  }

  @override
  void dispose() {
    infoRowModel1.dispose();
    infoRowModel2.dispose();
  }
}
