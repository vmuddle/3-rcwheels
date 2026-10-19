// TYre to suit Topy Wheel
use <topy.scad>

$fn=360;


module tyreProfile() {
    tyreWidth=(175/10)+3.25;
    tyreDepth=tyreWidth*.75;
    spacing=-30;
    translate([22,0,0])
    hull() {
        translate([0,-spacing,0])
            difference() {
                circle(d=(tyreWidth*4));
                translate([0,tyreWidth/64,0]) {
                    square(tyreWidth*4, true);
                }
            }
        translate([0,spacing,0])
            difference() {
                circle(d=(tyreWidth*4));
                translate([0,-tyreWidth/64,0]) {
                    square(tyreWidth*4, true);
                }
            }
        
        translate([4.68,-((spacing/2)+4.7),0]) {
            circle(d=2);
        }
        translate([4.68,((spacing/2)+4.7),0]) {
            circle(d=2);
        }
        translate([4.75,0,0]) {
            spacing=(tyreWidth-1)/2;
            translate([0,-spacing,0])
                circle(d=2);
            translate([0,spacing,0])
                circle(d=2);
            //square([1,tyreWidth*1], true);
            
        }
    }
}

module tyreRuler() {
    tyreWidth=(175/10)+3.25;
    translate([0,0,-tyreWidth/2])
        cylinder(h=tyreWidth, d=((14*25.4)/10)+(tyreWidth*.75));
}

module tyre() {
    rotate_extrude(angle=360)
        tyreProfile();
}

module treadBuck() {
    // apply a tread pattern around the tyre exterior
    
}

%tyreRuler();
if(true) {
    difference() {
        tyre();
        rimBuck();
        treadBuck();
        if(false) {
            translate([0,0,-100])
                cube(200, true);
        }
    }
} else {
    treadBuck();
}