# Walkthrough - Contact Screen Implementation

I have implemented the `ContactScreen` for OneMan Kitchen, using the branding, contact details, FAQs, and business hours provided.

## Changes Made

### Contact Feature
- **[ContactScreen](file:///D:/Vampior Designs/Projects/One man/oneman/lib/features/contact/screens/contact_screen.dart)**:
    - **Header Section**: Implemented the "Get in Touch" header with the provided description about reservations and catering.
    - **Contact Info Cards**: Created modern cards for the Hotline (077 7887755), Email (onemankitchenpvtltd@gmail.com), and Location (Kurunegala).
    - **Business Hours**: Added a high-contrast card showing Weekday and Weekend operating hours.
    - **FAQ Section**: Integrated 5 frequently asked questions using `ExpansionTile` for a clean, interactive experience.
    - **Inquiry Form**: Built a comprehensive form with validation for Name, Inquiry Type (dropdown), Email, and Message.
    - **Footer Branding**: Added the OneMan Kitchen logo, slogan, and copyright information.

## Verification Results
- **Data Accuracy**: All phone numbers, emails, addresses, and hours match the provided input exactly.
- **Form Functionality**: The inquiry form includes validation and shows a success snackbar upon submission.
- **UI Consistency**: Used `AppColors`, `kMainPadding`, and `kTextFieldBR` to ensure the screen fits perfectly with the rest of the application's design.
- **User Experience**: The FAQ section uses collapsible tiles to save space, and the scroll physics are set to `BouncingScrollPhysics` for a premium feel.
