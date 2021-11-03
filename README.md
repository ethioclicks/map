             Flutter map documentation
Chapter 1
Getting Started

1.	Open terminal and create a flutter project with command:
                 •	flutter create project_name
2.	Open working environment ( eg. vscode).
3.	Open the project we just created.
  	This application utilizing Google Maps, Places Autocomplete, and Geolocator.
  	For this application to work we need to:
a.	Have a Google project, enable the Android SDK, IOS SDK, and Places API in your GCloud Console.
b.	Obtain an API key and replace the YOUR_KEY placeholders in 
    - ios/Runner/AppDelegate.swift
    - android/app/src/main/AndroidManifest.xml
    - lib/services/places_service.dart
    
Chapter 2
Adding dependencies

We can add dependencies with two ways:
I.	Search for dependencies we needed in pubs.dev website.
II.	In terminal use command: 
    •	flutter pub add package_name
To work we need the following dependencies:
1.	provider:
    •	For state management.
2.	google_maps_flutter:
    •	To use Google map in our program.
	In order to use this package we need to set permission for android or for ios.
 

![pemmision for android](https://user-images.githubusercontent.com/58349651/140055853-fe53f395-3abd-4299-92a4-987945101baa.png)

3.	geolocator:
•	Used to focus on where we are.
4.	http:
•	To use our Google API.
5.	geocoding:
•	To convert address written with coordinates to readable address and vice versa.
Chapter 3
Create and setup Google map API
After creating our API we need to set up the API so that it can be used by our application by:
1.	Enable APIs for android, ios, for rest searches for places:
•	Go to: Menu -> APIs & Services -> Library
•	Enable three APIs: Maps SDK for Android, maps SDK for ios, places API
2.	Create and get an API key:
•	Go to: Menu -> APIs & Services -> Credentials
•	In Credentials page create API by pressing: 
Create credentials-> API key
 

•	Then a dialogue box will appear:
 

•	Select RESTRICT KEY
•	Then we will restrict Maps SDK for Android, maps SDK for ios, places API.

