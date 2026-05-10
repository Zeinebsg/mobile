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
import 'updateseance_model.dart';
export 'updateseance_model.dart';

class UpdateseanceWidget extends StatefulWidget {
  const UpdateseanceWidget({
    super.key,
    required this.seanceRef,
  });

  final DocumentReference? seanceRef;

  static String routeName = 'updateseance';
  static String routePath = '/updateseance';

  @override
  State<UpdateseanceWidget> createState() => _UpdateseanceWidgetState();
}

class _UpdateseanceWidgetState extends State<UpdateseanceWidget> {
  late UpdateseanceModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  
  // Données actuelles de la séance
  SeancesRecord? _currentSeance;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UpdateseanceModel());
    _loadCurrentSeance();
  }

  Future<void> _loadCurrentSeance() async {
    if (widget.seanceRef != null) {
      DocumentSnapshot doc = await widget.seanceRef!.get();
      if (doc.exists) {
        setState(() {
          _currentSeance = SeancesRecord.fromSnapshot(doc as DocumentSnapshot<Map<String, dynamic>>);
          _isLoading = false;
          
          // Initialiser les valeurs actuelles dans les contrôleurs
          _model.filmValue = _currentSeance?.filmId;
          _model.formatValue = _currentSeance?.format;
          _model.qualiteValue = _currentSeance?.quality;
          _model.datePicked = _currentSeance?.dateTime;
        });
      }
    }
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: Center(
          child: CircularProgressIndicator(
            color: FlutterFlowTheme.of(context).primary,
          ),
        ),
      );
    }

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
        List<FilmsRecord> updateseanceFilmsRecordList = filmsSnapshot.data!;

        return StreamBuilder<List<SallesRecord>>(
          stream: querySallesRecord(
            queryBuilder: (sallesRecord) => sallesRecord.where(
              'disponibility',
              isEqualTo: true,
            ),
          ),
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
            List<SallesRecord> updateseanceSallesRecordList = sallesSnapshot.data!;

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
                            'Mettre à jour la séance',
                            style: FlutterFlowTheme.of(context)
                                .headlineMedium
                                .override(
                                  font: GoogleFonts.poppins(),
                                  letterSpacing: 0.0,
                                ),
                          ),
                          SizedBox(height: 16),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              // DROPDOWN FILM
                              FutureBuilder<DocumentSnapshot>(
                                future: _currentSeance?.filmId != null
                                    ? FirebaseFirestore.instance.collection('films').doc(_currentSeance!.filmId).get()
                                    : null,
                                builder: (context, filmCurrentSnapshot) {
                                  String currentFilmTitle = _currentSeance?.filmName ?? 'Film inconnu';
                                  if (filmCurrentSnapshot.hasData && filmCurrentSnapshot.data!.exists) {
                                    var filmData = filmCurrentSnapshot.data!.data() as Map<String, dynamic>;
                                    currentFilmTitle = filmData['title'] ?? filmData['titre'] ?? currentFilmTitle;
                                  }
                                  
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Film actuel : $currentFilmTitle',
                                        style: TextStyle(color: Color(0xFFAAAAAA), fontSize: 12),
                                      ),
                                      SizedBox(height: 8),
                                      FlutterFlowDropDown<String>(
                                        controller: _model.filmValueController ??=
                                            FormFieldController<String>(
                                              _model.filmValue ??= _currentSeance?.filmId,
                                            ),
                                        options: List<String>.from(
                                          updateseanceFilmsRecordList
                                              .map((e) => e.reference.id)
                                              .toList()),
                                        optionLabels: updateseanceFilmsRecordList
                                            .map((e) => e.title)
                                            .toList(),
                                        onChanged: (val) async {
                                          safeSetState(() => _model.filmValue = val);
                                          // Récupérer le nom du film sélectionné
                                          final selectedFilm = updateseanceFilmsRecordList.firstWhere(
                                            (film) => film.reference.id == val,
                                            orElse: () => updateseanceFilmsRecordList.first,
                                          );
                                          _model.selectedFilmName = selectedFilm.title;
                                        },
                                        width: double.infinity,
                                        height: 40.0,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.poppins(),
                                              letterSpacing: 0.0,
                                            ),
                                        hintText: 'Choisir un autre film...',
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
                                    ],
                                  );
                                },
                              ),
                              
                              SizedBox(height: 16),
                              
                              // DROPDOWN SALLE
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Salle actuelle : ${_currentSeance?.salleRef?.path.split('/').last ?? 'Non définie'}',
                                    style: TextStyle(color: Color(0xFFAAAAAA), fontSize: 12),
                                  ),
                                  SizedBox(height: 8),
                                  FlutterFlowDropDown<String>(
                                    controller: _model.salleValueController ??=
                                        FormFieldController<String>(
                                          _model.salleValue ??= _currentSeance?.salleRef?.id,
                                        ),
                                    options: List<String>.from(updateseanceSallesRecordList
                                        .map((e) => e.reference.id)
                                        .toList()),
                                    optionLabels: updateseanceSallesRecordList
                                        .map((e) => e.name)
                                        .toList(),
                                    onChanged: (val) => safeSetState(() => _model.salleValue = val),
                                    width: double.infinity,
                                    height: 40.0,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.poppins(),
                                          letterSpacing: 0.0,
                                        ),
                                    hintText: 'Choisir une autre salle...',
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
                                ],
                              ),
                              
                              SizedBox(height: 16),
                              
                              // DROPDOWN FORMAT
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Format actuel : ${_currentSeance?.format.toUpperCase() ?? 'Non défini'}',
                                    style: TextStyle(color: Color(0xFFAAAAAA), fontSize: 12),
                                  ),
                                  SizedBox(height: 8),
                                  FlutterFlowDropDown<String>(
                                    controller: _model.formatValueController ??=
                                        FormFieldController<String>(
                                          _model.formatValue ??= _currentSeance?.format,
                                        ),
                                    options: List<String>.from(['vo', 'vf', 'vostfr']),
                                    optionLabels: ['VO', 'VF', 'VOSTFR'],
                                    onChanged: (val) => safeSetState(() => _model.formatValue = val),
                                    width: double.infinity,
                                    height: 40.0,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.poppins(),
                                          letterSpacing: 0.0,
                                        ),
                                    hintText: 'Changer le format...',
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
                                ],
                              ),
                              
                              SizedBox(height: 16),
                              
                              // DROPDOWN QUALITE
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Qualité actuelle : ${_currentSeance?.quality ?? 'Non définie'}',
                                    style: TextStyle(color: Color(0xFFAAAAAA), fontSize: 12),
                                  ),
                                  SizedBox(height: 8),
                                  FlutterFlowDropDown<String>(
                                    controller: _model.qualiteValueController ??=
                                        FormFieldController<String>(
                                          _model.qualiteValue ??= _currentSeance?.quality,
                                        ),
                                    options: List<String>.from(['2D', '3D', '4K']),
                                    optionLabels: ['2D', '3D', '4K'],
                                    onChanged: (val) => safeSetState(() => _model.qualiteValue = val),
                                    width: double.infinity,
                                    height: 40.0,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.poppins(),
                                          letterSpacing: 0.0,
                                        ),
                                    hintText: 'Changer la qualité...',
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
                                ],
                              ),
                              
                              SizedBox(height: 16),
                              
                              // DATE PICKER
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Date et heure actuelles : ${_currentSeance?.dateTime != null ? '${_currentSeance!.dateTime!.day}/${_currentSeance!.dateTime!.month}/${_currentSeance!.dateTime!.year} ${_currentSeance!.dateTime!.hour}:${_currentSeance!.dateTime!.minute}' : 'Non définie'}',
                                    style: TextStyle(color: Color(0xFFAAAAAA), fontSize: 12),
                                  ),
                                  SizedBox(height: 8),
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
                                      onTap: () async {
                                        final pickedDate = await showDatePicker(
                                          context: context,
                                          initialDate: _model.datePicked ?? DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(2050),
                                        );
                                        if (pickedDate != null) {
                                          final pickedTime = await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.fromDateTime(_model.datePicked ?? DateTime.now()),
                                          );
                                          if (pickedTime != null) {
                                            setState(() {
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
                                              : 'Choisir une nouvelle date et heure...',
                                          style: FlutterFlowTheme.of(context).bodyMedium,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 12.0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                // Préparer les données à mettre à jour
                                Map<String, dynamic> updateData = {};
                                
                                if (_model.filmValue != null && _model.filmValue != _currentSeance?.filmId) {
                                  updateData['filmId'] = _model.filmValue;
                                  if (_model.selectedFilmName != null) {
                                    updateData['filmName'] = _model.selectedFilmName;
                                    updateData['filmTitleLower'] = _model.selectedFilmName!.toLowerCase();
                                  }
                                }
                                
                                if (_model.salleValue != null && _model.salleValue != _currentSeance?.salleRef?.id) {
                                  updateData['salleRef'] = FirebaseFirestore.instance.collection('salles').doc(_model.salleValue);
                                }
                                
                                if (_model.formatValue != null && _model.formatValue != _currentSeance?.format) {
                                  updateData['format'] = _model.formatValue;
                                }
                                
                                if (_model.qualiteValue != null && _model.qualiteValue != _currentSeance?.quality) {
                                  updateData['quality'] = _model.qualiteValue;
                                }
                                
                                if (_model.datePicked != null && _model.datePicked != _currentSeance?.dateTime) {
                                  updateData['dateTime'] = _model.datePicked;
                                }
                                
                                if (updateData.isNotEmpty) {
                                  await widget.seanceRef!.update(updateData);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Séance mise à jour avec succès')),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Aucune modification effectuée')),
                                  );
                                }
                                
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SeanacesWidget(),
                                  ),
                                );
                              },
                              text: 'Mettre à jour',
                              icon: Icon(Icons.update, size: 15.0),
                              options: FFButtonOptions(
                                width: double.infinity,
                                height: 54.0,
                                padding: EdgeInsets.all(0.0),
                                color: FlutterFlowTheme.of(context).primary,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      font: GoogleFonts.poppins(),
                                      color: Colors.white,
                                    ),
                                elevation: 4.0,
                                borderSide: BorderSide(color: Colors.transparent, width: 1.0),
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