% plotting data - 2024.01.29 ajb

% plot mean anitaspec for both
figure(1); cla;


% wavenumber vector
wn = process.wavenum;

% spectra
M = process.meananitaspec(:,1);
S = process.meananitaspec(:,2);

Mdet1 = process.spec{1, 1}(:,1);
Mdet2 = process.spec{1, 1}(:,2);
Mdet3 = process.spec{1, 1}(:,3);


Mdet1anita = process.anitaspec{1, 1}(:,1);
Mdet2anita = process.anitaspec{1, 1}(:,2);
Mdet3anita = process.anitaspec{1, 1}(:,3);

% subplot(311)
% plot(wn,Mdet1)
% legend('det1')
% subplot(312)
% plot(wn,Mdet2)
% legend('det2')
% subplot(313)
% plot(wn,Mdet3)
% legend('det3')


figure(2);cla
subplot(311)
plot(wn,Mdet1anita)
legend('det1')
subplot(312)
plot(wn,Mdet2anita)
legend('det2')
subplot(313)
plot(wn,Mdet3anita)
legend('det3')
%plot(wn,Mdet1);
%axis tight

Sdet1anita = process.anitaspec{1, 2}(:,1);
Sdet2anita = process.anitaspec{1, 2}(:,2);
Sdet3anita = process.anitaspec{1, 2}(:,3);

figure(3);cla
subplot(311)
plot(wn,Sdet1anita)
legend('det1')
subplot(312)
plot(wn,Sdet2anita)
legend('det2')
subplot(313)
plot(wn,Sdet3anita)
legend('det3')



plot(wn,M,'r');
hold on
plot(wn,S,'b');
axis tight
xlabel('wavenumber shift')
ylabel('mean signal')