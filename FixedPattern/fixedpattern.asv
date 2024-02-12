clear;
close all;

load('whitelamp.mat')
WhiteSpec = RawData.Spectrum;
load('darkspec.mat');
DarkSpec = RawData.Spectrum;
load('LedTable.mat');
LedSpec = RawData.Spectrum;
load('throughput.mat');
ThroughputSpec = RawData.Spectrum;

load('whitelampBottomnshinning.mat');
BotWhiteSpec = RawData.Spectrum;

load('throughput5frame25min.mat');
ThroughputSpec2 = RawData.Spectrum;

load('darkspec5frame25min.mat');
DarkSpec2 = RawData.Spectrum;


OffsetThroughput = ThroughputSpec - DarkSpec;
OffsetWhiteSpec = WhiteSpec - DarkSpec;
OffsetBotWhiteSpec = BotWhiteSpec - DarkSpec;
OffsetThroughput2 = ThroughputSpec2 - DarkSpec2;


figure(2); clf
imagesc(OffsetThroughput2); 

%Row = 47;    % this is a bright row from frame 1 of white light
Row = 92; % to compare the bright line with green glass
RowLength = 256;

figure(1);
subplot (211);
for i=1:5,
    plot( OffsetThroughput2(Row+(i-1)*RowLength,:) );
    hold on
    % plot( DarkSpec(Row+(i-1)*RowLength,:) );
end

ylabel('Light counts shinning 25 min')
xlabel('x pixel number')
%hold off;
subplot (212);
% plot this row in each of the five frames
%figure(2);
for i=1:5,
    plot( OffsetThroughput(Row+(i-1)*RowLength,:) );
    hold on
    % plot( DarkSpec(Row+(i-1)*RowLength,:) );
end
ylabel('Light counts shinning 5 min')
xlabel('x pixel number')


WhiteFirstSpec =  double(OffsetWhiteSpec(Row,:));
BotWhiteFirstSpec = double(OffsetBotWhiteSpec(Row,:));
ThroughputFirstSpec =  double(OffsetThroughput(Row,:));
Throughput2FirstSpec = double(OffsetThroughput2(Row,:));

% create a smoothed version that has no ripples
WindowSize = 200;
ThroughputSmoothSpec = (smooth(double(ThroughputFirstSpec),WindowSize))';
WhiteSmoothSpec = (smooth(double(WhiteFirstSpec),WindowSize))';
BotWhiteSmoothSpec = (smooth(double(BotWhiteFirstSpec),WindowSize))';

figure (3);
%subplot(211);
plot(WhiteFirstSpec./WhiteSmoothSpec,'b');
hold on;
%subplot(212);
plot((BotWhiteFirstSpec./BotWhiteSmoothSpec),'r');

legend('Top shinning','Bottom shinning')

figure (10); clf
subplot(211);
plot (WhiteFirstSpec);
subplot(212);
plot(ThroughputFirstSpec);



figure(11);
subplot(211);
plot(ThroughputFirstSpec./ThroughputSmoothSpec);

subplot(212);
plot(WhiteFirstSpec./WhiteSmoothSpec)
% plot the light counts (dark counts removed)
%figure(1); clf

subplot(311);


subplot(312)
cla
plot(WhiteFirstSpec,'r')
hold on
plot(WhiteSmoothSpec,'b')
legend('data','smoothed')

% this is the correction vector
CorrectionFactor = WhiteFirstSpec./WhiteSmoothSpec;

subplot(313)
% plot the ratio of these to get the response function
cla
plot(WhiteFirstSpec./WhiteSmoothSpec)
hold on 
plot([1 1024],[1 1],'k--')  % the 1 line
legend('Ratio')

%%

% Now check that an independent light source can be similarly corrected 

% example 1 : LED light 

LedFirstSpec =  double(LedSpec(Row,:));
LedSmoothSpec = (smooth(double(LedFirstSpec),WindowSize))';
LedFirstSpecCorrected = LedFirstSpec./CorrectionFactor;

% example 2: paper

% example 3: green glass 

ThroughputFirstSpecCorrected = Throughput2FirstSpec ./ CorrectionFactor;
figure(100);
plot(ThroughputFirstSpecCorrected);
hold on
plot(Throughput2FirstSpec);




