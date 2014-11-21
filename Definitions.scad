////////////////////////////////////////////////////////////////////////////////
//  Definitions.scad
//
//  CoreXY
//  
//	Measurements are expressed in mm as the basic unit for OpenSCAD, but we use
//	English units
//

include <MCAD/units.scad>
include <MCAD/materials.scad>
use <MCAD/boxes.scad>
include <MCAD/stepper.scad>
include <MCAD/metric_fasteners.scad>        // fixed the version from the 2014.3 -- typos and some dimensions
use <Writescad/Write.scad>
use <build_plate.scad>

//	Commonly used abbreviations
//		BP	Base Plate
//		MW	Mini Wheel	
//

// color pallete
RED              = "Red";
BLUE			 = "Blue";
GREEN			 = "Green";
REFERENCE_MARK   = [100/255, 200/255, 100/255, 0.1];
REFERENCE_0      = [200/255,  50/255, 100/255, 0.7];
DARK_ANODIZED    = [ 60/255,  60/255,  60/255, 0.2];
STEEL            = [ 95/255, 101/255, 107/255, 1.0];
ALUMINUM         = [130/255, 142/255, 154/255, 0.4];
ROD              = [    0.9,     0.9,     0.9, 0.9];
ACRYLIC1         = [ 65/255,  78/255,  96/255, 0.7];
ACRYLIC2         = [ 85/255, 156/255, 200/255, 0.8];
RED_TRANSPARENT  = [255/255,   0/255,   0/255, 0.02];
BLUE_TRANSPARENT = [  0/255,   0/255, 255/255, 0.4];

// all dimensions in millimeters in OpenSCAD, so we convert with this
INCH_TO_MM = 25.4;

function inches(value) = value * INCH_TO_MM;

DISPLAY_RESOLUTION = 48; // arc resolution ($fn) for visual render
DXF_RESOLUTION     = 48; // higher resolution used for DXF render

BUILD_PLATE_SELECTOR = 3; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]
BUILD_PLATE_MANUAL_X = 380; //[100:400]
BUILD_PLATE_MANUAL_Y = 450; //[100:400]

VSLOTSIZE = 20;	// 20mm VSlot, used in spacing calculations

// dimensions of the base plate
BP_X = inches(20);
BP_Y = inches(24);
BP_Z = inches(0.25);

BP_FRONT_PORCH = inches(3);
BP_BACK_PORCH = inches(1.5);
BP_SIDE_WIDTH = inches(1.5);

BP_BINDING_BRACKET_WIDTH = inches(3);

// NEMA23 motors have the mounting bolts displaced 0.93 inches in X and Y from center
N23OFFSET = inches(0.93);

X_AXIS_DRIVE_LOCATION = [-BP_X/2+inches(1.25),-BP_Y/2+inches(1.25),BP_Z/2];
Y_AXIS_DRIVE_LOCATION = [BP_X/2-inches(1.25),-BP_Y/2+inches(1.25),BP_Z/2];

// reference location for placing gantries (puts them neatly between the steppers and the corner pulleys (just)
Y_AXIS_LEFT_GANTRY_LOCATION = [-BP_X/2+BP_SIDE_WIDTH/2,-BP_Y/2+BP_FRONT_PORCH-BP_BACK_PORCH,BP_Z/2];
Y_AXIS_RIGHT_GANTRY_LOCATION = [BP_X/2-BP_SIDE_WIDTH/2,-BP_Y/2+BP_FRONT_PORCH-BP_BACK_PORCH,BP_Z/2];

X_AXIS_GANTRY_OFFSET = inches(0.25);
Y_AXIS_GANTRY_OFFSET = inches(0.25);

X_AXIS_GANTRY_RAIL_SEPARATION = inches(3);
TOOL_PLATFORM_DEPTH = BP_SIDE_WIDTH+inches(1/2);
TOOL_PLATFORM_BRACKET_WIDTH = X_AXIS_GANTRY_RAIL_SEPARATION+inches(1);

// these are the locations on the Base where holes must go for the idler pulleys
X_AXIS_UPPER_IDLER_LOCATION = [inches(1)/2,BP_Y-inches(1)/2,BP_Z/2];
X_AXIS_LOWER_IDLER_LOCATION = [BP_X-inches(1.25),BP_Y-inches(1.25),BP_Z/2];
Y_AXIS_UPPER_IDLER_LOCATION = [BP_X-inches(1.25)/2,BP_Y-inches(1.25)/2,BP_Z/2];
Y_AXIS_LOWER_IDLER_LOCATION = [inches(1.25),BP_Y-inches(1.25),BP_Z/2];

//
//	VSlot Mini Wheel definitions
MWOutsideDiameter = 15.23;
MWWidth = 8.80;
MWTreadWidth = 5.78;
MWInsideDiameter = 8.64;
MWBearingChamferedDiameter = 9.974;
MWBearingUnChamferedDiameter = 10.35;
MWInsideChamferSize = 0.3;
MWChamferedDiameter = 12.21;
MWInSideChanferAngle = 135;
MWOutsideChamferSize = 2.14;
MWOutSideChanferAngle = 135;
MWOutSideChanferDepth = 1.51;
MWInsideBearingGap = 1.0;
MWInsideRadius = MWInsideDiameter/2;
MWOutsideRadius = MWOutsideDiameter/2;
MWSidewallHeight = 1.12;
MWBearingOutsideRadius = 4.99;
MWCentralRibHeight = 4.99 - MWInsideDiameter/2;

//
// So we can right and left apart
//
module Reference_Elements()
{
	color(ALUMINUM);
	translate([500,0,0])
	scale([10,10,10])
	rotate([90,0,0])
	write("R",bold=100);

	translate([-500,0,0])
	scale([10,10,10])
	rotate([90,0,0])
	write("L",bold=100);

}

////////////////////////////////////////////////////////////////////////////////
