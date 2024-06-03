import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:go_router/go_router.dart';
import 'dart:math';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
as smooth_page_indicator;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
as smooth_page_indicator;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeModel extends FlutterFlowModel<HomeWidget> {
  final unfocusNode = FocusNode();
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  // State field(s) for Calendar widget.
  DateTimeRange? calendarSelectedDay;
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
      pageViewController!.hasClients &&
      pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;

  @override
  void initState(BuildContext context) {
    calendarSelectedDay = DateTimeRange(
      start: DateTime.now().startOfDay,
      end: DateTime.now().endOfDay,
    );
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    tabBarController?.dispose();
  }
}
class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> with TickerProviderStateMixin {
  late HomeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeModel());

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => setState(() {}));
    animationsMap.addAll({
      'iconOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effects: [
          MoveEffect(
            curve: Curves.easeInOut,
            delay: const Duration(milliseconds: 0),
            duration: const Duration(milliseconds: 600),
            begin: Offset(0.0, 0.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'buttonOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effects: [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: const Duration(milliseconds: 0),
            duration: const Duration(milliseconds: 600),
            color: const Color(0x80FFFFFF),
            angle: 0.524,
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
      anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: Color(0xFFF7F7F7),
          automaticallyImplyLeading: false,
          leading: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              Navigator.pushNamed(
                context,
                '/login',
                arguments: {
                  'transitionInfo': PageTransitionType.leftToRight,
                },
              );
            },
            child: Icon(
              Icons.login,
              color: Colors.black,
              size: 24,
            ),
          ).animateOnActionTrigger(
            animationsMap['iconOnActionTriggerAnimation']!,
          ),
          title: Align(
            alignment: AlignmentDirectional(0, 0),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 2, 0),
              child: Text(
                'Welcome, Sana',
                style: FlutterFlowTheme.of(context).titleLarge.override(
                  fontFamily: 'Poppins',
                  fontSize: 25,
                  letterSpacing: 0,
                ),
              ),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
              child: Icon(
                Icons.settings_outlined,//new
                color: Colors.black,
                size: 24,
              ),
            ),
          ],
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment(0, 0),
                            child: FlutterFlowButtonTabBar(
                              useToggleButtonStyle: false,
                              labelStyle: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                fontFamily: 'Poppins',
                                letterSpacing: 0,
                              ),
                              unselectedLabelStyle: TextStyle(),
                              labelColor:
                              FlutterFlowTheme.of(context).primaryText,
                              unselectedLabelColor:
                              FlutterFlowTheme.of(context).secondaryText,
                              backgroundColor: Color(0xFF4C06D5CD),
                              unselectedBackgroundColor:
                              FlutterFlowTheme.of(context).alternate,
                              borderColor: Color(0xFF06d5cd),
                              unselectedBorderColor:
                              FlutterFlowTheme.of(context).alternate,
                              borderWidth: 2,
                              borderRadius: 8,
                              elevation: 0,
                              labelPadding:
                              EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                              buttonMargin:
                              EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                              padding: EdgeInsets.all(4),
                              tabs: [
                                Tab(
                                  text: 'Medicines',
                                ),
                                Tab(
                                  text: 'Consultation',
                                ),
                              ],
                              controller: _model.tabBarController,
                              onTap: (i) async {
                                [() async {}, () async {}][i]();
                              },
                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                              controller: _model.tabBarController,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FlutterFlowCalendar(
                                      color: Color(0xFF06D5CD),
                                      iconColor: Color(0xFF101518),
                                      weekFormat: true,
                                      weekStartsMonday: true,
                                      onChange:
                                          (DateTimeRange? newSelectedDate) {
                                        setState(() =>
                                        _model.calendarSelectedDay =
                                            newSelectedDate);
                                      },
                                      titleStyle: FlutterFlowTheme.of(context)
                                          .headlineSmall
                                          .override(
                                        fontFamily: 'Poppins',
                                        color: Colors.black,
                                        letterSpacing: 0,
                                      ),
                                      dayOfWeekStyle:
                                      FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                        fontFamily: 'Poppins',
                                        color: Colors.black,
                                        letterSpacing: 0,
                                        lineHeight: 1,
                                      ),
                                      dateStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Poppins',
                                        color: Colors.black,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      selectedDateStyle:
                                      FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                        fontFamily: 'Poppins',
                                        letterSpacing: 0,
                                      ),
                                      inactiveDateStyle:
                                      FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                        fontFamily: 'Poppins',
                                        color: Colors.black,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              12, 0, 0, 0),
                                          child: Text(
                                            'Today\'s Medicine',
                                            style: FlutterFlowTheme.of(context)
                                                .titleLarge
                                                .override(
                                              fontFamily: 'Poppins',
                                              letterSpacing: 0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          18, 12, 18, 15),
                                      child: Container(
                                        width: 363,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFFFFFF),
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(18),
                                            bottomRight: Radius.circular(18),
                                            topLeft: Radius.circular(18),
                                            topRight: Radius.circular(18),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.circular(8),
                                                  child: Image.asset(
                                                    'assets/images/blue.JPG',
                                                    width: 99,
                                                    height: 100,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(10, 0, 0, 0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                    MainAxisSize.max,
                                                    children: [
                                                      Align(
                                                        alignment:
                                                        AlignmentDirectional(
                                                            -1, 0),
                                                        child: Padding(
                                                          padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(10,
                                                              6, 0, 5),
                                                          child: Text(
                                                            'Fluoxetine',
                                                            style: FlutterFlowTheme
                                                                .of(context)
                                                                .titleLarge
                                                                .override(
                                                              fontFamily:
                                                              'Poppins',
                                                              letterSpacing:
                                                              0,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Align(
                                                    alignment:
                                                    AlignmentDirectional(
                                                        -1, 0),
                                                    child: Padding(
                                                      padding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          10, 0, 0, 5),
                                                      child: Text(
                                                        'Capsule, 20mg',
                                                        style: FlutterFlowTheme
                                                            .of(context)
                                                            .titleMedium
                                                            .override(
                                                          fontFamily:
                                                          'Poppins',
                                                          color:
                                                          Colors.black,
                                                          fontSize: 15,
                                                          letterSpacing: 0,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                    AlignmentDirectional(
                                                        -1, 0),
                                                    child: Padding(
                                                      padding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          10, 0, 0, 0),
                                                      child: Text(
                                                        'Daily, 2 times a day',
                                                        style: FlutterFlowTheme
                                                            .of(context)
                                                            .titleMedium
                                                            .override(
                                                          fontFamily:
                                                          'Poppins',
                                                          color:
                                                          Colors.black,
                                                          fontSize: 15,
                                                          letterSpacing: 0,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          18, 12, 18, 15),
                                      child: Container(
                                        width: 363,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFFFFFF),
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(18),
                                            bottomRight: Radius.circular(18),
                                            topLeft: Radius.circular(18),
                                            topRight: Radius.circular(18),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.circular(8),
                                                  child: Image.asset(
                                                    'assets/images/green.JPG',
                                                    width: 99,
                                                    height: 100,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(10, 0, 0, 0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                    MainAxisSize.max,
                                                    children: [
                                                      Align(
                                                        alignment:
                                                        AlignmentDirectional(
                                                            -1, 0),
                                                        child: Padding(
                                                          padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(10,
                                                              6, 0, 5),
                                                          child: Text(
                                                            'Paracetamol',
                                                            style: FlutterFlowTheme
                                                                .of(context)
                                                                .titleLarge
                                                                .override(
                                                              fontFamily:
                                                              'Poppins',
                                                              letterSpacing:
                                                              0,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Align(
                                                    alignment:
                                                    AlignmentDirectional(
                                                        -1, 0),
                                                    child: Padding(
                                                      padding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          10, 0, 0, 5),
                                                      child: Text(
                                                        'Capsule, 500mg',
                                                        style: FlutterFlowTheme
                                                            .of(context)
                                                            .titleMedium
                                                            .override(
                                                          fontFamily:
                                                          'Poppins',
                                                          color:
                                                          Colors.black,
                                                          fontSize: 15,
                                                          letterSpacing: 0,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                    AlignmentDirectional(
                                                        -1, 0),
                                                    child: Padding(
                                                      padding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          10, 0, 0, 0),
                                                      child: Text(
                                                        'Daily, every 4 to 6 hours',
                                                        style: FlutterFlowTheme
                                                            .of(context)
                                                            .titleMedium
                                                            .override(
                                                          fontFamily:
                                                          'Poppins',
                                                          color:
                                                          Colors.black,
                                                          fontSize: 15,
                                                          letterSpacing: 0,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          18, 12, 18, 0),
                                      child: Container(
                                        width: 363,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFFFFFF),
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(18),
                                            bottomRight: Radius.circular(18),
                                            topLeft: Radius.circular(18),
                                            topRight: Radius.circular(18),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.circular(8),
                                                  child: Image.network(
                                                    'https://images.unsplash.com/photo-1590518563786-901882bf6f82?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwzfHxjb3VnaCUyMHN5cnVwfGVufDB8fHx8MTcxNzI5OTE2OHww&ixlib=rb-4.0.3&q=80&w=1080',
                                                    width: 99,
                                                    height: 100,
                                                    fit: BoxFit.fitHeight,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(10, 0, 0, 0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                    MainAxisSize.max,
                                                    children: [
                                                      Align(
                                                        alignment:
                                                        AlignmentDirectional(
                                                            -1, 0),
                                                        child: Padding(
                                                          padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(10,
                                                              6, 0, 5),
                                                          child: Text(
                                                            'Cough Syrup',
                                                            style: FlutterFlowTheme
                                                                .of(context)
                                                                .titleLarge
                                                                .override(
                                                              fontFamily:
                                                              'Poppins',
                                                              letterSpacing:
                                                              0,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Align(
                                                    alignment:
                                                    AlignmentDirectional(
                                                        -1, 0),
                                                    child: Padding(
                                                      padding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          10, 0, 0, 5),
                                                      child: Text(
                                                        'Mixture, 5mg',
                                                        style: FlutterFlowTheme
                                                            .of(context)
                                                            .titleMedium
                                                            .override(
                                                          fontFamily:
                                                          'Poppins',
                                                          color:
                                                          Colors.black,
                                                          fontSize: 15,
                                                          letterSpacing: 0,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                    AlignmentDirectional(
                                                        -1, 0),
                                                    child: Padding(
                                                      padding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          10, 0, 0, 0),
                                                      child: Text(
                                                        'Daily, 2 times a day',
                                                        style: FlutterFlowTheme
                                                            .of(context)
                                                            .titleMedium
                                                            .override(
                                                          fontFamily:
                                                          'Poppins',
                                                          color:
                                                          Colors.black,
                                                          fontSize: 15,
                                                          letterSpacing: 0,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 25, 10, 0),
                                      child: Container(
                                        width: 390,
                                        height: 66,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF4C06D5CD),
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(19),
                                            bottomRight: Radius.circular(19),
                                            topLeft: Radius.circular(19),
                                            topRight: Radius.circular(19),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(10, 0, 0, 0),
                                                  child: FlutterFlowIconButton(
                                                    borderColor:
                                                    Colors.transparent,
                                                    borderRadius: 20,
                                                    borderWidth: 1,
                                                    buttonSize: 65,
                                                    icon: Icon(
                                                      Icons.home_sharp,
                                                      color: Colors.black,
                                                      size: 25,
                                                    ),
                                                    onPressed: () async {
                                                      context.pushNamed('home');
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Align(
                                                  alignment:
                                                  AlignmentDirectional(
                                                      0, 0),
                                                  child: Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        70, 0, 70, 0),
                                                    child:
                                                    FlutterFlowIconButton(
                                                      borderColor:
                                                      Colors.transparent,
                                                      borderRadius: 60,
                                                      borderWidth: 1,
                                                      buttonSize: 65,
                                                      fillColor: Color(0xFF06d5cd),
                                                      icon: Icon(
                                                        Icons.add,
                                                        color:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .primaryText,
                                                        size: 35,
                                                      ),
                                                      onPressed: () {
                                                        print(
                                                            'IconButton pressed ...');
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(15, 0, 0, 0),
                                                  child: FlutterFlowIconButton(
                                                    borderColor:
                                                    Colors.transparent,
                                                    borderRadius: 20,
                                                    borderWidth: 1,
                                                    buttonSize: 65,
                                                    icon: Icon(
                                                      Icons
                                                          .manage_search_rounded,
                                                      color:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .primaryText,
                                                      size: 35,
                                                    ),
                                                    onPressed: () async {
                                                      context.pushNamed(
                                                        'sp',
                                                        extra: <String, dynamic>{
                                                          'arguments': {
                                                            'transitionInfo': PageTransitionType.rightToLeft,
                                                          },
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            width: double.infinity,
                                            height: 144,
                                            child: Stack(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(8, 12, 8, 40),
                                                  child: PageView(
                                                    controller: _model
                                                        .pageViewController ??=
                                                        PageController(
                                                            initialPage: 0),
                                                    scrollDirection:
                                                    Axis.horizontal,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(24),
                                                        child: Image.network(
                                                          'https://img.freepik.com/free-photo/doctor-suggesting-hospital-program-patient_53876-14806.jpg?size=626&ext=jpg',
                                                          width: 300,
                                                          height: 267,
                                                          fit: BoxFit.cover,
                                                          alignment:
                                                          Alignment(-1, -1),
                                                        ),
                                                      ),
                                                      ClipRRect(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(8),
                                                        child: Image.network(
                                                          'https://picsum.photos/seed/627/600',
                                                          width: 300,
                                                          height: 200,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      ClipRRect(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(8),
                                                        child: Image.network(
                                                          'https://picsum.photos/seed/422/600',
                                                          width: 300,
                                                          height: 200,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                  AlignmentDirectional(
                                                      -1, 1),
                                                  child: Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        150, 0, 0, 16),
                                                    child: smooth_page_indicator
                                                        .SmoothPageIndicator(
                                                      controller: _model
                                                          .pageViewController ??=
                                                          PageController(
                                                              initialPage: 0),
                                                      count: 3,
                                                      axisDirection:
                                                      Axis.horizontal,
                                                      onDotClicked: (i) async {
                                                        await _model
                                                            .pageViewController!
                                                            .animateToPage(
                                                          i,
                                                          duration: Duration(
                                                              milliseconds:
                                                              500),
                                                          curve: Curves.ease,
                                                        );
                                                        setState(() {});
                                                      },
                                                      effect: smooth_page_indicator
                                                          .ExpandingDotsEffect(
                                                        expansionFactor: 3,
                                                        spacing: 8,
                                                        radius: 16,
                                                        dotWidth: 16,
                                                        dotHeight: 8,
                                                        dotColor: Color(0xFF4c06d5cd),
                                                        activeDotColor:
                                                        Colors.black,
                                                        paintStyle:
                                                        PaintingStyle.fill,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(-1, 0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20, 0, 0, 12),
                                        child: Text(
                                          'Doctors Near Me',
                                          style: FlutterFlowTheme.of(context)
                                              .titleLarge
                                              .override(
                                            fontFamily: 'Poppins',
                                            fontSize: 23,
                                            letterSpacing: 0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              8, 0, 8, 15),
                                          child: Container(
                                            width: 375,
                                            height: 106,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                              BorderRadius.circular(24),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(2, 0, 2, 0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        0, 4, 0, 5),
                                                    child: Row(
                                                      mainAxisSize:
                                                      MainAxisSize.max,
                                                      children: [
                                                        Column(
                                                          mainAxisSize:
                                                          MainAxisSize.max,
                                                          children: [
                                                            Row(
                                                              mainAxisSize:
                                                              MainAxisSize
                                                                  .max,
                                                              children: [
                                                                Container(
                                                                  width: 40,
                                                                  height: 40,
                                                                  clipBehavior:
                                                                  Clip.antiAlias,
                                                                  decoration:
                                                                  BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/doc1.png',
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(10,
                                                              0, 0, 0),
                                                          child: Column(
                                                            mainAxisSize:
                                                            MainAxisSize
                                                                .max,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              Row(
                                                                mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                                children: [
                                                                  Text(
                                                                    'Dr. Emily Carter',
                                                                    style: FlutterFlowTheme.of(
                                                                        context)
                                                                        .displaySmall
                                                                        .override(
                                                                      fontFamily:
                                                                      'Poppins',
                                                                      fontSize:
                                                                      19,
                                                                      letterSpacing:
                                                                      0,
                                                                      fontWeight:
                                                                      FontWeight.normal,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                                children: [
                                                                  Text(
                                                                    'Neurologist',
                                                                    style: FlutterFlowTheme.of(
                                                                        context)
                                                                        .bodyMedium
                                                                        .override(
                                                                      fontFamily:
                                                                      'Poppins',
                                                                      letterSpacing:
                                                                      0,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                              137, 0, 0, 0),
                                                          child: Icon(
                                                            Icons.drag_indicator,
                                                            color:
                                                            Color(0xFF545454),
                                                            size: 35,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: Padding(
                                                      padding: EdgeInsetsDirectional
                                                          .fromSTEB(0, 0, 0, 11),
                                                      child: Row(
                                                        mainAxisSize:
                                                        MainAxisSize.max,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(11, 5,
                                                                10, 0),
                                                            child: FFButtonWidget(
                                                              onPressed: () {
                                                                print(
                                                                    'Button pressed ...');
                                                              },
                                                              text:
                                                              '⏱︎ 14 years',
                                                              options:
                                                              FFButtonOptions(
                                                                width: 113,
                                                                height: 30,
                                                                padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                    14,
                                                                    0,
                                                                    14,
                                                                    0),
                                                                iconPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                    0,
                                                                    0,
                                                                    0,
                                                                    0),
                                                                color: Colors
                                                                    .white,
                                                                textStyle: FlutterFlowTheme.of(
                                                                    context)
                                                                    .titleSmall
                                                                    .override(
                                                                  fontFamily:
                                                                  'Poppins',
                                                                  color: Color(
                                                                      0xFF030303),
                                                                  fontSize:
                                                                  15,
                                                                  letterSpacing:
                                                                  0,
                                                                ),
                                                                elevation: 5,
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    8),
                                                              ),
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment:
                                                            AlignmentDirectional(
                                                                0, 0),
                                                            child: Padding(
                                                              padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  4,
                                                                  5,
                                                                  10,
                                                                  0),
                                                              child:
                                                              FFButtonWidget(
                                                                onPressed: () {
                                                                  print(
                                                                      'Button pressed ...');
                                                                },
                                                                text: '↑ 90% ',
                                                                options:
                                                                FFButtonOptions(
                                                                  width: 64,
                                                                  height: 30,
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                      0,
                                                                      0,
                                                                      0,
                                                                      0),
                                                                  iconPadding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                      0,
                                                                      0,
                                                                      0,
                                                                      0),
                                                                  color: Color(
                                                                      0xFFFBFBFB),
                                                                  textStyle: FlutterFlowTheme.of(
                                                                      context)
                                                                      .titleSmall
                                                                      .override(
                                                                    fontFamily:
                                                                    'Poppins',
                                                                    color: Colors
                                                                        .black,
                                                                    letterSpacing:
                                                                    0,
                                                                  ),
                                                                  elevation: 5,
                                                                  borderSide:
                                                                  BorderSide(
                                                                    color: Colors
                                                                        .transparent,
                                                                    width: 1,
                                                                  ),
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      8),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Align(
                                                              alignment:
                                                              AlignmentDirectional(
                                                                  1, 0),
                                                              child: Padding(
                                                                padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                    0,
                                                                    5,
                                                                    9,
                                                                    0),
                                                                child:
                                                                FFButtonWidget(
                                                                  onPressed:
                                                                      () async {
                                                                    context.pushNamed(
                                                                        'doctor1');
                                                                  },
                                                                  text:
                                                                  '+ Appointment',
                                                                  options:
                                                                  FFButtonOptions(
                                                                    width: 159,
                                                                    height: 32,
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                        12,
                                                                        0,
                                                                        12,
                                                                        0),
                                                                    iconPadding:
                                                                    EdgeInsetsDirectional.fromSTEB(
                                                                        0,
                                                                        0,
                                                                        0,
                                                                        0),
                                                                    color: Colors
                                                                        .white,
                                                                    textStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                        .titleSmall
                                                                        .override(
                                                                      fontFamily:
                                                                      'Poppins',
                                                                      color:
                                                                      Colors.black,
                                                                      letterSpacing:
                                                                      0,
                                                                    ),
                                                                    elevation:
                                                                    5,
                                                                    borderSide:
                                                                    BorderSide(
                                                                      color: Colors
                                                                          .transparent,
                                                                      width: 1,
                                                                    ),
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(8),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8, 0, 8, 15),
                                      child: Container(
                                        width: 375,
                                        height: 106,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                          BorderRadius.circular(24),
                                        ),
                                        child: Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              2, 0, 2, 0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 4, 0, 5),
                                                child: Row(
                                                  mainAxisSize:
                                                  MainAxisSize.max,
                                                  children: [
                                                    Column(
                                                      mainAxisSize:
                                                      MainAxisSize.max,
                                                      children: [
                                                        Row(
                                                          mainAxisSize:
                                                          MainAxisSize.max,
                                                          children: [
                                                            Container(
                                                              width: 40,
                                                              height: 40,
                                                              clipBehavior: Clip
                                                                  .antiAlias,
                                                              decoration:
                                                              BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child:
                                                              Image.asset(
                                                                'assets/images/doc2.png',
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          10, 0, 0, 0),
                                                      child: Column(
                                                        mainAxisSize:
                                                        MainAxisSize.max,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Row(
                                                            mainAxisSize:
                                                            MainAxisSize
                                                                .max,
                                                            children: [
                                                              Text(
                                                                'Dr. James Benedict',
                                                                style: FlutterFlowTheme.of(
                                                                    context)
                                                                    .displaySmall
                                                                    .override(
                                                                  fontFamily:
                                                                  'Poppins',
                                                                  fontSize:
                                                                  19,
                                                                  letterSpacing:
                                                                  0,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisSize:
                                                            MainAxisSize
                                                                .max,
                                                            children: [
                                                              Text(
                                                                'Pediatrician',
                                                                style: FlutterFlowTheme.of(
                                                                    context)
                                                                    .bodyMedium
                                                                    .override(
                                                                  fontFamily:
                                                                  'Poppins',
                                                                  letterSpacing:
                                                                  0,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          100, 0, 0, 0),
                                                      child: Icon(
                                                        Icons.drag_indicator,
                                                        color:
                                                        Color(0xFF545454),
                                                        size: 35,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Flexible(
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 0, 11),
                                                  child: Row(
                                                    mainAxisSize:
                                                    MainAxisSize.max,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(11, 5,
                                                            10, 0),
                                                        child: FFButtonWidget(
                                                          onPressed: () {
                                                            print(
                                                                'Button pressed ...');
                                                          },
                                                          text: '⏱︎ 10 years',
                                                          options:
                                                          FFButtonOptions(
                                                            width: 113,
                                                            height: 30,
                                                            padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                14,
                                                                0,
                                                                14,
                                                                0),
                                                            iconPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                0,
                                                                0,
                                                                0,
                                                                0),
                                                            color: Colors.white,
                                                            textStyle:
                                                            FlutterFlowTheme.of(
                                                                context)
                                                                .titleSmall
                                                                .override(
                                                              fontFamily:
                                                              'Poppins',
                                                              color: Color(
                                                                  0xFF030303),
                                                              fontSize:
                                                              15,
                                                              letterSpacing:
                                                              0,
                                                            ),
                                                            elevation: 5,
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                8),
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                        AlignmentDirectional(
                                                            0, 0),
                                                        child: Padding(
                                                          padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(4,
                                                              5, 10, 0),
                                                          child: FFButtonWidget(
                                                            onPressed: () {
                                                              print(
                                                                  'Button pressed ...');
                                                            },
                                                            text: '↑ 76% ',
                                                            options:
                                                            FFButtonOptions(
                                                              width: 64,
                                                              height: 30,
                                                              padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  0,
                                                                  0,
                                                                  0,
                                                                  0),
                                                              iconPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  0,
                                                                  0,
                                                                  0,
                                                                  0),
                                                              color: Color(
                                                                  0xFFFBFBFB),
                                                              textStyle:
                                                              FlutterFlowTheme.of(
                                                                  context)
                                                                  .titleSmall
                                                                  .override(
                                                                fontFamily:
                                                                'Poppins',
                                                                color: Colors
                                                                    .black,
                                                                letterSpacing:
                                                                0,
                                                              ),
                                                              elevation: 5,
                                                              borderSide:
                                                              BorderSide(
                                                                color: Colors
                                                                    .transparent,
                                                                width: 1,
                                                              ),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  8),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Align(
                                                          alignment:
                                                          AlignmentDirectional(
                                                              1, 0),
                                                          child: Padding(
                                                            padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                0,
                                                                5,
                                                                9,
                                                                0),
                                                            child:
                                                            FFButtonWidget(
                                                              onPressed: () {
                                                                print(
                                                                    'Button pressed ...');
                                                              },
                                                              text:
                                                              '+ Appointment',
                                                              options:
                                                              FFButtonOptions(
                                                                width: 159,
                                                                height: 32,
                                                                padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                    12,
                                                                    0,
                                                                    12,
                                                                    0),
                                                                iconPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                    0,
                                                                    0,
                                                                    0,
                                                                    0),
                                                                color: Colors
                                                                    .white,
                                                                textStyle: FlutterFlowTheme.of(
                                                                    context)
                                                                    .titleSmall
                                                                    .override(
                                                                  fontFamily:
                                                                  'Poppins',
                                                                  color: Colors
                                                                      .black,
                                                                  letterSpacing:
                                                                  0,
                                                                ),
                                                                elevation: 5,
                                                                borderSide:
                                                                BorderSide(
                                                                  color: Colors
                                                                      .transparent,
                                                                  width: 1,
                                                                ),
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    8),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8, 0, 8, 15),
                                      child: Container(
                                        width: 375,
                                        height: 106,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                          BorderRadius.circular(24),
                                        ),
                                        child: Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              2, 0, 2, 0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 4, 0, 5),
                                                child: Row(
                                                  mainAxisSize:
                                                  MainAxisSize.max,
                                                  children: [
                                                    Column(
                                                      mainAxisSize:
                                                      MainAxisSize.max,
                                                      children: [
                                                        Row(
                                                          mainAxisSize:
                                                          MainAxisSize.max,
                                                          children: [
                                                            Container(
                                                              width: 40,
                                                              height: 40,
                                                              clipBehavior: Clip
                                                                  .antiAlias,
                                                              decoration:
                                                              BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child:
                                                              Image.asset(
                                                                'assets/images/doc3.png',
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          10, 0, 0, 0),
                                                      child: Column(
                                                        mainAxisSize:
                                                        MainAxisSize.max,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Row(
                                                            mainAxisSize:
                                                            MainAxisSize
                                                                .max,
                                                            children: [
                                                              Text(
                                                                'Dr. Abigail Robinson',
                                                                style: FlutterFlowTheme.of(
                                                                    context)
                                                                    .displaySmall
                                                                    .override(
                                                                  fontFamily:
                                                                  'Poppins',
                                                                  fontSize:
                                                                  19,
                                                                  letterSpacing:
                                                                  0,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisSize:
                                                            MainAxisSize
                                                                .max,
                                                            children: [
                                                              Text(
                                                                'Cardiologist',
                                                                style: FlutterFlowTheme.of(
                                                                    context)
                                                                    .bodyMedium
                                                                    .override(
                                                                  fontFamily:
                                                                  'Poppins',
                                                                  letterSpacing:
                                                                  0,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          95, 0, 0, 0),
                                                      child: Icon(
                                                        Icons.drag_indicator,
                                                        color:
                                                        Color(0xFF545454),
                                                        size: 35,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Flexible(
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 0, 11),
                                                  child: Row(
                                                    mainAxisSize:
                                                    MainAxisSize.max,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(11, 5,
                                                            10, 0),
                                                        child: FFButtonWidget(
                                                          onPressed: () {
                                                            print(
                                                                'Button pressed ...');
                                                          },
                                                          text: '⏱︎ 25 years',
                                                          options:
                                                          FFButtonOptions(
                                                            width: 113,
                                                            height: 30,
                                                            padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                14,
                                                                0,
                                                                14,
                                                                0),
                                                            iconPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                0,
                                                                0,
                                                                0,
                                                                0),
                                                            color: Colors.white,
                                                            textStyle:
                                                            FlutterFlowTheme.of(
                                                                context)
                                                                .titleSmall
                                                                .override(
                                                              fontFamily:
                                                              'Poppins',
                                                              color: Color(
                                                                  0xFF030303),
                                                              fontSize:
                                                              15,
                                                              letterSpacing:
                                                              0,
                                                            ),
                                                            elevation: 5,
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                8),
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                        AlignmentDirectional(
                                                            0, 0),
                                                        child: Padding(
                                                          padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(4,
                                                              5, 10, 0),
                                                          child: FFButtonWidget(
                                                            onPressed: () {
                                                              print(
                                                                  'Button pressed ...');
                                                            },
                                                            text: '↑ 80% ',
                                                            options:
                                                            FFButtonOptions(
                                                              width: 64,
                                                              height: 30,
                                                              padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  0,
                                                                  0,
                                                                  0,
                                                                  0),
                                                              iconPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  0,
                                                                  0,
                                                                  0,
                                                                  0),
                                                              color: Color(
                                                                  0xFFFBFBFB),
                                                              textStyle:
                                                              FlutterFlowTheme.of(
                                                                  context)
                                                                  .titleSmall
                                                                  .override(
                                                                fontFamily:
                                                                'Poppins',
                                                                color: Colors
                                                                    .black,
                                                                letterSpacing:
                                                                0,
                                                              ),
                                                              elevation: 5,
                                                              borderSide:
                                                              BorderSide(
                                                                color: Colors
                                                                    .transparent,
                                                                width: 1,
                                                              ),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  8),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Align(
                                                          alignment:
                                                          AlignmentDirectional(
                                                              1, 0),
                                                          child: Padding(
                                                            padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                0,
                                                                5,
                                                                9,
                                                                0),
                                                            child:
                                                            FFButtonWidget(
                                                              onPressed: () {
                                                                print(
                                                                    'Button pressed ...');
                                                              },
                                                              text:
                                                              '+ Appointment',
                                                              options:
                                                              FFButtonOptions(
                                                                width: 159,
                                                                height: 32,
                                                                padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                    12,
                                                                    0,
                                                                    12,
                                                                    0),
                                                                iconPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                    0,
                                                                    0,
                                                                    0,
                                                                    0),
                                                                color: Colors
                                                                    .white,
                                                                textStyle: FlutterFlowTheme.of(
                                                                    context)
                                                                    .titleSmall
                                                                    .override(
                                                                  fontFamily:
                                                                  'Poppins',
                                                                  color: Colors
                                                                      .black,
                                                                  letterSpacing:
                                                                  0,
                                                                ),
                                                                elevation: 5,
                                                                borderSide:
                                                                BorderSide(
                                                                  color: Colors
                                                                      .transparent,
                                                                  width: 1,
                                                                ),
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    8),
                                                              ),
                                                            ).animateOnActionTrigger(
                                                              animationsMap[
                                                              'buttonOnActionTriggerAnimation']!,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 0, 10, 0),
                                      child: Container(
                                        width: 390,
                                        height: 66,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF4c06d5cd),
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(19),
                                            bottomRight: Radius.circular(19),
                                            topLeft: Radius.circular(19),
                                            topRight: Radius.circular(19),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(10, 0, 0, 0),
                                                  child: FlutterFlowIconButton(
                                                    borderColor:
                                                    Colors.transparent,
                                                    borderRadius: 20,
                                                    borderWidth: 1,
                                                    buttonSize: 65,
                                                    icon: Icon(
                                                      Icons.home_sharp,
                                                      color:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .primaryText,
                                                      size: 25,
                                                    ),
                                                    onPressed: () async {
                                                      context.pushNamed('home');
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Align(
                                                  alignment:
                                                  AlignmentDirectional(
                                                      0, 0),
                                                  child: Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        70, 0, 70, 0),
                                                    child:
                                                    FlutterFlowIconButton(
                                                      borderColor:
                                                      Colors.transparent,
                                                      borderRadius: 60,
                                                      borderWidth: 1,
                                                      buttonSize: 65,
                                                      fillColor: Color(0xFF06d5cd),
                                                      icon: Icon(
                                                        Icons.add,
                                                        color: Colors.black,
                                                        size: 35,
                                                      ),
                                                      onPressed: () {
                                                        print(
                                                            'IconButton pressed ...');
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(15, 0, 0, 0),
                                                  child: FlutterFlowIconButton(
                                                    borderColor:
                                                    Colors.transparent,
                                                    borderRadius: 20,
                                                    borderWidth: 1,
                                                    buttonSize: 65,
                                                    icon: Icon(
                                                      Icons
                                                          .manage_search_rounded,
                                                      color:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .primaryText,
                                                      size: 35,
                                                    ),
                                                    onPressed: () async {
                                                      context.pushNamed(
                                                        'null',
                                                        extra: <String, dynamic>{
                                                          'transitionInfo': PageTransitionType.rightToLeft,
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
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
            ],
          ),
        ),
      ),
    );
  }
}
