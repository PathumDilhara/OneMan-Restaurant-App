import 'package:flutter/material.dart';
import 'package:oneman/core/utils/colors.dart';
import 'package:oneman/core/utils/constants.dart';
import 'package:oneman/core/widgets/custom_button_widget.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  String _selectedInquiryType = 'Table Reservation';

  final List<String> _inquiryTypes = [
    'Table Reservation',
    'Event Catering',
    'Online Delivery Query',
    'General Inquiry',
    'Feedback',
  ];

  ValueNotifier<List<int>> openedList = ValueNotifier([]);

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _companyController.dispose();
    _messageController.dispose();
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
            top: kMainPadding * 6,
            bottom: kMainPadding * 14,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 30),

              _buildContactCards(),
              const SizedBox(height: 40),

              _buildBusinessHours(),
              const SizedBox(height: 40),

              _buildFAQSection(),
              const SizedBox(height: 40),

              _buildInquiryForm(),
              const SizedBox(height: 60),

              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Get in Touch",
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.primRed2,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          "Have questions about reservations, event catering, or online deliveries? Drop us a line and let's craft something delightful together!",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: AppColors.primDarkGrey,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildContactCards() {
    return Column(
      children: [
        _infoCard(
          icon: Icons.phone_in_talk_rounded,
          title: "Call Hotlines",
          value: "077 7887755",
          subtitle: "Hotline",
          onAction: () {},
        ),
        const SizedBox(height: 16),
        _infoCard(
          icon: Icons.email_outlined,
          title: "Email Support",
          value: "onemankitchenpvtltd@gmail.com",
          onAction: () {},
        ),
        const SizedBox(height: 16),
        _infoCard(
          icon: Icons.location_on_outlined,
          title: "Store Location",
          value: "No. 256/5, Kandy Road, Kurunegala, Sri Lanka",
          actionLabel: "View On Map",
          onAction: () {}, // TODO
        ),
      ],
    );
  }

  Widget _infoCard({
    required IconData icon,
    required String title,
    required String value,
    String? subtitle,
    String? actionLabel,
    required VoidCallback onAction,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primWhite,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primRed1.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Icon(icon, color: AppColors.primRed1, size: 24),
              ),
              const SizedBox(width: 14),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (subtitle != null)
            Text(
              subtitle,
              style: TextStyle(color: AppColors.primDarkGrey, fontSize: 12),
            ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: AppColors.primDark,
            ),
          ),
          if (actionLabel != null) ...[
            const SizedBox(height: 16),
            customButtonWidget(
              context: context,
              title: actionLabel,
              height: 40,
              width: 130,
              br: 12,
              bgColor: AppColors.primRed2,
              titleColor: AppColors.primWhite,
              onTap: onAction,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBusinessHours() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.primRed2,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.access_time_rounded, color: AppColors.primWhite),
              SizedBox(width: 10),
              Text(
                "Business Hours",
                style: TextStyle(
                  color: AppColors.primWhite,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _hourRow("Weekdays", "11:00 AM - 10:00 PM"),
          const Divider(color: AppColors.primWhite, thickness: 0.2, height: 24),
          _hourRow("Weekends", "11:00 AM - 11:00 PM"),
        ],
      ),
    );
  }

  Widget _hourRow(String days, String hours) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(days, style: const TextStyle(color: AppColors.primWhite)),
        Text(
          hours,
          style: const TextStyle(
            color: AppColors.primWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildFAQSection() {
    final List<Map<String, String>> faqs = [
      {
        "q": "What are your opening hours?",
        "a":
            "OneMan Kitchen is open from 11:00 AM to 10:00 PM from Monday to Friday, and from 11:00 AM to 11:00 PM on Saturdays and Sundays.",
      },
      {
        "q": "Do you offer home delivery in Kurunegala?",
        "a":
            "Yes! We offer fresh and fast delivery within Kurunegala city and suburbs.",
      },
      {
        "q": "How can I book catering for an event?",
        "a":
            "You can send an inquiry through the form below or call our hotline for customized catering packages.",
      },
      {
        "q": "Are your ingredients sourced fresh?",
        "a":
            "Absolutely. We savor the taste of premium culinary delights crafted with fresh ingredients daily.",
      },
      {
        "q": "Can I reserve a table in advance?",
        "a":
            "Yes, table reservations can be made via the form below or by calling us directly.",
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Frequently Asked Questions",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        ...faqs.asMap().entries.map((entry) {
          int idx = entry.key + 1;
          return ValueListenableBuilder(
            valueListenable: openedList,
            builder: (context, value, child) {
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color:
                      openedList.value.contains(idx)
                          ? AppColors.primRed1.withValues(alpha: 0.3)
                          : AppColors.primWhite,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ExpansionTile(
                  onExpansionChanged: (value) {
                    if (value) {
                      print("######## added $value $idx");
                      openedList.value = [...openedList.value, idx];
                    } else {
                      openedList.value = [...openedList.value]..remove(idx);
                    }
                  },
                  leading: Text(
                    idx.toString().padLeft(2, '0'),
                    style: TextStyle(
                      color: AppColors.primRed2,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  title: Text(
                    entry.value["q"]!,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primDark,
                    ),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        bottom: 16,
                      ),
                      child: Text(
                        entry.value["a"]!,
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }),
      ],
    );
  }

  Widget _buildInquiryForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Send an Inquiry",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        Form(
          key: _formKey,
          child: Column(
            children: [
              _buildFieldLabel("Full Name"),
              _buildTextField(
                controller: _nameController,
                hint: "Your Name",
                validator: (v) => v!.isEmpty ? "Please enter your name" : null,
              ),
              const SizedBox(height: 20),
              _buildFieldLabel("Select Inquiry Type"),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.primWhite,
                  borderRadius: BorderRadius.circular(kTextFieldBR),
                  border: Border.all(
                    color: AppColors.primGrey.withValues(alpha: 0.5),
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedInquiryType,
                    isExpanded: true,
                    items:
                        _inquiryTypes.map((String type) {
                          return DropdownMenuItem<String>(
                            value: type,
                            child: Text(type),
                          );
                        }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedInquiryType = newValue!;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildFieldLabel("Email Address"),
              _buildTextField(
                controller: _emailController,
                hint: "you@example.com",
                keyboardType: TextInputType.emailAddress,
                validator: (v) => v!.isEmpty ? "Please enter email" : null,
              ),
              const SizedBox(height: 20),
              _buildFieldLabel("Company / Event Title (Optional)"),
              _buildTextField(controller: _companyController, hint: "Optional"),
              const SizedBox(height: 20),
              _buildFieldLabel("Your Message"),
              _buildTextField(
                controller: _messageController,
                hint: "Describe your requirements...",
                maxLines: 4,
                validator: (v) => v!.isEmpty ? "Please enter message" : null,
              ),
              const SizedBox(height: 32),
              customButtonWidget(
                context: context,
                title: "Submit Inquiry",
                height: 55,
                br: 16,
                bgColor: AppColors.primRed2,
                titleColor: AppColors.primWhite,
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Inquiry sent successfully!"),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.primDark,
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: AppColors.primDarkGrey, fontSize: 14),
        filled: true,
        fillColor: AppColors.primWhite,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
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
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kTextFieldBR),
          borderSide: const BorderSide(color: AppColors.primRed2),
        ),
      ),
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
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
        Text(
          "Kurunegala",
          style: TextStyle(
            color: AppColors.primRed1,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          "Savor the taste of premium, state-of-the-art culinary delights crafted with fresh ingredients and extraordinary passion.",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.primDarkGrey,
            fontSize: 13,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 40),
        const Text(
          "© 2026 OneMan Kitchen. All rights reserved.\nPowered by Vampior Designs",
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.primDarkGrey, fontSize: 11),
        ),
      ],
    );
  }
}
