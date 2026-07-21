import 'package:flutter/material.dart';
import 'package:oneman/core/utils/colors.dart';
import 'package:oneman/core/utils/constants.dart';
import 'package:oneman/core/widgets/custom_button_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isEditMode = false;

  // Controllers with hardcoded data
  final TextEditingController _nameController = TextEditingController(
    text: "Neluminda Pavith",
  );
  final TextEditingController _emailController = TextEditingController(
    text: "NelumindaPavith72@gmail.com",
  );
  final TextEditingController _phoneController = TextEditingController(
    text: "0764790709",
  );
  final TextEditingController _addressController = TextEditingController(
    text: "No 47 willgoda whatta Kurunegala",
  );
  final TextEditingController _cityController = TextEditingController(text: "");
  final TextEditingController _postcodeController = TextEditingController(
    text: "",
  );
  final TextEditingController _countryController = TextEditingController(
    text: "",
  );

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _postcodeController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primScaffoldBg,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(
            left: kMainPadding * 2,
            right: kMainPadding * 2,
            top: kMainPadding * 5,
            bottom: kMainPadding * 14,
          ),
          child: Column(
            children: [
              SizedBox(height: kMainPadding * 6),
              _buildProfileHeader(),
              const SizedBox(height: 30),
              _buildQuickStats(),
              const SizedBox(height: 24),
              _buildSignOutButton(),
              const SizedBox(height: 40),
              _buildPersonalInformation(),
              const SizedBox(height: 60),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primRed1,
            border: Border.all(color: AppColors.primWhite, width: 4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: const Center(
            child: Text(
              "N",
              style: TextStyle(
                color: AppColors.primWhite,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          _nameController.text,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.primDark,
          ),
        ),
        Text(
          _emailController.text,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium!.copyWith(color: AppColors.primDarkGrey),
        ),
      ],
    );
  }

  Widget _buildQuickStats() {
    return Row(
      children: [
        _statCard("My Orders", "4", Icons.shopping_bag_outlined),
        const SizedBox(width: 12),
        _statCard("My Cart", "0", Icons.shopping_cart_outlined),
        const SizedBox(width: 12),
        _statCard("Wishlist", "0", Icons.favorite_border_rounded),
      ],
    );
  }

  Widget _statCard(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.primRed3.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primRed2, size: 24),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primDark,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.primDarkGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignOutButton() {
    return customButtonWidget(
      context: context,
      title: "Sign Out",
      height: 50,
      br: 16,
      bgColor: AppColors.primRed1.withValues(alpha: 0.1),
      borderColor: AppColors.primRed1.withValues(alpha: 0.2),
      titleColor: AppColors.primRed1,
      leadingIconPath: null, // No icon specified in requirement but could add
      onTap: () {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Signing out...")));
      },
    );
  }

  Widget _buildPersonalInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Personal Information",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton.icon(
              onPressed: () {
                setState(() {
                  _isEditMode = !_isEditMode;
                });
              },
              icon: Icon(
                _isEditMode ? Icons.check_circle_outline : Icons.edit_outlined,
                size: 18,
                color: AppColors.primRed2,
              ),
              label: Text(
                _isEditMode ? "Save" : "Edit Details",
                style: const TextStyle(color: AppColors.primRed2),
              ),
            ),
          ],
        ),
        Text(
          "Manage your details and contact information.",
          style: TextStyle(color: AppColors.primDarkGrey, fontSize: 13),
        ),
        const SizedBox(height: 24),
        Form(
          key: _formKey,
          child: Column(
            children: [
              _buildInfoField("Full Name", _nameController, "Neluminda Pavith"),
              _buildInfoField(
                "Email Address",
                _emailController,
                "NelumindaPavith72@gmail.com",
              ),
              _buildInfoField("Phone Number", _phoneController, "0764790709"),
              _buildInfoField(
                "Street Address",
                _addressController,
                "No 47 willgoda whatta Kurunegala",
              ),
              _buildInfoField("City", _cityController, "Enter city"),
              _buildInfoField(
                "Postcode",
                _postcodeController,
                "Enter postcode",
              ),
              _buildInfoField("Country", _countryController, "Enter country"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoField(
    String label,
    TextEditingController controller,
    String hint,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.primDark,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            enabled: _isEditMode,
            style: const TextStyle(fontSize: 15),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: AppColors.primDarkGrey),
              filled: true,
              fillColor:
                  _isEditMode
                      ? AppColors.primWhite
                      : AppColors.primWhite.withValues(alpha: 0.5),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(kTextFieldBR),
                borderSide: BorderSide(
                  color: AppColors.primGrey.withValues(alpha: 0.5),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(kTextFieldBR),
                borderSide: BorderSide(
                  color: AppColors.primGrey.withValues(alpha: 0.5),
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(kTextFieldBR),
                borderSide: BorderSide(
                  color: AppColors.primGrey.withValues(alpha: 0.2),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(kTextFieldBR),
                borderSide: const BorderSide(color: AppColors.primRed2),
              ),
            ),
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        Image.asset("assets/images/newlogoo.png", width: 80, height: 80),
        const SizedBox(height: 16),
        const Text(
          "OneMan Kitchen",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const Text(
          "Kurunegala",
          style: TextStyle(
            color: AppColors.primRed1,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
