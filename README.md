# WALLY Wall Plate Customizer - Mercury Thirteen Fork v1.7

This is a fork of the awesome WALLY Wall Plate Customizer by TheNewHobbyist (https://www.thingiverse.com/thing:47956) which itself was forked by Joshua Austill (https://github.com/jlaustill/WALLY-Wall-Plate-Customizer).

I've added several enhancements, such as:

- Mixed Plate layouts can now handle up to three rows of jacks
- Pitch between rows of jacks is now selectable on a per-gang basis
- Created jack "A/V - Banana Plug"  based on jack "A/V - Banana Plug With Border"
- Height values to the Plate Size dropdown menu
- Imported modules for creating keystone jacks / solids resulting in a better fit and an improved code footprint and imported jack "A/V - Banana Plug With Border" from "ReModded_WALLY_Plate_Customizer" (https://www.thingiverse.com/thing:4493144) by RobBotic
- Added new Full Plate types "Power - Outlet - Despard Single", "Power - Outlet - Despard Double", "Power - Outlet - Despard Triple", "Lighting - Pushbutton Pair" and "Lighting - Rotary Dimmer / Fan Control" from "Customizable Switch or Outlet Wall Plate" (https://www.thingiverse.com/thing:3840723) by pete2585
- Modularized duplex outlet hole creation to further improve code footprint
- Separated menu items out to individual menus according to whether they are a "Full Plate" or "Mixed Plate" option.
- Label handling is no longer tied to each individual jack; you can now place as many Labels as you like, anywhere on the plate, each with its own settings for font, size, angle and cut depth!
- Added an adjustable value for cylinder quality
- Grouped options into tabs for greater ease of use
- Sorted cutout names in Customizer lists to make more logical sense and make for easier navigation
- Added Neutrik Cutouts (https://www.datapro.net/drawings/cutouts/neutrik_cutout.pdf) per HacksolotFilms's suggestion
- Fixed a bug where the first plate spot did not build unless one of the "full plate" options are used
- Fixed: "Liberation Mono:Bol" -> "Liberation Mono:Bold"
- Improved layout of code... to me, at least. :)

... and more!

Give it a try, and feel free to send feedback if there's a jack style you'd like to see added.


<br><br>


<b>Usage Notes</b><br>

<i>Full Plate options</i><br>
Under each of the Gang Settings sections are five dropdown menus: <i>Full Plate</i>, <i>Row Pitch Adjust</i>, <i>Row 1</i>, <i>Row 2</i>, <i>Row 3</i>. The <i>Full Plate</i> menu allows you to select a layout for jacks which will occupy the entire plate, such as the NEMA L5-30P outlet or a standard toggle light switch.

<i>Mixed Plate options</i><br>
If you would rather design your own custom plate layout, leave the Full Plate option set to "None" and then you may select up to three individual jacks from the <i>Row 1</i>, <i>Row 2</i> and <i>Row 3</i> menus to occupy the plate. When buliding a custom plate in this way, you may use the <i>Row Pitch Adjust</i> slider to tune the amount of space between the rows of jacks on the current gang.

<i>Adding Labels</i><br>
The entires for Labels are entered as OpenSCAD lists; there are five "slots" provided, but you can add additional ones as desired to allow as many Labels as needed.<br>


For example, this is what's previded by default:
<pre>
Label Text		["", "", "", "", ""]
Label Font		["Liberation Mono", "Liberation Mono", "Liberation Mono", "Liberation Mono", "Liberation Mono"]
Label Size		[4, 4, 4, 4, 4]
Label X			[-1, -2, -3, -4, -5]
Label Y			[0, 0, 0, 0, 0]
Label Cut Depth		[2, 2, 2, 2, 2]
Label Angle		[0, 0, 0, 0, 0]
</pre>



This is a valid customization:
<pre>
Label Text		["TV - Left", "TV - Right", "TV - Subwoofer", "Printers", "PCs - Upstairs"]
Label Font		["QSwitchAx", "QSwitchAx", "QSwitchAx", "Loma", "Loma"]
Label Size		[4, 4, 4, 4, 4]
Label X			[-1, -1, -1, -2, -2]
Label Y			[-15, 10, 34, -12, 13]
Label Cut Depth		[2, 2, 2, 2, 2]
Label Angle		[0, 0, 0, 0, 0]
</pre>



This is also valid, to have more Labels:
<pre>
Label Text		["TV - Left", "TV - Right", "TV - Subwoofer", "Printers", "PCs - Upstairs", "PCs - Downstairs", "Doorbell Cameras", "Wii, XBox"]
Label Font		["QSwitchAx", "QSwitchAx", "QSwitchAx", "Loma", "Loma", "Loma", "Padauk", "Padauk"]
Label Size		[4, 4, 4, 4, 4, 4, 4, 4]
Label X			[-1, -1, -1, -2, -2, -2, -3, -3]
Label Y			[-15, 10, 34, -12, 13, 38, 0, 28]
Label Cut Depth		[2, 2, 2, 2, 2, 2, 2, 2]
Label Angle		[0, 0, 0, 0, 0, 0, 0, 0]
</pre>



The negative numbers in the "Label X" field are a shortcut to tell the Customizer to position that Label centered along the X axis of the specified gang. For example, to automatically position a Label in the center of gang 3, you would indicate -3 in this field. If instead the value is non-negative, the number will be enterpreted literally to specify the absolute position of this Label along the X axis. This allows you to specify a Label to appear anywhere on the plate, not just in relation to the position of a given gang.
