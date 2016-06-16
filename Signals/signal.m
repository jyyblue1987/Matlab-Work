clc;
close all;

xL = [-10 10];
yL = [-1 7];
line([0 0], yL);  %x-axis
line(xL, [0 0]);  %y-axis

x = [-7:0.1:-3];
y = 0 .* x;
hold on;
plot(x, y, 'r'), axis([-10 10 -1 20]), xlabel('t, ms'), ylabel('V'), title('Signal 1'),

x = [-3:0.05:0];
y = 4 * (1 - sqrt(1 - (x + 3).^2 / 9));
hold on;
plot(x, y, 'r')

x = [0:0.05:3];
y = 4 * (1 - sqrt(1 - (-x + 3).^2 / 9));
hold on;
plot(x, y, 'r')

x = [3:0.1:7];
y = 0 .* x;
hold on;
plot(x, y, 'r')


figure;

xL = [-10 10];
yL = [-1 4];
line([0 0], yL);  %x-axis
line(xL, [0 0]);  %y-axis


hold on;
x = [-7:0.1:-1];
y = 0 .* x;
plot(x, y, 'r'), axis([-10 10 -1 10]), xlabel('t, ms'), ylabel('V'), title('Signal 2'),

x = [-1:0.05:0];
y = 2 * (x + 1);
hold on;
plot(x, y, 'r')

y = [1:0.05:2];
x = 0 * y;
hold on;
plot(x, y, 'r')

x = [0:0.05:1];
y = 1 * ones(size(x));
hold on;
plot(x, y, 'r')

y = [0:0.05:1];
x = 1 * ones(size(y));
hold on;
plot(x, y, 'r')

hold on;
x = [1:0.1:7];
y = 0 .* x;
plot(x, y, 'r')