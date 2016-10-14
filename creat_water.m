function I_water = creat_water(I_O)
v1 = [-0.9572 0 0];
v2 = [0.2507 -0.9238 0];
a = size(I_O);

    I_water(1:3:3*a(1)-2,2:4) = I_O(1:a(1),1:3);
    I_water(1:3:3*a(1)-2,1) = 4;
    I_water(2:3:3*a(1)-1,2:4) = I_O(1:a(1),1:3)+meshgrid(v1,1:a(1));
    I_water(2:3:3*a(1)-1,1) = 3;
    I_water(3:3:3*a(1),2:4) = I_O(1:a(1),1:3)+meshgrid(v2,1:a(1));
    I_water(3:3:3*a(1),1)=3;
