import 'package:flutter/material.dart';
import '../main.dart';
import '../models/program.dart'; // Imports the shared model

class ProgramDetailsScreen extends StatelessWidget {
  final Program program;

  const ProgramDetailsScreen({super.key, required this.program});

  void _handleApply(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Row(
          children: [
            Icon(Icons.check_circle, color: AppColors.primary, size: 28),
            const SizedBox(width: 12),
            const Text('Application Sent!'),
          ],
        ),
        content: Text(
          'Your application for ${program.title} at ${program.company} has been successfully submitted.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: const Text('Awesome', style: TextStyle(color: AppColors.secondary, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Program Details'),
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppColors.text), onPressed: () => Navigator.of(context).pop()),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, color: AppColors.text),
            onPressed: () { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Share coming soon'))); },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Card(
                    elevation: 2,
                    shadowColor: Colors.black12,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: const LinearGradient(colors: [AppColors.primary, AppColors.secondary], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                                child: const Icon(Icons.business_center, color: Colors.white, size: 32),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(program.company, style: textTheme.bodyMedium?.copyWith(color: Colors.white.withOpacity(0.9), fontWeight: FontWeight.w600)),
                                    const SizedBox(height: 4),
                                    Text(program.title, style: textTheme.titleLarge?.copyWith(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Wrap(
                            spacing: 12, runSpacing: 12,
                            children: [
                              _buildHeaderTag(Icons.location_on_outlined, program.location),
                              _buildHeaderTag(Icons.access_time_outlined, program.duration),
                              _buildHeaderTag(Icons.attach_money_outlined, program.salary),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text('About the Role', style: textTheme.titleLarge?.copyWith(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Text(program.description, style: textTheme.bodyMedium?.copyWith(height: 1.6, color: AppColors.text.withOpacity(0.8))),
                  const SizedBox(height: 24),
                  Text('Requirements', style: textTheme.titleLarge?.copyWith(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Card(
                    elevation: 1,
                    shadowColor: Colors.black12,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildRequirementItem(context, 'Currently enrolled in a relevant degree program.'),
                          const SizedBox(height: 12),
                          _buildRequirementItem(context, 'Strong foundational knowledge in required technologies.'),
                          const SizedBox(height: 12),
                          _buildRequirementItem(context, 'Excellent communication and teamwork skills.'),
                          const SizedBox(height: 12),
                          _buildRequirementItem(context, 'Ability to commit to the full ${program.duration.toLowerCase()} duration.'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text('Perks & Benefits', style: textTheme.titleLarge?.copyWith(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildBenefitChip('Mentorship'),
                      const SizedBox(width: 8),
                      _buildBenefitChip('Flexible Hours'),
                      const SizedBox(width: 8),
                      _buildBenefitChip('Networking'),
                    ],
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            decoration: BoxDecoration(
              color: AppColors.surface,
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -4))],
            ),
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => _handleApply(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 2,
                  ),
                  child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text('Apply Now', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, size: 20),
                  ]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderTag(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: Colors.white.withOpacity(0.9)),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
      ],
    );
  }

  Widget _buildRequirementItem(BuildContext context, String text) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(margin: const EdgeInsets.only(top: 6), width: 6, height: 6, decoration: const BoxDecoration(color: AppColors.secondary, shape: BoxShape.circle)),
        const SizedBox(width: 12),
        Expanded(child: Text(text, style: textTheme.bodyMedium?.copyWith(height: 1.5, color: AppColors.text.withOpacity(0.8)))),
      ],
    );
  }

  Widget _buildBenefitChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
      ),
      child: Text(label, style: const TextStyle(color: AppColors.secondary, fontWeight: FontWeight.w600, fontSize: 13)),
    );
  }
}