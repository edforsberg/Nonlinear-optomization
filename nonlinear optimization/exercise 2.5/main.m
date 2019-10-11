n = 256; %Length signal
m = 256; %Length kernel
ue = zeros(n,1); %Exact signal
ue(20) = 100;
ue(100) = 20;
ue(200) = -100;
ue(250) = -20;
alpha = 1; %Regularization parameter
x_k = linspace(-10,10,m); %Build kernel
sigma = 1.0;
k = exp(-x_k.^ 2 / (2 * sigma ^ 2)); %Gaussian kernel
C = toeplitz([k'; zeros(n-1,1)],[k(1),zeros(1,n-1)]); %Convolution matrix
rng(1234)
noise = 0.0; %3; %Relative noise level
dis = rand(n+m-1,1); %Additive noise
y = C*ue+noise*dis*norm(C*ue,inf)*norm(dis,inf)^-1; %Disturbed convolution
figure(1)
plot(y) %Plot disturbed convolution


ul1 = quadprog(C,y,C,1);  %Calculate L1-reconstruction with quadprog in Matlab or Octave
%ul2 = ??? %Calculate L2-reconstruction by solving a linear system
%uls = ??? %Calculate the least-squares reconstruction
%by solving the normal equations.
figure(2)
plot(ul1) %Plot L1-reconstruction
hold on
%{
plot(ul2) %Plot L2-reconstruction
plot(ue) %Plot exact signal
hold off
figure(3)
plot(uls) %Plot least-squares reconstruction
%}