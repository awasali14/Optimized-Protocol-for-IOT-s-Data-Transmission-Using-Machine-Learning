clc;
close all;
clear all;
% Signal generation
x=0:.5:4*pi;                             % siganal taken upto 4pi
sig1=8*sin(x);                           % generate 1st sinusoidal signal
l=length(sig1);
sig2=8*triang(l);                        % Generate 2nd traingular Sigal
% Display of Both Signal
subplot(2,2,1);                          
plot(sig1);
title('Sinusoidal Signal');
ylabel('Amplitude--->');
xlabel('Time--->');
subplot(2,2,2);
plot(sig2);
title('Triangular Signal');
ylabel('Amplitude--->');
xlabel('Time--->');
% Display of Both Sampled Signal
subplot(2,2,3);
stem(sig1);
title('Sampled Sinusoidal Signal');
ylabel('Amplitude--->');
xlabel('Time--->');
subplot(2,2,4);
stem(sig2);
title('Sampled Triangular Signal');
ylabel('Amplitude--->');
xlabel('Time--->');
l1=length(sig1);
l2=length(sig2);
 for i=1:l1
  sig(1,i)=sig1(i);                        % Making Both row vector to a matrix
  sig(2,i)=sig2(i);
 end  
% TDM of both quantize signal
tdmsig=reshape(sig,1,2*l1);
%data = membrane(1);
s = whos('tdmsig')
tcpipServer = tcpip('0.0.0.0',55000,'NetworkRole','Server');
set(tcpipServer,'OutputBufferSize',s.bytes);
fopen(tcpipServer);
fwrite(tcpipServer,tdmsig(:),'double');
fclose(tcpipServer);