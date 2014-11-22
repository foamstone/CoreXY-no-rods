CoreXY-no-rods
==============
Intended build envelope = 480mm * 480mm * 400mm (volume = 0.09 cubic meters)

CoreXY implementation with no rods or linear bearings.
X-Y movement is bound to a 1/4" aluminum plate, and uses VSlot linear rails and wheel elements for motion in X and Y.

Design uses NEMA23 motors for movement, NEMA 17 for extruder.

Minimize distance between belts going to tool tray to bring net forces parallel to Y-axis gantry rails to minimize torque.

Tool tray will not have much weight initially (no motor in module on tray) to allow characterization for acceleration profiling.

Design intent is to make the tool tray capable of supporting swappable modules. Planned modules are
  Single filament extruder (liquid cooled)
  Multiple filament extruder
  Laser Cutter(low power)
  Milling spindle (machinable wax, ceramics and aluminum)
