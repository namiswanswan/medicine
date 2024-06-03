import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginModel extends FlutterFlowModel<LoginWidget> {
  final unfocusNode = FocusNode();
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  // State field(s) for emailAddress_Create widget.
  FocusNode? emailAddressCreateFocusNode;
  TextEditingController? emailAddressCreateTextController;
  String? Function(BuildContext, String?)?
  emailAddressCreateTextControllerValidator;
  // State field(s) for password_Create widget.
  FocusNode? passwordCreateFocusNode;
  TextEditingController? passwordCreateTextController;
  late bool passwordCreateVisibility;
  String? Function(BuildContext, String?)?
  passwordCreateTextControllerValidator;
  // State field(s) for emailAddress widget.
  FocusNode? emailAddressFocusNode;
  TextEditingController? emailAddressTextController;
  String? Function(BuildContext, String?)? emailAddressTextControllerValidator;
  // State field(s) for password widget.
  FocusNode? passwordFocusNode;
  TextEditingController? passwordTextController;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? passwordTextControllerValidator;

  @override
  void initState(BuildContext context) {
    passwordCreateVisibility = false;
    passwordVisibility = false;
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    tabBarController?.dispose();
    emailAddressCreateFocusNode?.dispose();
    emailAddressCreateTextController?.dispose();

    passwordCreateFocusNode?.dispose();
    passwordCreateTextController?.dispose();

    emailAddressFocusNode?.dispose();
    emailAddressTextController?.dispose();

    passwordFocusNode?.dispose();
    passwordTextController?.dispose();
  }
}

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget>
    with TickerProviderStateMixin {
  late LoginModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null; // The user canceled the sign-in
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoginModel());

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => setState(() {}));
    _model.emailAddressCreateTextController ??= TextEditingController();
    _model.emailAddressCreateFocusNode ??= FocusNode();

    _model.passwordCreateTextController ??= TextEditingController();
    _model.passwordCreateFocusNode ??= FocusNode();

    _model.emailAddressTextController ??= TextEditingController();
    _model.emailAddressFocusNode ??= FocusNode();

    _model.passwordTextController ??= TextEditingController();
    _model.passwordFocusNode ??= FocusNode();
    animationsMap.addAll({
      'containerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effects: [
          VisibilityEffect(duration: 1.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 400.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 400.0.ms,
            begin: Offset(0.0, 80.0),
            end: Offset(0.0, 0.0),
          ),
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 150.0.ms,
            duration: 400.0.ms,
            begin: Offset(0.8, 0.8),
            end: Offset(1.0, 1.0),
          ),
        ],
      ),
      'columnOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effects: [
          VisibilityEffect(duration: 300.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 300.0.ms,
            duration: 400.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 300.0.ms,
            duration: 400.0.ms,
            begin: Offset(0.0, 20.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'buttonOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effects: [
          TiltEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(0, 0),
            end: Offset(0, -0.349),
          ),
        ],
      ),
      'columnOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effects: [
          VisibilityEffect(duration: 300.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 300.0.ms,
            duration: 400.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 300.0.ms,
            duration: 400.0.ms,
            begin: Offset(0.0, 20.0),
            end: Offset(0.0, 0.0),
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
        backgroundColor: Colors.white,
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(32, 12, 32, 32),
                child: Container(
                  width: double.infinity,
                  height: 230,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: AlignmentDirectional(0, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 60),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/images/loginmed.png',
                        width: 392,
                        height: 362,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, -1),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 170, 0, 0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(12),
                          child: Container(
                            width: double.infinity,
                            height: MediaQuery.sizeOf(context).width >= 768.0
                                ? 530.0
                                : 630.0,
                            constraints: BoxConstraints(
                              maxWidth: 570,
                            ),
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4,
                                  color: Color(0x33000000),
                                  offset: Offset(
                                    0,
                                    2,
                                  ),
                                )
                              ],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                width: 2,
                              ),
                            ),
                            child: Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment(0, 0),
                                    child: TabBar(
                                      isScrollable: true,
                                      labelColor: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      unselectedLabelColor:
                                      FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      labelPadding:
                                      EdgeInsetsDirectional.fromSTEB(
                                          32, 0, 32, 0),
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .override(
                                        fontFamily: 'Readex Pro',
                                        letterSpacing: 0,
                                      ),
                                      unselectedLabelStyle:
                                      FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .override(
                                        fontFamily: 'Readex Pro',
                                        letterSpacing: 0,
                                      ),
                                      indicatorColor: Color(0xFF42BEFF),
                                      indicatorWeight: 3,
                                      tabs: [
                                        Tab(
                                          text: 'Login',
                                        ),
                                        Tab(
                                          text: 'Sign Up',
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
                                        Align(
                                          alignment:
                                          AlignmentDirectional(0, -1),
                                          child: Padding(
                                            padding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                24, 16, 24, 0),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  if (responsiveVisibility(
                                                    context: context,
                                                    phone: false,
                                                    tablet: false,
                                                  ))
                                                    Container(
                                                      width: 230,
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                            .of(context)
                                                            .secondaryBackground,
                                                      ),
                                                    ),
                                                  Text(
                                                    'Create Account',
                                                    textAlign: TextAlign.start,
                                                    style: FlutterFlowTheme.of(
                                                        context)
                                                        .headlineMedium
                                                        .override(
                                                      fontFamily: 'Poppins',
                                                      letterSpacing: 0,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        0, 4, 0, 24),
                                                    child: Text(
                                                      'Fill out the information below in order to access your account.',
                                                      textAlign:
                                                      TextAlign.start,
                                                      style: FlutterFlowTheme
                                                          .of(context)
                                                          .labelMedium
                                                          .override(
                                                        fontFamily:
                                                        'Poppins',
                                                        letterSpacing: 0,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        0, 0, 0, 16),
                                                    child: Container(
                                                      width: double.infinity,
                                                      child: TextFormField(
                                                        controller: _model
                                                            .emailAddressCreateTextController,
                                                        focusNode: _model
                                                            .emailAddressCreateFocusNode,
                                                        autofocus: true,
                                                        autofillHints: [
                                                          AutofillHints.email
                                                        ],
                                                        obscureText: false,
                                                        decoration:
                                                        InputDecoration(
                                                          labelText: 'Email',
                                                          labelStyle:
                                                          FlutterFlowTheme.of(
                                                              context)
                                                              .labelLarge
                                                              .override(
                                                            fontFamily:
                                                            'Poppins',
                                                            letterSpacing:
                                                            0,
                                                          ),
                                                          enabledBorder:
                                                          OutlineInputBorder(
                                                            borderSide:
                                                            BorderSide(
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .alternate,
                                                              width: 2,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                40),
                                                          ),
                                                          focusedBorder:
                                                          OutlineInputBorder(
                                                            borderSide:
                                                            BorderSide(
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .primary,
                                                              width: 2,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                40),
                                                          ),
                                                          errorBorder:
                                                          OutlineInputBorder(
                                                            borderSide:
                                                            BorderSide(
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .error,
                                                              width: 2,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                40),
                                                          ),
                                                          focusedErrorBorder:
                                                          OutlineInputBorder(
                                                            borderSide:
                                                            BorderSide(
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .error,
                                                              width: 2,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                40),
                                                          ),
                                                          filled: true,
                                                          fillColor: FlutterFlowTheme
                                                              .of(context)
                                                              .secondaryBackground,
                                                          contentPadding:
                                                          EdgeInsets.all(
                                                              24),
                                                        ),
                                                        style: FlutterFlowTheme
                                                            .of(context)
                                                            .bodyLarge
                                                            .override(
                                                          fontFamily:
                                                          'Poppins',
                                                          letterSpacing: 0,
                                                        ),
                                                        keyboardType:
                                                        TextInputType
                                                            .emailAddress,
                                                        validator: _model
                                                            .emailAddressCreateTextControllerValidator
                                                            .asValidator(
                                                            context),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        0, 0, 0, 16),
                                                    child: Container(
                                                      width: double.infinity,
                                                      child: TextFormField(
                                                        controller: _model
                                                            .passwordCreateTextController,
                                                        focusNode: _model
                                                            .passwordCreateFocusNode,
                                                        autofocus: true,
                                                        autofillHints: [
                                                          AutofillHints.password
                                                        ],
                                                        obscureText: !_model
                                                            .passwordCreateVisibility,
                                                        decoration:
                                                        InputDecoration(
                                                          labelText: 'Password',
                                                          labelStyle:
                                                          FlutterFlowTheme.of(
                                                              context)
                                                              .labelLarge
                                                              .override(
                                                            fontFamily:
                                                            'Poppins',
                                                            letterSpacing:
                                                            0,
                                                          ),
                                                          enabledBorder:
                                                          OutlineInputBorder(
                                                            borderSide:
                                                            BorderSide(
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .alternate,
                                                              width: 2,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                40),
                                                          ),
                                                          focusedBorder:
                                                          OutlineInputBorder(
                                                            borderSide:
                                                            BorderSide(
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .primary,
                                                              width: 2,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                40),
                                                          ),
                                                          errorBorder:
                                                          OutlineInputBorder(
                                                            borderSide:
                                                            BorderSide(
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .error,
                                                              width: 2,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                40),
                                                          ),
                                                          focusedErrorBorder:
                                                          OutlineInputBorder(
                                                            borderSide:
                                                            BorderSide(
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .error,
                                                              width: 2,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                40),
                                                          ),
                                                          filled: true,
                                                          fillColor: FlutterFlowTheme
                                                              .of(context)
                                                              .secondaryBackground,
                                                          contentPadding:
                                                          EdgeInsets.all(
                                                              24),
                                                          suffixIcon: InkWell(
                                                            onTap: () =>
                                                                setState(
                                                                      () => _model
                                                                      .passwordCreateVisibility =
                                                                  !_model
                                                                      .passwordCreateVisibility,
                                                                ),
                                                            focusNode: FocusNode(
                                                                skipTraversal:
                                                                true),
                                                            child: Icon(
                                                              _model.passwordCreateVisibility
                                                                  ? Icons
                                                                  .visibility_outlined
                                                                  : Icons
                                                                  .visibility_off_outlined,
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .secondaryText,
                                                              size: 24,
                                                            ),
                                                          ),
                                                        ),
                                                        style: FlutterFlowTheme
                                                            .of(context)
                                                            .bodyLarge
                                                            .override(
                                                          fontFamily:
                                                          'Poppins',
                                                          letterSpacing: 0,
                                                        ),
                                                        validator: _model
                                                            .passwordCreateTextControllerValidator
                                                            .asValidator(
                                                            context),
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
                                                          0, 0, 0, 16),
                                                      child: FFButtonWidget(
                                                        onPressed: () async {
                                                        Navigator.pushNamed(context, '/home');
                                                        },
                                                        text: 'Login',
                                                        options:
                                                        FFButtonOptions(
                                                          width: 230,
                                                          height: 52,
                                                          padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(0,
                                                              0, 0, 0),
                                                          iconPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(0,
                                                              0, 0, 0),
                                                          color: Colors.black,
                                                          textStyle:
                                                          FlutterFlowTheme.of(
                                                              context)
                                                              .titleSmall
                                                              .override(
                                                            fontFamily:
                                                            'Readex Pro',
                                                            color: Colors
                                                                .white,
                                                            letterSpacing:
                                                            0,
                                                          ),
                                                          elevation: 3,
                                                          borderSide:
                                                          BorderSide(
                                                            color: Colors
                                                                .transparent,
                                                            width: 1,
                                                          ),
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(40),
                                                        ),
                                                      ).animateOnActionTrigger(
                                                        animationsMap[
                                                        'buttonOnActionTriggerAnimation']!,
                                                      ),
                                                    ),
                                                  ),
                                                  Column(
                                                    mainAxisSize:
                                                    MainAxisSize.max,
                                                    children: [
                                                      Align(
                                                        alignment:
                                                        AlignmentDirectional(
                                                            0, 0),
                                                        child: Padding(
                                                          padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                              16,
                                                              0,
                                                              16,
                                                              24),
                                                          child: Text(
                                                            'Or sign in with',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: FlutterFlowTheme
                                                                .of(context)
                                                                .labelMedium
                                                                .override(
                                                              fontFamily:
                                                              'Readex Pro',
                                                              letterSpacing:
                                                              0,
                                                            ),
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
                                                              .fromSTEB(0,
                                                              0, 0, 10),
                                                          child: Wrap(
                                                            spacing: 16,
                                                            runSpacing: 0,
                                                            alignment:
                                                            WrapAlignment
                                                                .center,
                                                            crossAxisAlignment:
                                                            WrapCrossAlignment
                                                                .center,
                                                            direction:
                                                            Axis.horizontal,
                                                            runAlignment:
                                                            WrapAlignment
                                                                .center,
                                                            verticalDirection:
                                                            VerticalDirection
                                                                .down,
                                                            clipBehavior:
                                                            Clip.none,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                    0,
                                                                    0,
                                                                    0,
                                                                    16),
                                                                //a
                                                                child:
                                                                FFButtonWidget(
                                                                  onPressed: () async {
                                                                    final User? user = await _signInWithGoogle();
                                                                    if (user != null) {
                                                                      context.go('/home');
                                                                    }
                                                                  },
                                                                  //b
                                                                  text:
                                                                  'Continue with Google',
                                                                  icon: FaIcon(
                                                                    FontAwesomeIcons
                                                                        .google,
                                                                    size: 20,
                                                                  ),
                                                                  options:
                                                                  FFButtonOptions(
                                                                    width: 230,
                                                                    height: 44,
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                        0,
                                                                        0,
                                                                        0,
                                                                        0),
                                                                    iconPadding:
                                                                    EdgeInsetsDirectional.fromSTEB(
                                                                        0,
                                                                        0,
                                                                        0,
                                                                        0),
                                                                    color: FlutterFlowTheme.of(
                                                                        context)
                                                                        .secondaryBackground,
                                                                    textStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                        .bodyMedium
                                                                        .override(
                                                                      fontFamily:
                                                                      'Poppins',
                                                                      letterSpacing:
                                                                      0,
                                                                      fontWeight:
                                                                      FontWeight.bold,
                                                                    ),
                                                                    elevation:
                                                                    0,
                                                                    borderSide:
                                                                    BorderSide(
                                                                      color: FlutterFlowTheme.of(
                                                                          context)
                                                                          .alternate,
                                                                      width: 2,
                                                                    ),
                                                                    borderRadius:
                                                                    BorderRadius.circular(
                                                                        40),
                                                                    hoverColor:
                                                                    FlutterFlowTheme.of(context)
                                                                        .primaryBackground,
                                                                  ),
                                                                ),
                                                              ),
                                                              isAndroid
                                                                  ? Container()
                                                                  : Padding(
                                                                padding: EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                    0,
                                                                    0,
                                                                    0,
                                                                    8),
                                                                child:
                                                                FFButtonWidget(
                                                                  onPressed:
                                                                      () async {
                                                                  },
                                                                  text:
                                                                  'Continue with Apple',
                                                                  icon:
                                                                  FaIcon(
                                                                    FontAwesomeIcons
                                                                        .apple,
                                                                    size:
                                                                    20,
                                                                  ),
                                                                  options:
                                                                  FFButtonOptions(
                                                                    width:
                                                                    230,
                                                                    height:
                                                                    44,
                                                                    padding: EdgeInsetsDirectional.fromSTEB(
                                                                        0,
                                                                        0,
                                                                        0,
                                                                        0),
                                                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                                                        0,
                                                                        0,
                                                                        0,
                                                                        0),
                                                                    color:
                                                                    FlutterFlowTheme.of(context).secondaryBackground,
                                                                    textStyle: FlutterFlowTheme.of(context)
                                                                        .bodyMedium
                                                                        .override(
                                                                      fontFamily: 'Readex Pro',
                                                                      letterSpacing: 0,
                                                                      fontWeight: FontWeight.bold,
                                                                    ),
                                                                    elevation:
                                                                    0,
                                                                    borderSide:
                                                                    BorderSide(
                                                                      color:
                                                                      FlutterFlowTheme.of(context).alternate,
                                                                      width:
                                                                      2,
                                                                    ),
                                                                    borderRadius:
                                                                    BorderRadius.circular(40),
                                                                    hoverColor:
                                                                    FlutterFlowTheme.of(context).primaryBackground,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
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
                                                              .fromSTEB(0,
                                                              0, 0, 12),
                                                          child: FFButtonWidget(
                                                            onPressed:
                                                                () async {
                                                            },
                                                            text:
                                                            'Forgot Password?',
                                                            options:
                                                            FFButtonOptions(
                                                              height: 44,
                                                              padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  32,
                                                                  0,
                                                                  32,
                                                                  0),
                                                              iconPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  0,
                                                                  0,
                                                                  0,
                                                                  0),
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .secondaryBackground,
                                                              textStyle:
                                                              FlutterFlowTheme.of(
                                                                  context)
                                                                  .bodyMedium
                                                                  .override(
                                                                fontFamily:
                                                                'Readex Pro',
                                                                letterSpacing:
                                                                0,
                                                                fontWeight:
                                                                FontWeight.bold,
                                                              ),
                                                              elevation: 0,
                                                              borderSide:
                                                              BorderSide(
                                                                color: FlutterFlowTheme.of(
                                                                    context)
                                                                    .secondaryBackground,
                                                                width: 2,
                                                              ),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  40),
                                                              hoverColor:
                                                              FlutterFlowTheme.of(
                                                                  context)
                                                                  .primaryBackground,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ).animateOnPageLoad(animationsMap[
                                            'columnOnPageLoadAnimation1']!),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                          AlignmentDirectional(0, -1),
                                          child: Padding(
                                            padding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                24, 16, 24, 0),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  if (responsiveVisibility(
                                                    context: context,
                                                    phone: false,
                                                    tablet: false,
                                                  ))
                                                    Container(
                                                      width: 230,
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                            .of(context)
                                                            .secondaryBackground,
                                                      ),
                                                    ),
                                                  Text(
                                                    'Welcome Back',
                                                    textAlign: TextAlign.start,
                                                    style: FlutterFlowTheme.of(
                                                        context)
                                                        .headlineMedium
                                                        .override(
                                                      fontFamily: 'Outfit',
                                                      letterSpacing: 0,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        0, 4, 0, 24),
                                                    child: Text(
                                                      'Let\'s get started by filling out the form below.',
                                                      textAlign:
                                                      TextAlign.start,
                                                      style: FlutterFlowTheme
                                                          .of(context)
                                                          .labelMedium
                                                          .override(
                                                        fontFamily:
                                                        'Readex Pro',
                                                        letterSpacing: 0,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        0, 0, 0, 16),
                                                    child: Container(
                                                      width: double.infinity,
                                                      child: TextFormField(
                                                        controller: _model
                                                            .emailAddressTextController,
                                                        focusNode: _model
                                                            .emailAddressFocusNode,
                                                        autofocus: true,
                                                        autofillHints: [
                                                          AutofillHints.email
                                                        ],
                                                        obscureText: false,
                                                        decoration:
                                                        InputDecoration(
                                                          labelText: 'Email',
                                                          labelStyle:
                                                          FlutterFlowTheme.of(
                                                              context)
                                                              .labelLarge
                                                              .override(
                                                            fontFamily:
                                                            'Readex Pro',
                                                            letterSpacing:
                                                            0,
                                                          ),
                                                          enabledBorder:
                                                          OutlineInputBorder(
                                                            borderSide:
                                                            BorderSide(
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .primaryBackground,
                                                              width: 2,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                40),
                                                          ),
                                                          focusedBorder:
                                                          OutlineInputBorder(
                                                            borderSide:
                                                            BorderSide(
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .primary,
                                                              width: 2,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                40),
                                                          ),
                                                          errorBorder:
                                                          OutlineInputBorder(
                                                            borderSide:
                                                            BorderSide(
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .alternate,
                                                              width: 2,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                40),
                                                          ),
                                                          focusedErrorBorder:
                                                          OutlineInputBorder(
                                                            borderSide:
                                                            BorderSide(
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .alternate,
                                                              width: 2,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                40),
                                                          ),
                                                          filled: true,
                                                          fillColor: FlutterFlowTheme
                                                              .of(context)
                                                              .secondaryBackground,
                                                          contentPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                              24,
                                                              24,
                                                              0,
                                                              24),
                                                        ),
                                                        style: FlutterFlowTheme
                                                            .of(context)
                                                            .bodyLarge
                                                            .override(
                                                          fontFamily:
                                                          'Readex Pro',
                                                          letterSpacing: 0,
                                                        ),
                                                        keyboardType:
                                                        TextInputType
                                                            .emailAddress,
                                                        validator: _model
                                                            .emailAddressTextControllerValidator
                                                            .asValidator(
                                                            context),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        0, 0, 0, 16),
                                                    child: Container(
                                                      width: double.infinity,
                                                      child: TextFormField(
                                                        controller: _model
                                                            .passwordTextController,
                                                        focusNode: _model
                                                            .passwordFocusNode,
                                                        autofocus: true,
                                                        autofillHints: [
                                                          AutofillHints.password
                                                        ],
                                                        obscureText: !_model
                                                            .passwordVisibility,
                                                        decoration:
                                                        InputDecoration(
                                                          labelText: 'Password',
                                                          labelStyle:
                                                          FlutterFlowTheme.of(
                                                              context)
                                                              .labelLarge
                                                              .override(
                                                            fontFamily:
                                                            'Readex Pro',
                                                            letterSpacing:
                                                            0,
                                                          ),
                                                          enabledBorder:
                                                          OutlineInputBorder(
                                                            borderSide:
                                                            BorderSide(
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .alternate,
                                                              width: 2,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                40),
                                                          ),
                                                          focusedBorder:
                                                          OutlineInputBorder(
                                                            borderSide:
                                                            BorderSide(
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .primary,
                                                              width: 2,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                40),
                                                          ),
                                                          errorBorder:
                                                          OutlineInputBorder(
                                                            borderSide:
                                                            BorderSide(
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .error,
                                                              width: 2,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                40),
                                                          ),
                                                          focusedErrorBorder:
                                                          OutlineInputBorder(
                                                            borderSide:
                                                            BorderSide(
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .error,
                                                              width: 2,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                40),
                                                          ),
                                                          filled: true,
                                                          fillColor: FlutterFlowTheme
                                                              .of(context)
                                                              .secondaryBackground,
                                                          contentPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                              24,
                                                              24,
                                                              0,
                                                              24),
                                                          suffixIcon: InkWell(
                                                            onTap: () =>
                                                                setState(
                                                                      () => _model
                                                                      .passwordVisibility =
                                                                  !_model
                                                                      .passwordVisibility,
                                                                ),
                                                            focusNode: FocusNode(
                                                                skipTraversal:
                                                                true),
                                                            child: Icon(
                                                              _model.passwordVisibility
                                                                  ? Icons
                                                                  .visibility_outlined
                                                                  : Icons
                                                                  .visibility_off_outlined,
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .secondaryText,
                                                              size: 24,
                                                            ),
                                                          ),
                                                        ),
                                                        style: FlutterFlowTheme
                                                            .of(context)
                                                            .bodyLarge
                                                            .override(
                                                          fontFamily:
                                                          'Readex Pro',
                                                          letterSpacing: 0,
                                                        ),
                                                        validator: _model
                                                            .passwordTextControllerValidator
                                                            .asValidator(
                                                            context),
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
                                                          0, 0, 0, 16),
                                                      child: FFButtonWidget(
                                                        onPressed: () async {

                                                        },
                                                        text: 'Sign Up',
                                                        options:
                                                        FFButtonOptions(
                                                          width: 230,
                                                          height: 52,
                                                          padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(0,
                                                              0, 0, 0),
                                                          iconPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(0,
                                                              0, 0, 0),
                                                          color:
                                                          Color(0xFF070707),
                                                          textStyle:
                                                          FlutterFlowTheme.of(
                                                              context)
                                                              .titleSmall
                                                              .override(
                                                            fontFamily:
                                                            'Readex Pro',
                                                            color: Colors
                                                                .white,
                                                            letterSpacing:
                                                            0,
                                                          ),
                                                          elevation: 3,
                                                          borderSide:
                                                          BorderSide(
                                                            color: Colors
                                                                .transparent,
                                                            width: 1,
                                                          ),
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(40),
                                                        ),
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
                                                          .fromSTEB(16, 0,
                                                          16, 24),
                                                      child: Text(
                                                        'Or sign in with',
                                                        textAlign:
                                                        TextAlign.center,
                                                        style: FlutterFlowTheme
                                                            .of(context)
                                                            .labelMedium
                                                            .override(
                                                          fontFamily:
                                                          'Readex Pro',
                                                          letterSpacing: 0,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                    AlignmentDirectional(
                                                        0, 0),
                                                    child: Wrap(
                                                      spacing: 16,
                                                      runSpacing: 0,
                                                      alignment:
                                                      WrapAlignment.center,
                                                      crossAxisAlignment:
                                                      WrapCrossAlignment
                                                          .center,
                                                      direction:
                                                      Axis.horizontal,
                                                      runAlignment:
                                                      WrapAlignment.center,
                                                      verticalDirection:
                                                      VerticalDirection
                                                          .down,
                                                      clipBehavior: Clip.none,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(0,
                                                              0, 0, 16),
                                                          child: FFButtonWidget(
                                                            onPressed:
                                                                () async {
                                                            },
                                                            text:
                                                            'Continue with Google',
                                                            icon: FaIcon(
                                                              FontAwesomeIcons
                                                                  .google,
                                                              size: 20,
                                                            ),
                                                            options:
                                                            FFButtonOptions(
                                                              width: 230,
                                                              height: 44,
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
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .secondaryBackground,
                                                              textStyle:
                                                              FlutterFlowTheme.of(
                                                                  context)
                                                                  .bodyMedium
                                                                  .override(
                                                                fontFamily:
                                                                'Poppins',
                                                                letterSpacing:
                                                                0,
                                                                fontWeight:
                                                                FontWeight.bold,
                                                              ),
                                                              elevation: 0,
                                                              borderSide:
                                                              BorderSide(
                                                                color: FlutterFlowTheme.of(
                                                                    context)
                                                                    .alternate,
                                                                width: 2,
                                                              ),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  40),
                                                              hoverColor:
                                                              FlutterFlowTheme.of(
                                                                  context)
                                                                  .primaryBackground,
                                                            ),
                                                          ),
                                                        ),
                                                        isAndroid
                                                            ? Container()
                                                            : Padding(
                                                          padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                              0,
                                                              0,
                                                              0,
                                                              16),
                                                          child:
                                                          FFButtonWidget(
                                                            onPressed:
                                                                () async {
                                                            },
                                                            text:
                                                            'Continue with Apple',
                                                            icon: FaIcon(
                                                              FontAwesomeIcons
                                                                  .apple,
                                                              size: 20,
                                                            ),
                                                            options:
                                                            FFButtonOptions(
                                                              width: 230,
                                                              height: 44,
                                                              padding: EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  0,
                                                                  0,
                                                                  0,
                                                                  0),
                                                              iconPadding:
                                                              EdgeInsetsDirectional.fromSTEB(
                                                                  0,
                                                                  0,
                                                                  0,
                                                                  0),
                                                              color: FlutterFlowTheme.of(
                                                                  context)
                                                                  .secondaryBackground,
                                                              textStyle: FlutterFlowTheme.of(
                                                                  context)
                                                                  .bodyMedium
                                                                  .override(
                                                                fontFamily:
                                                                'Poppins',
                                                                letterSpacing:
                                                                0,
                                                                fontWeight:
                                                                FontWeight.bold,
                                                              ),
                                                              elevation:
                                                              0,
                                                              borderSide:
                                                              BorderSide(
                                                                color: FlutterFlowTheme.of(
                                                                    context)
                                                                    .alternate,
                                                                width: 2,
                                                              ),
                                                              borderRadius:
                                                              BorderRadius.circular(
                                                                  40),
                                                              hoverColor:
                                                              FlutterFlowTheme.of(context)
                                                                  .primaryBackground,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
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
                                                          0, 0, 0, 16),
                                                      child: FFButtonWidget(
                                                        onPressed: () async {
                                                        },
                                                        text:
                                                        'Forgot Password?',
                                                        options:
                                                        FFButtonOptions(
                                                          height: 44,
                                                          padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(32,
                                                              0, 32, 0),
                                                          iconPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(0,
                                                              0, 0, 0),
                                                          color: FlutterFlowTheme
                                                              .of(context)
                                                              .secondaryBackground,
                                                          textStyle:
                                                          FlutterFlowTheme.of(
                                                              context)
                                                              .bodyMedium
                                                              .override(
                                                            fontFamily:
                                                            'Poppins',
                                                            letterSpacing:
                                                            0,
                                                            fontWeight:
                                                            FontWeight
                                                                .bold,
                                                          ),
                                                          elevation: 0,
                                                          borderSide:
                                                          BorderSide(
                                                            color: FlutterFlowTheme
                                                                .of(context)
                                                                .secondaryBackground,
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(40),
                                                          hoverColor:
                                                          FlutterFlowTheme.of(
                                                              context)
                                                              .primaryBackground,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ).animateOnPageLoad(animationsMap[
                                            'columnOnPageLoadAnimation2']!),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ).animateOnPageLoad(
                              animationsMap['containerOnPageLoadAnimation']!),
                        ),
                      ],
                    ),
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
