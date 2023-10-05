%% Show all the parameters for a given floating point arithmetic 
% For more details see: https://nhigham.com/2020/06/02/what-is-bfloat16-arithmetic/

clc
clear;
disp("Show all the parameters for floating-point arithmetic.");
disp("The available precision are the following ones:")
disp("'q43', 'q52', 'b', 'h', 't', 's', 'd', 'q'");
prec = input("Select a flotaing point precision: ");
disp("--------------------------------------------------------------");

[u,xmins,xmin,xmax,p,emins,emin,emax] = float_params(prec);
disp("- The unit roundoff: " + string(u));
disp("- The smallest positive (subnormal) floating-point number: " + string(xmins));
disp("- The smallest positive normalized floating-point number:" + string(xmin));
disp("- The largest floating-point number: " + string(xmax));
disp("- The number of binary digits in the significand ");
disp("  (including the implicit leading bit): " + string(p));
disp("- The exponent of xmins: " + string(emins));
disp("- The exponent of xmin: " + string(emin));
disp("- The exponent of xmax: " + string(emax));