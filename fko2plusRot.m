function [fi,delta] = fko2plusRot(Pok,Pzk)
%UNTITLED Summary of this function goes here
%   Po to polo¿enie pocz¹tka uk³adu (0,0,0)
%   Pz to zadane punkty koncówki manipulatora (x, y, z)

    global R1 R2;
    
    %R1 i R2 to d³ugoœci pozzczególnych ramion
    R1=5;
	R2=12;
    global xw yw;
    
    % na potrzeby obliczeñ stworzono x i y
    syms x y z;
    
    % sprawdzanie d³ugosci macierzy Pz
    [row,col]=size(Pzk);  
    
    for i=1:row    
    % Wyliczanie punktów wspólnych dwóch okregów w celu znalezienia punktu
    % koñcowego pierwszego ramienia (i pocz¹tku drugiego ramienia)
    [xw, yw]=solve((x-Pok(1,1))^2+(y-Pok(1,2))^2==R1^2, (x-Pzk((i),1))^2+(y-Pzk((i),2))^2==R2^2, x, y);
    
    %funkcja atan2 wyliczamy k¹t pomiedzy osi¹ X a pierwszym ramieniem,
    %konwersja na liczbê a nastêpnie na k¹t
    fi(i,1)=double(atan2(yw(1,1),xw(1,1)))*180/pi;
    fi(i,2)=double(atan2(yw(2,1),xw(2,1)))*180/pi;
    
    %funkcja atan2 wyliczamy k¹t pomiedzy osia X a wektorem Po,Pz w
    %stopniach i przerabiamy od razu na kat miedzy pierwszym ramieniem a drugim ramieniem w stopniach
    delta(i,1)=180-fi(i,1)+double(atan2((Pzk((i),2)-yw(1,1)),Pzk((i),1)-xw(1,1)))*(180/pi);    
    delta(i,2)=180-fi(i,2)+double(atan2((Pzk((i),2)-yw(2,1)),Pzk((i),1)-xw(2,1)))*(180/pi);    

    end

end
%copyrights Sebastian Czuma
%xD
