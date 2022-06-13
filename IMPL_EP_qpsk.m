% This program is used to calculate the Bit Error Rate (BER) of QPSK in an 
% Additive White Gaussian Noise (AWGN) channel.

clear ; %Clear all variables
close all; %Close all figures
num_bit=1e6;
EbNodB=0:1:10;
EbNo=10.^(EbNodB/10);
for n=1:length(EbNodB)
    si=2*(round(rand(1,num_bit))-0.5); %In-phase symbol generation
    sq=2*(round(rand(1,num_bit))-0.5); %Quadrature symbol generation                
    s=si+1j*sq; %Adding the two parallel symbol streams
    w=(1/sqrt(2*EbNo(n)))*(randn(1,num_bit)+1j*randn(1,num_bit));  %Random noise generation
    r=s+w;  %Received signal
    si_=sign(real(r)); %In-phase demodulation
    sq_=sign(imag(r));  %Quadrature demodulation
    ber1=(num_bit-sum(si==si_))/num_bit;  %In-phase BER calculation
    ber2=(num_bit-sum(sq==sq_))/num_bit;   %Quadrature BER calculation
    sim_BER(n)=mean([ber1 ber2]);  %Overall BER
end
the_Ber = 0.5*erfc(sqrt(10.^(EbNodB/10))); % theoretical calculation of BER
semilogy(EbNodB, sim_BER,'-'); %Plotting simulated values
hold on
semilogy(EbNodB,the_Ber,'ko'); %Plotting theoretical values
title('BER curve for QPSK modulation');
legend('Simulation','Theoretical');
xlabel('EbNo(dB)')                              
ylabel('BER')                               
grid on