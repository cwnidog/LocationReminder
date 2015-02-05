# LocationReminder
==================

## MapButton:
------------
* Get your project setup in ObjectiveC
* Create a single view controller, that has a map view that takes up most the screen, and 3 buttons below it.
* The 3 buttons should set the region on the map view to 3 cool locations, you pick the locations.
* Implement Stack and Queue in ObjectiveC. You can implement them in the same project as your map app is in, since ObjectiveC
does not support playgrounds

## Annotations
--------------
* Using core location, display the users location on the map
* Add a long press gesture to the map view
* On long press, add an annotation onto the map view, which has a callout with an accessory button
* Upon pressing the accessory button, segue to a AddReminderDetailViewController

## Regions And Notifications
----------------------------
* Using Region monitoring & local notifications, schedule a location based reminder in the AddReminderDetailViewController
* Add a visual map annotation wherever a reminder is added, using NSNotificationCenter to communicate from the Detail view controller back to the primary map view controller

## WatchKit
-----------
* Create a WatchKit extension for your app, that will display the regions that are being monitored. Use the watch kit map view to show where the region actually is.
