////////////////////////////////////////////////////////////////////////////////
//	VSlot.scad
//
BUILD_PLATE_SELECTOR = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]
BUILD_PLATE_MANUAL_X = 100; //[100:400]
BUILD_PLATE_MANUAL_Y = 100; //[100:400]

include <Definitions.scad>

VSLOT_WIDTH = 2.0;
VSLOT_DEPTH = 2;
VSLOT_INNER_WIDTH = 1.64;
VSLOT_INNERMOST_WIDTH = .78;
VSLOT_GAP = 0.568;

module OuterShell(width)
{
	difference()
	{
		translate([-VSLOT_WIDTH/2,-VSLOT_WIDTH/2,0])
			cube(VSLOT_WIDTH,VSLOT_WIDTH,VSLOT_DEPTH);
			
		translate([-VSLOT_INNER_WIDTH/2,-VSLOT_INNER_WIDTH/2,0])
			cube(VSLOT_INNER_WIDTH,VSLOT_INNER_WIDTH,VSLOT_DEPTH);

		translate([VSLOT_INNERMOST_WIDTH-VSLOT_GAP,-VSLOT_GAP/2,0])
			cube([VSLOT_GAP*2,VSLOT_GAP,VSLOT_DEPTH]);
			
		translate([-VSLOT_INNERMOST_WIDTH-VSLOT_GAP,-VSLOT_GAP/2,0])
			cube([VSLOT_GAP*2,VSLOT_GAP,VSLOT_DEPTH]);
			
		translate([-VSLOT_GAP/2,VSLOT_INNERMOST_WIDTH-VSLOT_GAP,0])
			cube([VSLOT_GAP,VSLOT_GAP*2,VSLOT_DEPTH]);
			
		translate([-VSLOT_GAP/2,-VSLOT_INNERMOST_WIDTH-VSLOT_GAP,0])
			cube([VSLOT_GAP,VSLOT_GAP*2,VSLOT_DEPTH]);
	}
}

module InnerShell(width,size)
{
	// central square
	translate([-size/2,-size/2,0])
		cube([size,size,VSLOT_DEPTH]);
	// the four corner squares
	translate([1-.344,1-.344,0])
		cube([.344,.344,VSLOT_DEPTH]);
	translate([-1,-1,0])
		cube([.344,.344,VSLOT_DEPTH]);
	translate([-1,1-.344,0])
		cube([.344,.344,VSLOT_DEPTH]);
	translate([1-.344,-1,0])
		cube([.344,.344,VSLOT_DEPTH]);
}

module Diagonals(width)
{
	rotate([0,0,45])
	translate([-1.2,-0.075,0])
		cube([2.4,0.15,VSLOT_DEPTH]);
	rotate([0,0,-45])
	translate([-1.2,-0.075,0])
		cube([2.4,0.15,VSLOT_DEPTH]);
}


module Outside(width,size)
{
	OuterShell();
	Diagonals();


}

module AllButCenterHole(width)
{
	Outside(width,VSLOT_INNERMOST_WIDTH);
	InnerShell(width,VSLOT_INNERMOST_WIDTH);
}


module Basic_VSlot(width,length)
{
	intersection()
	{
		cylinder(d=4,h=5,center=false,$fn=5);
		difference()
		{
			AllButCenterHole();
	
			// y+ cutout
			translate([0,1.065,0])
			rotate([0,0,45])
			translate([-0.375,-0.375,0])
				cube([0.75,0.75,VSLOT_DEPTH]);
	
			// y- cutout
			translate([0,-1.065,0])
			rotate([0,0,45])
			translate([-0.375,-0.375,0])
				cube([0.75,0.75,VSLOT_DEPTH]);
	
			// x+ cutout
			translate([1.065,0,0])
			rotate([0,0,45])
			translate([-0.375,-0.375,0])
				cube([0.75,0.75,VSLOT_DEPTH]);
	
			// x- cutout
			translate([-1.065,0,0])
			rotate([0,0,45])
			translate([-0.375,-0.375,0])
				cube([0.75,0.75,VSLOT_DEPTH]);
	
			cylinder(d=0.42,h=2*VSLOT_DEPTH+.01,center=true,$fn=50);
		}
	}
}

module CubeMinusCylinder(width,size)
{
	intersection()
	{
		cube(size);
		difference()
		{
			translate([-size/2,-size/2,-size/2])
			cube(size);
		
			cylinder(d=size,h=size*2,center=true,$fn=50);
		}
	}
}

//
// Width is the square dimension of the rail.
//
module VSlot(width,length)
{
	translate([0,0,-length/.2])
	scale([1,1,length])
	difference()
	{
		intersection()
		{
			translate([-(width/2+.01),-(width/2+.01),-(width/2+.01)])
				cube((width+1));
				
			translate([0,0,-0.1])
			scale([10,10,10])
				Basic_VSlot(width,width);
		}
		
		//
		//	chamfers can also be done as a rotate_extrude()
		//
		
		// chamfers for the four remaining 90 degree angles
		translate([8.5,8.5,-.1])
		scale([3.01,3.01,50])
			CubeMinusCylinder(1);
	
		translate([-8.5,8.5,-.1])
		rotate([0,0,90])
		scale([3.01,3.01,50])
			CubeMinusCylinder(1);
	
		translate([8.5,-8.5,-.1])
		rotate([0,0,-90])
		scale([3.01,3.01,50])
			CubeMinusCylinder(1);
	
		translate([-8.5,-8.5,-.1])
		rotate([0,0,180])
		scale([3.01,3.01,50])
			CubeMinusCylinder(1);
	}
}

module main()
{
	VSlot(20,10);
}

if (undef == main)
{
	build_plate(BUILD_PLATE_SELECTOR,BUILD_PLATE_MANUAL_X,BUILD_PLATE_MANUAL_Y);
	main();
}
else
{
	// do nothing, we're compiled into some other source file...
}

////////////////////////////////////////////////////////////////////////////////
