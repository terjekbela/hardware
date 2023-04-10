/*
 * Prusament Box Hole Plug/Cap (parametric)
 *
 * Author: Pavel Rampas
 * Version: 1.0.0 (Changelog is at the bottom)
 * License: CC BY-SA 4.0 [https://creativecommons.org/licenses/by-sa/4.0/]
 * Link: https://github.com/pavelrampas/openscad-models
 *
 * OpenSCAD version: 2019.05
 *
 * Instructions:
 * Set up parameters, render and print.
 *
 * Height is layer.
 * Thickness is perimeter.
 */

// Parameters
//------------------------------------------------------------------------------

$fn = $preview ? 15 : 90;

render = "body"; // "body" or "text" (for multi-material prints)

baseHeight = 0.8;
wallThickness = 0.86; // ideal for 0.4 nozzle
teethHeight = 0.8;
teethThickness = wallThickness + 1;

text = ""; // text or keep empty
textSize = 20;
textFont = "Liberation Mono";
textRotate = false;

// Code
//------------------------------------------------------------------------------

if (render == "body") {
    _base();
    _wall();
    _teeth();
} else {
    _text(textRotate);
}

// Functions
//------------------------------------------------------------------------------


// Modules
//------------------------------------------------------------------------------

// base
module _base() {
    difference() {
        linear_extrude(height = baseHeight) {
            offset(r = 2) {
                circle(20, $fn=6);
            }
        }
        // text
        if (text) {
            _text(textRotate);
        }
    }
}

// text
module _text(rotate = false) {
    rotate([0, 0, (rotate ? 30 : 0)]) {
        linear_extrude(height = 0.2) {
            mirror([1,0,0]) {
                text(
                    text,
                    size=textSize,
                    font=textFont,
                    valign="center",
                    halign="center",
                    $fn=30
                );
            }
        }
    }
}

// wall
module _wall() {
    translate([0, 0, baseHeight]) {
        linear_extrude(height = 2) {
            difference() {
                offset(r = 1) {
                    circle(19, $fn=6);
                }
                offset(r = 1) {
                    circle(19 - wallThickness, $fn=6);
                }
            }
        }
    }
}

// teeth
module _teeth() {
    difference() {
        translate([0, 0, baseHeight + 2]) {
            linear_extrude(height = teethHeight) {
                difference() {
                    offset(r = 1) {
                        circle((19 - wallThickness) + teethThickness, $fn=6);
                    }
                    offset(r = 1) {
                        circle(19 - wallThickness, $fn=6);
                    }
                }
            }
        }

        for(i = [0 : 5]) {
            rotate([0, 0, 60 * i]) {
                translate([4, 0, baseHeight]) {
                    cube([8, 20 + wallThickness, teethHeight + 3], false);
                }
                translate([-12, 0, baseHeight]) {
                    cube([8, 20 + wallThickness, teethHeight + 3], false);
                }
            }
        }
    }
}

// Changelog
//------------------------------------------------------------------------------

// [1.0.0]:
// Initial release.
