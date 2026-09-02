class ProjectUtils {
  final String banners;
  final String icons;
  final String titles;
  final String description;
  final String links;
  ProjectUtils({
    required this.banners,
    required this.icons,
    required this.titles,
    required this.description,
    required this.links,
  });
}

List<ProjectUtils> projectUtils = [
  ProjectUtils(
    banners: 'assets/imgs/02.png',
    icons: 'assets/imgs/Expense.png',
    titles: 'The Ultimate Expense Tracker Application',
    description: 'The Expense Tracker App proves to be a truly remarkable solution for managing your financial outlays.',
    links: 'https://play.google.com/store/apps/details?id=com.hichembenabadji.Expensetracker',
  ),
  ProjectUtils(
    banners: 'assets/imgs/1.png',
    icons: 'assets/imgs/Quiz.png',
    titles: 'Fantastic Dice Roller Application',
    description: 'Experience randomness with our 2D dice rolling app!',
    links: 'https://play.google.com/store/apps/details?id=com.HichemBenabadji.DiceRoller',
  ),
  ProjectUtils(
    banners: 'assets/imgs/03.png',
    icons: 'assets/imgs/QuizFootbal.png',
    titles: 'The Football Quiz Application',
    description: 'Test your knowledge, challenge friends, and become a football quiz champion.',
    links: 'https://play.google.com/store/apps/details?id=com.hichembenabadji.FootbalQuiz',
  ),
  ProjectUtils(
    banners: 'assets/imgs/04.png',
    icons: 'assets/imgs/QuizCultural.png',
    titles: 'Quiz Cultural Application',
    description: 'Learn about cultures worldwide with our fun quiz application',
    links: 'https://play.google.com/store/apps/details?id=com.hichembenabadji.QuizCultural',
  ),
];
