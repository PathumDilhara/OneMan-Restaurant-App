# Implementation Plan - Contact Screen UI

This plan outlines the steps to implement a professional and user-friendly `ContactScreen` for the One Man restaurant app using the provided branding and information.

## User Review Required

> [!IMPORTANT]
> - The inquiry form will be implemented as a `StatefulWidget` component within the screen to handle user input.
> - Opening hours and contact details are set as per the provided data.
> - FAQs will be implemented as expandable tiles for a better mobile experience.

## Proposed Changes

### Contact Feature

#### [MODIFY] [contact_screen.dart](file:///D:/Vampior Designs/Projects/One man/oneman/lib/features/contact/screens/contact_screen.dart)
- Convert to a `StatefulWidget` to manage the inquiry form and scroll behavior.
- **Structure**:
    - **Header**: "Get in Touch" with the provided description.
    - **Contact Info Cards**:
        - **Hotline**: 077 7887755
        - **Email**: onemankitchenpvtltd@gmail.com
        - **Location**: No. 256/5, Kandy Road, Kurunegala (with "View On Map" button).
    - **Business Hours Section**:
        - Weekdays: 11:00 AM - 10:00 PM
        - Weekends: 11:00 AM - 11:00 PM
    - **FAQ Section**: Implement the 5 provided questions using `ExpansionTile`.
    - **Inquiry Form**:
        - Full Name (TextFormField)
        - Inquiry Type (Dropdown or ChoiceChips: Table Reservation, Event, Delivery, etc.)
        - Email Address (TextFormField)
        - Company / Event Title (Optional TextFormField)
        - Message (Multi-line TextFormField)
        - Submit Button (using `customButtonWidget`)
    - **Footer Branding**: "Crafting Delicious Experiences Daily" and copyright information.

## Verification Plan

### Manual Verification
- Navigate to the "Contact" tab.
- Verify all contact details match the provided text.
- Test form validation (e.g., empty fields).
- Ensure the FAQ tiles expand and collapse smoothly.
- Check layout responsiveness on the mobile device.
