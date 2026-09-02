class ServicesUtils {
  final String name;
  final String icon;
  final List<String> tool;
  final String description;

  ServicesUtils(
      {required this.name,
      required this.icon,
      required this.description,
      required this.tool});
}

List<ServicesUtils> servicesUtils = [
  ServicesUtils(
    name: 'Android App Development',
    icon: 'assets/icons/android.svg',
    description:
        "Are you enthusiastic about creating an amazing mobile app? Let's turn it into a reality!",
    tool: ['Flutter'],
  ),
  ServicesUtils(
    name: 'iOS App Development',
    icon: 'assets/icons/apple.svg',
    description:
        "Are you enthusiastic about creating an amazing mobile app? Let's turn it into a reality!",
    tool: ['Flutter'],
  ),
  ServicesUtils(
    name: 'Web Development',
    icon: 'assets/icons/website.svg',
    description:
        "Do you possess an idea for your next exceptional web app? Let's transform it into a reality.",
    tool: ['Flutter'],
  ),
];
