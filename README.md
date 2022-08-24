# WALLY-Wall-Plate-Customizer - Mercury Thirteen Fork



Change Log:

v1.7 - Mercury0x0d - 8/24/2022

Added:
- Completely rewrote the jack layout engine
	- Mixed Plate layouts can now handle up to three rows of jacks
	- Pitch between rows of jacks is now selectable on a per-gang basis
- Created jack "A/V - Banana Plug"  based on jack "A/V - Banana Plug With Border"
- Height values to the Plate Size dropdown menu
- Improvements from "ReModded_WALLY_Plate_Customizer" (https://www.thingiverse.com/thing:4493144) by RobBotic
	- Imported modules for creating keystone jacks / solids resulting in a better fit and an improved code footprint
	- Imported jack "A/V - Banana Plug With Border"
- New Full Plate types from "Customizable Switch or Outlet Wall Plate" (https://www.thingiverse.com/thing:3840723) by pete2585
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
