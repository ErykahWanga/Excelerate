import 'package:flutter/material.dart';
import '../main.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  
  String? _selectedCategory = 'General Feedback';
  bool _isSubmitting = false;

  final List<String> _categories = [
    'General Feedback',
    'Bug Report',
    'Feature Request',
    'Internship Experience',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitFeedback() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });

      // Simulate network request for form submission
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isSubmitting = false;
        });
        _showSuccessDialog();
      });
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, color: AppColors.primary, size: 24),
            ),
            const SizedBox(width: 12),
            const Text('Thank You!'),
          ],
        ),
        content: Text(
          'Your feedback has been successfully submitted. We appreciate your input and will review it shortly.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Navigator.of(context).pop(); // Close feedback screen
              },
              child: const Text('Done'),
            ),
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
        title: const Text('Submit Feedback'),
        elevation: 0,
        // Proper escape hatch: Close icon (X)
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.text),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Text(
                  'We value your input',
                  style: textTheme.titleLarge?.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Help us improve the Excelerate experience by sharing your thoughts, reporting issues, or suggesting new features.',
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.text.withOpacity(0.7),
                    height: 1.5,
                  ),
                ),
                
                const SizedBox(height: 32),

                // Category Dropdown
                Text(
                  'Feedback Category',
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  decoration: const InputDecoration(
                    hintText: 'Select a category',
                    prefixIcon: Icon(Icons.category_outlined, color: AppColors.secondary),
                  ),
                  items: _categories.map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCategory = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a category';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 24),

                // Name Input
                Text(
                  'Your Name',
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _nameController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: 'John Doe',
                    prefixIcon: Icon(Icons.person_outline, color: AppColors.secondary),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 24),

                // Email Input
                Text(
                  'Email Address',
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: 'john.doe@example.com',
                    prefixIcon: Icon(Icons.email_outlined, color: AppColors.secondary),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (!emailRegex.hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 24),

                // Message Input
                Text(
                  'Your Message',
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _messageController,
                  maxLines: 5,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    hintText: 'Tell us more about your experience...',
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(bottom: 40.0), // Align with top line of multiline
                      child: Icon(Icons.chat_bubble_outline, color: AppColors.secondary),
                    ),
                    alignLabelWithHint: true,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your feedback';
                    }
                    if (value.trim().length < 10) {
                      return 'Feedback must be at least 10 characters';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 40),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _isSubmitting ? null : _submitFeedback,
                    child: _isSubmitting
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Submit Feedback',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.send, size: 20),
                            ],
                          ),
                  ),
                ),
                
                const SizedBox(height: 24), // Bottom padding
              ],
            ),
          ),
        ),
      ),
    );
  }
}