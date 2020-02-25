use <sg9.scad>;
use <picam.scad>;


camera_x_offset = 25;
camera_y_offset = 5.5;
camera_z_offset = -20;

servo_x_offset = -12.5;

horn_d = 6; // horn hole d

horn_a = 6.5; // first hole offset
horn_b = 12.5; // second hole offset
horn_d2 = 2.5; // hole d

horn_angle = -10;

cam_screw_d = 2;
cam_screw_h = 4;
cam_screw_pos = [9.35, 21.85];

clearance = 10;

t = 3;

pi_screw_distance = 49;
pi_screw_d = 3;
pi_y_offset = -2;

module horn_holes(){
    
    cylinder(d=horn_d, center=true, h=1000);
    for(x=[horn_a, horn_b])
        translate([x, 0, -10])
            cylinder(d=horn_d2,h=1000, center=true); 
}

module holder() difference(){
    union(){
        hull(){
            cylinder(d = horn_d + t*2, h=t);
            for(pos=cam_screw_pos){
                translate([camera_x_offset -t , pos + camera_z_offset, 0])
                    cylinder(d = t*2, h=t);
                translate([camera_x_offset - cam_screw_h, pos + camera_z_offset, -camera_y_offset])
                    rotate([0, 90, 0])
                        cylinder(d=cam_screw_d + t*2, h=cam_screw_h);
            }
        }
    }
    
    hull(){
        for(x=[-100,camera_x_offset - t*2], z=[-t, -100])
        translate([x,0,z])
            rotate([90, 0, 0])
                cylinder(d=t*2, h=100, center=true);
    }
    
    for(pos=cam_screw_pos){
        translate([camera_x_offset - t, pos + camera_z_offset, -camera_y_offset])
            rotate([0, 90, 0])
                cylinder(d=cam_screw_d, h=100, center=true);
    }
    translate([ 0, 0, 6 + t])
        rotate([0, 0, horn_angle])
            horn_holes();
}

module base() difference(){
    translate([0, 0, -10]){
        hull() for(i=[-1,1]){
            translate([pi_y_offset, i*pi_screw_distance /2, 0])
                cylinder(d=pi_screw_d + t*2, h=t);
            cylinder(d=horn_d + t*2, h=t);
        }
    }
    for(i=[-1,1]){
        translate([pi_y_offset, i*pi_screw_distance /2, 0])
            cylinder(d=pi_screw_d, h=100, center=true);
    }
    translate([0, 0, -9])
    for(a=[-90, 90])
        rotate([180, 0, a])
            horn_holes();
}

$fn=64;

module holder_with_servo(){
    rotate([90, 0, 0])
        holder();
    translate([camera_x_offset, camera_y_offset , camera_z_offset])
    translate([0.5, 10.5, 19])
        rotate([90, 0, 90])
            raspberryPiCamera();

}

module complet(){
    rotate([180, 0, 0])
        mg90s();
    translate([servo_x_offset, -6, 17])
    rotate([90, 0 ,0]){
        mg90s();
        translate([0, 0, 10])
        rotate([-90, 0, 0])
            holder_with_servo();
    }
    
    base();
}

base();

//complet();
//base();