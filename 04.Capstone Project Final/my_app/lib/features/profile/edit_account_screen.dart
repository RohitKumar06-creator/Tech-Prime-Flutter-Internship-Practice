import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../home/home_screen.dart';
import 'viewmodels/profile_viewmodel.dart';

class EditAccountScreen extends StatefulWidget {
  final bool isFirstTimeSetup;

  const EditAccountScreen({super.key, this.isFirstTimeSetup = false});

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  late TextEditingController _usernameController;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _dobController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _cityController;
  late TextEditingController _provinceController;
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    final viewModel = Provider.of<ProfileViewModel>(context, listen: false);
    _usernameController = TextEditingController(text: viewModel.username);
    _firstNameController = TextEditingController(text: viewModel.firstName);
    _lastNameController = TextEditingController(text: viewModel.lastName);
    _dobController = TextEditingController(text: viewModel.dateOfBirth);
    _phoneController = TextEditingController(text: viewModel.phoneNumber);
    _emailController = TextEditingController(text: viewModel.email);
    _cityController = TextEditingController(text: viewModel.city);
    _provinceController = TextEditingController(text: viewModel.province);
    _addressController = TextEditingController(text: viewModel.address);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _dobController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _cityController.dispose();
    _provinceController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(ProfileViewModel viewModel) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1994, 2, 12),
      firstDate: DateTime(1940),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      viewModel.updateDateOfBirth(picked);
      if (mounted) {
        setState(() {
          _dobController.text = viewModel.dateOfBirth;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProfileViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: widget.isFirstTimeSetup
            ? null // Hide back button on first time setup so they must complete profile
            : IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.textDark,
                  size: 20,
                ),
                onPressed: () => Navigator.pop(context),
              ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          widget.isFirstTimeSetup ? 'Complete Your Profile' : 'Edit Account',
          style: const TextStyle(
            color: AppColors.textDark,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Personal',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 16),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F6F9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ecare ID',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      viewModel.ecareId,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              _buildInputField('Username', _usernameController),
              _buildInputField('First Name', _firstNameController),
              _buildInputField('Last Name', _lastNameController),

              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Date of Birth',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textMuted,
                      ),
                    ),
                    TextField(
                      controller: _dobController,
                      readOnly: true,
                      onTap: () => _selectDate(viewModel),
                      decoration: const InputDecoration(
                        suffixIcon: Icon(
                          Icons.calendar_today_outlined,
                          color: AppColors.textMuted,
                          size: 20,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFE0E0E0)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.primaryBlue),
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                  ],
                ),
              ),

              const Text(
                'Gender',
                style: TextStyle(fontSize: 12, color: AppColors.textMuted),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Female',
                        groupValue: viewModel.gender,
                        activeColor: AppColors.primaryBlue,
                        onChanged: (val) => viewModel.setGender(val!),
                      ),
                      const Text(
                        'Female',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 32),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Male',
                        groupValue: viewModel.gender,
                        activeColor: AppColors.primaryBlue,
                        onChanged: (val) => viewModel.setGender(val!),
                      ),
                      const Text(
                        'Male',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),

              const Text(
                'Contact',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 16),

              _buildInputField('Type your phone number', _phoneController),
              _buildInputField('Type your email', _emailController),
              _buildInputField('City', _cityController),
              _buildInputField('Province', _provinceController),
              _buildInputField('Address', _addressController),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    viewModel.updateAccountDetails(
                      username: _usernameController.text,
                      firstName: _firstNameController.text,
                      lastName: _lastNameController.text,
                      phoneNumber: _phoneController.text,
                      email: _emailController.text,
                      city: _cityController.text,
                      province: _provinceController.text,
                      address: _addressController.text,
                    );

                    if (widget.isFirstTimeSetup) {
                      // Navigate straight to the main HomeScreen after filling out profile
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChangeNotifierProvider.value(
                            value: viewModel,
                            child: const HomeScreen(),
                          ),
                        ),
                        (route) => false,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Changes saved successfully'),
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    widget.isFirstTimeSetup ? 'Get Started' : 'Save Changes',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
          ),
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFE0E0E0)),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.primaryBlue),
              ),
            ),
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }
}
