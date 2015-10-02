x = load('ml3x.dat');
y = load('ml3y.dat');
plot(x(:,1),y,'o');
xlabel('Exam 1')
ylabel('y')
print('plot1','-dpng');
plot(x(:,2),y,'o');
xlabel('Exam 2')
ylabel('y')
print('plot2','-dpng');
m = 80;
x = [ones(m,1),x];

% pos and neg
figure
pos = find(y == 1);
neg = find(y == 0);
plot(x(pos,2), x(pos,3), '+');
hold on
plot(x(neg,2), x(neg,3), 'o');
hold on
xlabel('Exam 1 score')
ylabel('Exam 2 score')
print('plot3','-dpng');


%cost j
theta = zeros(size(x(1,:)))';
h = inline('1.0 ./ (1.0 + exp(-z))');
max = 7;
j = zeros(max,1);
for num = 1:max
z = x * theta;
g = h(z);
gradient = (1/m).*x'*(g-y);
H = (1/m).*x'*diag(g)*diag(1-g)*x;
j(num) = (1/m)*sum(-y.*log(g) - (1-y).*log(1-g));
theta = theta - H\ gradient;
end

% boundary line
plot_x = [min(x(:,2)) - 2, max(x(:,2)) + 2];
plot_y = (-1./theta(3)).*(theta(2).* plot_x + theta(1));
plot(plot_x, plot_y)
legend('Admitted', 'Not admitted', 'Decision Boundary')
hold off
print('plot4', '-dpng');

%plot J
figure
plot(0:max-1, j, '-');
xlabel('Iteration'); ylabel('J')
print('plot5', '-dpng');

%probability
z = [1 20 80] * theta;
g = 1.0 ./ (1.0 + exp(-z));
prob = 1 - g;

%own data
%x1 = [56 97 85 68 73 91 88 83 75 86 77 71 84 61 59 70 81 74 63 80 93 76 94];
%x1 = [x1, 96 77 65 78 93 61 78 83 55 96 67 91 84 71 69 70 83 82 93 72 85 66 64];
%x1 = [x1, 88 69 54 68 73 81 98 93 65 76 57 61 54 91 99 80 60 58 86 78 88 69 94];
%x1 = [x1, 88 69 52 65 72 83 91 95 67 85 54];
%x2 = [66 67 95 68 77 81 98 83 85 56 97 81 89 71 69 50 91 64 83 70 93 96 64]; 
%x2 = [x2, 86 97 55 98 73 81 58 63 95 76 87 91 84 81 69 80 93 62 53 82 95 56 84];
%x2 = [x2, 80 79 59 69 63 71 88 63 95 86 97 81 74 51 69 60 50 78 66 58 98 69 74];
%x2 = [x2, 78 88 62 55 82 93 91 85 57 75 69];
%x = [x1', x2'];
%y = load('ml3y.dat');
