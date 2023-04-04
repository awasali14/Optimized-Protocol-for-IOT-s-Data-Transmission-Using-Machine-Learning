clc;
clear all
close all

% number of users
nou=16;
t=linspace(0,1000,1000);
t1 = length(t);  
number_of_nodes = nou;
number_of_messages = nou*t1;
%preparing feature set for trained model
rt_features =[number_of_nodes number_of_messages]; 
%calling the trained model
load Trained_model
rt_prediction=(predict(Md1,rt_features));

if rt_prediction == 0 %execute TDM
    
%signal generation
r=rem(nou,2);
q=fix(nou/2);
q1 =q+1;
if r == 0
for i=1:q
    
sig1(i,:)=sin(t);                           

end

for i=1:q
l=length(sig1);
sig2(:,i)=triang(l);
end

else 
   
for i=1:q1
    
sig1(i,:)=sin(t);                           

end

for i=1:q
l=length(sig1);
sig2(:,i)=triang(l);
end

end

% Display of Both Signal
if r == 0
for j=1:q
figure
plot(sig1(j,:))              
xlabel('Time'); ylabel('amplitude'); title('Sinusoidal Signal');
end

for j=1:q
figure
plot(sig2(:,j))              
xlabel('Time'); ylabel('amplitude'); title('Triangular');
end

else 
    
   
 
for j=1:q1
figure
plot(sig1(j,:))              
xlabel('Time'); ylabel('amplitude'); title('Sinusoidal Signal');
end

for j=1:q
figure
plot(sig2(:,j))              
xlabel('Time'); ylabel('amplitude'); title('Triangular');
end

end

% Display of Both Sampled Signal

if r == 0
for i=1:q
figure
stem(sig1(i,:))              
xlabel('Time'); ylabel('amplitude'); title('Sinusoidal Signal');
end

for i=1:q
figure
stem(sig2(:,i))              
xlabel('Time'); ylabel('amplitude'); title('Triangular');
end

else
    
   
 
for i=1:q1
figure
stem(sig1(i,:))              
xlabel('Time'); ylabel('amplitude'); title('Sinusoidal Signal');
end

for i=1:q
figure
stem(sig2(:,i))              
xlabel('Time'); ylabel('amplitude'); title('Triangular');
end

end

%end of signals display

l1=length(sig1);
l2=length(sig2);

 % Making Both row vector to a matrix
if r == 0
for j=1:q
    
for i=1:l1
  sig(j,i)=sig1(i);                          
end
end
q1=q;
for j=1:q
    q1=q1+1;
    for i=1:l1
      sig(q1,i)=sig2(i);  
    end

end

else 
   
for j=1:q1
    
for i=1:l1
  sig(j,i)=sig1(i);                           
end
end
q2=q1;
for j=1:q
    q2=q2+1;
    for i=1:l1
        
        sig(q2,i)=sig2(i);
    end

end

end

% TDM of quantize signal
tdmsig=reshape(sig,1,nou*l1);   

% Display of TDM Signal
figure
stem(tdmsig);
title('TDM Signal');
ylabel('Amplitude');
xlabel('Time');

% Demultiplexing of TDM Signal
 demux=reshape(tdmsig,nou,l1);
 
% Converting The matrix into row vectors 
 
 if r == 0
     for j=1:q
  
for i=1:l1
  sig3(j,i)=demux(j,i); 
end
     end
     q2=q;
for j=1:q
    q2=q2+1;
 for i=1:l1                  
  sig4(j,i)=demux(q2,i);
 end  
end

else 
   
  for j=1:q1
  
for i=1:l1
  sig3(j,i)=demux(j,i); 
end
     end
     q2=q1;
for j=1:q
    q2=q2+1;
 for i=1:l1                  
  sig4(j,i)=demux(q2,i);
 end  
end

 end
% Display of Both Signal
if r == 0
for j=1:q
figure
plot(sig3(j,:))              
xlabel('Time'); ylabel('amplitude'); title('Sinusoidal Signal');
end

for j=1:q
figure
plot(sig4(j,:))              
xlabel('Time'); ylabel('amplitude'); title('Triangular');
end

else 
    
   
 
for j=1:q1
figure
plot(sig3(j,:))              
xlabel('Time'); ylabel('amplitude'); title('Sinusoidal Signal');
end

for j=1:q
figure
plot(sig4(j,:))              
xlabel('Time'); ylabel('amplitude'); title('Triangular');
end

end
 



 
else %execute fdm block
    
   % modulating signal frequency in Hz
channel_freq=[30 40 50 60 70 80 90 100 110 120 130 140 150 160 170 180 190 200 210 220 230 240 250 260 270 280 290 300 310 320 330 340 350 360 370 380 390 400 410 20 430 440 450 460 470 480 490 500 510 520 530 540 550 560 570 580 590 600 610 620 630 640 650 660 670 680 690 700];
    for i=1:nou
   mfreq(1,i) = channel_freq (1,i);
    end

% carrier frequency allocated to the different users in Hz

cfreq=mfreq.*10;
% choose frequency deviation
freqdev=10;
% generate modulating signal 

for i=1:nou
    m(i,:)=sin(2*pi*mfreq(1,i)*t)+2*sin(pi*8*t);
end
% Generate the modulated signal
for i=1:nou
    y(i,:)=fmmod(m(i,:),cfreq(1,i),10*cfreq(1,i),freqdev);
end
% pass the modulated signal through the channel 
ch_op=awgn(sum(y),0,'measured');
% demodulate the received signal at the base station 
for i=1:nou
    z(i,:)=fmdemod(y(i,:),cfreq(1,i),10*cfreq(1,i),freqdev);
end
% display the transmitted signal  and received signal at the base station
% figure
C = {'k','b','r','g','y',[.5 .6 .7],[.8 .2 .6],[.3 .2 .2],'k','b','r','g','y',[.5 .6 .7],[.8 .2 .6],[.3 .2 .2],'k','b','r','g','y',[.5 .6 .7],[.8 .2 .6],[.3 .2 .2],'k','b','r','g','y',[.5 .6 .7],[.8 .2 .6],[.3 .2 .2],'k','b','r','g','y',[.5 .6 .7],[.8 .2 .6],[.3 .2 .2],'k','b','r','g','y',[.5 .6 .7],[.8 .2 .6],[.3 .2 .2],'k','b','r','g','y',[.5 .6 .7],[.8 .2 .6],[.3 .2 .2],'k','b','r','g','y',[.5 .6 .7],[.8 .2 .6],[.3 .2 .2],'k','b','r','g','y',[.5 .6 .7],[.8 .2 .6],[.3 .2 .2],'k','b','r','g','y',[.5 .6 .7],[.8 .2 .6],[.3 .2 .2],}; % Cell array of colros.
for i=1:nou 
    figure (1)
    hold on 
    plot(y(i,:),'color',C{i});
    xlabel('time index'); ylabel('amplitude'); title('Signal from different users combined in the channel');
    figure
    subplot(3,1,1)
    plot(m(i,:))               % modulating signal
    xlabel('time index'); ylabel('amplitude'); title('modulating Signal from user');
    subplot(3,1,2)
    plot(y(i,:),'color',C{i}); % modulated signal
    xlabel('time index'); ylabel('amplitude'); title('modulated Signal');
    subplot(3,1,3)
    plot(z(i,:),'color',C{i}); % demodulated signal 
    xlabel('time index'); ylabel('amplitude'); title('demodulated Signal from reciever');
end
figure 
plot(ch_op) % combination of all modulated signals passed through the channel
xlabel('time index'); ylabel('amplitude'); title('Signal after passing through the channel');
end