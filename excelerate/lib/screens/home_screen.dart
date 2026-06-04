import 'package:flutter/material.dart';
import '../main.dart';
import 'program_listing_screen.dart';
import 'feedback_screen.dart';

class Announcement {
  final String title;
  final String date;
  final String description;
  final Color accentColor;
  const Announcement({required this.title, required this.date, required this.description, required this.accentColor});
}

class FeaturedProgram {
  final String title;
  final String company;
  final String duration;
  const FeaturedProgram({required this.title, required this.company, required this.duration});
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<Announcement> _announcements = const [
    Announcement(title: 'New Summer Internships Available', date: 'Today, 9:00 AM', description: 'Over 50 new positions added in Engineering.', accentColor: AppColors.primary),
    Announcement(title: 'Resume Workshop Reminder', date: 'Yesterday, 2:30 PM', description: 'Join us this Friday for a 1-on-1 resume review.', accentColor: AppColors.secondary),
  ];

  final List<FeaturedProgram> _featuredPrograms = const [
    FeaturedProgram(title: 'Frontend Developer', company: 'TechNova Inc.', duration: '3 Months'),
    FeaturedProgram(title: 'UX/UI Design Intern', company: 'Creative Studio', duration: '6 Months'),
  ];

  @override
  void initState() {
    super.initState();
    // Setup Modern Animations
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.background,
      // FIX: Added logic to actually show the Program Listing screen when index is 1
      body: _currentIndex == 1
          ? const ProgramListingScreen() 
          : SafeArea(
              child: _currentIndex == 2
                  ? _buildProfileView(textTheme)
                  : _buildAnimatedDashboard(textTheme),
            ),
      bottomNavigationBar: _buildCustomBottomNavBar(),
    );
  }

  Widget _buildAnimatedDashboard(TextTheme textTheme) {
    // Center and Contain the layout for Web/Desktop
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800), // Keeps content contained
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('Hello, Alex! 👋', style: textTheme.titleLarge?.copyWith(fontSize: 28, fontWeight: FontWeight.w800)),
                        const SizedBox(height: 4),
                        Text('Ready to excel today?', style: textTheme.bodyMedium?.copyWith(color: AppColors.text.withOpacity(0.7))),
                      ]),
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.primary, width: 2)),
                        child: const CircleAvatar(radius: 24, backgroundColor: AppColors.secondary, child: Icon(Icons.person, color: Colors.white, size: 28)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  
                  // Announcements Section
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text('Announcements', style: textTheme.titleLarge?.copyWith(fontSize: 20)),
                    TextButton(onPressed: () {}, child: Text('View All', style: TextStyle(color: AppColors.secondary, fontWeight: FontWeight.w600, fontSize: 14))),
                  ]),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 180,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _announcements.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 16),
                      itemBuilder: (context, index) {
                        final item = _announcements[index];
                        return _buildHoverCard(
                          child: SizedBox(
                            width: 300,
                            child: Card(
                              elevation: 2,
                              shadowColor: Colors.black12,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(children: [
                                      Container(width: 8, height: 8, decoration: BoxDecoration(color: item.accentColor, shape: BoxShape.circle)),
                                      const SizedBox(width: 8),
                                      Text(item.date, style: textTheme.bodyMedium?.copyWith(fontSize: 12, color: AppColors.text.withOpacity(0.6), fontWeight: FontWeight.w600)),
                                    ]),
                                    const SizedBox(height: 16),
                                    Text(item.title, style: textTheme.titleLarge?.copyWith(fontSize: 16, fontWeight: FontWeight.bold), maxLines: 2, overflow: TextOverflow.ellipsis),
                                    const SizedBox(height: 8),
                                    Expanded(child: Text(item.description, style: textTheme.bodyMedium?.copyWith(fontSize: 13, color: AppColors.text.withOpacity(0.8)), maxLines: 3, overflow: TextOverflow.ellipsis)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Featured Programs Section
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text('Featured Programs', style: textTheme.titleLarge?.copyWith(fontSize: 20)),
                    TextButton(onPressed: () => _onItemTapped(1), child: Text('Browse All', style: TextStyle(color: AppColors.secondary, fontWeight: FontWeight.w600, fontSize: 14))),
                  ]),
                  const SizedBox(height: 16),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _featuredPrograms.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final program = _featuredPrograms[index];
                      return _buildHoverCard(
                        child: Card(
                          elevation: 2,
                          shadowColor: Colors.black12,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () => _onItemTapped(1),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                children: [
                                  Container(width: 60, height: 60, decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.15), borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.business_center, color: AppColors.primary, size: 32)),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(program.title, style: textTheme.titleLarge?.copyWith(fontSize: 16, fontWeight: FontWeight.bold)),
                                        const SizedBox(height: 4),
                                        Text(program.company, style: textTheme.bodyMedium?.copyWith(color: AppColors.text.withOpacity(0.7))),
                                        const SizedBox(height: 12),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                          decoration: BoxDecoration(color: AppColors.secondary.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                                          child: Text(program.duration, style: textTheme.bodyMedium?.copyWith(fontSize: 12, color: AppColors.secondary, fontWeight: FontWeight.w600)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Icon(Icons.chevron_right, color: AppColors.text, size: 24),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 32),

                  // Submit Feedback Button
                  _buildHoverCard(
                    child: SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const FeedbackScreen()));
                        },
                        icon: const Icon(Icons.feedback_outlined, color: AppColors.secondary),
                        label: const Text('Submit Feedback', style: TextStyle(color: AppColors.secondary, fontWeight: FontWeight.w600, fontSize: 16)),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          side: const BorderSide(color: AppColors.secondary, width: 1.5),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Modern Hover Effect Widget (Works beautifully on Web/Desktop)
  Widget _buildHoverCard({required Widget child}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        child: child,
      ),
    );
  }

  Widget _buildProfileView(TextTheme textTheme) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(radius: 50, backgroundColor: AppColors.primary, child: Icon(Icons.person, size: 50, color: Colors.white)),
                const SizedBox(height: 16),
                Text('Alex Johnson', style: textTheme.titleLarge),
                const SizedBox(height: 8),
                Text('alex.johnson@excelerate.com', style: textTheme.bodyMedium),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                    icon: const Icon(Icons.logout),
                    label: const Text('Sign Out'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 16)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -4))],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavItem(0, Icons.home_outlined, Icons.home, 'Home'),
              _buildNavItem(1, Icons.explore_outlined, Icons.explore, 'Programs'),
              _buildNavItem(2, Icons.person_outline, Icons.person, 'Profile'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData inactiveIcon, IconData activeIcon, String label) {
    final bool isSelected = _currentIndex == index;
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () => _onItemTapped(index),
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withOpacity(0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(isSelected ? activeIcon : inactiveIcon, color: isSelected ? AppColors.primary : AppColors.text.withOpacity(0.5), size: 24),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(label, style: textTheme.bodyMedium?.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 14)),
            ],
          ],
        ),
      ),
    );
  }
}