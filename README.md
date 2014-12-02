CoreXY-no-rods (A 3D Printer Implementation)
==============
Intended build envelope = 480mm * 480mm * 400mm (volume = 0.09 cubic meters)

CoreXY implementation with no rods or linear bearings.
X-Y movement is bound to a 1/4" aluminum plate, and uses VSlot linear rails and wheel elements for motion in X and Y.

Design uses NEMA23 motors for movement, NEMA 17 for extruder.

Minimize distance between belts going to tool tray to bring net forces parallel to center of Y-axis gantry rails to minimize torque.

Tool tray will not have much weight initially (no motor in module on tray) to allow characterization for acceleration profiling. Expected tool tray size will include a 4"x4" opening for tools to fit through.

Design intent is to make the tool tray capable of supporting swappable modules. Planned modules are:
  Single filament extruder (liquid cooled)
  Multiple filament extruder
  Laser Cutter(low power)
  Milling spindle (machinable wax, ceramics and aluminum)

The objective behind liquid cooling is to use a more efficient cooling technique that does not affect the temperature inside the build area. Fans and their airflow may have a negative impact on some materials being printed, since the benefits of a heated bed are negatively impacted by forced air cooling.
