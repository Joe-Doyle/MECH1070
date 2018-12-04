function temp = fetchTemp(pin)

%This fetches and normalizes the temperature
% of a TMP36 sensor on an analog pin of an
% attached arduino

pin = strcat('A',num2str(pin))

temp = normTemp((readVoltage(a,pin) * (1023 / 5)), 5)

end