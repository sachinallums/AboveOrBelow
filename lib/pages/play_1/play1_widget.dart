import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'play1_model.dart';
export 'play1_model.dart';

class Play1Widget extends StatefulWidget {
  const Play1Widget({Key? key}) : super(key: key);

  @override
  _Play1WidgetState createState() => _Play1WidgetState();
}

class _Play1WidgetState extends State<Play1Widget> {
  late Play1Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Play1Model());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if ((FFAppState().curProblemIndex == FFAppState().numInitialQuestions) &&
          ((functions.getAccurcay(FFAppState().numCorrect,
                      FFAppState().numInitialQuestions) >=
                  0.8) ||
              ((FFAppState().curCycle == 3) && (FFAppState().curLevel < 6)))) {
        setState(() {
          FFAppState().curLevel = FFAppState().curLevel + 1;
          FFAppState().curCycle = 1;
        });
      } else if (FFAppState().curProblemIndex ==
          FFAppState().numInitialQuestions) {
        setState(() {
          FFAppState().curCycle = FFAppState().curCycle + 1;
        });
      }

      if ((FFAppState().curProblemIndex <
              FFAppState().sessionQuestions.length) &&
          (FFAppState().numTrialsDone < FFAppState().desiredTrialNum)) {
        _model.currentProblem = await actions.getDoc(
          FFAppState().sessionQuestions.toList(),
          FFAppState().curProblemIndex,
        );
        setState(() {
          FFAppState().updateProblemInfoStruct(
            (e) => e
              ..problemLevel = _model.currentProblem?.problemLevel
              ..problemOptions = _model.currentProblem?.problemOptions
              ..targetNum = _model.currentProblem?.targetNum
              ..questionIsBelow = _model.currentProblem?.isBelow
              ..num1 = _model.currentProblem?.num1
              ..num2 = _model.currentProblem?.num2
              ..num3 = _model.currentProblem?.num3
              ..num4 = _model.currentProblem?.num4
              ..num5 = _model.currentProblem?.num5
              ..num1Symbolic = _model.currentProblem?.num1Symbolic
              ..num2Symbolic = _model.currentProblem?.num2Symbolic
              ..num3Symbolic = _model.currentProblem?.num3Symbolic
              ..num4Symbolic = _model.currentProblem?.num4Symbolic
              ..num5Symbolic = _model.currentProblem?.num5Symbolic
              ..targetNumSymbolic = _model.currentProblem?.targetNumSymbolic
              ..problemCycle = _model.currentProblem?.problemCycle
              ..referenceID = _model.currentProblem?.referenceID
              ..problemID = _model.currentProblem?.problemID
              ..firstAttempt = FFAppState().curProblemIndex <
                  FFAppState().numInitialQuestions
              ..correctNum = _model.currentProblem?.correctNum
              ..foil = _model.currentProblem?.foil,
          );
          FFAppState().answeredQuestion = false;
          FFAppState().gotQuestionCorrect = false;
        });
        await Future.delayed(const Duration(milliseconds: 500));
        if (FFAppState().problemInfo.num4 == 0 &&
            FFAppState().problemInfo.num5 == 0) {
          context.pushNamed(
            'play_3options',
            extra: <String, dynamic>{
              kTransitionInfoKey: TransitionInfo(
                hasTransition: true,
                transitionType: PageTransitionType.fade,
              ),
            },
          );
        } else if (FFAppState().problemInfo.num5 == 0) {
          context.pushNamed(
            'play_4options',
            extra: <String, dynamic>{
              kTransitionInfoKey: TransitionInfo(
                hasTransition: true,
                transitionType: PageTransitionType.fade,
              ),
            },
          );
        } else {
          context.pushNamed(
            'play_5options',
            extra: <String, dynamic>{
              kTransitionInfoKey: TransitionInfo(
                hasTransition: true,
                transitionType: PageTransitionType.fade,
              ),
            },
          );
        }
      } else {
        await Future.delayed(const Duration(milliseconds: 1250));
        if (FFAppState().numTrialsDone < FFAppState().desiredTrialNum) {
          context.pushNamed(
            'MoreQuestionsPage',
            extra: <String, dynamic>{
              kTransitionInfoKey: TransitionInfo(
                hasTransition: true,
                transitionType: PageTransitionType.fade,
              ),
            },
          );
        } else {
          context.pushNamed(
            'play_finish',
            extra: <String, dynamic>{
              kTransitionInfoKey: TransitionInfo(
                hasTransition: true,
                transitionType: PageTransitionType.fade,
              ),
            },
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return StreamBuilder<List<ProblemsRecord>>(
      stream: queryProblemsRecord(
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
        List<ProblemsRecord> play1ProblemsRecordList = snapshot.data!;
        // Return an empty Container when the item does not exist.
        if (snapshot.data!.isEmpty) {
          return Container();
        }
        final play1ProblemsRecord = play1ProblemsRecordList.isNotEmpty
            ? play1ProblemsRecordList.first
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(0.0),
                  child: Image.asset(
                    'assets/images/iPad_Pro_12.9in__6.png',
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
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
