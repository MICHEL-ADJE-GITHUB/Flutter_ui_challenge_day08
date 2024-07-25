import 'package:day_8_app/Animations/fade_animation.dart';
import 'package:day_8_app/login_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Day 08 App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _scale2Controller;
  late AnimationController _widthController;
  late AnimationController _positionController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _scale2Animation;
  late Animation<double> _widthAnimation;
  late Animation<double> _positionAnimation;

  bool hideIcon = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.8,
    ).animate(_scaleController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _widthController.forward();
        }
      });

    _widthController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _widthAnimation = Tween<double>(
      begin: 80.0,
      end: 300.0,
    ).animate(_widthController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _positionController.forward();
        }
      });

    _positionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _positionAnimation = Tween<double>(
      begin: 0.0,
      end: 215.0,
    ).animate(_positionController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            hideIcon = true;
          });
          _scale2Controller.forward();
        }
      });

    _scale2Controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scale2Animation = Tween<double>(
      begin: 1.0,
      end: 32.0,
    ).animate(_scale2Controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                child: LoginPage(),
              ));
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(3, 9, 23, 1),
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              top: -50,
              left: 0,
              child: FadeAnimation(
                1,
                Container(
                  width: width,
                  height: 400,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('assets/images/one.png'),
                    fit: BoxFit.cover,
                  )),
                ),
              ),
            ),
            Positioned(
              top: -100,
              left: 0,
              child: FadeAnimation(
                1.3,
                Container(
                  width: width,
                  height: 400,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('assets/images/one.png'),
                    fit: BoxFit.cover,
                  )),
                ),
              ),
            ),
            Positioned(
              top: -150,
              left: 0,
              child: FadeAnimation(
                1.6,
                Container(
                  width: width,
                  height: 400,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('assets/images/one.png'),
                    fit: BoxFit.cover,
                  )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeAnimation(
                    1,
                    const Text(
                      'Welcome',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  FadeAnimation(
                    1.3,
                    Text(
                      "We promis that you'll have the most \nfuss-free time with us ever.",
                      style: TextStyle(
                          color: Colors.white.withOpacity(.7),
                          height: 1.4,
                          fontSize: 15),
                    ),
                  ),
                  const SizedBox(
                    height: 180,
                  ),
                  FadeAnimation(
                    1.6,
                    AnimatedBuilder(
                      animation: _scaleController,
                      builder: (context, child) => Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Center(
                          child: AnimatedBuilder(
                            animation: _widthController,
                            builder: (context, child) => Container(
                              padding: const EdgeInsets.all(10),
                              height: 80,
                              width: _widthAnimation.value,
                              decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(.4),
                                  borderRadius: BorderRadius.circular(50)),
                              child: InkWell(
                                onTap: () {
                                  _scaleController.forward();
                                },
                                child: Stack(
                                  children: [
                                    AnimatedBuilder(
                                      animation: _positionController,
                                      builder: (context, child) => Positioned(
                                        left: _positionAnimation.value,
                                        child: AnimatedBuilder(
                                          animation: _scale2Controller,
                                          builder: (context, child) =>
                                              Transform.scale(
                                            scale: _scale2Animation.value,
                                            child: Container(
                                              width: 60,
                                              height: 60,
                                              decoration: const BoxDecoration(
                                                color: Colors.blue,
                                                shape: BoxShape.circle,
                                              ),
                                              child: hideIcon == false
                                                  ? const Icon(
                                                      Icons.arrow_forward,
                                                      color: Colors.white,
                                                    )
                                                  : Container(),
                                            ),
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
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
