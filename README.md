# LovelyGrandchildren 🎀✨💖

LovelyGrandchildren is a Swift‑native iOS mobile application for discovering and tracking GMMTV mascots in one place. It helps fans quickly identify mascots, learn their parent artists, and keep up with related events, official channels, and merchandise links.

GMMTV mascots are more than cute characters, they are part of "fandom identity and fan engagement". A single app can help fans discover mascots faster, follow events more easily, and stay connected to official updates without confusion.

## Motivation
Thai mascots and BL series are loved by fans in Thailand and around the world. Many fans discover mascots through viral clips, but the information is often scattered across different official accounts and fan communities.

This project aims to solve that by creating one central place for GMMTV mascot information, especially for fans who want to know:
- The mascot’s name.
- The mascot’s parent artists.
- Official links and channels.
- Event schedules and notifications.
- Merchandise links from official shops.

## Problems We Solve

- **Missed Engagement**: Fans often miss limited-edition pop-up events because there is no central notification system.
- **Identification Gap**: New fans cannot easily identify mascots based on appearance alone.
- **Information Fragmentation**: Mascot meet-and-greet schedules and event details are scattered across many official accounts.

## Key Features

- **Mascot Profiles**: Each mascot has a profile page with its name, appearance, and parent artists.
- **Event Participation**: Users can view mascot appearances in fan meetings, pop-up events, and special activities.
- **Parent Artists**: The app connects each mascot to its official “parent” actors or artists.
- **Official Channels**: Users can open official GMMTV links and social channels for verified updates.
- **Event Tracker**: Fans can browse all upcoming mascot events in one place.
- **Event Calendar**: A calendar view helps users see event dates more clearly and avoid missing important activities.
- **Merchandise Links**: The app does not sell products directly, but it provides links to official merch shops.

## Application Preview
![LovelyGrandchildren Preview](https://raw.githubusercontent.com/ParimaSA/LovelyGrandchildren/main/LovelyGrandchildrenPreview.png)

## Project Setup

### Prerequisites
- macOS with Xcode installed (latest stable version recommended).
- An Apple ID for signing and simulator testing.

### Steps

1. Clone the repository:
   ```bash
   git clone https://github.com/ParimaSA/LovelyGrandchildren.git
   cd LovelyGrandchildren
   ```

2. Open the project in Xcode.
   
3. Connect to Firebase:  
   Follow the official iOS setup guide: [Add Firebase to your Apple project](https://firebase.google.com/docs/ios/setup).
   
   In step 4, add the following Firebase libraries:  
   - `FirebaseCore`  
   - `FirebaseDatabase`  
   - `FirebaseFirestore`  
   - `FirebaseStorage`
     
   Make sure to download and add the `GoogleService-Info.plist` file to your Xcode project.
   
   After completing the tutorial, go to your project target in Xcode → **General** tab → scroll to **Frameworks, Libraries, and Embedded Content** and add the same Firebase libraries there as well.

5. Run the app  
   Select a simulator and press Run to build and launch the app.
