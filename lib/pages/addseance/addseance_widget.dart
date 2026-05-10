import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/pages/seanaces/seanaces_widget.dart';
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'addseance_model.dart';
export 'addseance_model.dart';

class AddseanceWidget extends StatefulWidget {
  const AddseanceWidget({super.key});

  static String routeName = 'addseance';
  static String routePath = '/addseance';

  @override
  State<AddseanceWidget> createState() => _AddseanceWidgetState();
}

class _AddseanceWidgetState extends State<AddseanceWidget> {
  late AddseanceModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isCheckingDisponibility = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddseanceModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  // Vérifier si la salle est disponible
  Future<bool> _isSalleDisponible(String salleId, DateTime dateTime, int dureeFilm) async {
    final debutSeance = dateTime;
    final finSeanceAvecNettoyage = debutSeance.add(Duration(minutes: dureeFilm + 15));

    final allSeances = await FirebaseFirestore.instance
        .collection('seances')
        .where('salleId', isEqualTo: salleId)
        .get();

    for (var doc in allSeances.docs) {
      final data = doc.data() as Map<String, dynamic>;
      final seanceDebut = (data['dateTime'] as Timestamp).toDate();

      if (seanceDebut.isBefore(debutSeance.subtract(const Duration(days: 2)))) continue;

      final int duree = (data['duree'] as int?) ?? 150;
      final seanceFin = seanceDebut.add(Duration(minutes: duree + 15));

      if (finSeanceAvecNettoyage.isAfter(seanceDebut) && debutSeance.isBefore(seanceFin)) {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<FilmsRecord>>(
      stream: queryFilmsRecord(),
      builder: (context, filmsSnapshot) {
        if (!filmsSnapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            body: Center(
              child: SizedBox(
                width: 40.0,
                height: 40.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        List<FilmsRecord> addseanceFilmsRecordList = filmsSnapshot.data!;

        return StreamBuilder<List<SallesRecord>>(
          stream: querySallesRecord(),
          builder: (context, sallesSnapshot) {
            if (!sallesSnapshot.hasData) {
              return Scaffold(
                backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
                body: Center(
                  child: SizedBox(
                    width: 40.0,
                    height: 40.0,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        FlutterFlowTheme.of(context).primary,
                      ),
                    ),
                  ),
                ),
              );
            }
            List<SallesRecord> addseanceSallesRecordList = sallesSnapshot.data!;

            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Scaffold(
                key: scaffoldKey,
                backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
                appBar: AppBar(
                  backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
                  automaticallyImplyLeading: false,
                  leading: FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 30.0,
                    borderWidth: 1.0,
                    buttonSize: 60.0,
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      size: 30.0,
                    ),
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                  ),
                  actions: [],
                  centerTitle: false,
                  elevation: 0.0,
                ),
                body: SafeArea(
                  top: true,
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Creer nouvelle séance',
                            style: FlutterFlowTheme.of(context)
                                .headlineMedium
                                .override(
                                  font: GoogleFonts.poppins(),
                                  letterSpacing: 0.0,
                                ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              // DROPDOWN FILM
                              FlutterFlowDropDown<String>(
                                controller: _model.filmValueController ??=
                                    FormFieldController<String>(
                                      _model.filmValue ??= '',
                                    ),
                                options: List<String>.from(
                                  addseanceFilmsRecordList
                                      .map((e) => e.reference.id)
                                      .toList()),
                                optionLabels: addseanceFilmsRecordList
                                    .map((e) => e.title)
                                    .toList(),
                                onChanged: (val) async {
                                  safeSetState(() => _model.filmValue = val);
                                  _model.selectedFilmId = _model.filmValue;
                                  
                                  final selectedFilm = addseanceFilmsRecordList.firstWhere(
                                    (film) => film.reference.id == val,
                                    orElse: () => addseanceFilmsRecordList.first,
                                  );
                                  
                                  _model.selectedFilmName = selectedFilm.title;
                                  _model.selectedFilmDuree = (selectedFilm.duree as int?) ?? 150;
                                  
                                  safeSetState(() {});
                                },
                                width: double.infinity,
                                height: 40.0,
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.poppins(),
                                      letterSpacing: 0.0,
                                    ),
                                hintText: 'Choisir un film ...',
                                icon: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: FlutterFlowTheme.of(context).secondaryText,
                                  size: 24.0,
                                ),
                                fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                elevation: 2.0,
                                borderColor: Color(0xE8C31111),
                                borderWidth: 3.0,
                                borderRadius: 8.0,
                                margin: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                                hidesUnderline: true,
                                isOverButton: false,
                                isSearchable: false,
                                isMultiSelect: false,
                              ),
                              
                              // DROPDOWN SALLE
                              FlutterFlowDropDown<String>(
                                controller: _model.salleValueController ??=
                                    FormFieldController<String>(
                                      _model.salleValue ??= '',
                                    ),
                                options: List<String>.from(addseanceSallesRecordList
                                    .map((e) => e.reference.id)
                                    .toList()),
                                optionLabels: addseanceSallesRecordList
                                    .map((e) => e.name)
                                    .toList(),
                                onChanged: (val) {
                                  safeSetState(() => _model.salleValue = val);
                                  final selectedSalle = addseanceSallesRecordList.firstWhere(
                                    (salle) => salle.reference.id == val,
                                    orElse: () => addseanceSallesRecordList.first,
                                  );
                                  _model.selectedSalleName = selectedSalle.name;
                                  safeSetState(() {});
                                },
                                width: double.infinity,
                                height: 40.0,
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.poppins(),
                                      letterSpacing: 0.0,
                                    ),
                                hintText: 'Choisir une salle ...',
                                icon: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: FlutterFlowTheme.of(context).secondaryText,
                                  size: 24.0,
                                ),
                                fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                elevation: 2.0,
                                borderColor: Color(0xE8C31111),
                                borderWidth: 3.0,
                                borderRadius: 8.0,
                                margin: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                                hidesUnderline: true,
                                isOverButton: false,
                                isSearchable: false,
                                isMultiSelect: false,
                              ),
                              
                              // DROPDOWN FORMAT
                              FlutterFlowDropDown<String>(
                                controller: _model.formatValueController ??=
                                    FormFieldController<String>(
                                      _model.formatValue ??= '',
                                    ),
                                options: List<String>.from(['vo', 'vf', 'vostfr']),
                                optionLabels: ['VO', 'VF', 'VOSTFR'],
                                onChanged: (val) =>
                                    safeSetState(() => _model.formatValue = val),
                                width: double.infinity,
                                height: 40.0,
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.poppins(),
                                      letterSpacing: 0.0,
                                    ),
                                hintText: 'Format...',
                                icon: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: FlutterFlowTheme.of(context).secondaryText,
                                  size: 24.0,
                                ),
                                fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                elevation: 2.0,
                                borderColor: Color(0xE8C31111),
                                borderWidth: 3.0,
                                borderRadius: 8.0,
                                margin: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                                hidesUnderline: true,
                                isOverButton: false,
                                isSearchable: false,
                                isMultiSelect: false,
                              ),
                              
                              // DROPDOWN QUALITE
                              FlutterFlowDropDown<String>(
                                controller: _model.qualiteValueController ??=
                                    FormFieldController<String>(
                                      _model.qualiteValue ??= '',
                                    ),
                                options: List<String>.from(['2D', '3D', '4K']),
                                optionLabels: ['2D', '3D', '4K'],
                                onChanged: (val) =>
                                    safeSetState(() => _model.qualiteValue = val),
                                width: double.infinity,
                                height: 40.0,
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.poppins(),
                                      letterSpacing: 0.0,
                                    ),
                                hintText: 'Qualité...',
                                icon: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: FlutterFlowTheme.of(context).secondaryText,
                                  size: 24.0,
                                ),
                                fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                elevation: 2.0,
                                borderColor: Color(0xE8C31111),
                                borderWidth: 3.0,
                                borderRadius: 8.0,
                                margin: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                                hidesUnderline: true,
                                isOverButton: false,
                                isSearchable: false,
                                isMultiSelect: false,
                              ),
                              
                              // DATE PICKER
                              Container(
                                width: double.infinity,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                  border: Border.all(
                                    color: Color(0xE8961010),
                                    width: 3.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    final pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2050),
                                    );
                                    if (pickedDate != null) {
                                      final pickedTime = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      );
                                      if (pickedTime != null) {
                                        safeSetState(() {
                                          _model.datePicked = DateTime(
                                            pickedDate.year,
                                            pickedDate.month,
                                            pickedDate.day,
                                            pickedTime.hour,
                                            pickedTime.minute,
                                          );
                                        });
                                      }
                                    }
                                  },
                                  child: Center(
                                    child: Text(
                                      _model.datePicked != null
                                          ? '${_model.datePicked!.day}/${_model.datePicked!.month}/${_model.datePicked!.year} ${_model.datePicked!.hour}:${_model.datePicked!.minute.toString().padLeft(2, '0')}'
                                          : 'Choisir la date et l\'heure...',
                                      style: FlutterFlowTheme.of(context).bodyMedium,
                                    ),
                                  ),
                                ),
                              ),
                            ].divide(SizedBox(height: 16.0)).addToStart(SizedBox(height: 12.0)),
                          ),
                          
                          // BOUTON AJOUTER
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 12.0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                if (_model.selectedFilmId == null || _model.selectedFilmId!.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Veuillez choisir un film')),
                                  );
                                  return;
                                }
                                if (_model.salleValue == null || _model.salleValue!.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Veuillez choisir une salle')),
                                  );
                                  return;
                                }
                                if (_model.datePicked == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Veuillez choisir une date')),
                                  );
                                  return;
                                }
                                
                                setState(() => _isCheckingDisponibility = true);
                                
                                final isDispo = await _isSalleDisponible(
                                  _model.salleValue!,
                                  _model.datePicked!,
                                  _model.selectedFilmDuree ?? 150,
                                );
                                
                                if (!isDispo) {
                                  setState(() => _isCheckingDisponibility = false);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('❌ Cette salle n\'est pas disponible à cet horaire (nettoyage inclus)'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                  return;
                                }
                                
                                // CRÉATION DE LA SÉANCE - VERSION MANUELLE
                                final salleRef = FirebaseFirestore.instance.collection('salles').doc(_model.salleValue);
                                
                                await FirebaseFirestore.instance.collection('seances').add({
                                  'dateTime': _model.datePicked,
                                  'format': _model.formatValue,
                                  'quality': _model.qualiteValue,
                                  'ownerId': currentUserReference,
                                  'reservedSeatts': 0,
                                  'filmName': _model.selectedFilmName,
                                  'filmId': _model.selectedFilmId,
                                  'salleRef': salleRef,
                                  'salleName': _model.selectedSalleName,
                                  'duree': _model.selectedFilmDuree ?? 150,
                                });
                                
                                print('✅ Séance ajoutée - salleId: ${_model.salleValue}, salleName: ${_model.selectedSalleName}');
                                
                                setState(() => _isCheckingDisponibility = false);
                                    
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SeanacesWidget(),
                                  ),
                                );
                              },
                              text: _isCheckingDisponibility ? 'Vérification...' : 'Ajouter la séance',
                              icon: _isCheckingDisponibility ? null : const Icon(Icons.add, size: 15.0),
                              options: FFButtonOptions(
                                width: double.infinity,
                                height: 54.0,
                                padding: EdgeInsets.all(0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).primary,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      font: GoogleFonts.poppins(),
                                      color: Colors.white,
                                      letterSpacing: 0.0,
                                    ),
                                elevation: 4.0,
                                borderSide: const BorderSide(color: Colors.transparent, width: 1.0),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}