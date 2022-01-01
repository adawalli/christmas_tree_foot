$fn = 80;



module body(t_len, t_height, t_shelf_len) {
    polygon(points=[
                    [0,0],
                    [0, t_height],
                    [t_shelf_len, t_height],
                    [t_len, t_shelf_len],
                    [t_len, 0]]);
};

//Primary Shape
main_t_shelf_len = 10;
main_t_len = 170;
main_t_height = 55;
main_body_dep = 14.37;

main_body_thickness = 2;

//Cutout Sides
cutout_t_shelf_len= main_t_shelf_len - main_body_thickness*2;
cutout_t_len = main_t_len - main_body_thickness*2;
cutout_t_height= main_t_height - main_body_thickness*2;
cutout_body_dep = main_body_dep;


module cutout() {
translate([main_body_thickness, main_body_thickness, main_body_thickness/2])
    linear_extrude(height=main_body_dep) 
      body(cutout_t_len, cutout_t_height, cutout_t_shelf_len);
}

bracket_h = main_t_height - 1.5;
bracket_d = 10.38;
bracket_w = 7.97;

module bracket_body() {
  difference(){
    translate([-bracket_w/2,bracket_h/2,0])
      cube([bracket_w, bracket_h, bracket_d ], center=true);
    
    translate([ -2, bracket_h/2, bracket_w/2])
    cube([4, bracket_h, 4], center=true);
    
    translate([ -2, bracket_h/2, -bracket_w/2])
    cube([4, bracket_h, 4], center=true);
  }
}

module foot() {
    foot_roof_len=12;
    foot_base_len=25;
    foot_height=8.8;
    translate([main_t_len-foot_roof_len,-foot_height,0])
    linear_extrude(height=main_body_dep, center=true)
      polygon([[0,0],
              [0,foot_height],
              [foot_roof_len,foot_height],
              [foot_base_len,0]]);
}


module tab() {
    translate([10, -5/2, 0])
    cube([10.55, 5, main_body_thickness], center=true);
}


difference() {

  linear_extrude(height=main_body_dep, center=true) 
  body(main_t_len, main_t_height, main_t_shelf_len);

  //cutout();
  //mirror([0,0,1]) cutout();
}

bracket_body();
foot();
tab();