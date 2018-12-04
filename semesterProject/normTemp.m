function temp = normTemp(inTemp, voltage)

%This function normalizes the temperature reading of
% a TMP36 tmperature sensor given the raw input and
% reference voltage

temp1 = inTemp/1024;
temp1 = temp1*voltage;
temp1 = temp1-0.5;
temp1 = temp1*100;
temp1 = temp1*1.8 + 32;
temp  = temp1;