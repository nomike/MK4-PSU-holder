include<openscad-screw-holes/screw_holes.scad>;
$fn = 64;
screw_hole_fn = 64;

epsilon = 0.001; // To prevent z-fighting

width = 105;
depth = 49;
total_heigth = 235;
wall_thickness = 3;
bottom_cutout_height = 26.3;
bottom_cutout_depth = 18.1;
slit_width = 3;
slit_depth = 3;
slit_distance = 50.5;
slit_height = 10.6;

tollerance = 0.1;
holder_height = 25;

cable_cutout_diameter = 20;
cable_cutout_width = 65;
scrwedriver_hole_diameter = 8;

screw_type = DIN963;
screw_size = M3;

/*
 * Module: psu
 *
 * Description:
 * This module creates a 3D model of a Prusa PSU. You can use it in your own projects e.g. by
 * differencing it from a larger object to create a cutout for the PSU.
 */
module psu() {
    difference() {
        cube([width, depth, total_heigth]);
        translate([wall_thickness, -epsilon, -epsilon]) cube([width - 2 * wall_thickness, bottom_cutout_depth + epsilon, bottom_cutout_height + epsilon]);
        translate([width/2 - slit_distance/2 - slit_width, depth - slit_depth + epsilon, -epsilon]) cube([slit_width, slit_depth, slit_height + epsilon]);
        translate([width/2 + slit_distance/2, depth - slit_depth + epsilon, -epsilon]) cube([slit_width, slit_depth, slit_height + epsilon]);
    }

}



/*
 * Module: psu_holder
 *
 * Description:
 * This module creates a 3D model of a PSU (Power Supply Unit) holder with various cutouts for cables, screws, and screwdrivers.
 *
 * Components:
 * - Basic Shape: A cube representing the main body of the PSU holder.
 * - Cable Cutout: A cutout for the cables to pass through.
 * - Screw Cutouts: Holes for screws to secure the PSU holder onto the lack enclosure.
 * - Screwdriver Holes: Holes to allow access for a screwdriver.
 */
module psu_holder() {
    difference() {
        difference() { // basic shape
            cube([width + 2 * tollerance + 2 * wall_thickness, depth + 2 * tollerance + 2 * wall_thickness, wall_thickness + holder_height]);
            translate([wall_thickness, wall_thickness, wall_thickness]) cube([width + 2 * tollerance, depth + 2 * tollerance, holder_height + epsilon]);
        }
        union() { // cutout for cable
            translate([-epsilon, wall_thickness + depth / 2 - cable_cutout_diameter / 2, -epsilon])
            cube([wall_thickness + epsilon + cable_cutout_width, cable_cutout_diameter, holder_height + wall_thickness + 2 * epsilon]);
        }
        union() { // screw cutouts
            translate([width / 4 + wall_thickness, depth + wall_thickness + 0.3 - epsilon, holder_height / 2 + wall_thickness]) rotate([-90, 0, 0]) screw_hole(screw_type, screw_size, wall_thickness);
            translate([width / 4 * 3 + wall_thickness, depth + wall_thickness + 0.3 - epsilon, holder_height / 2 + wall_thickness]) rotate([-90, 0, 0]) screw_hole(screw_type, screw_size, wall_thickness);
        }
        union() { // screwdriver holes
            translate([width / 4 + wall_thickness, -epsilon, holder_height / 2 + wall_thickness]) rotate([-90, 0, 0]) cylinder(d=scrwedriver_hole_diameter, h=wall_thickness + 2 * epsilon);
            translate([width / 4 * 3 + wall_thickness, -epsilon, holder_height / 2 + wall_thickness]) rotate([-90, 0, 0]) cylinder(d=scrwedriver_hole_diameter, h=wall_thickness + 2 * epsilon);
        }
    }
}

// translate([width * 1.5, 0, 0]) color("Tomato") psu();
psu_holder();
