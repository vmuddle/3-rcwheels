// Topy steel rim
// 5.5Jx14 ET15
$fn=360;
modelScaleDivisor=10;

wallThickness=max(1.6, 10/modelScaleDivisor);
innerWidth=175/modelScaleDivisor;
outerWidth=innerWidth+wallThickness*2;
rimDiameter=(14*25.4)/modelScaleDivisor;
boltDiameter=12/modelScaleDivisor;
boltCircleDiameter=114.3/modelScaleDivisor;
boltCount=4;
slotCount=9;

module outerRim() {
    difference() {
        translate([0,0,-outerWidth/2])
            cylinder(d=rimDiameter+(wallThickness*2), h=outerWidth);
        translate([0,0,-innerWidth/2])
            difference() {
                cylinder(d=rimDiameter+(wallThickness*2), h=innerWidth);
                cylinder(d=rimDiameter, h=innerWidth);
            }
        translate([0,0,-outerWidth/2])
            cylinder(d=rimDiameter-(wallThickness*2), h=outerWidth);
    }
}

module lipProfile() {
    hull() {
        circle(d=1, $fn=64);
        translate([0.25,0,0])
            circle(d=1, $fn=4);
    }
}

module rimProfile() {
    // Top Outside Lip
    translate([(rimDiameter/2)-1,outerWidth/2,0]) {
        lipProfile();
    }
    // Tyre Bed
    translate([(rimDiameter/2)-1,outerWidth/2,0]) {
        hull() {
            circle(d=1, $fn=4);
            translate([0,-outerWidth,0])
                circle(d=1, $fn=4);
        }
    }
    // valve bed
    translate([(rimDiameter/2)-1,(outerWidth/2)-0,0]) {
        hull() {
            circle(d=1, $fn=4);
            translate([-0.25,-outerWidth/3,0])
                circle(d=1, $fn=4);
        }
        translate([0,-outerWidth/3,0])
        hull() {
            circle(d=1, $fn=4);
            translate([-2,0,0])
                circle(d=1, $fn=4);
        }
    }
    // SlotFace
    translate([(rimDiameter/2)-1,(outerWidth/2)-0,0]) {
        hull() {
            translate([-2,-outerWidth/3,0])
                circle(d=1, $fn=4);
            translate([-6.25,-(outerWidth/3)+4,0])
                circle(d=1, $fn=64);
        }
        hull() {
            translate([-6.25,-(outerWidth/3)+4,0])
                circle(d=1, $fn=64);
            translate([-8,-(outerWidth/3)+3,0])
                circle(d=1, $fn=64);
            
        }
    }
    // boltFace
    translate([(rimDiameter/2)-1,(outerWidth/2)-0,0]) {
        hull() {
            translate([-8,-(outerWidth/3)+3,0])
                circle(d=1, $fn=16);
            translate([-((rimDiameter/2)-1.5),-(outerWidth/3)+3,0])
                circle(d=1, $fn=1);
            
        }
    }
    // Top Inside Lip
    translate([(rimDiameter/2)-1,-outerWidth/2,0])
        lipProfile();
    
}
module rimFace() {
    rotate_extrude(angle=360) {
        rimProfile();
    }
    boltStrength();
}

module slot() {
    slotLength=3;
    translate([0,(rimDiameter/2)-6,outerWidth/4]) {
        rotate([-30,0,0]) {
            hull() {
                translate([-slotLength/2,0,0])
                    cylinder(h=6, d=2);
                translate([slotLength/2,0,0])
                    cylinder(h=6, d=2);
            }
        }
    }
}

module rimHoles() {
    step=360/slotCount;
    for(angle = [0:step:360])
        rotate([0,0,angle])
            slot();
}

module boltStrength() {
    difference() {
        translate([0,0,5.25]) {
            for(angle = [0:90:360]) {
                hull() {
                    rotate([0,0,(angle+45)])
                        translate([(boltCircleDiameter/2)-.5,0,0]) {
                                hull() {
                                    cylinder(h=2, d=3);
                                    translate([3.5,0,1.5])
                                        cube([1,3,1], true);
                                        //cylinder(h=2, d=3);
                                    cylinder(h=1, d=4);
                                    translate([2.75,0,0.5])
                                        cube([1,4,1], true);
                                        //cylinder(h=1, d=4);
                                }
                            }
                            
                    //cylinder(h=1,d=rimDiameter/2);
                }
            }
        }
        translate([0,0,-3.75]) {
            cylinder(h=10,d=rimDiameter);
        }
    }
    translate([0,0,6.75]) {
        difference() {
            cylinder(h=0.5, d=4.5);
            cylinder(h=0.5, d=4);
            
        }
    }
}




module boltHoles() {
    for(angle = [0:90:360]) {
        rotate([0,0,angle])
        translate([boltCircleDiameter/2,0,0])
            cylinder(h=outerWidth, d=boltDiameter);
    }
}

module wheelNuts() {
    nutLength=1.5;
    for(angle = [0:90:360]) {
        rotate([0,0,angle])
        translate([boltCircleDiameter/2,0,7]) {
                cylinder(h=nutLength, d=boltDiameter+1, $fn=6);
                cylinder(h=nutLength+.2, d=boltDiameter);
            }
    }
}

module rimBuck() {
    rimFace();
    translate([0,0,-((outerWidth+4)/2)])
        cylinder(d=rimDiameter-2, h=outerWidth+4);    
    
}


//outerRim();
if(true) {
    wheelNuts();
difference() {
    rimFace();
    rimHoles();
    boltHoles();
    cylinder(h=outerWidth, d=4);
}
} else {
    boltStrength();
}