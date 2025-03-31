import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'account_type_page.dart';

class RegisterPage extends StatefulWidget {
  final AccountType accountType;

  const RegisterPage({
    super.key,
    required this.accountType,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();
  bool _isLoading = false;

  // NGO specific fields
  final _ngoNameController = TextEditingController();
  final _ngoRegNumberController = TextEditingController();
  final _ngoEmailController = TextEditingController();
  final _ngoPhoneController = TextEditingController();
  final _ngoPasswordController = TextEditingController();
  final _ngoConfirmPasswordController = TextEditingController();
  final _ngoTypeController = TextEditingController();
  final _ngoFounderController = TextEditingController();
  final _ngoYearController = TextEditingController();
  final _ngoCityController = TextEditingController();
  final _ngoStateController = TextEditingController();
  final _ngoWebsiteController = TextEditingController();
  final _ngoMissionController = TextEditingController();

  // User specific fields
  final _userNameController = TextEditingController();
  final _userEmailController = TextEditingController();
  final _userPhoneController = TextEditingController();
  final _userPasswordController = TextEditingController();
  final _userConfirmPasswordController = TextEditingController();
  final _userCityController = TextEditingController();
  final _userStateController = TextEditingController();
  final _userPinController = TextEditingController();
  final _userOccupationController = TextEditingController();

  final List<String> _ngoTypes = [
    'Environmental',
    'Water Conservation',
    'Marine Life Protection',
    'Waste Management',
    'Other',
  ];

  final List<String> _occupations = [
    'Student',
    'Professional',
    'Business Owner',
    'Government Employee',
    'Other',
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    _ngoNameController.dispose();
    _ngoRegNumberController.dispose();
    _ngoEmailController.dispose();
    _ngoPhoneController.dispose();
    _ngoPasswordController.dispose();
    _ngoConfirmPasswordController.dispose();
    _ngoTypeController.dispose();
    _ngoFounderController.dispose();
    _ngoYearController.dispose();
    _ngoCityController.dispose();
    _ngoStateController.dispose();
    _ngoWebsiteController.dispose();
    _ngoMissionController.dispose();
    _userNameController.dispose();
    _userEmailController.dispose();
    _userPhoneController.dispose();
    _userPasswordController.dispose();
    _userConfirmPasswordController.dispose();
    _userCityController.dispose();
    _userStateController.dispose();
    _userPinController.dispose();
    _userOccupationController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      
      // Simulate registration process
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() => _isLoading = false);
          context.go('/success');
        }
      });
    }
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
                onPressed: () => context.go('/account-type'),
              ),
              const SizedBox(height: 24),
              Text(
                'Create ${widget.accountType == AccountType.user ? 'User' : 'NGO'} Account',
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Join us in making a difference',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        if (widget.accountType == AccountType.ngo) ...[
                          _buildNGOForm(),
                        ] else ...[
                          _buildUserForm(),
                        ],
                        const SizedBox(height: 24),
                        _buildLoginButton(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNGOForm() {
    return Column(
      children: [
        _buildSectionTitle('Basic Details'),
        TextFormField(
          controller: _ngoNameController,
          decoration: InputDecoration(
            labelText: 'NGO Name',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            prefixIcon: const Icon(Icons.business),
          ),
          validator: (value) => value?.isEmpty ?? true ? 'Please enter NGO name' : null,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _ngoRegNumberController,
          decoration: InputDecoration(
            labelText: 'Registration Number',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            prefixIcon: const Icon(Icons.numbers),
          ),
          validator: (value) => value?.isEmpty ?? true ? 'Please enter registration number' : null,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _ngoEmailController,
          decoration: InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            prefixIcon: const Icon(Icons.email),
          ),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value?.isEmpty ?? true) return 'Please enter email';
            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)) {
              return 'Please enter a valid email';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _ngoPhoneController,
          decoration: InputDecoration(
            labelText: 'Phone Number',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            prefixIcon: const Icon(Icons.phone),
          ),
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value?.isEmpty ?? true) return 'Please enter phone number';
            if (value!.length != 10) return 'Phone number must be 10 digits';
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _ngoPasswordController,
          decoration: InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            prefixIcon: const Icon(Icons.lock),
          ),
          obscureText: true,
          validator: (value) {
            if (value?.isEmpty ?? true) return 'Please enter password';
            if (value!.length < 6) return 'Password must be at least 6 characters';
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _ngoConfirmPasswordController,
          decoration: InputDecoration(
            labelText: 'Confirm Password',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            prefixIcon: const Icon(Icons.lock_outline),
          ),
          obscureText: true,
          validator: (value) {
            if (value?.isEmpty ?? true) return 'Please confirm password';
            if (value != _ngoPasswordController.text) return 'Passwords do not match';
            return null;
          },
        ),
        const SizedBox(height: 24),
        _buildSectionTitle('Organization Details'),
        DropdownButtonFormField<String>(
          value: _ngoTypeController.text.isEmpty ? null : _ngoTypeController.text,
          decoration: InputDecoration(
            labelText: 'NGO Type',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            prefixIcon: const Icon(Icons.category),
          ),
          items: _ngoTypes.map((type) {
            return DropdownMenuItem(
              value: type,
              child: Text(type),
            );
          }).toList(),
          onChanged: (value) {
            setState(() => _ngoTypeController.text = value ?? '');
          },
          validator: (value) => value?.isEmpty ?? true ? 'Please select NGO type' : null,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _ngoFounderController,
          decoration: InputDecoration(
            labelText: 'Founder Name',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            prefixIcon: const Icon(Icons.person),
          ),
          validator: (value) => value?.isEmpty ?? true ? 'Please enter founder name' : null,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _ngoYearController,
          decoration: InputDecoration(
            labelText: 'Established Year',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            prefixIcon: const Icon(Icons.calendar_today),
          ),
          keyboardType: TextInputType.number,
          validator: (value) => value?.isEmpty ?? true ? 'Please enter established year' : null,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _ngoCityController,
          decoration: InputDecoration(
            labelText: 'City',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            prefixIcon: const Icon(Icons.location_city),
          ),
          validator: (value) => value?.isEmpty ?? true ? 'Please enter city' : null,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _ngoStateController,
          decoration: InputDecoration(
            labelText: 'State',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            prefixIcon: const Icon(Icons.location_city),
          ),
          validator: (value) => value?.isEmpty ?? true ? 'Please enter state' : null,
        ),
        const SizedBox(height: 24),
        _buildSectionTitle('Verification Details'),
        TextFormField(
          controller: _ngoWebsiteController,
          decoration: InputDecoration(
            labelText: 'Website URL (Optional)',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            prefixIcon: const Icon(Icons.language),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _ngoMissionController,
          decoration: InputDecoration(
            labelText: 'Mission Statement',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            prefixIcon: const Icon(Icons.description),
          ),
          maxLines: 3,
          validator: (value) => value?.isEmpty ?? true ? 'Please enter mission statement' : null,
        ),
        const SizedBox(height: 24),
        _buildRegisterButton(),
      ],
    );
  }

  Widget _buildUserForm() {
    return Column(
      children: [
        _buildSectionTitle('Basic Details'),
        TextFormField(
          controller: _userNameController,
          decoration: InputDecoration(
            labelText: 'Full Name',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            prefixIcon: const Icon(Icons.person),
          ),
          validator: (value) => value?.isEmpty ?? true ? 'Please enter your name' : null,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _userEmailController,
          decoration: InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            prefixIcon: const Icon(Icons.email),
          ),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value?.isEmpty ?? true) return 'Please enter email';
            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)) {
              return 'Please enter a valid email';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _userPhoneController,
          decoration: InputDecoration(
            labelText: 'Phone Number',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            prefixIcon: const Icon(Icons.phone),
          ),
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value?.isEmpty ?? true) return 'Please enter phone number';
            if (value!.length != 10) return 'Phone number must be 10 digits';
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _userPasswordController,
          decoration: InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            prefixIcon: const Icon(Icons.lock),
          ),
          obscureText: true,
          validator: (value) {
            if (value?.isEmpty ?? true) return 'Please enter password';
            if (value!.length < 6) return 'Password must be at least 6 characters';
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _userConfirmPasswordController,
          decoration: InputDecoration(
            labelText: 'Confirm Password',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            prefixIcon: const Icon(Icons.lock_outline),
          ),
          obscureText: true,
          validator: (value) {
            if (value?.isEmpty ?? true) return 'Please confirm password';
            if (value != _userPasswordController.text) return 'Passwords do not match';
            return null;
          },
        ),
        const SizedBox(height: 24),
        _buildSectionTitle('Additional Information (Optional)'),
        TextFormField(
          controller: _userCityController,
          decoration: InputDecoration(
            labelText: 'City',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            prefixIcon: const Icon(Icons.location_city),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _userStateController,
          decoration: InputDecoration(
            labelText: 'State',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            prefixIcon: const Icon(Icons.location_city),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _userPinController,
          decoration: InputDecoration(
            labelText: 'PIN Code',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            prefixIcon: const Icon(Icons.pin_drop),
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          value: _userOccupationController.text.isEmpty ? null : _userOccupationController.text,
          decoration: InputDecoration(
            labelText: 'Occupation',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            prefixIcon: const Icon(Icons.work),
          ),
          items: _occupations.map((occupation) {
            return DropdownMenuItem(
              value: occupation,
              child: Text(occupation),
            );
          }).toList(),
          onChanged: (value) {
            setState(() => _userOccupationController.text = value ?? '');
          },
        ),
        const SizedBox(height: 24),
        _buildRegisterButton(),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleRegister,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: _isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : const Text(
                'Continue',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account? ',
          style: GoogleFonts.poppins(
            color: Colors.grey.shade600,
          ),
        ),
        TextButton(
          onPressed: () => context.go('/login'),
          child: const Text(
            'Login',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
