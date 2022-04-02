clc, close all; clear

data = load("data.txt")

% Our features
circumference = data(:,1);
% Our y
age = data(:,2)
y = data(:,2)

% Linear
x = [ones(length(age), 1), circumference];
theta = pinv(x' * x) * x' * y;
y_fit = x * theta;

% Quadratic
x_quad = nan(length(age), 3);
x_quad(:, 1) = 1;
x_quad(:, 2) = age;
x_quad(:, 3) = age .^ 2;
theta_quad = pinv(x_quad' * x_quad) * x_quad' * y

x_band = (30:0.5:220)';
x_quad_band = [ones(length(x_band), 1), x_band, x_band.^2];
y_fit_quad = x_quad_band * theta_quad


% Cubic
x_cubic = nan(length(age), 3);
x_cubic(:, 1) = 1;
x_cubic(:, 2) = age;
x_cubic(:, 3) = age .^ 2;
x_cubic(:, 4) = age .^ 3;
theta_cubic = pinv(x_cubic' * x_cubic) * x_cubic' * y;

x_band = (30:0.5:220)';
% x_cubic_band = [ones(length(x_band), 1), x_band, x_band.^2, x_band.^3];
% y_fit_cubic = x_cubic_band * theta_cubic
y_fit_cubic = theta_cubic(1) + theta_cubic(2) * x_band + theta_cubic(3) * x_band .^ 2 + theta_cubic(4) * x_band .^ 3




% Scatter Plot
figure;
scatter(circumference, age);
title("Tree Age vs Circumference")
xlabel("Circumference (mm)")
ylabel("Age (Days)")
hold on
plot(circumference, y_fit)

predict1 = [1, 100] *theta;
fprintf('For circumference = 100 mm, we predict an age of %f days\n',...
    predict1);
predict2 = [1, 150] * theta;
fprintf('For circumference = 150 mm, we predict an age of %f days\n',...
    predict2);


hold on
plot(x_band, y_fit_quad)

hold on
plot(x_band, y_fit_cubic)

legend("Data Points", "Linear Fit", "Quadratic Fit", "Cubic Fit", "Location", "best")