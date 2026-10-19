// 12 mm wheel hex hub for a 4 mm axle.
hexFlatToFlat = 12;
hexWidth = 5;
shaftDiameter = 4;
shaftClearance = 0.2;

hexCircumDiameter = hexFlatToFlat / cos(30);
boreDiameter = shaftDiameter + shaftClearance;

module hexBuck() {
    difference() {
        cylinder(d=hexCircumDiameter, h=hexWidth, $fn=6);
        //translate([0, 0, -0.1])
        //    cylinder(d=boreDiameter, h=hexWidth + 0.2, $fn=48);
    }
}

difference() {

    cylinder(h=hexWidth, d=hexFlatToFlat+8, $fn=6);
    hexBuck();
}
