import 'package:flutter/material.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:medical_waste/screens/login.dart';


class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  ValueNotifier<int> _currentPageNotifier = ValueNotifier<int>(0);

  final List<OnboardingItem> onboardingItems = [
    OnboardingItem(
      title: 'Welcome to Medical Waste App',
      description: 'Manage your medical waste efficiently.',
      image: 'assets/scalpel.png', 
    ),
    OnboardingItem(
      title: 'Track Your Waste',
      description: 'Easily track your waste disposal requests.',
      image: 'assets/syringe.png', 
    ),
    OnboardingItem(
      title: 'Get Started',
      description: 'Tap the button below to start using the app.',
      image: 'assets/test-tube.png', 
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     const pageCount = 3;


    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView.builder(
            controller: _pageController,
            itemCount: onboardingItems.length,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
                _currentPageNotifier.value = page;
              });
            },
            itemBuilder: (context, index) {
              return OnboardingScreen(
                item: onboardingItems[index],
              );
            },
          ),


          if (_currentPage < pageCount)
          Positioned(
            bottom: 250.0,
            left: 20.0,
            right: 20.0,
            child: PageViewDotIndicator(
              currentItem: _currentPage,
              count: pageCount,
              unselectedColor: Colors.black26,
              selectedColor: const Color.fromARGB(255, 0, 91, 64),
              duration: const Duration(milliseconds: 200),
              boxShape: BoxShape.circle,
              onItemClicked: (index) {
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),

            const SizedBox(
              height: 16,
              ),

          Positioned(
            bottom: 30.0,
            left: 20.0,
            right: 20.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                if (_currentPage > 0)
                  ElevatedButton(
                    onPressed: () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    child: const Text('Previous'),
                  ),
                ElevatedButton(
                  onPressed: () {
                    if (_currentPage < onboardingItems.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    } else {
                      // Navigate to the login page
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>  const LoginPage(),
                      ));
                    }
                  },
                  child: Text(
                    _currentPage == onboardingItems.length - 1
                        ? 'Login'
                        : 'Next',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



class OnboardingItem {
  final String title;
  final String description;
  final String image;

  OnboardingItem({
    required this.title,
    required this.description,
    required this.image,
  });
}

class OnboardingScreen extends StatelessWidget {
  final OnboardingItem item;

  const OnboardingScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          item.image,
          height: 200.0,
          width: 200.0,
        ),
        const SizedBox(height: 30.0),
        Text(
          item.title,
          style: const TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10.0),
        Text(
          item.description,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }
}

