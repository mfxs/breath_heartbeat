function amplitude(x,fs)
mag=abs(fft(x));
n=length(x);
f=0:fs/(n-1):fs;
plot(f,mag);
xlabel('Frequency');
ylabel('Amplitude');
end