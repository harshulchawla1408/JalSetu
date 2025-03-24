import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import 'account_type_page.dart';

class PhoneSignupPage extends StatefulWidget {
  final AccountType accountType;

  const PhoneSignupPage({
    super.key,
    required this.accountType,
  });

  @override
  State<PhoneSignupPage> createState() => _PhoneSignupPageState();
}

class _PhoneSignupPageState extends State<PhoneSignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  bool _acceptedTerms = false;
  bool _acceptedPrivacy = false;

  bool get _canProceed => _acceptedTerms && _acceptedPrivacy;

  void _handleConfirm() {
    if (_formKey.currentState?.validate() ?? false) {
      context.go('/auth/otp', extra: _phoneController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.go('/auth');
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.accountType == AccountType.user
                ? 'Create User Account'
                : 'Create NGO Account',
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go('/auth'),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Please enter your Phone Number',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Enter your phone number',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).textTheme.bodySmall?.color,
                        ),
                  ),
                  const SizedBox(height: 32),
                  CustomTextField(
                    controller: _phoneController,
                    label: 'Phone no.',
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter your phone number';
                      }
                      if (value!.length != 10) {
                        return 'Phone number must be 10 digits';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  _buildCheckbox(
                    'I have read and agreed to the terms and conditions',
                    _acceptedTerms,
                    (value) => setState(() => _acceptedTerms = value ?? false),
                  ),
                  const SizedBox(height: 12),
                  _buildCheckbox(
                    'I have read and agreed to the Privacy Policy',
                    _acceptedPrivacy,
                    (value) => setState(() => _acceptedPrivacy = value ?? false),
                  ),
                  const SizedBox(height: 32),
                  CustomButton(
                    onPressed: _canProceed ? _handleConfirm : null,
                    child: const Text(
                      'Confirm',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCheckbox(
    String label,
    bool value,
    void Function(bool?) onChanged,
  ) {
    return Row(
      children: [
        SizedBox(
          height: 24,
          width: 24,
          child: Checkbox(
            value: value,
            onChanged: onChanged,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: GestureDetector(
            onTap: () => onChanged(!value),
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }
} 