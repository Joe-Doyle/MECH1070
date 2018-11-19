function deflection = calcDef(L, F, E, b, h)

%This function calculates the deflection of a beam using
%(L)ength, (F)Point Load, (E)Youngs Modulus in GPa, (b)width of
%beam cross section, and (h)eight of beam cross section.

I = (b*h^3)/12 %compute second moment of area from beam width and height
E = E*1000000000 %convert GPa to psi
deflection = (F*L^3)/(48*E*I) %compute deflection
end