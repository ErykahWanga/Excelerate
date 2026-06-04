import 'package:flutter/material.dart';
import '../main.dart';
import '../models/program.dart'; // Imports the shared model
import 'program_details_screen.dart';

class ProgramListingScreen extends StatefulWidget {
  const ProgramListingScreen({super.key});

  @override
  State<ProgramListingScreen> createState() => _ProgramListingScreenState();
}

class _ProgramListingScreenState extends State<ProgramListingScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Remote', 'On-site', 'Hybrid', 'Part-time'];

  final List<Program> _allPrograms = const [
    Program(id: '1', title: 'Frontend Developer Intern', company: 'TechNova Inc.', location: 'San Francisco, CA', type: 'Hybrid', duration: '3 Months', salary: '\$25/hr', description: 'Build scalable web applications using React and Flutter.'),
    Program(id: '2', title: 'UX/UI Design Intern', company: 'Creative Studio', location: 'New York, NY', type: 'On-site', duration: '6 Months', salary: '\$22/hr', description: 'Design intuitive user interfaces and conduct user research.'),
    Program(id: '3', title: 'Data Science Intern', company: 'DataFlow Analytics', location: 'Remote', type: 'Remote', duration: '4 Months', salary: '\$30/hr', description: 'Analyze large datasets and build predictive models.'),
    Program(id: '4', title: 'Marketing Intern', company: 'Growth Hackers', location: 'Austin, TX', type: 'Part-time', duration: '3 Months', salary: '\$18/hr', description: 'Assist in developing and executing digital marketing campaigns.'),
    Program(id: '5', title: 'Backend Engineer Intern', company: 'CloudScale Systems', location: 'Remote', type: 'Remote', duration: '6 Months', salary: '\$28/hr', description: 'Develop and maintain RESTful APIs and microservices.'),
  ];

  List<Program> get _filteredPrograms {
    return _allPrograms.where((program) {
      final matchesSearch = program.title.toLowerCase().contains(_searchController.text.toLowerCase()) ||
          program.company.toLowerCase().contains(_searchController.text.toLowerCase());
      final matchesFilter = _selectedFilter == 'All' || program.type == _selectedFilter || (_selectedFilter == 'Part-time' && program.type == 'Part-time');
      return matchesSearch && matchesFilter;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Explore Programs'), elevation: 0),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
            color: AppColors.background,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _searchController,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: 'Search by role or company...',
                    prefixIcon: const Icon(Icons.search, color: AppColors.secondary),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(icon: const Icon(Icons.clear, color: AppColors.text), onPressed: () { _searchController.clear(); setState(() {}); })
                        : null,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _filters.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final filter = _filters[index];
                      final isSelected = _selectedFilter == filter;
                      return FilterChip(
                        label: Text(filter, style: TextStyle(color: isSelected ? Colors.white : AppColors.text, fontWeight: FontWeight.w600, fontSize: 14)),
                        selected: isSelected,
                        onSelected: (bool selected) { setState(() { _selectedFilter = selected ? filter : 'All'; }); },
                        backgroundColor: AppColors.surface,
                        selectedColor: AppColors.primary,
                        checkmarkColor: Colors.white,
                        elevation: isSelected ? 4 : 0,
                        shadowColor: Colors.black12,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: isSelected ? AppColors.primary : const Color(0xFFE0E0E0), width: 1),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFE0E0E0)),
          Expanded(
            child: _filteredPrograms.isEmpty
                ? _buildEmptyState(textTheme)
                : ListView.separated(
                    padding: const EdgeInsets.all(20),
                    itemCount: _filteredPrograms.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final program = _filteredPrograms[index];
                      return _buildProgramCard(program, textTheme);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgramCard(Program program, TextTheme textTheme) {
    return Card(
      elevation: 2,
      shadowColor: Colors.black12,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProgramDetailsScreen(program: program)),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 56, height: 56,
                    decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.15), borderRadius: BorderRadius.circular(12)),
                    child: Center(child: Text(program.company.substring(0, 1).toUpperCase(), style: textTheme.titleLarge?.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold))),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(program.title, style: textTheme.titleLarge?.copyWith(fontSize: 16, fontWeight: FontWeight.bold), maxLines: 2, overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 4),
                        Text(program.company, style: textTheme.bodyMedium?.copyWith(color: AppColors.text.withOpacity(0.7))),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8, runSpacing: 8,
                children: [
                  _buildTag(program.type, AppColors.secondary),
                  _buildTag(program.duration, AppColors.text.withOpacity(0.7)),
                  _buildTag(program.salary, AppColors.text.withOpacity(0.7)),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 18, color: AppColors.secondary),
                      const SizedBox(width: 4),
                      Text(program.location, style: textTheme.bodyMedium?.copyWith(fontSize: 13, color: AppColors.text.withOpacity(0.8))),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(8)),
                    child: const Row(mainAxisSize: MainAxisSize.min, children: [
                      Text('View', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                      SizedBox(width: 4),
                      Icon(Icons.arrow_forward, size: 16, color: Colors.white),
                    ]),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTag(String label, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(8), border: Border.all(color: const Color(0xFFE0E0E0))),
      child: Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: textColor)),
    );
  }

  Widget _buildEmptyState(TextTheme textTheme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off_outlined, size: 64, color: AppColors.text.withOpacity(0.3)),
            const SizedBox(height: 16),
            Text('No programs found', style: textTheme.titleLarge?.copyWith(color: AppColors.text.withOpacity(0.7))),
            const SizedBox(height: 8),
            Text('Try adjusting your search or filters.', textAlign: TextAlign.center, style: textTheme.bodyMedium?.copyWith(color: AppColors.text.withOpacity(0.5))),
          ],
        ),
      ),
    );
  }
} // <-- THIS CLOSING BRACE WAS MISSING BEFORE