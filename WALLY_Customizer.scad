/*
	WALLY - Wall Plate Customizer
	created by TheNewHobbyist, 2013 (http://thenewhobbyist.com)
	modified by Mercury Thirteen (Mercury0x0d), 2022 (http://MercuryCoding.com)

	Most of the connectors used with this thing are panel mount connectors from www.DataPro.net I can't vouch for their quality but they did have easy to find dimensions for their products so I used them.

	Note: "None" and "Blank" should not be considered equal. if "None" is selected for one of the three holes on a plate, the other selected holes will be centered on that plate. If "Blank" is selected that plug location will remain blank but the other selected holes will NOT move into a centered position.



	Change Log:

	v1.7 - Mercury0x0d - 8/24/2022
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
		- Label handling is no longer tied to each individual jack; you can now place up to 40 anywhere on the plate, each with its own settings for font, size, angle and cut depth.
		- Variable names have been altered for greater code readability.
	Fixed:
		- All cubes comprising SolidKeystone now render correctly (one was missing previously)
		- Made Labels applied last to the final plate so that solids do not interfere with Label cutouts
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
plate_width = 1;								// [1:5]

// Overall plate size
plate_size = 0;									// [0:Standard - 4.5 inch / 114.3 mm height, 1:Junior-Jumbo - 4.875 inch / 123.825 mm height, 2:Jumbo - 5.25 inch / 133.35 mm height]

// Set smoothness of curves and holes.
cylinder_quality = 128;							// [1:128]





/* [Gang 1 Settings] */
// Full plate selection; overrides any other selections for this gang
Gang_1_Full_Plate = "none";						// ["none": None, "button": Lighting - Pushbutton Pair, "rocker": Lighting - Rocker / Paddle / Leviton 'Decora', "rotary": Lighting - Rotary Dimmer / Fan Control, "toggle": Lighting - Toggle Switch, "long_toggle": Lighting - Toggle Switch - Long, "L5-30P": Power - NEMA L5-30P, "outletDespardSingle": Power - Outlet - Despard Single, "outletDespardDouble": Power - Outlet - Despard Double, "outletDespardTriple": Power - Outlet - Despard Triple, "outletDuplex": Power - Outlet - Duplex]

// Fine-tune row padding
Gang_1_Row_Pitch_Adjust = 0;					// [-4:16]

// Row 1 type (if not using a Full Plate option)
Gang_1_Row_1 = "none";							// ["none": None, "blank": Blank Port, "bananaJackSet": A/V - Banana Jack Set, "bananaJackSetWithBorder": A/V - Banana Jack Set With Border, "displayport": A/V - Displayport, "dvi": A/V - DVI-I Port, "hdmi": A/V - HDMI Port, "neutrik": A/V - Neutrik Cutout, "svideo": A/V - S-Video Port, "stereo": A/V - Stereo Headphone Jack, "vga": A/V - VGA Port, "cat5e": Data - Cat 5e / Cat 6 Port, "db09": Data - DB-09 Port, "f-type": Data - F-Type/Coaxial Port, "firewire": Data - Firewire IEEE 1394 Port, "keystone1": Data - Keystone Jack, "keystone2": Data - Keystone Jack - Dual, "ps2": Data - PS2 Port, "usb-a": Data - USB-A Port, "usb-b": Data - USB-B Port]

// Row 2 type (if not using a Full Plate option)
Gang_1_Row_2 = "none";							// ["none": None, "blank": Blank Port, "bananaJackSet": A/V - Banana Jack Set, "bananaJackSetWithBorder": A/V - Banana Jack Set With Border, "displayport": A/V - Displayport, "dvi": A/V - DVI-I Port, "hdmi": A/V - HDMI Port, "neutrik": A/V - Neutrik Cutout, "svideo": A/V - S-Video Port, "stereo": A/V - Stereo Headphone Jack, "vga": A/V - VGA Port, "cat5e": Data - Cat 5e / Cat 6 Port, "db09": Data - DB-09 Port, "f-type": Data - F-Type/Coaxial Port, "firewire": Data - Firewire IEEE 1394 Port, "keystone1": Data - Keystone Jack, "keystone2": Data - Keystone Jack - Dual, "ps2": Data - PS2 Port, "usb-a": Data - USB-A Port, "usb-b": Data - USB-B Port]

// Row 3 type (if not using a Full Plate option)
Gang_1_Row_3 = "none";							// ["none": None, "blank": Blank Port, "bananaJackSet": A/V - Banana Jack Set, "bananaJackSetWithBorder": A/V - Banana Jack Set With Border, "displayport": A/V - Displayport, "dvi": A/V - DVI-I Port, "hdmi": A/V - HDMI Port, "neutrik": A/V - Neutrik Cutout, "svideo": A/V - S-Video Port, "stereo": A/V - Stereo Headphone Jack, "vga": A/V - VGA Port, "cat5e": Data - Cat 5e / Cat 6 Port, "db09": Data - DB-09 Port, "f-type": Data - F-Type/Coaxial Port, "firewire": Data - Firewire IEEE 1394 Port, "keystone1": Data - Keystone Jack, "keystone2": Data - Keystone Jack - Dual, "ps2": Data - PS2 Port, "usb-a": Data - USB-A Port, "usb-b": Data - USB-B Port]





/* [Gang 2 Settings] */
Gang_2_Full_Plate = "none";						// ["none": None, "button": Lighting - Pushbutton Pair, "rocker": Lighting - Rocker / Paddle / Leviton 'Decora', "rotary": Lighting - Rotary Dimmer / Fan Control, "toggle": Lighting - Toggle Switch, "long_toggle": Lighting - Toggle Switch - Long, "L5-30P": Power - NEMA L5-30P, "outletDespardSingle": Power - Outlet - Despard Single, "outletDespardDouble": Power - Outlet - Despard Double, "outletDespardTriple": Power - Outlet - Despard Triple, "outletDuplex": Power - Outlet - Duplex]

// Fine-tune row padding
Gang_2_Row_Pitch_Adjust = 0;					// [-4:16]

// Row 1 type (if not using a Full Plate option)
Gang_2_Row_1 = "none";							// ["none": None, "blank": Blank Port, "bananaJackSet": A/V - Banana Jack Set, "bananaJackSetWithBorder": A/V - Banana Jack Set With Border, "displayport": A/V - Displayport, "dvi": A/V - DVI-I Port, "hdmi": A/V - HDMI Port, "neutrik": A/V - Neutrik Cutout, "svideo": A/V - S-Video Port, "stereo": A/V - Stereo Headphone Jack, "vga": A/V - VGA Port, "cat5e": Data - Cat 5e / Cat 6 Port, "db09": Data - DB-09 Port, "f-type": Data - F-Type/Coaxial Port, "firewire": Data - Firewire IEEE 1394 Port, "keystone1": Data - Keystone Jack, "keystone2": Data - Keystone Jack - Dual, "ps2": Data - PS2 Port, "usb-a": Data - USB-A Port, "usb-b": Data - USB-B Port]

// Row 2 type (if not using a Full Plate option)
Gang_2_Row_2 = "none";							// ["none": None, "blank": Blank Port, "bananaJackSet": A/V - Banana Jack Set, "bananaJackSetWithBorder": A/V - Banana Jack Set With Border, "displayport": A/V - Displayport, "dvi": A/V - DVI-I Port, "hdmi": A/V - HDMI Port, "neutrik": A/V - Neutrik Cutout, "svideo": A/V - S-Video Port, "stereo": A/V - Stereo Headphone Jack, "vga": A/V - VGA Port, "cat5e": Data - Cat 5e / Cat 6 Port, "db09": Data - DB-09 Port, "f-type": Data - F-Type/Coaxial Port, "firewire": Data - Firewire IEEE 1394 Port, "keystone1": Data - Keystone Jack, "keystone2": Data - Keystone Jack - Dual, "ps2": Data - PS2 Port, "usb-a": Data - USB-A Port, "usb-b": Data - USB-B Port]

// Row 3 type (if not using a Full Plate option)
Gang_2_Row_3 = "none";							// ["none": None, "blank": Blank Port, "bananaJackSet": A/V - Banana Jack Set, "bananaJackSetWithBorder": A/V - Banana Jack Set With Border, "displayport": A/V - Displayport, "dvi": A/V - DVI-I Port, "hdmi": A/V - HDMI Port, "neutrik": A/V - Neutrik Cutout, "svideo": A/V - S-Video Port, "stereo": A/V - Stereo Headphone Jack, "vga": A/V - VGA Port, "cat5e": Data - Cat 5e / Cat 6 Port, "db09": Data - DB-09 Port, "f-type": Data - F-Type/Coaxial Port, "firewire": Data - Firewire IEEE 1394 Port, "keystone1": Data - Keystone Jack, "keystone2": Data - Keystone Jack - Dual, "ps2": Data - PS2 Port, "usb-a": Data - USB-A Port, "usb-b": Data - USB-B Port]





/* [Gang 3 Settings] */
Gang_3_Full_Plate = "none";						// ["none": None, "button": Lighting - Pushbutton Pair, "rocker": Lighting - Rocker / Paddle / Leviton 'Decora', "rotary": Lighting - Rotary Dimmer / Fan Control, "toggle": Lighting - Toggle Switch, "long_toggle": Lighting - Toggle Switch - Long, "L5-30P": Power - NEMA L5-30P, "outletDespardSingle": Power - Outlet - Despard Single, "outletDespardDouble": Power - Outlet - Despard Double, "outletDespardTriple": Power - Outlet - Despard Triple, "outletDuplex": Power - Outlet - Duplex]

// Fine-tune row padding
Gang_3_Row_Pitch_Adjust = 0;					// [-4:16]

// Row 1 type (if not using a Full Plate option)
Gang_3_Row_1 = "none";							// ["none": None, "blank": Blank Port, "bananaJackSet": A/V - Banana Jack Set, "bananaJackSetWithBorder": A/V - Banana Jack Set With Border, "displayport": A/V - Displayport, "dvi": A/V - DVI-I Port, "hdmi": A/V - HDMI Port, "neutrik": A/V - Neutrik Cutout, "svideo": A/V - S-Video Port, "stereo": A/V - Stereo Headphone Jack, "vga": A/V - VGA Port, "cat5e": Data - Cat 5e / Cat 6 Port, "db09": Data - DB-09 Port, "f-type": Data - F-Type/Coaxial Port, "firewire": Data - Firewire IEEE 1394 Port, "keystone1": Data - Keystone Jack, "keystone2": Data - Keystone Jack - Dual, "ps2": Data - PS2 Port, "usb-a": Data - USB-A Port, "usb-b": Data - USB-B Port]

// Row 2 type (if not using a Full Plate option)
Gang_3_Row_2 = "none";							// ["none": None, "blank": Blank Port, "bananaJackSet": A/V - Banana Jack Set, "bananaJackSetWithBorder": A/V - Banana Jack Set With Border, "displayport": A/V - Displayport, "dvi": A/V - DVI-I Port, "hdmi": A/V - HDMI Port, "neutrik": A/V - Neutrik Cutout, "svideo": A/V - S-Video Port, "stereo": A/V - Stereo Headphone Jack, "vga": A/V - VGA Port, "cat5e": Data - Cat 5e / Cat 6 Port, "db09": Data - DB-09 Port, "f-type": Data - F-Type/Coaxial Port, "firewire": Data - Firewire IEEE 1394 Port, "keystone1": Data - Keystone Jack, "keystone2": Data - Keystone Jack - Dual, "ps2": Data - PS2 Port, "usb-a": Data - USB-A Port, "usb-b": Data - USB-B Port]

// Row 3 type (if not using a Full Plate option)
Gang_3_Row_3 = "none";							// ["none": None, "blank": Blank Port, "bananaJackSet": A/V - Banana Jack Set, "bananaJackSetWithBorder": A/V - Banana Jack Set With Border, "displayport": A/V - Displayport, "dvi": A/V - DVI-I Port, "hdmi": A/V - HDMI Port, "neutrik": A/V - Neutrik Cutout, "svideo": A/V - S-Video Port, "stereo": A/V - Stereo Headphone Jack, "vga": A/V - VGA Port, "cat5e": Data - Cat 5e / Cat 6 Port, "db09": Data - DB-09 Port, "f-type": Data - F-Type/Coaxial Port, "firewire": Data - Firewire IEEE 1394 Port, "keystone1": Data - Keystone Jack, "keystone2": Data - Keystone Jack - Dual, "ps2": Data - PS2 Port, "usb-a": Data - USB-A Port, "usb-b": Data - USB-B Port]





/* [Gang 4 Settings] */
Gang_4_Full_Plate = "none";						// ["none": None, "button": Lighting - Pushbutton Pair, "rocker": Lighting - Rocker / Paddle / Leviton 'Decora', "rotary": Lighting - Rotary Dimmer / Fan Control, "toggle": Lighting - Toggle Switch, "long_toggle": Lighting - Toggle Switch - Long, "L5-30P": Power - NEMA L5-30P, "outletDespardSingle": Power - Outlet - Despard Single, "outletDespardDouble": Power - Outlet - Despard Double, "outletDespardTriple": Power - Outlet - Despard Triple, "outletDuplex": Power - Outlet - Duplex]

// Fine-tune row padding
Gang_4_Row_Pitch_Adjust = 0;					// [-4:16]

// Row 1 type (if not using a Full Plate option)
Gang_4_Row_1 = "none";							// ["none": None, "blank": Blank Port, "bananaJackSet": A/V - Banana Jack Set, "bananaJackSetWithBorder": A/V - Banana Jack Set With Border, "displayport": A/V - Displayport, "dvi": A/V - DVI-I Port, "hdmi": A/V - HDMI Port, "neutrik": A/V - Neutrik Cutout, "svideo": A/V - S-Video Port, "stereo": A/V - Stereo Headphone Jack, "vga": A/V - VGA Port, "cat5e": Data - Cat 5e / Cat 6 Port, "db09": Data - DB-09 Port, "f-type": Data - F-Type/Coaxial Port, "firewire": Data - Firewire IEEE 1394 Port, "keystone1": Data - Keystone Jack, "keystone2": Data - Keystone Jack - Dual, "ps2": Data - PS2 Port, "usb-a": Data - USB-A Port, "usb-b": Data - USB-B Port]

// Row 2 type (if not using a Full Plate option)
Gang_4_Row_2 = "none";							// ["none": None, "blank": Blank Port, "bananaJackSet": A/V - Banana Jack Set, "bananaJackSetWithBorder": A/V - Banana Jack Set With Border, "displayport": A/V - Displayport, "dvi": A/V - DVI-I Port, "hdmi": A/V - HDMI Port, "neutrik": A/V - Neutrik Cutout, "svideo": A/V - S-Video Port, "stereo": A/V - Stereo Headphone Jack, "vga": A/V - VGA Port, "cat5e": Data - Cat 5e / Cat 6 Port, "db09": Data - DB-09 Port, "f-type": Data - F-Type/Coaxial Port, "firewire": Data - Firewire IEEE 1394 Port, "keystone1": Data - Keystone Jack, "keystone2": Data - Keystone Jack - Dual, "ps2": Data - PS2 Port, "usb-a": Data - USB-A Port, "usb-b": Data - USB-B Port]

// Row 3 type (if not using a Full Plate option)
Gang_4_Row_3 = "none";							// ["none": None, "blank": Blank Port, "bananaJackSet": A/V - Banana Jack Set, "bananaJackSetWithBorder": A/V - Banana Jack Set With Border, "displayport": A/V - Displayport, "dvi": A/V - DVI-I Port, "hdmi": A/V - HDMI Port, "neutrik": A/V - Neutrik Cutout, "svideo": A/V - S-Video Port, "stereo": A/V - Stereo Headphone Jack, "vga": A/V - VGA Port, "cat5e": Data - Cat 5e / Cat 6 Port, "db09": Data - DB-09 Port, "f-type": Data - F-Type/Coaxial Port, "firewire": Data - Firewire IEEE 1394 Port, "keystone1": Data - Keystone Jack, "keystone2": Data - Keystone Jack - Dual, "ps2": Data - PS2 Port, "usb-a": Data - USB-A Port, "usb-b": Data - USB-B Port]





/* [Gang 5 Settings] */
Gang_5_Full_Plate = "none";						// ["none": None, "button": Lighting - Pushbutton Pair, "rocker": Lighting - Rocker / Paddle / Leviton 'Decora', "rotary": Lighting - Rotary Dimmer / Fan Control, "toggle": Lighting - Toggle Switch, "long_toggle": Lighting - Toggle Switch - Long, "L5-30P": Power - NEMA L5-30P, "outletDespardSingle": Power - Outlet - Despard Single, "outletDespardDouble": Power - Outlet - Despard Double, "outletDespardTriple": Power - Outlet - Despard Triple, "outletDuplex": Power - Outlet - Duplex]

// Fine-tune row padding
Gang_5_Row_Pitch_Adjust = 0;					// [-4:16]

// Row 1 type (if not using a Full Plate option)
Gang_5_Row_1 = "none";							// ["none": None, "blank": Blank Port, "bananaJackSet": A/V - Banana Jack Set, "bananaJackSetWithBorder": A/V - Banana Jack Set With Border, "displayport": A/V - Displayport, "dvi": A/V - DVI-I Port, "hdmi": A/V - HDMI Port, "neutrik": A/V - Neutrik Cutout, "svideo": A/V - S-Video Port, "stereo": A/V - Stereo Headphone Jack, "vga": A/V - VGA Port, "cat5e": Data - Cat 5e / Cat 6 Port, "db09": Data - DB-09 Port, "f-type": Data - F-Type/Coaxial Port, "firewire": Data - Firewire IEEE 1394 Port, "keystone1": Data - Keystone Jack, "keystone2": Data - Keystone Jack - Dual, "ps2": Data - PS2 Port, "usb-a": Data - USB-A Port, "usb-b": Data - USB-B Port]

// Row 2 type (if not using a Full Plate option)
Gang_5_Row_2 = "none";							// ["none": None, "blank": Blank Port, "bananaJackSet": A/V - Banana Jack Set, "bananaJackSetWithBorder": A/V - Banana Jack Set With Border, "displayport": A/V - Displayport, "dvi": A/V - DVI-I Port, "hdmi": A/V - HDMI Port, "neutrik": A/V - Neutrik Cutout, "svideo": A/V - S-Video Port, "stereo": A/V - Stereo Headphone Jack, "vga": A/V - VGA Port, "cat5e": Data - Cat 5e / Cat 6 Port, "db09": Data - DB-09 Port, "f-type": Data - F-Type/Coaxial Port, "firewire": Data - Firewire IEEE 1394 Port, "keystone1": Data - Keystone Jack, "keystone2": Data - Keystone Jack - Dual, "ps2": Data - PS2 Port, "usb-a": Data - USB-A Port, "usb-b": Data - USB-B Port]

// Row 3 type (if not using a Full Plate option)
Gang_5_Row_3 = "none";							// ["none": None, "blank": Blank Port, "bananaJackSet": A/V - Banana Jack Set, "bananaJackSetWithBorder": A/V - Banana Jack Set With Border, "displayport": A/V - Displayport, "dvi": A/V - DVI-I Port, "hdmi": A/V - HDMI Port, "neutrik": A/V - Neutrik Cutout, "svideo": A/V - S-Video Port, "stereo": A/V - Stereo Headphone Jack, "vga": A/V - VGA Port, "cat5e": Data - Cat 5e / Cat 6 Port, "db09": Data - DB-09 Port, "f-type": Data - F-Type/Coaxial Port, "firewire": Data - Firewire IEEE 1394 Port, "keystone1": Data - Keystone Jack, "keystone2": Data - Keystone Jack - Dual, "ps2": Data - PS2 Port, "usb-a": Data - USB-A Port, "usb-b": Data - USB-B Port]





/* [Label Settings] */
Label_01_Text = "";
Label_01_Font = "Liberation Mono";
Label_01_Size = 4;									// [1:16]
Label_01_X_Method = "1";							// ["1": Centered at Gang 1, "2": Centered at Gang 2, "3": Centered at Gang 3, "4": Centered at Gang 4, "5": Centered at Gang 5, "0": Free-floating]
Label_01_X = 0;										// [0:256]
Label_01_Y = 0;										// [-64:64]
Label_01_Cut_Depth = 2;								// [0:0.5:2]
Label_01_Angle = 0;									// [0:359]


Label_02_Text = "";
Label_02_Font = "Liberation Mono";
Label_02_Size = 4;									// [1:16]
Label_02_X_Method = "1";							// ["1": Centered at Gang 1, "2": Centered at Gang 2, "3": Centered at Gang 3, "4": Centered at Gang 4, "5": Centered at Gang 5, "0": Free-floating]
Label_02_X = 0;										// [0:256]
Label_02_Y = 0;										// [-64:64]
Label_02_Cut_Depth = 2;								// [0:0.5:2]
Label_02_Angle = 0;									// [0:359]


Label_03_Text = "";
Label_03_Font = "Liberation Mono";
Label_03_Size = 4;									// [1:16]
Label_03_X_Method = "1";							// ["1": Centered at Gang 1, "2": Centered at Gang 2, "3": Centered at Gang 3, "4": Centered at Gang 4, "5": Centered at Gang 5, "0": Free-floating]
Label_03_X = 0;										// [0:256]
Label_03_Y = 0;										// [-64:64]
Label_03_Cut_Depth = 2;								// [0:0.5:2]
Label_03_Angle = 0;									// [0:359]


Label_04_Text = "";
Label_04_Font = "Liberation Mono";
Label_04_Size = 4;									// [1:16]
Label_04_X_Method = "1";							// ["1": Centered at Gang 1, "2": Centered at Gang 2, "3": Centered at Gang 3, "4": Centered at Gang 4, "5": Centered at Gang 5, "0": Free-floating]
Label_04_X = 0;										// [0:256]
Label_04_Y = 0;										// [-64:64]
Label_04_Cut_Depth = 2;								// [0:0.5:2]
Label_04_Angle = 0;									// [0:359]


Label_05_Text = "";
Label_05_Font = "Liberation Mono";
Label_05_Size = 4;									// [1:16]
Label_05_X_Method = "1";							// ["1": Centered at Gang 1, "2": Centered at Gang 2, "3": Centered at Gang 3, "4": Centered at Gang 4, "5": Centered at Gang 5, "0": Free-floating]
Label_05_X = 0;										// [0:256]
Label_05_Y = 0;										// [-64:64]
Label_05_Cut_Depth = 2;								// [0:0.5:2]
Label_05_Angle = 0;									// [0:359]


Label_06_Text = "";
Label_06_Font = "Liberation Mono";
Label_06_Size = 4;									// [1:16]
Label_06_X_Method = "1";							// ["1": Centered at Gang 1, "2": Centered at Gang 2, "3": Centered at Gang 3, "4": Centered at Gang 4, "5": Centered at Gang 5, "0": Free-floating]
Label_06_X = 0;										// [0:256]
Label_06_Y = 0;										// [-64:64]
Label_06_Cut_Depth = 2;								// [0:0.5:2]
Label_06_Angle = 0;									// [0:359]


Label_07_Text = "";
Label_07_Font = "Liberation Mono";
Label_07_Size = 4;									// [1:16]
Label_07_X_Method = "1";							// ["1": Centered at Gang 1, "2": Centered at Gang 2, "3": Centered at Gang 3, "4": Centered at Gang 4, "5": Centered at Gang 5, "0": Free-floating]
Label_07_X = 0;										// [0:256]
Label_07_Y = 0;										// [-64:64]
Label_07_Cut_Depth = 2;								// [0:0.5:2]
Label_07_Angle = 0;									// [0:359]


Label_08_Text = "";
Label_08_Font = "Liberation Mono";
Label_08_Size = 4;									// [1:16]
Label_08_X_Method = "1";							// ["1": Centered at Gang 1, "2": Centered at Gang 2, "3": Centered at Gang 3, "4": Centered at Gang 4, "5": Centered at Gang 5, "0": Free-floating]
Label_08_X = 0;										// [0:256]
Label_08_Y = 0;										// [-64:64]
Label_08_Cut_Depth = 2;								// [0:0.5:2]
Label_08_Angle = 0;									// [0:359]


Label_09_Text = "";
Label_09_Font = "Liberation Mono";
Label_09_Size = 4;									// [1:16]
Label_09_X_Method = "1";							// ["1": Centered at Gang 1, "2": Centered at Gang 2, "3": Centered at Gang 3, "4": Centered at Gang 4, "5": Centered at Gang 5, "0": Free-floating]
Label_09_X = 0;										// [0:256]
Label_09_Y = 0;										// [-64:64]
Label_09_Cut_Depth = 2;								// [0:0.5:2]
Label_09_Angle = 0;									// [0:359]


Label_10_Text = "";
Label_10_Font = "Liberation Mono";
Label_10_Size = 4;									// [1:16]
Label_10_X_Method = "1";							// ["1": Centered at Gang 1, "2": Centered at Gang 2, "3": Centered at Gang 3, "4": Centered at Gang 4, "5": Centered at Gang 5, "0": Free-floating]
Label_10_X = 0;										// [0:256]
Label_10_Y = 0;										// [-64:64]
Label_10_Cut_Depth = 2;								// [0:0.5:2]
Label_10_Angle = 0;									// [0:359]


Label_11_Text = "";
Label_11_Font = "Liberation Mono";
Label_11_Size = 4;									// [1:16]
Label_11_X_Method = "1";							// ["1": Centered at Gang 1, "2": Centered at Gang 2, "3": Centered at Gang 3, "4": Centered at Gang 4, "5": Centered at Gang 5, "0": Free-floating]
Label_11_X = 0;										// [0:256]
Label_11_Y = 0;										// [-64:64]
Label_11_Cut_Depth = 2;								// [0:0.5:2]
Label_11_Angle = 0;									// [0:359]


Label_12_Text = "";
Label_12_Font = "Liberation Mono";
Label_12_Size = 4;									// [1:16]
Label_12_X_Method = "1";							// ["1": Centered at Gang 1, "2": Centered at Gang 2, "3": Centered at Gang 3, "4": Centered at Gang 4, "5": Centered at Gang 5, "0": Free-floating]
Label_12_X = 0;										// [0:256]
Label_12_Y = 0;										// [-64:64]
Label_12_Cut_Depth = 2;								// [0:0.5:2]
Label_12_Angle = 0;									// [0:359]


Label_13_Text = "";
Label_13_Font = "Liberation Mono";
Label_13_Size = 4;									// [1:16]
Label_13_X_Method = "1";							// ["1": Centered at Gang 1, "2": Centered at Gang 2, "3": Centered at Gang 3, "4": Centered at Gang 4, "5": Centered at Gang 5, "0": Free-floating]
Label_13_X = 0;										// [0:256]
Label_13_Y = 0;										// [-64:64]
Label_13_Cut_Depth = 2;								// [0:0.5:2]
Label_13_Angle = 0;									// [0:359]


Label_14_Text = "";
Label_14_Font = "Liberation Mono";
Label_14_Size = 4;									// [1:16]
Label_14_X_Method = "1";							// ["1": Centered at Gang 1, "2": Centered at Gang 2, "3": Centered at Gang 3, "4": Centered at Gang 4, "5": Centered at Gang 5, "0": Free-floating]
Label_14_X = 0;										// [0:256]
Label_14_Y = 0;										// [-64:64]
Label_14_Cut_Depth = 2;								// [0:0.5:2]
Label_14_Angle = 0;									// [0:359]


Label_15_Text = "";
Label_15_Font = "Liberation Mono";
Label_15_Size = 4;									// [1:16]
Label_15_X_Method = "1";							// ["1": Centered at Gang 1, "2": Centered at Gang 2, "3": Centered at Gang 3, "4": Centered at Gang 4, "5": Centered at Gang 5, "0": Free-floating]
Label_15_X = 0;										// [0:256]
Label_15_Y = 0;										// [-64:64]
Label_15_Cut_Depth = 2;								// [0:0.5:2]
Label_15_Angle = 0;									// [0:359]


Label_16_Text = "";
Label_16_Font = "Liberation Mono";
Label_16_Size = 4;									// [1:16]
Label_16_X_Method = "1";							// ["1": Centered at Gang 1, "2": Centered at Gang 2, "3": Centered at Gang 3, "4": Centered at Gang 4, "5": Centered at Gang 5, "0": Free-floating]
Label_16_X = 0;										// [0:256]
Label_16_Y = 0;										// [-64:64]
Label_16_Cut_Depth = 2;								// [0:0.5:2]
Label_16_Angle = 0;									// [0:359]


Label_17_Text = "";
Label_17_Font = "Liberation Mono";
Label_17_Size = 4;									// [1:16]
Label_17_X_Method = "1";							// ["1": Centered at Gang 1, "2": Centered at Gang 2, "3": Centered at Gang 3, "4": Centered at Gang 4, "5": Centered at Gang 5, "0": Free-floating]
Label_17_X = 0;										// [0:256]
Label_17_Y = 0;										// [-64:64]
Label_17_Cut_Depth = 2;								// [0:0.5:2]
Label_17_Angle = 0;									// [0:359]


Label_18_Text = "";
Label_18_Font = "Liberation Mono";
Label_18_Size = 4;									// [1:16]
Label_18_X_Method = "1";							// ["1": Centered at Gang 1, "2": Centered at Gang 2, "3": Centered at Gang 3, "4": Centered at Gang 4, "5": Centered at Gang 5, "0": Free-floating]
Label_18_X = 0;										// [0:256]
Label_18_Y = 0;										// [-64:64]
Label_18_Cut_Depth = 2;								// [0:0.5:2]
Label_18_Angle = 0;									// [0:359]


Label_19_Text = "";
Label_19_Font = "Liberation Mono";
Label_19_Size = 4;									// [1:16]
Label_19_X_Method = "1";							// ["1": Centered at Gang 1, "2": Centered at Gang 2, "3": Centered at Gang 3, "4": Centered at Gang 4, "5": Centered at Gang 5, "0": Free-floating]
Label_19_X = 0;										// [0:256]
Label_19_Y = 0;										// [-64:64]
Label_19_Cut_Depth = 2;								// [0:0.5:2]
Label_19_Angle = 0;									// [0:359]


Label_20_Text = "";
Label_20_Font = "Liberation Mono";
Label_20_Size = 4;									// [1:16]
Label_20_X_Method = "1";							// ["1": Centered at Gang 1, "2": Centered at Gang 2, "3": Centered at Gang 3, "4": Centered at Gang 4, "5": Centered at Gang 5, "0": Free-floating]
Label_20_X = 0;										// [0:256]
Label_20_Y = 0;										// [-64:64]
Label_20_Cut_Depth = 2;								// [0:0.5:2]
Label_20_Angle = 0;									// [0:359]


Label_21_Text = "";
Label_21_Font = "Liberation Mono";
Label_21_Size = 4;									// [1:16]
Label_21_X_Method = "1";							// ["1": Centered at Gang 1, "2": Centered at Gang 2, "3": Centered at Gang 3, "4": Centered at Gang 4, "5": Centered at Gang 5, "0": Free-floating]
Label_21_X = 0;										// [0:256]
Label_21_Y = 0;										// [-64:64]
Label_21_Cut_Depth = 2;								// [0:0.5:2]
Label_21_Angle = 0;									// [0:359]


Label_22_Text = "";
Label_22_Font = "Liberation Mono";
Label_22_Size = 4;									// [1:16]
Label_22_X_Method = "1";							// ["1": Centered at Gang 1, "2": Centered at Gang 2, "3": Centered at Gang 3, "4": Centered at Gang 4, "5": Centered at Gang 5, "0": Free-floating]
Label_22_X = 0;										// [0:256]
Label_22_Y = 0;										// [-64:64]
Label_22_Cut_Depth = 2;								// [0:0.5:2]
Label_22_Angle = 0;									// [0:359]


Label_23_Text = "";
Label_23_Font = "Liberation Mono";
Label_23_Size = 4;									// [1:16]
Label_23_X_Method = "1";							// ["1": Centered at Gang 1, "2": Centered at Gang 2, "3": Centered at Gang 3, "4": Centered at Gang 4, "5": Centered at Gang 5, "0": Free-floating]
Label_23_X = 0;										// [0:256]
Label_23_Y = 0;										// [-64:64]
Label_23_Cut_Depth = 2;								// [0:0.5:2]
Label_23_Angle = 0;									// [0:359]


Label_24_Text = "";
Label_24_Font = "Liberation Mono";
Label_24_Size = 4;									// [1:16]
Label_24_X_Method = "1";							// ["1": Centered at Gang 1, "2": Centered at Gang 2, "3": Centered at Gang 3, "4": Centered at Gang 4, "5": Centered at Gang 5, "0": Free-floating]
Label_24_X = 0;										// [0:256]
Label_24_Y = 0;										// [-64:64]
Label_24_Cut_Depth = 2;								// [0:0.5:2]
Label_24_Angle = 0;									// [0:359]


Label_25_Text = "";
Label_25_Font = "Liberation Mono";
Label_25_Size = 4;									// [1:16]
Label_25_X_Method = "1";							// ["1": Centered at Gang 1, "2": Centered at Gang 2, "3": Centered at Gang 3, "4": Centered at Gang 4, "5": Centered at Gang 5, "0": Free-floating]
Label_25_X = 0;										// [0:256]
Label_25_Y = 0;										// [-64:64]
Label_25_Cut_Depth = 2;								// [0:0.5:2]
Label_25_Angle = 0;									// [0:359]


Label_26_Text = "";
Label_26_Font = "Liberation Mono";
Label_26_Size = 4;									// [1:16]
Label_26_X_Method = "1";							// ["1": Centered at Gang 1, "2": Centered at Gang 2, "3": Centered at Gang 3, "4": Centered at Gang 4, "5": Centered at Gang 5, "0": Free-floating]
Label_26_X = 0;										// [0:256]
Label_26_Y = 0;										// [-64:64]
Label_26_Cut_Depth = 2;								// [0:0.5:2]
Label_26_Angle = 0;									// [0:359]


Label_27_Text = "";
Label_27_Font = "Liberation Mono";
Label_27_Size = 4;									// [1:16]
Label_27_X_Method = "1";							// ["1": Centered at Gang 1, "2": Centered at Gang 2, "3": Centered at Gang 3, "4": Centered at Gang 4, "5": Centered at Gang 5, "0": Free-floating]
Label_27_X = 0;										// [0:256]
Label_27_Y = 0;										// [-64:64]
Label_27_Cut_Depth = 2;								// [0:0.5:2]
Label_27_Angle = 0;									// [0:359]


Label_28_Text = "";
Label_28_Font = "Liberation Mono";
Label_28_Size = 4;									// [1:16]
Label_28_X_Method = "1";							// ["1": Centered at Gang 1, "2": Centered at Gang 2, "3": Centered at Gang 3, "4": Centered at Gang 4, "5": Centered at Gang 5, "0": Free-floating]
Label_28_X = 0;										// [0:256]
Label_28_Y = 0;										// [-64:64]
Label_28_Cut_Depth = 2;								// [0:0.5:2]
Label_28_Angle = 0;									// [0:359]


Label_29_Text = "";
Label_29_Font = "Liberation Mono";
Label_29_Size = 4;									// [1:16]
Label_29_X_Method = "1";							// ["1": Centered at Gang 1, "2": Centered at Gang 2, "3": Centered at Gang 3, "4": Centered at Gang 4, "5": Centered at Gang 5, "0": Free-floating]
Label_29_X = 0;										// [0:256]
Label_29_Y = 0;										// [-64:64]
Label_29_Cut_Depth = 2;								// [0:0.5:2]
Label_29_Angle = 0;									// [0:359]


Label_30_Text = "";
Label_30_Font = "Liberation Mono";
Label_30_Size = 4;									// [1:16]
Label_30_X_Method = "1";							// ["1": Centered at Gang 1, "2": Centered at Gang 2, "3": Centered at Gang 3, "4": Centered at Gang 4, "5": Centered at Gang 5, "0": Free-floating]
Label_30_X = 0;										// [0:256]
Label_30_Y = 0;										// [-64:64]
Label_30_Cut_Depth = 2;								// [0:0.5:2]
Label_30_Angle = 0;									// [0:359]


Label_31_Text = "";
Label_31_Font = "Liberation Mono";
Label_31_Size = 4;									// [1:16]
Label_31_X_Method = "1";							// ["1": Centered at Gang 1, "2": Centered at Gang 2, "3": Centered at Gang 3, "4": Centered at Gang 4, "5": Centered at Gang 5, "0": Free-floating]
Label_31_X = 0;										// [0:256]
Label_31_Y = 0;										// [-64:64]
Label_31_Cut_Depth = 2;								// [0:0.5:2]
Label_31_Angle = 0;									// [0:359]


Label_32_Text = "";
Label_32_Font = "Liberation Mono";
Label_32_Size = 4;									// [1:16]
Label_32_X_Method = "1";							// ["1": Centered at Gang 1, "2": Centered at Gang 2, "3": Centered at Gang 3, "4": Centered at Gang 4, "5": Centered at Gang 5, "0": Free-floating]
Label_32_X = 0;										// [0:256]
Label_32_Y = 0;										// [-64:64]
Label_32_Cut_Depth = 2;								// [0:0.5:2]
Label_32_Angle = 0;									// [0:359]


Label_33_Text = "";
Label_33_Font = "Liberation Mono";
Label_33_Size = 4;									// [1:16]
Label_33_X_Method = "1";							// ["1": Centered at Gang 1, "2": Centered at Gang 2, "3": Centered at Gang 3, "4": Centered at Gang 4, "5": Centered at Gang 5, "0": Free-floating]
Label_33_X = 0;										// [0:256]
Label_33_Y = 0;										// [-64:64]
Label_33_Cut_Depth = 2;								// [0:0.5:2]
Label_33_Angle = 0;									// [0:359]


Label_34_Text = "";
Label_34_Font = "Liberation Mono";
Label_34_Size = 4;									// [1:16]
Label_34_X_Method = "1";							// ["1": Centered at Gang 1, "2": Centered at Gang 2, "3": Centered at Gang 3, "4": Centered at Gang 4, "5": Centered at Gang 5, "0": Free-floating]
Label_34_X = 0;										// [0:256]
Label_34_Y = 0;										// [-64:64]
Label_34_Cut_Depth = 2;								// [0:0.5:2]
Label_34_Angle = 0;									// [0:359]


Label_35_Text = "";
Label_35_Font = "Liberation Mono";
Label_35_Size = 4;									// [1:16]
Label_35_X_Method = "1";							// ["1": Centered at Gang 1, "2": Centered at Gang 2, "3": Centered at Gang 3, "4": Centered at Gang 4, "5": Centered at Gang 5, "0": Free-floating]
Label_35_X = 0;										// [0:256]
Label_35_Y = 0;										// [-64:64]
Label_35_Cut_Depth = 2;								// [0:0.5:2]
Label_35_Angle = 0;									// [0:359]


Label_36_Text = "";
Label_36_Font = "Liberation Mono";
Label_36_Size = 4;									// [1:16]
Label_36_X_Method = "1";							// ["1": Centered at Gang 1, "2": Centered at Gang 2, "3": Centered at Gang 3, "4": Centered at Gang 4, "5": Centered at Gang 5, "0": Free-floating]
Label_36_X = 0;										// [0:256]
Label_36_Y = 0;										// [-64:64]
Label_36_Cut_Depth = 2;								// [0:0.5:2]
Label_36_Angle = 0;									// [0:359]


Label_37_Text = "";
Label_37_Font = "Liberation Mono";
Label_37_Size = 4;									// [1:16]
Label_37_X_Method = "1";							// ["1": Centered at Gang 1, "2": Centered at Gang 2, "3": Centered at Gang 3, "4": Centered at Gang 4, "5": Centered at Gang 5, "0": Free-floating]
Label_37_X = 0;										// [0:256]
Label_37_Y = 0;										// [-64:64]
Label_37_Cut_Depth = 2;								// [0:0.5:2]
Label_37_Angle = 0;									// [0:359]


Label_38_Text = "";
Label_38_Font = "Liberation Mono";
Label_38_Size = 4;									// [1:16]
Label_38_X_Method = "1";							// ["1": Centered at Gang 1, "2": Centered at Gang 2, "3": Centered at Gang 3, "4": Centered at Gang 4, "5": Centered at Gang 5, "0": Free-floating]
Label_38_X = 0;										// [0:256]
Label_38_Y = 0;										// [-64:64]
Label_38_Cut_Depth = 2;								// [0:0.5:2]
Label_38_Angle = 0;									// [0:359]


Label_39_Text = "";
Label_39_Font = "Liberation Mono";
Label_39_Size = 4;									// [1:16]
Label_39_X_Method = "1";							// ["1": Centered at Gang 1, "2": Centered at Gang 2, "3": Centered at Gang 3, "4": Centered at Gang 4, "5": Centered at Gang 5, "0": Free-floating]
Label_39_X = 0;										// [0:256]
Label_39_Y = 0;										// [-64:64]
Label_39_Cut_Depth = 2;								// [0:0.5:2]
Label_39_Angle = 0;									// [0:359]


Label_40_Text = "";
Label_40_Font = "Liberation Mono";
Label_40_Size = 4;									// [1:16]
Label_40_X_Method = "1";							// ["1": Centered at Gang 1, "2": Centered at Gang 2, "3": Centered at Gang 3, "4": Centered at Gang 4, "5": Centered at Gang 5, "0": Free-floating]
Label_40_X = 0;										// [0:256]
Label_40_Y = 0;										// [-64:64]
Label_40_Cut_Depth = 2;								// [0:0.5:2]
Label_40_Angle = 0;									// [0:359]





module CustomizerBegone()
{
	// This module is here to stop Customizer from picking up the variables below
}





// Define some gGlobals
rowPitchList = [Gang_1_Row_Pitch_Adjust, Gang_2_Row_Pitch_Adjust, Gang_3_Row_Pitch_Adjust, Gang_4_Row_Pitch_Adjust, Gang_5_Row_Pitch_Adjust];

l_offset = [34.925, 39.6875, 44.45];
r_offset = [34.925, 39.6875, 44.45];
spacer = [0, 0, 46.0375, 92.075, 138.1125, 184.15];
solid_plate_width = l_offset[plate_size] + spacer[plate_width] + r_offset[plate_size];

height_sizes = [114.3, 123.825, 133.35];

kEdgeWidth = solid_plate_width + 10; // Bevel setting for top and bottom
kRightBevel = solid_plate_width - 4; // Bevel for right side (scales)

kSwitchOffset = 46.0375; // Offset all additional holes
kThinnerOffset = [0, 0.92, 0.95, 0.96, 0.97, 0.973]; // Manual fix for right side wackiness

kMiddleLine = height_sizes[plate_size] / 2;

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
gTextLabels =
[
	[Label_01_Text, Label_01_Font, Label_01_Size, Label_01_X_Method, Label_01_X, Label_01_Y, Label_01_Cut_Depth, Label_01_Angle],
	[Label_02_Text, Label_02_Font, Label_02_Size, Label_02_X_Method, Label_02_X, Label_02_Y, Label_02_Cut_Depth, Label_02_Angle],
	[Label_03_Text, Label_03_Font, Label_03_Size, Label_03_X_Method, Label_03_X, Label_03_Y, Label_03_Cut_Depth, Label_03_Angle],
	[Label_04_Text, Label_04_Font, Label_04_Size, Label_04_X_Method, Label_04_X, Label_04_Y, Label_04_Cut_Depth, Label_04_Angle],
	[Label_05_Text, Label_05_Font, Label_05_Size, Label_05_X_Method, Label_05_X, Label_05_Y, Label_05_Cut_Depth, Label_05_Angle],
	[Label_06_Text, Label_06_Font, Label_06_Size, Label_06_X_Method, Label_06_X, Label_06_Y, Label_06_Cut_Depth, Label_06_Angle],
	[Label_07_Text, Label_07_Font, Label_07_Size, Label_07_X_Method, Label_07_X, Label_07_Y, Label_07_Cut_Depth, Label_07_Angle],
	[Label_08_Text, Label_08_Font, Label_08_Size, Label_08_X_Method, Label_08_X, Label_08_Y, Label_08_Cut_Depth, Label_08_Angle],
	[Label_09_Text, Label_09_Font, Label_09_Size, Label_09_X_Method, Label_09_X, Label_09_Y, Label_09_Cut_Depth, Label_09_Angle],
	[Label_10_Text, Label_10_Font, Label_10_Size, Label_10_X_Method, Label_10_X, Label_10_Y, Label_10_Cut_Depth, Label_10_Angle],
	[Label_11_Text, Label_11_Font, Label_11_Size, Label_11_X_Method, Label_11_X, Label_11_Y, Label_11_Cut_Depth, Label_11_Angle],
	[Label_12_Text, Label_12_Font, Label_12_Size, Label_12_X_Method, Label_12_X, Label_12_Y, Label_12_Cut_Depth, Label_12_Angle],
	[Label_13_Text, Label_13_Font, Label_13_Size, Label_13_X_Method, Label_13_X, Label_13_Y, Label_13_Cut_Depth, Label_13_Angle],
	[Label_14_Text, Label_14_Font, Label_14_Size, Label_14_X_Method, Label_14_X, Label_14_Y, Label_14_Cut_Depth, Label_14_Angle],
	[Label_15_Text, Label_15_Font, Label_15_Size, Label_15_X_Method, Label_15_X, Label_15_Y, Label_15_Cut_Depth, Label_15_Angle],
	[Label_16_Text, Label_16_Font, Label_16_Size, Label_16_X_Method, Label_16_X, Label_16_Y, Label_16_Cut_Depth, Label_16_Angle],
	[Label_17_Text, Label_17_Font, Label_17_Size, Label_17_X_Method, Label_17_X, Label_17_Y, Label_17_Cut_Depth, Label_17_Angle],
	[Label_18_Text, Label_18_Font, Label_18_Size, Label_18_X_Method, Label_18_X, Label_18_Y, Label_18_Cut_Depth, Label_18_Angle],
	[Label_19_Text, Label_19_Font, Label_19_Size, Label_19_X_Method, Label_19_X, Label_19_Y, Label_19_Cut_Depth, Label_19_Angle],
	[Label_20_Text, Label_20_Font, Label_20_Size, Label_20_X_Method, Label_20_X, Label_10_Y, Label_20_Cut_Depth, Label_20_Angle],
	[Label_21_Text, Label_21_Font, Label_21_Size, Label_21_X_Method, Label_21_X, Label_01_Y, Label_21_Cut_Depth, Label_21_Angle],
	[Label_22_Text, Label_22_Font, Label_22_Size, Label_22_X_Method, Label_22_X, Label_02_Y, Label_22_Cut_Depth, Label_22_Angle],
	[Label_23_Text, Label_23_Font, Label_23_Size, Label_23_X_Method, Label_23_X, Label_03_Y, Label_23_Cut_Depth, Label_23_Angle],
	[Label_24_Text, Label_24_Font, Label_24_Size, Label_24_X_Method, Label_24_X, Label_04_Y, Label_24_Cut_Depth, Label_24_Angle],
	[Label_25_Text, Label_25_Font, Label_25_Size, Label_25_X_Method, Label_25_X, Label_05_Y, Label_25_Cut_Depth, Label_25_Angle],
	[Label_26_Text, Label_26_Font, Label_26_Size, Label_26_X_Method, Label_26_X, Label_06_Y, Label_26_Cut_Depth, Label_26_Angle],
	[Label_27_Text, Label_27_Font, Label_27_Size, Label_27_X_Method, Label_27_X, Label_07_Y, Label_27_Cut_Depth, Label_27_Angle],
	[Label_28_Text, Label_28_Font, Label_28_Size, Label_28_X_Method, Label_28_X, Label_08_Y, Label_28_Cut_Depth, Label_28_Angle],
	[Label_29_Text, Label_29_Font, Label_29_Size, Label_29_X_Method, Label_29_X, Label_09_Y, Label_29_Cut_Depth, Label_29_Angle],
	[Label_30_Text, Label_30_Font, Label_30_Size, Label_30_X_Method, Label_30_X, Label_30_Y, Label_30_Cut_Depth, Label_30_Angle],
	[Label_31_Text, Label_31_Font, Label_31_Size, Label_31_X_Method, Label_31_X, Label_31_Y, Label_31_Cut_Depth, Label_31_Angle],
	[Label_32_Text, Label_32_Font, Label_32_Size, Label_32_X_Method, Label_32_X, Label_32_Y, Label_32_Cut_Depth, Label_32_Angle],
	[Label_33_Text, Label_33_Font, Label_33_Size, Label_33_X_Method, Label_33_X, Label_33_Y, Label_33_Cut_Depth, Label_33_Angle],
	[Label_34_Text, Label_34_Font, Label_34_Size, Label_34_X_Method, Label_34_X, Label_34_Y, Label_34_Cut_Depth, Label_34_Angle],
	[Label_35_Text, Label_35_Font, Label_35_Size, Label_35_X_Method, Label_35_X, Label_35_Y, Label_35_Cut_Depth, Label_35_Angle],
	[Label_36_Text, Label_36_Font, Label_36_Size, Label_36_X_Method, Label_36_X, Label_36_Y, Label_36_Cut_Depth, Label_36_Angle],
	[Label_37_Text, Label_37_Font, Label_37_Size, Label_37_X_Method, Label_37_X, Label_37_Y, Label_37_Cut_Depth, Label_37_Angle],
	[Label_38_Text, Label_38_Font, Label_38_Size, Label_38_X_Method, Label_38_X, Label_38_Y, Label_38_Cut_Depth, Label_38_Angle],
	[Label_39_Text, Label_39_Font, Label_39_Size, Label_39_X_Method, Label_39_X, Label_39_Y, Label_39_Cut_Depth, Label_39_Angle],
	[Label_40_Text, Label_40_Font, Label_40_Size, Label_40_X_Method, Label_40_X, Label_40_Y, Label_40_Cut_Depth, Label_40_Angle]
];

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
kLabelXMethod = 3;
kLabelX = 4;
kLabelY = 5;
kLabelCutDepth = 6;
kLabelAngle = 7;

// Pushbutton-related konstants
kPushbuttonDiameter = 13.081;
kPushbuttonOffset = 11.7094;





// BUILD! THAT! PLATE! YAYYYYYYYYYYY
// Rotate the plate so it sits face-up on the 3D printer's build plate.
// Monotonic Ironing is now a thing, and doing it this way means you can get some smoooooooth plate faces!
rotate([0, 0, -90])
{
	// put plate at 0, 0, 0 for easier printing
	translate([-kMiddleLine, -solid_plate_width / 2, -6])
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

					for (plateIndex = [0:plate_width - 1])
					{
						PlateBuild(plateIndex);
						PlateDoScrews(plateIndex);
					}
				}

				union()
				{
					for (plateIndex = [0:plate_width - 1])
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
	translate([y, x, 0]) cylinder(r = 4.7625, h = 10, center = true, $fn = cylinder_quality);
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
		cylinder(h = 14, d = kDespardDiameter, $fn = cylinder_quality);
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
		cylinder(r = 17.4625, h = 15, center = true, $fn = cylinder_quality);
		translate([-24.2875, -15, -2]) cube([10, 37, 15], center = false);
		translate([14.2875, -15, -2]) cube([10, 37, 15], center = false);
	}
}





module PlateBaseCreate()
{
	//Plate size and bevel
	difference()
	{
		cube([height_sizes[plate_size], solid_plate_width, 6]);
		translate([-4.3, -5, 6.2]) rotate([0, 45, 0]) cube([6, kEdgeWidth, 6]); //Top Bevel
		translate([height_sizes[plate_size] - 4.2, -5, 6.25]) rotate([0, 45, 0]) cube([6, kEdgeWidth, 6]); //Bottom Bevel
		translate([height_sizes[plate_size] + 10, -4.4, 6.1]) rotate([0, 45, 90]) cube([6, height_sizes[plate_size] + 20, 6]); //Left Bevel (doesn't change)
		translate([height_sizes[plate_size] + 10, kRightBevel, 6]) rotate([0, 45, 90]) cube([6, height_sizes[plate_size] + 10, 6]); //Right Bevel (scales right)
	}
}





module PlateBuild(plateIndex)
{
	// handle all "full plate" options first
	x = l_offset[plate_size] + kSwitchOffset * plateIndex;
	rowPitch = rowPitchList[plateIndex];

	if (gPlates[plateIndex] != "none")
	{
		// do the hole cutouts
		translate([0, l_offset[plate_size] + kSwitchOffset * plateIndex, 0]) PlateDoHoles(gPlates[plateIndex]);
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

	if (hole_type == "L5-30P")
	{
		translate([kMiddleLine, 0, 0]) cylinder(d = 35.5, h = 500, center = true, $fn = cylinder_quality);
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
		translate([kMiddleLine - kPushbuttonOffset, 0, 0]) cylinder(h = 7, d = kPushbuttonDiameter, $fn = cylinder_quality);
		translate([kMiddleLine + kPushbuttonOffset, 0, 0]) cylinder(h = 7, d = kPushbuttonDiameter, $fn = cylinder_quality);
	}

	if (hole_type == "rotary")
	{
		translate([kMiddleLine, 0, 0]) cylinder(r = 5, h = 7, $fn = cylinder_quality);
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
		translate([0, -12.5, 3]) cylinder(r = 1.75, h = 10, center = true, $fn = cylinder_quality);
		translate([0, 12.5, 3]) cylinder(r = 1.75, h = 10, center = true, $fn = cylinder_quality);
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
		translate([0, -13, 3]) cylinder(r = 1.75, h = 10, center = true, $fn = cylinder_quality);
		translate([0, 13, 3]) cylinder(r = 1.75, h = 10, center = true, $fn = cylinder_quality);
		translate([0, 0, 3]) cube([6, 16, 10], center = true);
	}

	if (hole_type == "dvi")
	{
		// Fits http://www.datapro.net/products/dvi-i-panel-mount-extension-cable.html
		translate([0, -16, 3]) cylinder(r = 1.75, h = 10, center = true, $fn = cylinder_quality);
		translate([0, 16, 3]) cylinder(r = 1.75, h = 10, center = true, $fn = cylinder_quality);
		translate([0, 0, 3]) cube([10, 26, 10], center = true);
	}

	if (hole_type == "displayport")
	{
		// Fits http://www.datapro.net/products/dvi-i-panel-mount-extension-cable.html
		translate([0, -13.5, 3]) cylinder(r = 1.75, h = 10, center = true, $fn = cylinder_quality);
		translate([0, 13.5, 3]) cylinder(r = 1.75, h = 10, center = true, $fn = cylinder_quality);
		difference()
		{
			translate([0, 0, 3]) cube([7, 19, 10], center = true);
			translate([2.47, -9.37, 3]) rotate([0, 0, -54.6]) cube([3, 5, 14], center = true);
		}
	}

	if (hole_type == "usb-a")
	{
		// Fits http://www.datapro.net/products/usb-panel-mount-type-a-cable.html
		translate([0, -15, 3]) cylinder(r = 1.75, h = 10, center = true, $fn = cylinder_quality);
		translate([0, 15, 3]) cylinder(r = 1.75, h = 10, center = true, $fn = cylinder_quality);
		translate([0, 0, 3]) cube([8, 16, 10], center = true);
	}

	if (hole_type == "usb-b")
	{
		// Fits http://www.datapro.net/products/usb-panel-mount-type-b-cable.html
		translate([0, -13, 3]) cylinder(r = 1.75, h = 10, center = true, $fn = cylinder_quality);
		translate([0, 13, 3]) cylinder(r = 1.75, h = 10, center = true, $fn = cylinder_quality);
		translate([0, 0, 3]) cube([11, 12, 10], center = true);
	}

	if (hole_type == "firewire")
	{
		// Fits http://www.datapro.net/products/firewire-panel-mount-extension.html
		translate([0, -13.5, 3]) cylinder(r = 1.75, h = 10, center = true, $fn = cylinder_quality);
		translate([0, 13.5, 3]) cylinder(r = 1.75, h = 10, center = true, $fn = cylinder_quality);
		translate([0, 0, 3]) cube([7, 12, 10], center = true);
	}

	if (hole_type == "f-type")
	{
		// Fits http://www.datapro.net/products/f-type-panel-mounting-coupler.html
		translate([0, 0, 3]) cylinder(r = 4.7625, h = 10, center = true, $fn = cylinder_quality);
	}

	if (hole_type == "cat5e" || hole_type == "cat6")
	{
		// Cat5e Fits http://www.datapro.net/products/cat-5e-panel-mount-ethernet.html
		// Cat6 Fits hhttp://www.datapro.net/products/cat-6-panel-mount-ethernet.html
		translate([0, -12.5, 3]) cylinder(r = 1.75, h = 10, center = true, $fn = cylinder_quality);
		translate([0, 12.5, 3]) cylinder(r = 1.75, h = 10, center = true, $fn = cylinder_quality);
		translate([0, 0, 3]) cube([15, 15, 10], center = true);
	}

	if (hole_type == "svideo" || hole_type == "ps2")
	{
		// S-Video Fits hhttp://www.datapro.net/products/cat-6-panel-mount-ethernet.html
		// PS2 http://www.datapro.net/products/ps2-panel-mount-extension-cable.html
		translate([0, -10, 3]) cylinder(r = 1.75, h = 10, center = true, $fn = cylinder_quality);			// screw hole - left
		translate([0, 10, 3]) cylinder(r = 1.75, h = 10, center = true, $fn = cylinder_quality);			// screw hole - right
		translate([0, 0, 3]) cylinder(r = 5, h = 10, center = true, $fn = cylinder_quality);				// center hole
	}


	if (hole_type == "stereo")
	{
		// Stereo coupler Fits http://www.datapro.net/products/stereo-panel-mount-coupler.html
		cylinder(r = 2.985, h = 15, center = true, $fn = cylinder_quality);
	}

	if (hole_type == "neutrik")
	{
		// Neutrik fits https://www.datapro.net/drawings/cutouts/neutrik_cutout.pdf
		cylinder(d = 24, h = 15, center = true, $fn = cylinder_quality);									// center hole
		translate([-12, -9.5, 0]) cylinder(d = 3.2, h = 15, $fn = cylinder_quality);						// screw hole - upper left
		translate([12, 9.5, 0]) cylinder(d = 3.2, h = 15, $fn = cylinder_quality);							// screw hole - lower right
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
	scale([0.95,kThinnerOffset[plate_width],1])
	{
		translate([3,3,0])
		{
			difference()
			{
				cube([height_sizes[plate_size], solid_plate_width, 6]);
				translate([-4.3, -5, 6.2]) rotate([0, 45, 0]) cube([6, kEdgeWidth, 6]); //Top Bevel
				translate([height_sizes[plate_size] - 4.2, -5, 6.25]) rotate([0, 45, 0]) cube([6, kEdgeWidth, 6]); //Bottom Bevel
				translate([height_sizes[plate_size] + 10, -4.4, 6.1]) rotate([0, 45, 90]) cube([6, height_sizes[plate_size] + 20, 6]); //Left Bevel (doesn't change)
				translate([height_sizes[plate_size] + 10, kRightBevel, 6]) rotate([0, 45, 90]) cube([6, height_sizes[plate_size] + 10, 6]); //Right Bevel (scales right)
			}
		}
	}
}





module PlateDoLabels()
{
	for (thisLabel = [0:len(gTextLabels) - 1])
	{
		thisLabelText = gTextLabels[thisLabel][kLabelText];
		thisLabelFont = gTextLabels[thisLabel][kLabelFont];
		thisLabelSize = gTextLabels[thisLabel][kLabelSize];
		thisLabelX = gTextLabels[thisLabel][kLabelX];
		thisLabelY = gTextLabels[thisLabel][kLabelY];
		thisLabelCutDepth = gTextLabels[thisLabel][kLabelCutDepth];
		thisLabelAngle = gTextLabels[thisLabel][kLabelAngle];

		// decide what x should be
		thisPlateNumber = search(gTextLabels[thisLabel][kLabelXMethod], [["1", 1], ["2", 2], ["3", 3], ["4", 4], ["5", 5], ["0", 0]])[0];
		x = gTextLabels[thisLabel][kLabelXMethod] == "0" ? thisLabelX : l_offset[plate_size] + (thisPlateNumber * kSwitchOffset);

		translate([kMiddleLine + thisLabelY, x, 6 - thisLabelCutDepth])
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
	x = l_offset[plate_size] + kSwitchOffset * plateIndex;
	plateType = gPlates[plateIndex];

	if (plateType != "none")
	{
		// This is a "Full Plate"
		if (plateType == "outletDuplex") translate([0, x, 0]) ScrewsCenter();
		if (plateType == "rocker" || plateType == "outletDespardSingle" || plateType == "outletDespardDouble" || plateType == "outletDespardTriple") translate([0, x, 0]) ScrewsRocker();
		if (plateType == "button" || plateType == "rotary" || plateType == "toggle" || plateType == "long_toggle" || plateType == "L5-30P") translate([0, x, 0]) ScrewsYoke();
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
				x = l_offset[plate_size] + kSwitchOffset * plateIndex - 11.5;
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
	translate([kMiddleLine + 41.67125, 0, -1]) cylinder(r = 2, h = 10, $fn = cylinder_quality);
	translate([kMiddleLine + 41.67125, 0, 3.5]) cylinder(r1 = 2, r2 = 3.3, h = 3, $fn = cylinder_quality);
	translate([kMiddleLine - 41.67125, 0, -1]) cylinder(r = 2, h = 10, $fn = cylinder_quality);
	translate([kMiddleLine - 41.67125, 0, 3.5]) cylinder(r1 = 2, r2 = 3.3, h = 3, $fn = cylinder_quality);
}





module ScrewsCenter()
{
	// Duplex Outlet screw holes
	translate([kMiddleLine, 0, -1]) cylinder(r = 2, h = 10, $fn = cylinder_quality);
	translate([kMiddleLine, 0, 3.5]) cylinder(r1 = 2, r2 = 3.3, h = 3, $fn = cylinder_quality);
}





module ScrewsRocker()
{
	// Rocker/Designer screw holes
	translate([kMiddleLine + 48.41875, 0, -1]) cylinder(r = 2, h = 10, $fn = cylinder_quality);
	translate([kMiddleLine + 48.41875, 0, 3.5]) cylinder(r1 = 2, r2 = 3.3, h = 3, $fn = cylinder_quality);
	translate([kMiddleLine - 48.41875, 0, -1]) cylinder(r = 2, h = 10, $fn = cylinder_quality);
	translate([kMiddleLine - 48.41875, 0, 3.5]) cylinder(r1 = 2, r2 = 3.3, h = 3, $fn = cylinder_quality);
}





module ScrewsYoke()
{
	// Toggle screw holes
	translate([kMiddleLine + 30.1625, 0, -1]) cylinder(r = 2, h = 10, $fn = cylinder_quality);
	translate([kMiddleLine + 30.1625, 0, 3.5]) cylinder(r1 = 2, r2 = 3.3, h = 3, $fn = cylinder_quality);
	translate([kMiddleLine - 30.1625, 0, -1]) cylinder(r = 2, h = 10, $fn = cylinder_quality);
	translate([kMiddleLine - 30.1625, 0, 3.5]) cylinder(r1 = 2, r2 = 3.3, h = 3, $fn = cylinder_quality);
}




module ShapeRoundRect(width, height, cornerRadius)
{
	hull()
	{
		translate([cornerRadius, cornerRadius, 0]) circle(r = cornerRadius, $fn = cylinder_quality);
		translate([width - cornerRadius, cornerRadius, 0]) circle(r = cornerRadius, $fn = cylinder_quality);
		translate([width - cornerRadius, height - cornerRadius, 0]) circle(r = cornerRadius, $fn = cylinder_quality);
		translate([cornerRadius, height - cornerRadius, 0]) circle(r = cornerRadius, $fn = cylinder_quality);
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
