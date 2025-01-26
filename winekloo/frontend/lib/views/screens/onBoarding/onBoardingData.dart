class OnboardingItem {
  final String imagePath;
  final String title;
  final String subtitle;

  OnboardingItem({
    required this.imagePath,
    required this.title,
    required this.subtitle,
  });
}

final List<OnboardingItem> onboardingItems = [
  OnboardingItem(
    imagePath: 'assets/images/onboarding_1.png',
    title: 'What Are You Craving?',
    subtitle: 'Tell us what you crave, we’ll take care of the rest.',
  ),
  OnboardingItem(
    imagePath: 'assets/images/onboarding_2.png',
    title: 'All Your Favorites',
    subtitle: 'All the spots that serve your favorite dishes, gathered in one place.',
  ),
  OnboardingItem(
    imagePath: 'assets/images/onboarding_3.png',
    title: 'Flavor Journey Awaits',
    subtitle: 'We’ll take you on a journey through flavors you don’t want to miss.',
  ),
  OnboardingItem(
    imagePath: 'assets/images/onboarding_4.png',
    title: 'Let the Tastes Begin!',
    subtitle: 'Let the Tastes Begin!',
  ),
];
