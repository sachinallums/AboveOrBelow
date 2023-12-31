import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_page_model.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async' show Future;
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return StreamBuilder<List<GameSessionDataRecord>>(
      stream: queryGameSessionDataRecord(
        singleRecord: true,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        List<GameSessionDataRecord> homePageGameSessionDataRecordList =
            snapshot.data!;
        // Return an empty Container when the item does not exist.
        if (snapshot.data!.isEmpty) {
          return Container();
        }
        final homePageGameSessionDataRecord =
            homePageGameSessionDataRecordList.isNotEmpty
                ? homePageGameSessionDataRecordList.first
                : null;
        return GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: SafeArea(
              top: true,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Align(
                  alignment: AlignmentDirectional(-1.0, -1.0),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(0.0),
                        child: Image.asset(
                          'assets/images/iPad_Pro_de_10,5__12.png',
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.66, 0.75),
                        child: Container(
                          width: 504.0,
                          height: 100.0,
                          decoration: BoxDecoration(),
                          child: Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FFButtonWidget(
                                  onPressed: () async {
                                    context.pushNamed(
                                      'demo_1',
                                      extra: <String, dynamic>{
                                        kTransitionInfoKey: TransitionInfo(
                                          hasTransition: true,
                                          transitionType:
                                              PageTransitionType.fade,
                                          duration: Duration(milliseconds: 0),
                                        ),
                                      },
                                    );
                                  },
                                  text: 'Demo',
                                  options: FFButtonOptions(
                                    height: 55.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        24.0, 0.0, 24.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: Color(0xFFF0A573),
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Montserrat',
                                          color: Colors.white,
                                          fontSize: 30.0,
                                          letterSpacing: 1.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                    elevation: 3.0,
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(134.0),
                                  ),
                                ),
                                StreamBuilder<List<ProblemsRecord>>(
                                  stream: queryProblemsRecord(
                                    queryBuilder: (problemsRecord) =>
                                        problemsRecord
                                            .where('problemCycle',
                                                isEqualTo:
                                                    FFAppState().curCycle)
                                            .where('problemLevel',
                                                isEqualTo:
                                                    FFAppState().curLevel)
                                            .orderBy('referenceID'),
                                  ),
                                  builder: (context, snapshot) {
                                    // Customize what your widget looks like when it's loading.
                                    if (!snapshot.hasData) {
                                      return Center(
                                        child: SizedBox(
                                          width: 50.0,
                                          height: 50.0,
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    List<ProblemsRecord>
                                        buttonProblemsRecordList =
                                        snapshot.data!;
                                    return FFButtonWidget(
                                      onPressed: () async {
                                        setState(() {
                                          FFAppState().coins = 0;
                                          FFAppState().sessionQuestions =
                                              buttonProblemsRecordList
                                                  .map((e) => e.reference)
                                                  .toList()
                                                  .cast<DocumentReference>();
                                          FFAppState().curProblemIndex = 0;
                                        });

                                        var gameSessionDataRecordReference =
                                            GameSessionDataRecord.collection
                                                .doc();
                                        await gameSessionDataRecordReference
                                            .set(
                                                createGameSessionDataRecordData(
                                          accuracy: 0.0,
                                          numQuestionsAnswered: 0,
                                          numCorrect: 0,
                                          sessionResponseTime: 0.0,
                                          startTime: getCurrentTimestamp,
                                          userID: FFAppState().userID,
                                        ));
                                        _model.parentSessionRef =
                                            GameSessionDataRecord.getDocumentFromData(
                                                createGameSessionDataRecordData(
                                                  accuracy: 0.0,
                                                  numQuestionsAnswered: 0,
                                                  numCorrect: 0,
                                                  sessionResponseTime: 0.0,
                                                  startTime:
                                                      getCurrentTimestamp,
                                                  userID: FFAppState().userID,
                                                ),
                                                gameSessionDataRecordReference);
                                        setState(() {
                                          FFAppState().sessionParentReference =
                                              _model
                                                  .parentSessionRef?.reference;
                                          FFAppState().numInitialQuestions =
                                              FFAppState()
                                                  .sessionQuestions
                                                  .length;
                                        });

                                        context.pushNamed(
                                          'play_1',
                                          extra: <String, dynamic>{
                                            kTransitionInfoKey: TransitionInfo(
                                              hasTransition: true,
                                              transitionType:
                                                  PageTransitionType.fade,
                                              duration:
                                                  Duration(milliseconds: 0),
                                            ),
                                          },
                                        );

                                        setState(() {});
                                      },
                                      text: 'Play',
                                      options: FFButtonOptions(
                                        height: 55.0,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            24.0, 0.0, 24.0, 0.0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: Color(0xFFF0A573),
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'Montserrat',
                                              color: Colors.white,
                                              fontSize: 30.0,
                                              letterSpacing: 1.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                        elevation: 3.0,
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 0.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(134.0),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // // code to export csv data
                      // ElevatedButton(
                      //   onPressed: exportData,
                      //   child: Text("Export CSV"),
                      // ),

                      Align(
                        alignment: AlignmentDirectional(-0.75, 0.0),
                        child: Container(
                          width: 350.0,
                          height: 450.0,
                          decoration: BoxDecoration(),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              'assets/images/${FFAppState().curAnimal}.png',
                              width: 300.0,
                              height: 200.0,
                              fit: BoxFit.contain,
                            ),
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
  }
}

void exportData() async {
  final CollectionReference problems =
      FirebaseFirestore.instance.collection("problems");
  final myData = await rootBundle
      .loadString("assets/iSNS_above_or_below_lv6-5 - Sheet1.csv");

  List<List<dynamic>> csvTable = CsvToListConverter().convert(myData);
  List<List<dynamic>> data = [];
  data = csvTable;

  for (var i = 0; i < data.length; i++) {
    var record = {
      "problemID": data[i][0],
      "referenceID": data[i][1],
      "problemLevel": data[i][2],
      "problemCycle": data[i][3],
      "isBelow": convertStringToBool(data[i][4]),
      "targetNum": data[i][5],
      "correctNum": data[i][6],
      "num1": data[i][7],
      "num2": data[i][8],
      "num3": data[i][9],
      "num4": data[i][10],
      "num5": data[i][11],
      "foil": convertStringToBool(data[i][12]),
      "num1Symbolic": convertStringToBool(data[i][13]),
      "num2Symbolic": convertStringToBool(data[i][14]),
      "num3Symbolic": convertStringToBool(data[i][15]),
      "num4Symbolic": convertStringToBool(data[i][16]),
      "num5Symbolic": convertStringToBool(data[i][17]),
      "targetNumSymbolic": convertStringToBool(data[i][18]),
    };
    problems.add(record);
  }
}

bool convertStringToBool(String input) {
  if (input == "TRUE") {
    return true;
  } else {
    return false;
  }
}
