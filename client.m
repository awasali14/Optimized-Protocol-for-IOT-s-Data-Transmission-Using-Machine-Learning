tcpipClient = tcpip('localhost',55000,'NetworkRole','Client')
set(tcpipClient,'InputBufferSize',416);
set(tcpipClient,'Timeout',60);
fopen(tcpipClient);
rawData = fread(tcpipClient,52,'double');
fclose(tcpipClient);
tdmsig = transpose(rawData);
demux=reshape(tdmsig,2,26);
 for i=1:26
  sig3(i)=demux(1,i);                    % Converting The matrix into row vectors
  sig4(i)=demux(2,i);
 end  
 
 % display of demultiplexed signal
 figure
 subplot(2,1,1)
 plot(sig3);
 title('Recovered Sinusoidal Signal');
 ylabel('Amplitude--->');
 xlabel('Time--->');
 subplot(2,1,2)
 plot(sig4);
 title('Recovered Triangular Signal');
 ylabel('Amplitude--->');
 xlabel('Time--->');