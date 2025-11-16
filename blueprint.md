# CCT Lamp Control App Blueprint

## Overview

This document outlines the design and features of a Flutter mobile application for controlling a CCT (Correlated Color Temperature) lamp. The app will provide an intuitive interface for users to control the lamp's brightness, color temperature, and power state.

## Style, Design, and Features

### Initial Version (v1.0)

*   **UI/UX:**
    *   Modern and clean design following Material Design 3 principles.
    *   A main screen with all the necessary controls for the CCT lamp.
    *   A color palette inspired by light and warmth.
    *   Use of Google Fonts for clear and stylish typography.
    *   Visually balanced layout with clean spacing.
*   **Core Features:**
    *   **Power Control:** A prominent switch to turn the lamp on and off.
    *   **Brightness Control:** A slider to adjust the lamp's brightness from 0% to 100%.
    *   **Color Temperature Control:** A slider to adjust the color temperature from warm white (e.g., 2700K) to cool white (e.g., 6500K).
    *   **Light Preview:** A visual indicator on the screen that changes its color and intensity to reflect the current settings of the lamp.
*   **State Management:**
    *   Use of `ValueNotifier` and `ValueListenableBuilder` for efficient local state management of brightness, color temperature, and power state.

## Current Plan

*   **Task:** Create the initial version of the CCT Lamp Control App.
*   **Steps:**
    1.  Add necessary dependencies to `pubspec.yaml` (`google_fonts`, `flutter_colorpicker`).
    2.  Create the main application structure in `lib/main.dart`.
    3.  Implement the UI with sliders for brightness and color temperature, and a power switch.
    4.  Implement the light preview that dynamically updates with the controls.
    5.  Set up a basic theme with a suitable color scheme and typography.
