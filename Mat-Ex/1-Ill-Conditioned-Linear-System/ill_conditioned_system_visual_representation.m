%% Example of ill conditioned linear system taken from Carl Mayer Example 1.6.2
% This is an example of a system whose solution is extremely sensitive to
% a small perturbation. This sensitivity is intrinsic to the system itself and is
% not a result of any numerical procedure. Therefore, you cannot expect some
% "numerical trick" to remove the sensitivity. If the exact solution is sensitive to
% small perturbations, then any computed solution cannot be less so, regardless of
% the algorithm used.
% Geometrically, two equations in two unknowns represent two straight lines, and
% the point of intersection is the solution for the system. An ill-conditioned system
% represents two straight lines that are almost parallel. If two straight lines 
% are almost parallel and if one of the lines is tilted only slightly, 
% then the point of intersection (i.e., the solution of the associated 2 × 2 
% linear system) is drastically altered.

clc
clear
close all

%% Data definition
% Define the coefficients matrix A
A = [.835 .667;
    .333 .266];

% Define three different vectors of known terms, with a very small error 
% equals to .001 (1e-3). This error is related to the instrumnets used to
% collect the data. 
b = [.168; .067];
b_a = [.169; .066];
b_b = [.167; .068];

% Used to show the results in exponent format
format short e

%% Solve linear system
% We use the built-in method, which is the LU factorization with partial
% pivoting, which is a backward stable algorithm.
x_b = A\b;
x_ba = A\b_a;
x_bb = A\b_b;

%% Show the results of the linear system
fprintf('The correct solution with input data [.168; .067] with no perturbations is: \n'); disp(x_b);
fprintf('The solution with the perturbated input data [.169; .066] is:\n'); disp(x_ba);
fprintf('The solution with the perturbated input data [.167; .068] is:\n'); disp(x_bb);
fprintf('----------------------------------------------------------------------------------------\n');
fprintf('The condition number of the matrix A is: %.3e\n', cond(A));
fprintf('The error on the input data is: %.3e\n', 1.0e-03);
fprintf('The error on the output data is much bigger (err_input*cond(A)): %.3e\n', 1.0e-03*cond(A));
fprintf('This problem is related to the ill-conditionate system given in input.\n');
fprintf('----------------------------------------------------------------------------------------\n');
fprintf(['The three line are more or less parallel. If two straight lines are almost parallel \n and if ' ...
    'one of the lines is tilted only slightly, then the point of intersection \n(i.e., the solution ' ...
    'of the associated 2 × 2 linear system) is drastically altered.\n']);

%% Plot the result
% we show only the first two of the three line 
x = linspace(-1200, 1000, 1e5);
l1y = (-.835*x + .168) /.667;
l2y = (-.333*x + .067) /.266;
l2ya = (-.333*x + .066)/.266;

% plot signal on new figure
figure();
plot(x, l1y, 'r.', x, l2y, 'g.', x, l2ya, 'b.');
xlim([-1200 1000]);
xlabel("X");
ylabel("Y");

% create a new pair of axes inside current figure
axes('position',[0.54,0.56,0.35,0.35]);

% put box around new pair of axes
box on 

% range of t near perturbation
indexOfInterest = (x>-342.27) & (x < -342.19); 
plot(x(indexOfInterest), l1y(indexOfInterest), 'r.', ...
    x(indexOfInterest), l2y(indexOfInterest), 'g.', ...
    x(indexOfInterest), l2ya(indexOfInterest), 'b.') % plot on new axes
xlim([-342.27,-342.22]);
ylim([428.68, 428.74]);

%% Plot the difference between the two lines
figure();
plot(x, l1y-l2ya, 'r',...
    x, l1y-l2y, 'g', ...
    x, zeros(size(x)), 'b', 'LineWidth', 1.2);
xlim([-1200 1000]);
xlabel("X");
ylabel("Y");