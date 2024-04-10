clc
clear all

%take number of points from the user
string = 'Enter number of points: ';
n = input(string);
disp('Please Note that any zero input will not work properly in Exponential,Power or growth rate models :( ');
%take the points x,y respectively from the user
i=1;
X_sum=0;
Y_sum=0;
X2_sum=0;
XY_sum=0;
while i<=n
    string = 'Enter x: ';
    x(i) = input(string);
    X=linspace(x(1),x(end),1000); %used linspace to make the graph smoother
    string = 'Enter y: ';
    y(i) = input(string);
    Y=linspace(y(1),y(end),1000);
    i=i+1;
end

%calculate sum of X & Y & X^2 & XY
i=1;
while i<=n
    X_sum = X_sum+x(i);
    X2_sum=X2_sum+x(i).*x(i);
    Y_sum=Y_sum+y(i);
    XY_sum=XY_sum+x(i).*y(i);
    i=i+1;
end

%solving 2 eqns in 2 unknowns to get a0 & a1
I = [n X_sum;X_sum X2_sum];
O = [Y_sum; XY_sum];
sol = linsolve(I,O);
a0=sol(1);
a1=sol(2);
Y_Linear=a0+a1.*X;

%displaying the values of the model coefficients
disp('****************************** Linear Model ******************************')
STRING=['a0 = ',num2str(a0),'  a1 = ',num2str(a1)];
disp(STRING)
STRING=['Y = ',num2str(a0) ,' +',num2str(a1),'X'];
disp(STRING)

%calculating St & Sr to get R^2
i=1;
S_r=0;
S_t=0;
Y_avg=Y_sum/n;
while i<=n
    e_i=y(i)-a0-a1.*x(i);
    S_r=S_r+e_i.^2;
    S_t=S_t+(y(i)-Y_avg).^2;
    i=i+1;
end
R_Squared_Linear=(S_t-S_r)/S_t;
STRING=['R Squared = ',num2str(R_Squared_Linear)];
disp(STRING)

%plotting Linear Model
figure;
subplot(2,2,1)
plot(x,y,'ro')
hold on
plot(X,Y_Linear,'k')
grid on
title ('Linear Model','FontSize',13)
xlabel('X','FontSize',12)
ylabel('Y','FontSize',12)

%Exponential Model
%calculate sum of X & Y & X^2 & XY
i=1;
X_sum=0;
Y_sum=0;
X2_sum=0;
XY_sum=0;
Y_Exponential = log(y);
while i<=n
    X_sum = X_sum+x(i);
    X2_sum=X2_sum+x(i).^2;
    Y_sum=Y_sum+Y_Exponential(i);
    XY_sum=XY_sum+x(i).*Y_Exponential(i);
    i=i+1;
end

%solving 2 eqns in 2 unknowns to get a0 & a1 & a &b
I = [n X_sum;X_sum X2_sum];
O = [Y_sum; XY_sum];
sol = linsolve(I,O);
a0=sol(1);
a1=sol(2);
a=exp(a0);
b=a1;
Y_EXP =a.*exp(b.*X);

%displaying the values of the model coefficients
disp('****************************** Exponential Model **************************')
STRING=['a0 = ',num2str(a0),'  a1 = ',num2str(a1)];
disp(STRING)
STRING=['a = ',num2str(a),'  b = ',num2str(b)];
disp(STRING)
STRING=['Y = ',num2str(a) ,' e^',num2str(b),'X'];
disp(STRING)

%calculating St & Sr to get R^2
i=1;
S_r=0;
S_t=0;
Y_avg=Y_sum/n;
while i<=n
    e_i=Y_Exponential(i)-a0-a1.*x(i);
    S_r=S_r+e_i.^2;
    S_t=S_t+(Y_Exponential(i)-Y_avg).^2;
    i=i+1;
end
R_Squared_Exponential=(S_t-S_r)/S_t;
STRING=['R Squared = ',num2str(R_Squared_Exponential)];
disp(STRING)

%plotting Exponential Model
subplot(2,2,2)
plot(x,y,'ro')
hold on
plot(X,Y_EXP,'k')
grid on
title ('Exponential Model','FontSize',13)
xlabel('X','FontSize',12)
ylabel('Y','FontSize',12)

%Power Model
%calculate sum of X & Y & X^2 & XY
i=1;
X_sum=0;
Y_sum=0;
X2_sum=0;
XY_sum=0;
X_power = log10(x);
Y_Power = log10(y);
while i<=n
    X_sum = X_sum+X_power(i);
    X2_sum=X2_sum+X_power(i).^2;
    Y_sum=Y_sum+Y_Power(i);
    XY_sum=XY_sum+X_power(i).*Y_Power(i);
    i=i+1;
end

%solving 2 eqns in 2 unknowns to get a0 & a1 & a &b
I = [n X_sum;X_sum X2_sum];
O = [Y_sum; XY_sum];
sol = linsolve(I,O);
a0=sol(1);
a1=sol(2);
a=10^(a0);
b=a1;
Y_P =a.*X.^b;

%displaying the values of the model coefficients
disp('****************************** Power Model ******************************')
STRING=['a0 = ',num2str(a0),'  a1 = ',num2str(a1)];
disp(STRING)
STRING=['a = ',num2str(a),'  b = ',num2str(b)];
disp(STRING)
STRING=['Y = ',num2str(a) ,' X^',num2str(b)];
disp(STRING)

%calculating St & Sr to get R^2
i=1;
S_r=0;
S_t=0;
Y_avg=Y_sum/n;
while i<=n
    e_i=Y_Power(i)-a0-a1.*X_power(i);
    S_r=S_r+e_i.^2;
    S_t=S_t+(Y_Power(i)-Y_avg).^2;
    i=i+1;
end
R_Squared_Power=(S_t-S_r)/S_t;
STRING=['R Squared = ',num2str(R_Squared_Power)];
disp(STRING)

%plotting Power Model
subplot(2,2,3)
plot(x,y,'ro')
hold on
plot(X,Y_P,'k')
grid on
title ('Power Model','FontSize',13)
xlabel('X','FontSize',12)
ylabel('Y','FontSize',12)

%Growth Rate Model
%calculate sum of X & Y & X^2 & XY
i=1;
X_sum=0;
Y_sum=0;
X2_sum=0;
XY_sum=0;
X_Growth = 1./x;
Y_Growth = 1./y;
while i<=n
    X_sum = X_sum+X_Growth(i);
    X2_sum=X2_sum+X_Growth(i).^2;
    Y_sum=Y_sum+Y_Growth(i);
    XY_sum=XY_sum+X_Growth(i).*Y_Growth(i);
    i=i+1;
end

%solving 2 eqns in 2 unknowns to get a0 & a1 & a &b
I = [n X_sum;X_sum X2_sum];
O = [Y_sum; XY_sum];
sol = linsolve(I,O);
a0=sol(1);
a1=sol(2);
a=1/a0;
b=a1*a;
Y_G =a.*X./(b+X);

%displaying the values of the model coefficients
disp('****************************** Growth Rate Model ******************************')
STRING=['a0 = ',num2str(a0),'  a1 = ',num2str(a1)];
disp(STRING)
STRING=['a = ',num2str(a),'  b = ',num2str(b)];
disp(STRING)
STRING=['Y = ',num2str(a) ,'X/',num2str(b),'+X'];
disp(STRING)

%calculating St & Sr to get R^2
i=1;
S_r=0;
S_t=0;
Y_avg=Y_sum/n;
while i<=n
    e_i=Y_Growth(i)-a0-a1.*X_Growth(i);
    S_r=S_r+e_i.^2;
    S_t=S_t+(Y_Growth(i)-Y_avg).^2;
    i=i+1;
end
R_Squared_Growth=(S_t-S_r)/S_t;
STRING=['R Squared = ',num2str(R_Squared_Growth)];
disp(STRING)

%plotting Growth Rate Model
subplot(2,2,4)
plot(x,y,'ro')
hold on
plot(X,Y_G,'k')
grid on
title ('Growth Rate Model','FontSize',13)
xlabel('X','FontSize',12)
ylabel('Y','FontSize',12)

disp('****************************** The best model ******************************')
STRING=['R_Squared_Linear= ',num2str(R_Squared_Linear)];
disp(STRING)
STRING=['R_Squared_Exponential= ',num2str(R_Squared_Exponential)];
disp(STRING)
STRING=['R_Squared_Power= ',num2str(R_Squared_Power)];
disp(STRING)
STRING=['R_Squared_Growth= ',num2str(R_Squared_Growth)];
disp(STRING)
if (R_Squared_Linear > R_Squared_Exponential) && (R_Squared_Linear > R_Squared_Power) && (R_Squared_Linear > R_Squared_Growth)
    disp('The best fit is THE LINEAR MODEL');
elseif (R_Squared_Exponential > R_Squared_Linear) && (R_Squared_Exponential > R_Squared_Power) && (R_Squared_Exponential > R_Squared_Growth)
    disp('The best fit is THE EXPONENTIAL MODEL');
elseif (R_Squared_Power > R_Squared_Linear) && (R_Squared_Power > R_Squared_Exponential) && (R_Squared_Power > R_Squared_Growth)
    disp('The best fit is THE POWER MODEL');
elseif (R_Squared_Growth > R_Squared_Linear) && (R_Squared_Growth > R_Squared_Exponential) && (R_Squared_Growth > R_Squared_Power)
    disp('The best fit is THE GROWTH RATE MODEL')
end