function [alfa,Pok,Pzk] = fkoRot(Po,Pz)
%UNTITLED Summary of this function goes here
%   Po to polo�enie pocz�tka uk�adu ale tylko osi x reszta pozostaje bez
%   zmian
%   Pz to zadane punkty konc�wki manipulatora (x, y, z)
    
    % na potrzeby oblicze� stworzono nowe x i y
    new_Po = sqrt(Po(1,1)^2 + Po(1,3)^2);
    Pok(1,1) = new_Po;
    Pok(1,2) = Po(1,2);
    Pok(1,3) = Po(1,3);
    
    % sprawdzanie d�ugosci macierzy Pz
    [row,col]=size(Pz);  
    
    for i=1:row
    %wyznacznie k�ta rotacji podstawy
    alfa(i) = double(atan2(Pz(i,1),Pz(i,3)))*180/pi;
    
    %wyznaczanie nowej osi na lini d�ugo�ci ramienia manipulatora gdy�
    %wcze�niejsza funkcja (we wcze�niejszej wersji) byla dla 2 lub 3 stopni
    %swobody (bez rotacji podstawy)
    new_Pz = sqrt(Pz(i,1)^2 + Pz(i,3)^2);
    Pzk(i,1) = new_Pz;
    Pzk(i,2) = Pz(i,2);
    Pzk(i,3) = Pz(i,3);
    end

end
%copyrights Sebastian Czuma
%xD
