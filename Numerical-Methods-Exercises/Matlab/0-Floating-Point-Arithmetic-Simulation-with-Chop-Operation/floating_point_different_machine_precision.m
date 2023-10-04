%% Compute number in different floating point arithmetic 
% In this script we will use the chop function for rounding 
% the elements to a lower precision arithmetic with one of several 
% forms of rounding. Its intended use is for simulating arithmetic of 
% different precisions (less than double) with various rounding modes. 
% The input to chop should be single precision or double precision and 
% the output will have the same type: the lower precision numbers are
% stored within a higher precision type. For more details 
% see: https://nhigham.com/2020/06/02/what-is-bfloat16-arithmetic/

%% Define a number in exact arithmetic
clc
x = input("Enter a number in the exact arithmetic: ");
disp("-----------------------------------------------------------------------------");

%% Rounding the number to simulate IEEE half precision (half fp16) 
opt_h.format = 'h';
xh = chop(x, opt_h);
err_h = (x - xh)/x;
disp("Number in the IEEE half precision (half fp16): " + string(xh));
disp("Error computed by using the IEEE half precision (half fp16): " + string(err_h));
disp("-----------------------------------------------------------------------------");

%% Rounding the number to simulate IEEE single precision (fp32)
opt_s.format = 's';  
xs = chop(x, opt_s);
err_s = (x - xs)/x;
disp("Number in the IEEE single precision (fp32): " + string(xs));
disp("Error computed by using the IEEE single precision (fp32): " + string(err_s));
disp("-----------------------------------------------------------------------------");

%% Rounding the number to simulate IEEE double precision (fp64)
opt_d.format = 'd';
xd = chop(x, opt_d);
err_d = (x - xd)/x;
disp("Number in the IEEE double precision (fp64): " + string(xd));
disp("Error computed by using the IEEE double precision (fp64): " + string(err_d));
disp("-----------------------------------------------------------------------------");

%% Rounding the number to simulate the bfloat 16 
opt_b.format = 'b';
xb = chop(x, opt_b); 
err_b = (x - xb)/x;
disp("Number in the bfloat 16 precision: " + string(xb));
disp("Error computed by using the bfloat 16 precision: " + string(err_b));
disp("-----------------------------------------------------------------------------");

%% Rounding the number to simulate NVIDIA quarter precision (4 exponent bits, 3 significand (mantissa) bits))
opt_q43.format = 'q43';
xq43= chop(x, opt_q43); 
err_q43 = (x - xq43)/x;
disp("Number in the NVIDIA quarter precision (q43): " + string(xq43));
disp("Error computed by using the NVIDIA quarter precision (q43): " + string(err_q43));
disp("-----------------------------------------------------------------------------");

%% Rounding the number to simulate NVIDIA quarter precision (5 exponent bits, %  2 significand bits)
opt_q52.format = 'q52'; 
xq52= chop(x, opt_q52); 
err_q52 = (x - xq52)/x;
disp("Number in the NVIDIA quarter precision (q52): " + string(xq52));
disp("Error computed by using the NVIDIA quarter precision (q52): " + string(err_q52));
disp("-----------------------------------------------------------------------------");

%% Rounding the number to simulate custom precision 
opt_c.format = 'c';
xc = chop(x, opt_c);
err_c = (x - xc)/x;
disp("Number in the custom precision: " + string(xc));
disp("Error computed by using the custom precision: " + string(err_c));
disp("-----------------------------------------------------------------------------");



clc
float_params('q52')