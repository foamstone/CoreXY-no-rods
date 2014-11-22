////////////////////////////////////////////////////////////////////////////////
//	BasePlate.scad
//
// Base plate for CoreXY. We support emitting a drawing by setting the value
//	EmitAsDrawing to true.
//
//	Made to be included as a component in the assembly, but can be rendered 
//	standalone as well.

EmitAsDrawing = false;
ToolKerf = 0.0635;	// waterjet kerf. Adjust as needed to tool size.

//	CoreXY common definitions, used in all files
// includes and uses
include <./Definitions.scad>
use <VSlot.scad>
use <VSlotMiniWheel.scad>

////////////////////////////////////////////////////////////////////////////////
//	Front binding bracket components.
//	Note that we use symmetry, and also scaling to make the back binding brackets

//  BasePlateFrontBindingBracketBoltPatternTemplate(element)
//    element is one of {"hole", "bolt", "nut"}
//  Bolt pattern for one side of front binding bracket
//  Bolts for one side of front binding bracket
//  Nuts for one side of front binding bracket
module BasePlateFrontBindingBracketBoltPatternTemplate(element)
{
	color([0.23, 0.23, 0.23, 0.2])
	if ("hole" == element)
	{
		translate([BP_BINDING_BRACKET_WIDTH/-3,BP_BINDING_BRACKET_WIDTH/3,0])
	 		cylinder(d=5,h=BP_Z*5,center=true,$fn=50);
		translate([BP_BINDING_BRACKET_WIDTH/-3,BP_BINDING_BRACKET_WIDTH/-3,0])
			cylinder(d=5,h=BP_Z*5,center=true,$fn=50);
		translate([BP_BINDING_BRACKET_WIDTH/-6,0,0])
			cylinder(d=5,h=BP_Z*5,center=true,$fn=50);
	}
	else if ("bolt" == element)
	{
		translate([BP_BINDING_BRACKET_WIDTH/-3,BP_BINDING_BRACKET_WIDTH/3,BP_Z*2])
	 		rotate([180,0,0]) bolt(5,30);
		translate([BP_BINDING_BRACKET_WIDTH/-3,BP_BINDING_BRACKET_WIDTH/-3,BP_Z*2])
			rotate([180,0,0]) bolt(5,30);
		translate([BP_BINDING_BRACKET_WIDTH/-6,0,BP_Z*2])
			rotate([180,0,0]) bolt(5,30);
	}
	else if ("nut" == element)
	{
		translate([BP_BINDING_BRACKET_WIDTH/-3,BP_BINDING_BRACKET_WIDTH/3,-12.5])
	 		cylinder(d=inches(.4),h=5,center=true,$fn=6);
		translate([BP_BINDING_BRACKET_WIDTH/-3,BP_BINDING_BRACKET_WIDTH/-3,-12.5])
			cylinder(d=inches(.4),h=5,center=true,$fn=6);
		translate([BP_BINDING_BRACKET_WIDTH/-6,0,-12.5])
			cylinder(d=inches(.4),h=5,center=true,$fn=6);
	}
	else { echo("BasePlateFrontBindingBracketBoltPatternTemplate(): Invalid parameter"}
}

//  bolt pattern for front binding bracket of BasePlate
//  Uses symmetry.
module BasePlateFrontBindingBracketBoltPattern(element)
{
	BasePlateFrontBindingBracketBoltPatternTemplate(element);
	mirror([1,0,0])
	BasePlateFrontBindingBracketBoltPatternTemplate(element);
}

module BasePlateFrontBindingBracketsMountingHardware()
{
	translate([0,BP_FRONT_PORCH/2-BP_Y/2,0])
	{
		BasePlateFrontBindingBracketBoltPattern("bolt");
		BasePlateFrontBindingBracketBoltPattern("nut");
	}
}
module BasePlateFrontBindingBracket()
{
	translate([0,BP_FRONT_PORCH/2-BP_Y/2,0])
	difference()
	{
		translate([-BP_FRONT_PORCH/2,-BP_FRONT_PORCH/2,BP_Z/2])
		color("SteelBlue")
			cube([BP_BINDING_BRACKET_WIDTH,BP_FRONT_PORCH,BP_Z]);
	
		BasePlateFrontBindingBracketBoltPatternTemplate("hole");
		mirror([1,0,0])
		BasePlateFrontBindingBracketBoltPatternTemplate("hole");
	}
}
module BasePlateFrontBindingBrackets()
{
	BasePlateFrontBindingBracket();
	translate([0,0,BP_Z*-2])
		BasePlateFrontBindingBracket();
}

////////////////////////////////////////////////////////////////////////////////
//	Rear binding bracket components.
//	Note that we use symmetry, and also scaling from the front binding bracket
//	to make these.
//
module BasePlateRearBindingBracketBoltPatternTemplate(element)
{

	if ("hole" == element)
	{
		translate([BP_BINDING_BRACKET_WIDTH/-3,BP_BACK_PORCH/3,0])
			cylinder(d=5,h=BP_Z*10,center=true,$fn=50);
		translate([BP_BINDING_BRACKET_WIDTH/-3,BP_BACK_PORCH/-3,0])
			cylinder(d=5,h=BP_Z*10,center=true,$fn=50);
		translate([BP_BINDING_BRACKET_WIDTH/-6,0,0])
			cylinder(d=5,h=BP_Z*10,center=true,$fn=50);
	}
	else if ("bolt" == element)
	{
		translate([0,BP_Y/2-BP_BINDING_BRACKET_WIDTH/4,BP_Z*2])
		color([0.23, 0.23, 0.23, 0.2])
		{
			translate([BP_BINDING_BRACKET_WIDTH/-3,BP_BACK_PORCH/3,0])
				rotate([180,0,0]) bolt(5,30);
			translate([BP_BINDING_BRACKET_WIDTH/-3,BP_BACK_PORCH/-3,0])
				rotate([180,0,0]) bolt(5,30);
			translate([BP_BINDING_BRACKET_WIDTH/-6,0,0])
				rotate([180,0,0]) bolt(5,30);
		}
	}
	else if ("nut" == element)
	{
		translate([0,BP_Y/2-BP_BINDING_BRACKET_WIDTH/4,BP_Z*2])
		color([0.23, 0.23, 0.23, 0.2])
		{
			translate([BP_BINDING_BRACKET_WIDTH/-3,BP_BACK_PORCH/3,-25])
				cylinder(d=inches(.4),h=5,center=true,$fn=6);

			translate([BP_BINDING_BRACKET_WIDTH/-3,BP_BACK_PORCH/-3,-25])
				cylinder(d=inches(.4),h=5,center=true,$fn=6);
		
			translate([BP_BINDING_BRACKET_WIDTH/-6,0,-25])
				cylinder(d=inches(.4),h=5,center=true,$fn=6);
		}
	}
	else { echo("Unknown element in BasePlateRearBindingBracketBoltPatternTemplate()"); }

}
module BasePlateRearBindingBracketBoltPattern(element)
{
	BasePlateRearBindingBracketBoltPatternTemplate(element);
	mirror([1,0,0])
	BasePlateRearBindingBracketBoltPatternTemplate(element);
}
module BasePlateRearBindingBracketsMountingHardware()
{
	BasePlateRearBindingBracketBoltPattern("bolt");
	BasePlateRearBindingBracketBoltPattern("nut");
}
module BasePlateRearBindingBracket()
{
	translate([0,-BP_BACK_PORCH/2+BP_Y/2,0])
	difference()
	{
		translate([-BP_BINDING_BRACKET_WIDTH/2,-BP_BACK_PORCH/2,BP_Z/2])
		color("BurlyWood")
			cube([BP_BINDING_BRACKET_WIDTH,BP_BACK_PORCH,BP_Z]);
	
		BasePlateRearBindingBracketBoltPattern("hole");
	}
}
module BasePlateRearBindingBrackets()
{
	BasePlateRearBindingBracket();
	translate([0,0,BP_Z*-2])
		BasePlateRearBindingBracket();
}

//
// Place holes for attaching Y Axis gantry to Base with T-nuts in the VSlot
//
module Y_Axis_Gantry_Holes(side)
{
	// left side in default view
	if ("left" == side)
	{
		// left side when in default view
		translate(Y_AXIS_LEFT_GANTRY_LOCATION)
		for (i =[0 : 1 : 5])
		{
			// bolts
			color([0.23, 0.23, 0.23, 0.2])
			translate([BP_X/2,80*i+BP_Y/2+BP_FRONT_PORCH,-BP_Z+0.01])
				cylinder(d=inches(.2),h=20,center=false,$fn=50);
			// T-nuts
			color("Lime")
			translate([BP_X/2,80*i+BP_Y/2+BP_FRONT_PORCH,-BP_Z-10])
				cylinder(d=inches(.4),h=4,center=false,$fn=6);
		}
	}
	else
	{
		// right side when in default view
		translate(Y_AXIS_RIGHT_GANTRY_LOCATION)
		for (i =[0 : 1 : 5])
		{
			// bolts
			color([0.23, 0.23, 0.23, 0.2])
			translate([BP_X/2,80*i+BP_Y/2+BP_FRONT_PORCH,-BP_Z+0.01])
				cylinder(d=inches(.4),h=20,center=false,$fn=50);
			// T-nuts
			color("Lime")
			translate([BP_X/2,80*i+BP_Y/2+BP_FRONT_PORCH,-BP_Z-10])
				cylinder(d=inches(.4),h=4,center=false,$fn=6);
		}
	}
}

module Nema23MotorMountingBoltPattern()
{
	translate([0,0,0])
		cylinder(d=inches(1.5),h=inches(2),center=true,$fn=50);
	translate([-N23OFFSET,-N23OFFSET,0])
		cylinder(d=inches(.2),h=inches(2),center=true,$fn=50);
	translate([ N23OFFSET,-N23OFFSET,0])
		cylinder(d=inches(.2),h=inches(2),center=true,$fn=50);
	translate([-N23OFFSET, N23OFFSET,0])
		cylinder(d=inches(.2),h=inches(2),center=true,$fn=50);
	translate([ N23OFFSET, N23OFFSET,0])
		cylinder(d=inches(.2),h=inches(2),center=true,$fn=50);
}

//
//
//
module basicplate()
{
	difference()
	{
		// the base
		cube([BP_X/2,BP_Y,BP_Z]);

		// the central cutout
		translate([(BP_SIDE_WIDTH),BP_FRONT_PORCH,-BP_Z*2])
		cube([BP_X-BP_SIDE_WIDTH,BP_Y-BP_FRONT_PORCH-BP_BACK_PORCH,BP_Z*8]);
	}
}

//
// Left side of the base plate
//
module BasePlateLeftSide()
{
	%color("DeepPink")
	difference()
	{
		translate([-BP_X/2,-BP_Y/2,-BP_Z/2])
		difference()
		{
			// the base
			basicplate();
	
			// X-Axis bolt pattern for stepper, translated to origin, then into 
			// the base plate for intersection, then to the relative position required.
			translate([BP_X/2,BP_Y/2,-BP_Z/2])
			translate([0,0,-BP_Z])
			translate(X_AXIS_DRIVE_LOCATION)
				Nema23MotorMountingBoltPattern();
	
			// X-Axis bolt pattern for Upper Idler mount point
			translate(X_AXIS_UPPER_IDLER_LOCATION)
				cylinder(d=5,h=BP_Z*10,center=true,$fn=50);
	
			// Y-Axis bolt pattern for Lower Idler mount point
			translate(Y_AXIS_LOWER_IDLER_LOCATION)
				cylinder(d=5,h=BP_Z*10,center=true,$fn=50);
	
			// y-Axis holes for attaching gantry to Base on the left side
			Y_Axis_Gantry_Holes("left");
		}
	
		// Bolt pattern for attaching right and left base plate pieces with 
		// the Front Binding Brackets
		translate([BP_X/2,BP_FRONT_PORCH/2,-BP_Z/2])
			BasePlateFrontBindingBracketBoltPatternTemplate("hole");
				
		// Bolt pattern for attaching right and left base plate pieces with 
		// the Rear Binding Brackets
		translate([0,BP_Y/2-BP_BACK_PORCH/2,BP_Z/2])
			BasePlateRearBindingBracketBoltPatternTemplate("hole");
	}
}

//
// right side of the base plate. Symmetry used...
module BasePlateRightSide()
{
	mirror([1,0,0])
		BasePlateLeftSide();
}

module BasePlate()
{
	BasePlateLeftSide();
	BasePlateRightSide();
	BasePlateFrontBindingBrackets();
	BasePlateFrontBindingBracketsMountingHardware();
	BasePlateRearBindingBrackets();
	BasePlateRearBindingBracketsMountingHardware();

}

if (undef == main)
{
	if (!EmitAsDrawing)
	{
		echo("---------------------------------------------------------BasePlate.scad is rendering");
		echo();
		Reference_Elements();
		BasePlate();
	}
	else
	{
		echo("---------------------------------------------------------BasePlate.scad is rendering as a drawing");
		echo();
		//translate([BP_X/4,-10,10])
		rotate([0,0,0]) BasePlateLeftSide();
		//translate([-BP_X/4+50,BP_FRONT_PORCH/2,10])
		rotate([]) BasePlateRightSide();
		//translate([-40,120,10])
		rotate([]) BasePlateFrontBindingBracket();
		//translate([40,120,10])
		rotate([]) BasePlateFrontBindingBracket();
		//translate([225,-65,10])
		rotate([0,0,90]) BasePlateRearBindingBracket();
		//translate([267,-65,10])
		rotate([0,0,90]) BasePlateRearBindingBracket();
	}
}
else
{
	echo("---------------------------------------------------------BasePlate.scad");
}
