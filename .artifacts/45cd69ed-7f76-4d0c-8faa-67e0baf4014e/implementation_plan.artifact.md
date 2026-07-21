# Implementation Plan - Profile Screen UI

This plan outlines the steps to implement a professional and modern `ProfileScreen` for the One Man restaurant app using the provided data.

## User Review Required

> [!IMPORTANT]
> - The profile data will be hardcoded in the UI as requested (service layer to be implemented later).
> - I will implement an "Edit Mode" toggle to switch between viewing and editing profile details.
> - The "Sign Out" button will simulate a logout process with a snackbar.

## Proposed Changes

### Profile Feature

#### [MODIFY] [profile_screen.dart](file:///D:/Vampior Designs/Projects/One man/oneman/lib/features/profile/screens/profile_screen.dart)
- Convert to a `StatefulWidget` to manage form state and edit mode.
- **UI Structure**:
    - **Header**:
        - Circular Avatar with initials "N".
        - User Name: "Neluminda Pavith".
        - Email: "NelumindaPavith72@gmail.com".
    - **Quick Stats Row**: Three cards showing "My Orders" (4), "My Cart" (0), and "My Wishlist" (0).
    - **Sign Out Button**: A prominent logout button.
    - **Personal Information Section**:
        - "Edit Details" button.
        - **Fields**:
            - Full Name
            - Email Address
            - Phone Number (0764790709)
            - Street Address (No 47 willgoda whatta Kurunegala)
            - City (Enter city)
            - Postcode (Enter postcode)
            - Country (Enter country)
    - **Footer Branding**: Consistent with the `ContactScreen` (Logo, slogan, and copyright).

## Verification Plan

### Manual Verification
- Navigate to the "Profile" tab via the bottom navigation bar.
- Verify all user details match the provided text.
- Test the "Edit Details" toggle to ensure fields become editable.
- Verify the "Sign Out" button triggers a snackbar.
- Check layout responsiveness on the mobile device.
