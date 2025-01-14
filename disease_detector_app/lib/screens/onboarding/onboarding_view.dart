import 'package:disease_detector_app/storage/check_first_install.dart';
import 'package:disease_detector_app/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../config/themes/color.dart';
import '../login/login_screen.dart';
import 'onboarding_items.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final controller = OnboardingItems();
  final pageController = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    final bool dark = HelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomSheet: Container(
        color: dark ? AppColor.dark : AppColor.light,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: isLastPage ? getStarted() : buildBottomNavigation(),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: PageView.builder(
          onPageChanged: (index) =>
              setState(() => isLastPage = controller.items.length - 1 == index),
          itemCount: controller.items.length,
          controller: pageController,
          itemBuilder: (context, index) {
            return buildPageContent(index);
          },
        ),
      ),
    );
  }

  Widget buildBottomNavigation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () =>
              pageController.jumpToPage(controller.items.length - 1),
          child: const Text("Skip"),
        ),
        SmoothPageIndicator(
          controller: pageController,
          count: controller.items.length,
          onDotClicked: (index) => pageController.animateToPage(index,
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeIn),
          effect: const WormEffect(
            dotHeight: 12,
            dotWidth: 12,
            activeDotColor: AppColor.primary,
          ),
        ),
        TextButton(
          onPressed: () => pageController.nextPage(
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeIn),
          child: const Text("Next"),
        ),
      ],
    );
  }

  Widget buildPageContent(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(controller.items[index].image),
        const SizedBox(height: 15),
        Text(
          controller.items[index].title,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        Text(
          controller.items[index].descriptions,
          style: const TextStyle(color: Colors.grey, fontSize: 17),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget getStarted() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: AppColor.primary),
      width: MediaQuery.of(context).size.width * .9,
      height: 55,
      child: TextButton(
        onPressed: () {
          CheckFirstInstall.setFirstInstall();
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginScreen()));
        },
        child: const Text(
          "Get started",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
