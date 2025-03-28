import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

enum AccountType {
  user,
  ngo,
}

class AccountTypePage extends StatefulWidget {
  const AccountTypePage({super.key});

  @override
  State<AccountTypePage> createState() => _AccountTypePageState();
}

class _AccountTypePageState extends State<AccountTypePage> {
  AccountType? _selectedType;

  void _handleTypeSelection(AccountType type) {
    setState(() {
      _selectedType = type;
    });
    
    // Navigate to register page with the selected account type
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        context.go('/register', extra: type);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.go('/start'),
              ),
              const SizedBox(height: 24),
              Text(
                'Who are you?',
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Select your account type to continue',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: Column(
                  children: [
                    _buildTypeCard(
                      AccountType.user,
                      'User',
                      'I want to report waste spots and contribute to a cleaner environment',
                      Icons.person,
                    ),
                    const SizedBox(height: 16),
                    _buildTypeCard(
                      AccountType.ngo,
                      'NGO',
                      'I represent an organization working towards water conservation',
                      Icons.business,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTypeCard(
    AccountType type,
    String title,
    String description,
    IconData icon,
  ) {
    final isSelected = _selectedType == type;
    return GestureDetector(
      onTap: () => _handleTypeSelection(type),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue.shade100 : Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.blue : Colors.grey.shade600,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.blue : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 16,
                ),
              ),
          ],
        ),
      ),
    );
  }
} 