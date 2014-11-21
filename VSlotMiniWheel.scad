////////////////////////////////////////////////////////////////////////////////
//	MiniWheel.scad
//
//	VSlot Mini wheel for CoreXY. We support emitting a drawing by setting the
//  value EmitAsDrawing to true.
//
//	Made to be included as a component in the assembly, but can also be
//  rendered standalone as well.

EmitAsDrawing = false;
ToolKerf = 0.0635;	// waterjet kerf. Adjust as needed to tool size.

//
//	CoreXY common definitions, used in all files
//
include <Definitions.scad>
use <Writescad/Write.scad>
use <build_plate.scad>

// includes and uses
use <MCAD/boxes.scad>;
include <MCAD/stepper.scad>
use <MCAD/metric_fasteners.scad>
use <VSlot_20x20_profile.scad>

module basicWheelProfile()
{
	union()
	{
		translate([-.5,-0.05,(MWOutsideDiameter-MWBearingChamferedDiameter)/2])
		cube([1,0.1,0.65]);

		translate([-MWWidth/2,-0.05,0])
		cube([MWWidth,0.1,(MWOutsideDiameter-MWBearingChamferedDiameter)/2]);
	}
}

module WheelCrossSection()
{
		//rotate([0,90,0])
		basicWheelProfile();
}

module MWCrossSection()
{
	color(REFERENCE_MARK)
	{
		difference()
		{
			WheelCrossSection();

			translate([sqrt(2)*MWTreadWidth,-1,1.2-sqrt(2)/2*MWTreadWidth])
			rotate([0,45,0])
			translate([-MWTreadWidth,0,-MWTreadWidth])
			cube([MWTreadWidth*2,20,MWTreadWidth*2]);

			translate([-sqrt(2)*MWTreadWidth,-1,1.2-sqrt(2)/2*MWTreadWidth])
			rotate([0,45,0])
			translate([-MWTreadWidth,0,-MWTreadWidth])
			cube([MWTreadWidth*2,20,MWTreadWidth*2]);
		}
	}
}
module PositionedMiniWheel()
{
	translate([-MWOutsideDiameter/2,0,0.5])
	rotate([90,0,90])
	MWCrossSection();

}
module RotatedMiniWheel()
{
	color(ROD)
	rotate_extrude(convexity=30,$fn=50)
	projection(cut=false)
	PositionedMiniWheel();
}

module MiniWheel()
{
	RotatedMiniWheel();
}

if (undef == main)
{
	if (!EmitAsDrawing)
	{
		echo("---------------------------------------------------------MiniWheel.scad is rendering");
		echo();
	}
	else
	{
		echo("---------------------------------------------------------MiniWheel.scad is rendering as a drawing");
		echo();
		//translate([BasePlate_X/4,-10,10])
		MiniWheel();
	}
}
else
{
	echo("---------------------------------------------------------MiniWheel.scad");
}

////////////////////////////////////////////////////////////////////////////////
