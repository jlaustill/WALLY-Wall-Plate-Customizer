/*
	WALLY - Wall Plate Customizer
	created by TheNewHobbyist, 2013 (http://thenewhobbyist.com)
	modified by Mercury Thirteen (Mercury0x0d), 2022 (http://MercuryCoding.com)

	Most of the connectors used with this thing are panel mount connectors from www.DataPro.net I can't vouch for their quality but they did have easy to find dimensions for their products so I used them.

	Note: "None" and "Blank" should not be considered equal. if "None" is selected for one of the three holes on a plate, the other selected holes will be centered on that plate. If "Blank" is selected that plug location will remain blank but the other selected holes will NOT move into a centered position.



	Change Log:

	v1.7.2 - Mercury0x0d - 2/19/2023 - Developed in OpenSCAD 2021.01
	Fixed:
		- Made change suggested by @Johnepanz to ovalify the mounting holes of Neutrik cutouts


	v1.7.1 - Mercury0x0d - 9/15/2022 - Developed in OpenSCAD 2021.01
	Fixed:
		- Eliminated "gang based" X axis positioning. Turns out, if you use negative numbers to signify a special positioning mode, you can no longer use negative numbers when you actually need negative numbers. Funny thing, that.


	v1.7 - Mercury0x0d - 8/24/2022 - Developed in OpenSCAD 2021.01
	Added:
		- Completely rewrote the jack layout engine:
			- Mixed Plate layouts can now handle up to three rows of jacks
			- Pitch between rows of jacks is now selectable on a per-gang basis
		- Created jack "A/V - Banana Plug"  based on jack "A/V - Banana Plug With Border"
		- Height values to the Plate Size dropdown menu
		- Improvements from "ReModded_WALLY_Plate_Customizer" (https://www.thingiverse.com/thing:4493144) by RobBotic:
			- Imported modules for creating keystone jacks / solids resulting in a better fit and an improved code footprint
			- Imported jack "A/V - Banana Plug With Border"
		- New Full Plate types from "Customizable Switch or Outlet Wall Plate" (https://www.thingiverse.com/thing:3840723) by pete2585:
			- Power - Outlet - Despard Single
			- Power - Outlet - Despard Double
			- Power - Outlet - Despard Triple
			- Lighting - Pushbutton Pair
			- Lighting - Rotary Dimmer / Fan Control

	Changed:
		- Modularized duplex outlet hole creation to further improve code footprint
		- Removed version number from header comment since the Change Log here effectively communicates that information now.
		- Separated menu items out to individual menus according to whether they are a "Full Plate" or "Mixed Plate" option.
		- Split creation of solids out from PlateDoHoles() and into PlateDoSolids() to allow for more efficient code
		- Label handling is no longer tied to each individual jack; you can now place as many Labels as you like, anywhere on the plate, each with its own settings for font, size, angle and cut depth!
		- Variable names have been altered for greater code readability.

	Fixed:
		- All cubes comprising SolidKeystone now render correctly (one was missing previously)
		- Cylinder Quality now defaults to 64 (half) instead of 128 (maximum)
		- Labels are now the last step of plate creation to ensure that solids do not interfere with the text cutouts
		- Trimmed some unused variables


	v1.6 - Mercury0x0d - 8/17/2022
	- Added an adjustable value for cylinder quality
	- Added an adjustable value for Label size
	- Adjusted location of bottom text labels to fix a bug where Label spacing did not match across top and bottom positions
	- Adjusted Z-height of main cube used in building keystone solids to fix a bug where text labels on upper keystone jacks would be obscured by the solid protruding through the text cutout
	- Grouped options into tabs for greater ease of use
	- Removed dualsidetoggle reference as it appears nowhere else in the code and is functionally the same as a duplex outlet
	- Sorted cutout names in Customizer lists to make more logical sense and make for easier navigation


	v1.5 - Mercury0x0d - 8/16/2022
	- Added Neutrik Cutouts (https://www.datapro.net/drawings/cutouts/neutrik_cutout.pdf) per HacksolotFilms's suggestion


	v1.4 - Mercury0x0d - 8/13/2022 - The "I've never used OpenSCAD in my life until yesterday" edition! :D
	- Added Keystone Jack - Dual to allow a pair of keystone jacks side-by-side.
	- Fixed a bug where the first plate spot did not build unless one of the "full plate" options are used
	- Fixed: "Liberation Mono:Bol" -> "Liberation Mono:Bold"
	- Improved layout of code... to me, at least. :)


	v1.3 - TheNewHobbyist
	ADDED: 3 new sizes for plate export: Standard, Junior-Jumbo, and Jumbo.


	v1.2 - TheNewHobbyist
	ADDED: Long Toggle Switch for laird


	v1.1 - TheNewHobbyist
	UPDATED: Screw hole locations for designer and toggle plate types.
	UPDATED: Hole size for designer plate type.
	UPDATED: Outlet hole spacing

*/

  //////////////////////////
 // Customizer Settings: //
//////////////////////////

/* [Plate Specifications] */
// How many gangs will this plate have?
Plate_Width = 1;								// [1:5]

// Overall plate size
Plate_Size = 0;									// [0:Standard - 4.5 inch / 114.3 mm height, 1:Junior-Jumbo - 4.875 inch / 123.825 mm height, 2:Jumbo - 5.25 inch / 133.35 mm height]

// Set smoothness of curves and holes.
Cylinder_Quality = 64;							// [16:128]





/* [Gang 1 Settings] */
// Full plate selection; overrides any other selections for this gang
Gang_1_Full_Plate = "none";						// ["none": None, "button": Lighting - Pushbutton Pair, "rocker": Lighting - Rocker / Paddle / Leviton 'Decora', "rotary": Lighting - Rotary Dimmer / Fan Control, "toggle": Lighting - Toggle Switch, "long_toggle": Lighting - Toggle Switch - Long, "NEMA-L5-30P": Power - NEMA L5-30P, "outletDespardSingle": Power - Outlet - Despard Single, "outletDespardDouble": Power - Outlet - Despard Double, "outletDespardTriple": Power - Outlet - Despard Triple, "outletDuplex": Power - Outlet - Duplex]

// Fine-tune row padding
Gang_1_Row_Pitch_Adjust = 0;					// [-4:16]

// Row 1 type (if not using a Full Plate option)
Gang_1_Row_1 = "none";							// ["none": None, "blank": Blank Port, "bananaJackSet": A/V - Banana Jack Set, "bananaJackSetWithBorder": A/V - Banana Jack Set With Border, "displayport": A/V - Displayport, "dvi": A/V - DVI-I Port, "hdmi": A/V - HDMI Port, "neutrik": A/V - Neutrik Cutout, "svideo": A/V - S-Video Port, "stereo": A/V - Stereo Headphone Jack, "vga": A/V - VGA Port, "cat5e": Data - Cat 5e / Cat 6 Port, "db09": Data - DB-09 Port, "f-type": Data - F-Type/Coaxial Port, "firewire": Data - Firewire IEEE 1394 Port, "keystone1": Data - Keystone Jack, "keystone2": Data - Keystone Jack - Dual, "ps2": Data - PS2 Port, "usb-a": Data - USB-A Port, "usb-b": Data - USB-B Port]

// Row 2 type (if not using a Full Plate option)
Gang_1_Row_2 = "none";							// ["none": None, "blank": Blank Port, "bananaJackSet": A/V - Banana Jack Set, "bananaJackSetWithBorder": A/V - Banana Jack Set With Border, "displayport": A/V - Displayport, "dvi": A/V - DVI-I Port, "hdmi": A/V - HDMI Port, "neutrik": A/V - Neutrik Cutout, "svideo": A/V - S-Video Port, "stereo": A/V - Stereo Headphone Jack, "vga": A/V - VGA Port, "cat5e": Data - Cat 5e / Cat 6 Port, "db09": Data - DB-09 Port, "f-type": Data - F-Type/Coaxial Port, "firewire": Data - Firewire IEEE 1394 Port, "keystone1": Data - Keystone Jack, "keystone2": Data - Keystone Jack - Dual, "ps2": Data - PS2 Port, "usb-a": Data - USB-A Port, "usb-b": Data - USB-B Port]

// Row 3 type (if not using a Full Plate option)
Gang_1_Row_3 = "none";							// ["none": None, "blank": Blank Port, "bananaJackSet": A/V - Banana Jack Set, "bananaJackSetWithBorder": A/V - Banana Jack Set With Border, "displayport": A/V - Displayport, "dvi": A/V - DVI-I Port, "hdmi": A/V - HDMI Port, "neutrik": A/V - Neutrik Cutout, "svideo": A/V - S-Video Port, "stereo": A/V - Stereo Headphone Jack, "vga": A/V - VGA Port, "cat5e": Data - Cat 5e / Cat 6 Port, "db09": Data - DB-09 Port, "f-type": Data - F-Type/Coaxial Port, "firewire": Data - Firewire IEEE 1394 Port, "keystone1": Data - Keystone Jack, "keystone2": Data - Keystone Jack - Dual, "ps2": Data - PS2 Port, "usb-a": Data - USB-A Port, "usb-b": Data - USB-B Port]





/* [Gang 2 Settings] */
Gang_2_Full_Plate = "none";						// ["none": None, "button": Lighting - Pushbutton Pair, "rocker": Lighting - Rocker / Paddle / Leviton 'Decora', "rotary": Lighting - Rotary Dimmer / Fan Control, "toggle": Lighting - Toggle Switch, "long_toggle": Lighting - Toggle Switch - Long, "NEMA-L5-30P": Power - NEMA L5-30P, "outletDespardSingle": Power - Outlet - Despard Single, "outletDespardDouble": Power - Outlet - Despard Double, "outletDespardTriple": Power - Outlet - Despard Triple, "outletDuplex": Power - Outlet - Duplex]

// Fine-tune row padding
Gang_2_Row_Pitch_Adjust = 0;					// [-4:16]

// Row 1 type (if not using a Full Plate option)
Gang_2_Row_1 = "none";							// ["none": None, "blank": Blank Port, "bananaJackSet": A/V - Banana Jack Set, "bananaJackSetWithBorder": A/V - Banana Jack Set With Border, "displayport": A/V - Displayport, "dvi": A/V - DVI-I Port, "hdmi": A/V - HDMI Port, "neutrik": A/V - Neutrik Cutout, "svideo": A/V - S-Video Port, "stereo": A/V - Stereo Headphone Jack, "vga": A/V - VGA Port, "cat5e": Data - Cat 5e / Cat 6 Port, "db09": Data - DB-09 Port, "f-type": Data - F-Type/Coaxial Port, "firewire": Data - Firewire IEEE 1394 Port, "keystone1": Data - Keystone Jack, "keystone2": Data - Keystone Jack - Dual, "ps2": Data - PS2 Port, "usb-a": Data - USB-A Port, "usb-b": Data - USB-B Port]

// Row 2 type (if not using a Full Plate option)
Gang_2_Row_2 = "none";							// ["none": None, "blank": Blank Port, "bananaJackSet": A/V - Banana Jack Set, "bananaJackSetWithBorder": A/V - Banana Jack Set With Border, "displayport": A/V - Displayport, "dvi": A/V - DVI-I Port, "hdmi": A/V - HDMI Port, "neutrik": A/V - Neutrik Cutout, "svideo": A/V - S-Video Port, "stereo": A/V - Stereo Headphone Jack, "vga": A/V - VGA Port, "cat5e": Data - Cat 5e / Cat 6 Port, "db09": Data - DB-09 Port, "f-type": Data - F-Type/Coaxial Port, "firewire": Data - Firewire IEEE 1394 Port, "keystone1": Data - Keystone Jack, "keystone2": Data - Keystone Jack - Dual, "ps2": Data - PS2 Port, "usb-a": Data - USB-A Port, "usb-b": Data - USB-B Port]

// Row 3 type (if not using a Full Plate option)
Gang_2_Row_3 = "none";							// ["none": None, "blank": Blank Port, "bananaJackSet": A/V - Banana Jack Set, "bananaJackSetWithBorder": A/V - Banana Jack Set With Border, "displayport": A/V - Displayport, "dvi": A/V - DVI-I Port, "hdmi": A/V - HDMI Port, "neutrik": A/V - Neutrik Cutout, "svideo": A/V - S-Video Port, "stereo": A/V - Stereo Headphone Jack, "vga": A/V - VGA Port, "cat5e": Data - Cat 5e / Cat 6 Port, "db09": Data - DB-09 Port, "f-type": Data - F-Type/Coaxial Port, "firewire": Data - Firewire IEEE 1394 Port, "keystone1": Data - Keystone Jack, "keystone2": Data - Keystone Jack - Dual, "ps2": Data - PS2 Port, "usb-a": Data - USB-A Port, "usb-b": Data - USB-B Port]





/* [Gang 3 Settings] */
Gang_3_Full_Plate = "none";						// ["none": None, "button": Lighting - Pushbutton Pair, "rocker": Lighting - Rocker / Paddle / Leviton 'Decora', "rotary": Lighting - Rotary Dimmer / Fan Control, "toggle": Lighting - Toggle Switch, "long_toggle": Lighting - Toggle Switch - Long, "NEMA-L5-30P": Power - NEMA L5-30P, "outletDespardSingle": Power - Outlet - Despard Single, "outletDespardDouble": Power - Outlet - Despard Double, "outletDespardTriple": Power - Outlet - Despard Triple, "outletDuplex": Power - Outlet - Duplex]

// Fine-tune row padding
Gang_3_Row_Pitch_Adjust = 0;					// [-4:16]

// Row 1 type (if not using a Full Plate option)
Gang_3_Row_1 = "none";							// ["none": None, "blank": Blank Port, "bananaJackSet": A/V - Banana Jack Set, "bananaJackSetWithBorder": A/V - Banana Jack Set With Border, "displayport": A/V - Displayport, "dvi": A/V - DVI-I Port, "hdmi": A/V - HDMI Port, "neutrik": A/V - Neutrik Cutout, "svideo": A/V - S-Video Port, "stereo": A/V - Stereo Headphone Jack, "vga": A/V - VGA Port, "cat5e": Data - Cat 5e / Cat 6 Port, "db09": Data - DB-09 Port, "f-type": Data - F-Type/Coaxial Port, "firewire": Data - Firewire IEEE 1394 Port, "keystone1": Data - Keystone Jack, "keystone2": Data - Keystone Jack - Dual, "ps2": Data - PS2 Port, "usb-a": Data - USB-A Port, "usb-b": Data - USB-B Port]

// Row 2 type (if not using a Full Plate option)
Gang_3_Row_2 = "none";							// ["none": None, "blank": Blank Port, "bananaJackSet": A/V - Banana Jack Set, "bananaJackSetWithBorder": A/V - Banana Jack Set With Border, "displayport": A/V - Displayport, "dvi": A/V - DVI-I Port, "hdmi": A/V - HDMI Port, "neutrik": A/V - Neutrik Cutout, "svideo": A/V - S-Video Port, "stereo": A/V - Stereo Headphone Jack, "vga": A/V - VGA Port, "cat5e": Data - Cat 5e / Cat 6 Port, "db09": Data - DB-09 Port, "f-type": Data - F-Type/Coaxial Port, "firewire": Data - Firewire IEEE 1394 Port, "keystone1": Data - Keystone Jack, "keystone2": Data - Keystone Jack - Dual, "ps2": Data - PS2 Port, "usb-a": Data - USB-A Port, "usb-b": Data - USB-B Port]

// Row 3 type (if not using a Full Plate option)
Gang_3_Row_3 = "none";							// ["none": None, "blank": Blank Port, "bananaJackSet": A/V - Banana Jack Set, "bananaJackSetWithBorder": A/V - Banana Jack Set With Border, "displayport": A/V - Displayport, "dvi": A/V - DVI-I Port, "hdmi": A/V - HDMI Port, "neutrik": A/V - Neutrik Cutout, "svideo": A/V - S-Video Port, "stereo": A/V - Stereo Headphone Jack, "vga": A/V - VGA Port, "cat5e": Data - Cat 5e / Cat 6 Port, "db09": Data - DB-09 Port, "f-type": Data - F-Type/Coaxial Port, "firewire": Data - Firewire IEEE 1394 Port, "keystone1": Data - Keystone Jack, "keystone2": Data - Keystone Jack - Dual, "ps2": Data - PS2 Port, "usb-a": Data - USB-A Port, "usb-b": Data - USB-B Port]





/* [Gang 4 Settings] */
Gang_4_Full_Plate = "none";						// ["none": None, "button": Lighting - Pushbutton Pair, "rocker": Lighting - Rocker / Paddle / Leviton 'Decora', "rotary": Lighting - Rotary Dimmer / Fan Control, "toggle": Lighting - Toggle Switch, "long_toggle": Lighting - Toggle Switch - Long, "NEMA-L5-30P": Power - NEMA L5-30P, "outletDespardSingle": Power - Outlet - Despard Single, "outletDespardDouble": Power - Outlet - Despard Double, "outletDespardTriple": Power - Outlet - Despard Triple, "outletDuplex": Power - Outlet - Duplex]

// Fine-tune row padding
Gang_4_Row_Pitch_Adjust = 0;					// [-4:16]

// Row 1 type (if not using a Full Plate option)
Gang_4_Row_1 = "none";							// ["none": None, "blank": Blank Port, "bananaJackSet": A/V - Banana Jack Set, "bananaJackSetWithBorder": A/V - Banana Jack Set With Border, "displayport": A/V - Displayport, "dvi": A/V - DVI-I Port, "hdmi": A/V - HDMI Port, "neutrik": A/V - Neutrik Cutout, "svideo": A/V - S-Video Port, "stereo": A/V - Stereo Headphone Jack, "vga": A/V - VGA Port, "cat5e": Data - Cat 5e / Cat 6 Port, "db09": Data - DB-09 Port, "f-type": Data - F-Type/Coaxial Port, "firewire": Data - Firewire IEEE 1394 Port, "keystone1": Data - Keystone Jack, "keystone2": Data - Keystone Jack - Dual, "ps2": Data - PS2 Port, "usb-a": Data - USB-A Port, "usb-b": Data - USB-B Port]

// Row 2 type (if not using a Full Plate option)
Gang_4_Row_2 = "none";							// ["none": None, "blank": Blank Port, "bananaJackSet": A/V - Banana Jack Set, "bananaJackSetWithBorder": A/V - Banana Jack Set With Border, "displayport": A/V - Displayport, "dvi": A/V - DVI-I Port, "hdmi": A/V - HDMI Port, "neutrik": A/V - Neutrik Cutout, "svideo": A/V - S-Video Port, "stereo": A/V - Stereo Headphone Jack, "vga": A/V - VGA Port, "cat5e": Data - Cat 5e / Cat 6 Port, "db09": Data - DB-09 Port, "f-type": Data - F-Type/Coaxial Port, "firewire": Data - Firewire IEEE 1394 Port, "keystone1": Data - Keystone Jack, "keystone2": Data - Keystone Jack - Dual, "ps2": Data - PS2 Port, "usb-a": Data - USB-A Port, "usb-b": Data - USB-B Port]

// Row 3 type (if not using a Full Plate option)
Gang_4_Row_3 = "none";							// ["none": None, "blank": Blank Port, "bananaJackSet": A/V - Banana Jack Set, "bananaJackSetWithBorder": A/V - Banana Jack Set With Border, "displayport": A/V - Displayport, "dvi": A/V - DVI-I Port, "hdmi": A/V - HDMI Port, "neutrik": A/V - Neutrik Cutout, "svideo": A/V - S-Video Port, "stereo": A/V - Stereo Headphone Jack, "vga": A/V - VGA Port, "cat5e": Data - Cat 5e / Cat 6 Port, "db09": Data - DB-09 Port, "f-type": Data - F-Type/Coaxial Port, "firewire": Data - Firewire IEEE 1394 Port, "keystone1": Data - Keystone Jack, "keystone2": Data - Keystone Jack - Dual, "ps2": Data - PS2 Port, "usb-a": Data - USB-A Port, "usb-b": Data - USB-B Port]





/* [Gang 5 Settings] */
Gang_5_Full_Plate = "none";						// ["none": None, "button": Lighting - Pushbutton Pair, "rocker": Lighting - Rocker / Paddle / Leviton 'Decora', "rotary": Lighting - Rotary Dimmer / Fan Control, "toggle": Lighting - Toggle Switch, "long_toggle": Lighting - Toggle Switch - Long, "NEMA-L5-30P": Power - NEMA L5-30P, "outletDespardSingle": Power - Outlet - Despard Single, "outletDespardDouble": Power - Outlet - Despard Double, "outletDespardTriple": Power - Outlet - Despard Triple, "outletDuplex": Power - Outlet - Duplex]

// Fine-tune row padding
Gang_5_Row_Pitch_Adjust = 0;					// [-4:16]

// Row 1 type (if not using a Full Plate option)
Gang_5_Row_1 = "none";							// ["none": None, "blank": Blank Port, "bananaJackSet": A/V - Banana Jack Set, "bananaJackSetWithBorder": A/V - Banana Jack Set With Border, "displayport": A/V - Displayport, "dvi": A/V - DVI-I Port, "hdmi": A/V - HDMI Port, "neutrik": A/V - Neutrik Cutout, "svideo": A/V - S-Video Port, "stereo": A/V - Stereo Headphone Jack, "vga": A/V - VGA Port, "cat5e": Data - Cat 5e / Cat 6 Port, "db09": Data - DB-09 Port, "f-type": Data - F-Type/Coaxial Port, "firewire": Data - Firewire IEEE 1394 Port, "keystone1": Data - Keystone Jack, "keystone2": Data - Keystone Jack - Dual, "ps2": Data - PS2 Port, "usb-a": Data - USB-A Port, "usb-b": Data - USB-B Port]

// Row 2 type (if not using a Full Plate option)
Gang_5_Row_2 = "none";							// ["none": None, "blank": Blank Port, "bananaJackSet": A/V - Banana Jack Set, "bananaJackSetWithBorder": A/V - Banana Jack Set With Border, "displayport": A/V - Displayport, "dvi": A/V - DVI-I Port, "hdmi": A/V - HDMI Port, "neutrik": A/V - Neutrik Cutout, "svideo": A/V - S-Video Port, "stereo": A/V - Stereo Headphone Jack, "vga": A/V - VGA Port, "cat5e": Data - Cat 5e / Cat 6 Port, "db09": Data - DB-09 Port, "f-type": Data - F-Type/Coaxial Port, "firewire": Data - Firewire IEEE 1394 Port, "keystone1": Data - Keystone Jack, "keystone2": Data - Keystone Jack - Dual, "ps2": Data - PS2 Port, "usb-a": Data - USB-A Port, "usb-b": Data - USB-B Port]

// Row 3 type (if not using a Full Plate option)
Gang_5_Row_3 = "none";							// ["none": None, "blank": Blank Port, "bananaJackSet": A/V - Banana Jack Set, "bananaJackSetWithBorder": A/V - Banana Jack Set With Border, "displayport": A/V - Displayport, "dvi": A/V - DVI-I Port, "hdmi": A/V - HDMI Port, "neutrik": A/V - Neutrik Cutout, "svideo": A/V - S-Video Port, "stereo": A/V - Stereo Headphone Jack, "vga": A/V - VGA Port, "cat5e": Data - Cat 5e / Cat 6 Port, "db09": Data - DB-09 Port, "f-type": Data - F-Type/Coaxial Port, "firewire": Data - Firewire IEEE 1394 Port, "keystone1": Data - Keystone Jack, "keystone2": Data - Keystone Jack - Dual, "ps2": Data - PS2 Port, "usb-a": Data - USB-A Port, "usb-b": Data - USB-B Port]





/* [Label Settings] */
Label_Text		= ["", "", "", "", ""];
Label_Font		= ["Liberation Mono", "Liberation Mono", "Liberation Mono", "Liberation Mono", "Liberation Mono"];
Label_Size		= [4, 4, 4, 4, 4];
Label_X			= [-1, -2, -3, -4, -5];
Label_Y			= [0, 0, 0, 0, 0];
Label_Cut_Depth	= [2, 2, 2, 2, 2];
Label_Angle		= [0, 0, 0, 0, 0];












/* [Hidden] */
// Define some gGlobals
rowPitchList = [Gang_1_Row_Pitch_Adjust, Gang_2_Row_Pitch_Adjust, Gang_3_Row_Pitch_Adjust, Gang_4_Row_Pitch_Adjust, Gang_5_Row_Pitch_Adjust];

l_offset = [34.925, 39.6875, 44.45];
r_offset = [34.925, 39.6875, 44.45];
spacer = [0, 0, 46.0375, 92.075, 138.1125, 184.15];
solid_Plate_Width = l_offset[Plate_Size] + spacer[Plate_Width] + r_offset[Plate_Size];

height_sizes = [114.3, 123.825, 133.35];

kEdgeWidth = solid_Plate_Width + 10; // Bevel setting for top and bottom
kRightBevel = solid_Plate_Width - 4; // Bevel for right side (scales)

kSwitchOffset = 46.0375; // Offset all additional holes
kThinnerOffset = [0, 0.92, 0.95, 0.96, 0.97, 0.973]; // Manual fix for right side wackiness

kMiddleLine = height_sizes[Plate_Size] / 2;

// "gPlates" is a global list of all the "Full Plate" options which are selected
gPlates = [Gang_1_Full_Plate, Gang_2_Full_Plate, Gang_3_Full_Plate, Gang_4_Full_Plate, Gang_5_Full_Plate];

// create a list of all the "Mixed Plate" options which are not "none"
gPlateRows =
[
	[for (a = [Gang_1_Row_1, Gang_1_Row_2, Gang_1_Row_3]) if (a != "none") a],
	[for (a = [Gang_2_Row_1, Gang_2_Row_2, Gang_2_Row_3]) if (a != "none") a],
	[for (a = [Gang_3_Row_1, Gang_3_Row_2, Gang_3_Row_3]) if (a != "none") a],
	[for (a = [Gang_4_Row_1, Gang_4_Row_2, Gang_4_Row_3]) if (a != "none") a],
	[for (a = [Gang_5_Row_1, Gang_5_Row_2, Gang_5_Row_3]) if (a != "none") a]
];

// create a list of all the Label settings
gTextLabels = [Label_Text, Label_Font, Label_Size, Label_X, Label_Y, Label_Cut_Depth, Label_Angle];

// this helps plot jack locations for Mixed Plate options
gYOffsets =
[
	[kMiddleLine],
	[kMiddleLine - 14.25, kMiddleLine + 14.25],
	[kMiddleLine - 25, kMiddleLine, kMiddleLine + 25]
];





// Define us some kConstants

// Despard-related konstants
kDespardDiameter = 23.7664;
kDespardBoundRectHeight = 17.6196;

// Keystone-related konstants
kKeystoneClearance = 0.2;
kKeystoneHeight = 16.5 + kKeystoneClearance;
kKeystoneWidth = 15 + kKeystoneClearance;
kKeystoneColumnOffset = 11.5;

// Label-related konstants
kLabelText = 0;
kLabelFont = 1;
kLabelSize = 2;
kLabelX = 3;
kLabelY = 4;
kLabelCutDepth = 5;
kLabelAngle = 6;

// Pushbutton-related konstants
kPushbuttonDiameter = 13.081;
kPushbuttonOffset = 11.7094;





// BUILD! THAT! PLATE! YAYYYYYYYYYYY
// Rotate the plate so it sits face-up on the 3D printer's build plate.
// Monotonic Ironing is now a thing, and doing it this way means you can get some smoooooooth plate faces!
rotate([0, 0, -90])
{
	// put plate at 0, 0, 0 for easier printing
	translate([-kMiddleLine, -solid_Plate_Width / 2, -6])
	{
		difference()
		{
			// Although it does effectively nothing, this translate() is necessary to group the following difference() and union() into a single object prior to the Label cut being performed later. This is done to avoid issues with preview artifacts without having to resort to messing with the geometry using tiny epsilon values.
			translate([0,0,0])
			{
				difference()
				{
					PlateBaseCreate();
					translate([0, 0, -3]) PlateDoInner();

					for (plateIndex = [0:Plate_Width - 1])
					{
						PlateBuild(plateIndex);
						PlateDoScrews(plateIndex);
					}
				}

				union()
				{
					for (plateIndex = [0:Plate_Width - 1])
					{
						PlateDoSolids(plateIndex);
					}
				}
			}

			// This needs to be done last to make sure any added solids (e.g. with Keystone jacks) do not interfere with the label cut.
			// The label cut may affect the solids, but the other way around just looks plain bad.
			PlateDoLabels();
		}
	}
}





module HoleBananaJack(x, y)
{
	translate([y, x, 0]) cylinder(r = 4.7625, h = 10, center = true, $fn = Cylinder_Quality);
}





module HoleBananaJackSet()
{
	translate([0, 0, 3])
	{
		x = 9.5;
		y = -4.25;
		HoleBananaJack(-x, y);
		HoleBananaJack(x, y);
	}
}





module HoleBananaJackSetWithBorder()
{
	translate([0, 0, 3])
	{
		x = 9.5;
		y = -4.25;
		HoleBananaJack(-x, y);
		HoleBananaJack(x, y);

		// Create recessed box around everything
		translate([12.5, -kSwitchOffset / 2, 2])
		{
			rotate([0, 0, 90])
			{
				linear_extrude(2)
				{
					difference()
					{
						ShapeRoundRect(kSwitchOffset, 25, 0.75);
						translate([1, 1, 0]) ShapeRoundRect(kSwitchOffset - 2, 23, 0.75);
					}
				}
			}
		}
	}
}





module HoleDespard()
{
	intersection()
	{
		cylinder(h = 14, d = kDespardDiameter, $fn = Cylinder_Quality);
		cube([kDespardBoundRectHeight, 40, 14], center = true);
	}
}





module HoleKeystone(y_offset)
{
	translate([0, y_offset, 5])
	{
		cube([kKeystoneHeight, kKeystoneWidth, 10], center = true);
		translate([-5.5, 0, 0]) rotate([0, 45, 0]) cube([4, kKeystoneWidth, 10], center = true);
	}
}





module HoleOutlet()
{
	difference()
	{
		cylinder(r = 17.4625, h = 15, center = true, $fn = Cylinder_Quality);
		translate([-24.2875, -15, -2]) cube([10, 37, 15], center = false);
		translate([14.2875, -15, -2]) cube([10, 37, 15], center = false);
	}
}





module PlateBaseCreate()
{
	//Plate size and bevel
	difference()
	{
		cube([height_sizes[Plate_Size], solid_Plate_Width, 6]);
		translate([-4.3, -5, 6.2]) rotate([0, 45, 0]) cube([6, kEdgeWidth, 6]); //Top Bevel
		translate([height_sizes[Plate_Size] - 4.2, -5, 6.25]) rotate([0, 45, 0]) cube([6, kEdgeWidth, 6]); //Bottom Bevel
		translate([height_sizes[Plate_Size] + 10, -4.4, 6.1]) rotate([0, 45, 90]) cube([6, height_sizes[Plate_Size] + 20, 6]); //Left Bevel (doesn't change)
		translate([height_sizes[Plate_Size] + 10, kRightBevel, 6]) rotate([0, 45, 90]) cube([6, height_sizes[Plate_Size] + 10, 6]); //Right Bevel (scales right)
	}
}





module PlateBuild(plateIndex)
{
	// handle all "full plate" options first
	x = l_offset[Plate_Size] + kSwitchOffset * plateIndex;
	rowPitch = rowPitchList[plateIndex];

	if (gPlates[plateIndex] != "none")
	{
		// do the hole cutouts
		translate([0, l_offset[Plate_Size] + kSwitchOffset * plateIndex, 0]) PlateDoHoles(gPlates[plateIndex]);
	} else {
		// If we get here, we're not doing "Full Plate" mode, so we build the plate from the individual row selections
		selections = len(gPlateRows[plateIndex]);

		if (selections)
		{
			// do the layout for this gang
			for (row = [0:selections - 1])
			{
				y = gYOffsets[selections - 1][row];
				rowItem = gPlateRows[plateIndex][row];

				if (gYOffsets[selections - 1][row] != kMiddleLine)
				{
					// we're not on the center row
					if (row == 0)
					{
						// we're on the top row, so we subtract the pitch padding value
						translate([y - rowPitch, x, 0]) PlateDoHoles(rowItem);
					} else {
						// we're on the bottom row, so we add the pitch padding value
						translate([y + rowPitch, x, 0]) PlateDoHoles(rowItem);
					}
				} else {
					// we're on the center row, so we leave it as-is
					translate([y, x, 0]) PlateDoHoles(rowItem);
				}
			}
		}
	}
}





module PlateDoHoles(hole_type)
{
	// Hole Cutout definitions
	if (hole_type == "blank") {}

	if (hole_type == "NEMA-L5-30P")
	{
		translate([kMiddleLine, 0, 0]) cylinder(d = 35.5, h = 500, center = true, $fn = Cylinder_Quality);
	}

	if (hole_type == "toggle")
	{
		translate([kMiddleLine, 0, 0]) cube([23.8125, 10.3188, 15], center = true);
	}

	if (hole_type == "long_toggle")
	{
		translate([kMiddleLine, 0, 0]) cube([43.6563, 11.9063, 15], center = true);
	}

	if (hole_type == "rocker")
	{
		translate([kMiddleLine, 0, 0]) cube([67.1, 33.3, 15], center = true);
	}

	if (hole_type == "button")
	{
		translate([kMiddleLine - kPushbuttonOffset, 0, 0]) cylinder(h = 7, d = kPushbuttonDiameter, $fn = Cylinder_Quality);
		translate([kMiddleLine + kPushbuttonOffset, 0, 0]) cylinder(h = 7, d = kPushbuttonDiameter, $fn = Cylinder_Quality);
	}

	if (hole_type == "rotary")
	{
		translate([kMiddleLine, 0, 0]) cylinder(r = 5, h = 7, $fn = Cylinder_Quality);
	}

	if (hole_type == "outletDuplex")
	{
		translate([kMiddleLine + 19.3915, 0, 0]) HoleOutlet();	// upper hole
		translate([kMiddleLine - 19.3915, 0, 0]) HoleOutlet();	// lower hole
	}

	if (hole_type == "outletDespardSingle")
	{
		translate([kMiddleLine, 0, 0]) HoleDespard();
	}

	if (hole_type == "outletDespardDouble")
	{
		translate([kMiddleLine - 23.8, 0, 0]) HoleDespard();
		translate([kMiddleLine + 23.8, 0, 0]) HoleDespard();
	}

	if (hole_type == "outletDespardTriple")
	{
		translate([kMiddleLine - 23.8, 0, 0]) HoleDespard();
		translate([kMiddleLine, 0, 0]) HoleDespard();
		translate([kMiddleLine + 23.8, 0, 0]) HoleDespard();
	}

	if (hole_type == "bananaJackSet")
	{
		HoleBananaJackSet();
	}

	if (hole_type == "bananaJackSetWithBorder")
	{
		HoleBananaJackSetWithBorder();
	}

	if (hole_type == "vga" || hole_type == "db09")
	{
		// VGA Fits http://www.datapro.net/products/vga-dual-panel-mount-f-f-cable.html
		// DB09 Fits http://www.datapro.net/products/db9-serial-panel-mount-male-extension.html
		translate([0, -12.5, 3]) cylinder(r = 1.75, h = 10, center = true, $fn = Cylinder_Quality);
		translate([0, 12.5, 3]) cylinder(r = 1.75, h = 10, center = true, $fn = Cylinder_Quality);
		difference()
		{
			cube([10, 19, 13], center = true);
			translate([-5, -9.2, 1]) rotate([0, 0, -35.6]) cube([4.4, 2.4, 15], center = true);
			translate([.9, -11.2, 0]) rotate([0, 0, 9.6]) cube([10, 4.8, 15], center = true);
			translate([4.6, -8.5, 0]) rotate([0, 0, 37.2]) cube([4.4, 2.4, 15], center = true);
			translate([-5, 9.2, 1]) rotate([0, 0, 35.6]) cube([4.4, 2.4, 15], center = true);
			translate([0.9, 11.2, 0]) rotate([0, 0, -9.6]) cube([10, 4.8, 15], center = true);
			translate([4.6, 8.5, 0]) rotate([0, 0, -37.2]) cube([4.4, 2.4, 15], center = true);
		}
	}

	if (hole_type == "hdmi")
	{
		// Fits http://www.datapro.net/products/hdmi-panel-mount-extension-cable.html
		translate([0, -13, 3]) cylinder(r = 1.75, h = 10, center = true, $fn = Cylinder_Quality);
		translate([0, 13, 3]) cylinder(r = 1.75, h = 10, center = true, $fn = Cylinder_Quality);
		translate([0, 0, 3]) cube([6, 16, 10], center = true);
	}

	if (hole_type == "dvi")
	{
		// Fits http://www.datapro.net/products/dvi-i-panel-mount-extension-cable.html
		translate([0, -16, 3]) cylinder(r = 1.75, h = 10, center = true, $fn = Cylinder_Quality);
		translate([0, 16, 3]) cylinder(r = 1.75, h = 10, center = true, $fn = Cylinder_Quality);
		translate([0, 0, 3]) cube([10, 26, 10], center = true);
	}

	if (hole_type == "displayport")
	{
		// Fits http://www.datapro.net/products/dvi-i-panel-mount-extension-cable.html
		translate([0, -13.5, 3]) cylinder(r = 1.75, h = 10, center = true, $fn = Cylinder_Quality);
		translate([0, 13.5, 3]) cylinder(r = 1.75, h = 10, center = true, $fn = Cylinder_Quality);
		difference()
		{
			translate([0, 0, 3]) cube([7, 19, 10], center = true);
			translate([2.47, -9.37, 3]) rotate([0, 0, -54.6]) cube([3, 5, 14], center = true);
		}
	}

	if (hole_type == "usb-a")
	{
		// Fits http://www.datapro.net/products/usb-panel-mount-type-a-cable.html
		translate([0, -15, 3]) cylinder(r = 1.75, h = 10, center = true, $fn = Cylinder_Quality);
		translate([0, 15, 3]) cylinder(r = 1.75, h = 10, center = true, $fn = Cylinder_Quality);
		translate([0, 0, 3]) cube([8, 16, 10], center = true);
	}

	if (hole_type == "usb-b")
	{
		// Fits http://www.datapro.net/products/usb-panel-mount-type-b-cable.html
		translate([0, -13, 3]) cylinder(r = 1.75, h = 10, center = true, $fn = Cylinder_Quality);
		translate([0, 13, 3]) cylinder(r = 1.75, h = 10, center = true, $fn = Cylinder_Quality);
		translate([0, 0, 3]) cube([11, 12, 10], center = true);
	}

	if (hole_type == "firewire")
	{
		// Fits http://www.datapro.net/products/firewire-panel-mount-extension.html
		translate([0, -13.5, 3]) cylinder(r = 1.75, h = 10, center = true, $fn = Cylinder_Quality);
		translate([0, 13.5, 3]) cylinder(r = 1.75, h = 10, center = true, $fn = Cylinder_Quality);
		translate([0, 0, 3]) cube([7, 12, 10], center = true);
	}

	if (hole_type == "f-type")
	{
		// Fits http://www.datapro.net/products/f-type-panel-mounting-coupler.html
		translate([0, 0, 3]) cylinder(r = 4.7625, h = 10, center = true, $fn = Cylinder_Quality);
	}

	if (hole_type == "cat5e" || hole_type == "cat6")
	{
		// Cat5e Fits http://www.datapro.net/products/cat-5e-panel-mount-ethernet.html
		// Cat6 Fits hhttp://www.datapro.net/products/cat-6-panel-mount-ethernet.html
		translate([0, -12.5, 3]) cylinder(r = 1.75, h = 10, center = true, $fn = Cylinder_Quality);
		translate([0, 12.5, 3]) cylinder(r = 1.75, h = 10, center = true, $fn = Cylinder_Quality);
		translate([0, 0, 3]) cube([15, 15, 10], center = true);
	}

	if (hole_type == "svideo" || hole_type == "ps2")
	{
		// S-Video Fits hhttp://www.datapro.net/products/cat-6-panel-mount-ethernet.html
		// PS2 http://www.datapro.net/products/ps2-panel-mount-extension-cable.html
		translate([0, -10, 3]) cylinder(r = 1.75, h = 10, center = true, $fn = Cylinder_Quality);			// screw hole - left
		translate([0, 10, 3]) cylinder(r = 1.75, h = 10, center = true, $fn = Cylinder_Quality);			// screw hole - right
		translate([0, 0, 3]) cylinder(r = 5, h = 10, center = true, $fn = Cylinder_Quality);				// center hole
	}


	if (hole_type == "stereo")
	{
		// Stereo coupler Fits http://www.datapro.net/products/stereo-panel-mount-coupler.html
		cylinder(r = 2.985, h = 15, center = true, $fn = Cylinder_Quality);
	}

	if (hole_type == "neutrik")
	{
		// Neutrik fits https://www.datapro.net/drawings/cutouts/neutrik_cutout.pdf
		cylinder(d = 24, h = 15, center = true, $fn = Cylinder_Quality);									// center hole
		translate([-12, -9.5, 0]) rotate(-45,[0,0,1])resize([6,3.2]) cylinder(d = 3.2, h = 15, $fn = Cylinder_Quality); // screw hole - upper left
		translate([12, 9.5, 0]) rotate(-45,[0,0,1])resize([6,3.2]) cylinder(d = 3.2, h = 15, $fn = Cylinder_Quality); // screw hole - lower right
	}

	if (hole_type == "keystone1")
	{
		//translate([0, 0, 5]) cube([16.5, 15, 10], center = true);
		HoleKeystone(0);
	}

	if (hole_type == "keystone2")
	{
		HoleKeystone(-13);
		HoleKeystone(13);
	}
}





module PlateDoInner()
{
	scale([0.95,kThinnerOffset[Plate_Width],1])
	{
		translate([3,3,0])
		{
			difference()
			{
				cube([height_sizes[Plate_Size], solid_Plate_Width, 6]);
				translate([-4.3, -5, 6.2]) rotate([0, 45, 0]) cube([6, kEdgeWidth, 6]); //Top Bevel
				translate([height_sizes[Plate_Size] - 4.2, -5, 6.25]) rotate([0, 45, 0]) cube([6, kEdgeWidth, 6]); //Bottom Bevel
				translate([height_sizes[Plate_Size] + 10, -4.4, 6.1]) rotate([0, 45, 90]) cube([6, height_sizes[Plate_Size] + 20, 6]); //Left Bevel (doesn't change)
				translate([height_sizes[Plate_Size] + 10, kRightBevel, 6]) rotate([0, 45, 90]) cube([6, height_sizes[Plate_Size] + 10, 6]); //Right Bevel (scales right)
			}
		}
	}
}





module PlateDoLabels()
{
	// validate labels
	if (!(len(gTextLabels[kLabelText]) == len(gTextLabels[kLabelFont]) && len(gTextLabels[kLabelText]) == len(gTextLabels[kLabelSize]) && len(gTextLabels[kLabelText]) == len(gTextLabels[kLabelX]) && len(gTextLabels[kLabelText]) == len(gTextLabels[kLabelY]) && len(gTextLabels[kLabelText]) == len(gTextLabels[kLabelCutDepth]) && len(gTextLabels[kLabelText]) == len(gTextLabels[kLabelAngle])))
	{
		echo("LABEL LIST MISMATCH");
		echo("Label Text list size: ", len(gTextLabels[kLabelText]));
		echo("Label Font list size: ", len(gTextLabels[kLabelFont]));
		echo("Label Size list size: ", len(gTextLabels[kLabelSize]));
		echo("Label X list size: ", len(gTextLabels[kLabelX]));
		echo("Label Y list size: ", len(gTextLabels[kLabelY]));
		echo("Label Cut Depth list size: ", len(gTextLabels[kLabelCutDepth]));
		echo("Label Angle list size: ", len(gTextLabels[kLabelAngle]));
		echo("Label list sizes must match. Please correct this error for your Labels to be created.");
	}


	// create labels
	labelCount = len(gTextLabels[kLabelText]);

	for (thisLabel = [0:labelCount - 1])
	{
		thisLabelText = gTextLabels[kLabelText][thisLabel];
		thisLabelFont = gTextLabels[kLabelFont][thisLabel];
		thisLabelSize = gTextLabels[kLabelSize][thisLabel];
		thisLabelX = gTextLabels[kLabelX][thisLabel];
		thisLabelY = gTextLabels[kLabelY][thisLabel];
		thisLabelCutDepth = gTextLabels[kLabelCutDepth][thisLabel];
		thisLabelAngle = gTextLabels[kLabelAngle][thisLabel];

		// render the text
		translate([kMiddleLine + thisLabelY, thisLabelX + (solid_Plate_Width / 2), 6 - thisLabelCutDepth])
		{
			rotate([0, 0, 90 - thisLabelAngle])
			{
				linear_extrude(16)
				{
					text(thisLabelText, halign = "center", size = thisLabelSize, font = thisLabelFont);
				}
			}
		}
	}
}





module PlateDoScrews(plateIndex)
{
	x = l_offset[Plate_Size] + kSwitchOffset * plateIndex;
	plateType = gPlates[plateIndex];

	if (plateType != "none")
	{
		// This is a "Full Plate"
		if (plateType == "outletDuplex") translate([0, x, 0]) ScrewsCenter();
		if (plateType == "rocker" || plateType == "outletDespardSingle" || plateType == "outletDespardDouble" || plateType == "outletDespardTriple") translate([0, x, 0]) ScrewsRocker();
		if (plateType == "button" || plateType == "rotary" || plateType == "toggle" || plateType == "long_toggle" || plateType == "NEMA-L5-30P") translate([0, x, 0]) ScrewsYoke();
	} else {
		// This is a "Mixed Plate"
		translate([0, x, 0]) ScrewsBox();
	}
}





module PlateDoSolids(plateIndex)
{
	selections = len(gPlateRows[plateIndex]);

	if (gPlates[plateIndex] != "none")
	{
		// handle all "full plate" options first
	} else {
		selections = len(gPlateRows[plateIndex]);

		if (selections)
		{
			// do the layout for this gang
			for (row = [0:selections - 1])
			{
				x = l_offset[Plate_Size] + kSwitchOffset * plateIndex - 11.5;
				y = gYOffsets[selections - 1][row] + 14.3;
				rowPitch = rowPitchList[plateIndex];
				rowItem = gPlateRows[plateIndex][row];
				middleRow = kMiddleLine;

				if (gYOffsets[selections - 1][row] != middleRow)
				{
					// we're not on the center row
					if (row == 0)
					{
						// we're on the top row, so we subtract the pitch padding value
						translate([y - rowPitch, x, -3.9]) SolidDispatcher(rowItem);
					} else {
						// we're on the bottom row, so we add the pitch padding value
						translate([y + rowPitch, x, -3.9]) SolidDispatcher(rowItem);
					}
				} else {
					// we're on the center row, so we leave it as-is
					translate([y, x, -3.9]) SolidDispatcher(rowItem);
				}
			}
		}
	}
}





module ScrewsBox()
{
	// Box screw holes
	translate([kMiddleLine + 41.67125, 0, -1]) cylinder(r = 2, h = 10, $fn = Cylinder_Quality);
	translate([kMiddleLine + 41.67125, 0, 3.5]) cylinder(r1 = 2, r2 = 3.3, h = 3, $fn = Cylinder_Quality);
	translate([kMiddleLine - 41.67125, 0, -1]) cylinder(r = 2, h = 10, $fn = Cylinder_Quality);
	translate([kMiddleLine - 41.67125, 0, 3.5]) cylinder(r1 = 2, r2 = 3.3, h = 3, $fn = Cylinder_Quality);
}





module ScrewsCenter()
{
	// Duplex Outlet screw holes
	translate([kMiddleLine, 0, -1]) cylinder(r = 2, h = 10, $fn = Cylinder_Quality);
	translate([kMiddleLine, 0, 3.5]) cylinder(r1 = 2, r2 = 3.3, h = 3, $fn = Cylinder_Quality);
}





module ScrewsRocker()
{
	// Rocker/Designer screw holes
	translate([kMiddleLine + 48.41875, 0, -1]) cylinder(r = 2, h = 10, $fn = Cylinder_Quality);
	translate([kMiddleLine + 48.41875, 0, 3.5]) cylinder(r1 = 2, r2 = 3.3, h = 3, $fn = Cylinder_Quality);
	translate([kMiddleLine - 48.41875, 0, -1]) cylinder(r = 2, h = 10, $fn = Cylinder_Quality);
	translate([kMiddleLine - 48.41875, 0, 3.5]) cylinder(r1 = 2, r2 = 3.3, h = 3, $fn = Cylinder_Quality);
}





module ScrewsYoke()
{
	// Toggle screw holes
	translate([kMiddleLine + 30.1625, 0, -1]) cylinder(r = 2, h = 10, $fn = Cylinder_Quality);
	translate([kMiddleLine + 30.1625, 0, 3.5]) cylinder(r1 = 2, r2 = 3.3, h = 3, $fn = Cylinder_Quality);
	translate([kMiddleLine - 30.1625, 0, -1]) cylinder(r = 2, h = 10, $fn = Cylinder_Quality);
	translate([kMiddleLine - 30.1625, 0, 3.5]) cylinder(r1 = 2, r2 = 3.3, h = 3, $fn = Cylinder_Quality);
}




module ShapeRoundRect(width, height, cornerRadius)
{
	hull()
	{
		translate([cornerRadius, cornerRadius, 0]) circle(r = cornerRadius, $fn = Cylinder_Quality);
		translate([width - cornerRadius, cornerRadius, 0]) circle(r = cornerRadius, $fn = Cylinder_Quality);
		translate([width - cornerRadius, height - cornerRadius, 0]) circle(r = cornerRadius, $fn = Cylinder_Quality);
		translate([cornerRadius, height - cornerRadius, 0]) circle(r = cornerRadius, $fn = Cylinder_Quality);
	}
}





module SolidDispatcher(hole_type)
{
	// Keystone Solids
	if (hole_type == "keystone1") SolidKeystone();

	if (hole_type == "keystone2")
	{
		translate([0, 13, 0]) SolidKeystone();
		translate([0, -13, 0]) SolidKeystone();
	}
}





module SolidKeystone()
{
	rotate([0, 0, 90])
	{
		difference()
		{
			translate([2, 2, .1]) cube([19, 26.5, 9.8]);
			translate([4 - kKeystoneClearance / 2, 4 - kKeystoneClearance / 2, 0])
			{
				difference()
				{
					cube([15 + kKeystoneClearance, 22.5 + kKeystoneClearance, 10]);
					translate([-1, 3, -3.40970]) rotate([45, 0, 0]) cube([17, 2, 6.5]);
					translate([-1, 21.0, 0]) rotate([-45, 0, 0]) cube([17, 2, 6.5]);
				}
				translate([0, 1.8, 0]) cube([15 + kKeystoneClearance, 19.62 + kKeystoneClearance, 5]);
			}
		}
	}
}
