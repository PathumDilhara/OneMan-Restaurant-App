# Implementation Plan - Complete Offers Page

Complete the `OffersScreen` with a modern, functional UI that showcases special deals and discounts for the "One Man" food delivery app.

## Proposed Changes

### [offers] Component

#### [MODIFY] [offers_screen.dart](file:///D:/Vampior Designs/Projects/One man/oneman/lib/features/offers/screens/offers_screen.dart)
- Replace `Placeholder` with a full-page implementation.
- Add a stylized header "Special Offers".
- Implement a scrollable list of offer cards.
- Add sample offer data (e.g., "30% OFF on first order", "Free Delivery", "Buy 1 Get 1").
- Each card will include a title, description, discount badge, and a "Claim Now" button.
- Ensure the layout fits within the bottom navigation structure (considering the floating nav bar).

## Verification Plan

### Manual Verification
- Run the app and navigate to the Offers tab (percentage icon).
- Verify the list of offers is displayed correctly.
- Check that the UI is responsive and fits the project's design language (colors, padding, etc.).
- Ensure the bottom navigation bar doesn't obscure the content (use appropriate padding/margin).
