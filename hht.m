function hht(L)
imf=emd(L);  % 对输入信号进行EMD分解    
[A,f,~]=hhspectrum(imf);    % 对IMF分量求取瞬时频率与振幅：A：是每个IMF的振幅向量,f:每个IMF对应的瞬时频率，t：时间序列号
[E,~,Cenf]=toimage(A,f);    % 将每个IMF信号合成求取Hilbert谱，E：对应的振幅值，Cenf：每个网格对应的中心频率。这里横轴为时间，纵轴为频率。即时频图(用颜色表示第三维值的大小)和三维图（三维坐标系：时间，中心频率，振幅）        
cemd_visu(L,1:length(L),imf); % 显示每个IMF分量及残余信号
disp_hhs(E);    % 希尔伯特谱
% 画出边际谱
colormap(flipud(gray)); % 黑白显示
N=length(Cenf);    % 设置频率点数。完全从理论公式出发。网格化后中心频率很重要，大家从连续数据变为离散的角度去思考，相信应该很容易理解
for k=1:size(E,1)
    bjp(k)=sum(E(k,:))*1/100;
end
figure(3);
plot(Cenf(1,:)*100,bjp);  % 作边际谱图   进行求取Hilbert谱时频率已经被抽样成具有一定窗长的离散频率，所以此时的频率轴已经是中心频率
xlabel('频率 / Hz');
ylabel('幅值');
end