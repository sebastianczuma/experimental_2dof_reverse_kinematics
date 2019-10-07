function [fi,delta,gamma] = fko3plusRot(Pok,Pzk)
%UNTITLED Summary of this function goes here
%   Po to polo�enie pocz�tka uk�adu (0,0,0)
%   Pz to zadane punkty konc�wki manipulatora (x, y, z)

    global R1 R2 R3;
    
    %R1, R2 i R3 to d�ugo�ci poszczeg�lnych ramion
    R1=5;
	R2=12;
    R3=6;

    global xw yw; %punkty przeci�cia si� dw�ch okreg�w o �rodkach tam gdzie punkt poczatkowy uk�adu i punkt zadany o promieniach R1+0.5*R2 i R3+0.5*R2
    global xw1_1 yw1_1 xw1_2 yw1_2; %zmienne przechowujace jedna warto�� czyli punkt styku(nie dwa punkty przeciecia) nowego okregu o srodku w wyliczonym wyzej punkcie z drugiem okregiem o promeiniu R1
    global xw2_1 yw2_1 xw2_2 yw2_2; %zmienne przechowujace jedna warto�� czyli punkt styku(nie dwa punkty przeciecia) nowego okregu o srodku w wyliczonym wyzej punkcie z drugiem okregiem o promeiniu R3
    global xw3_1 yw3_1 xw3_2 yw3_2; %zmienne przechowuj�ce dwie warto��, tj. punkty przeciecia si� okregu o �rodku z punkt�w wyliczonych le�acych na okregu R1(xw2_1 yw2_1 xw2_2 yw2_2) i okregu R3
    global xw4_1 yw4_1 xw4_2 yw4_2; %to samo co linijke wy�ej ale dla okr�gu pierwszego z punkt�w na okregu R3
    
    % na potrzeby oblicze� stworzono x i y
    syms x y z;
    
    % sprawdzanie d�ugosci macierzy Pz
    [row,col]=size(Pzk);
    
    for i=1:row  
        %ETAP I
        % Wyliczanie punkt�w wsp�lnych dw�ch okreg�w o promieniach R1+1/2*R2 i
        % R3+1/2*R2 w celu znalezienia punkt�w potrzebnych do uzyskania
        % polozenia ramienia R2:
        [xw, yw]=solve((x-Pok(1,1))^2+(y-Pok(1,2))^2==(R1+0.5*R2)^2, (x-Pzk(i,1))^2+(y-Pzk(i,2))^2==(R3+0.5*R2)^2, x, y);

            %ETAP II
        %Maj�c dwa punkty policzone wy�ej od ka�dego z nich tworzymy okrag o
        %promieniu 1/2*R2 i o �rodku znajdujacym si� na wyliczonych dw�ch
        %punktach. Najpierw liczymy dla punktu pierwszego
        %punkt styku z okregiem powsta�ym od R1
        [xw1_1, yw1_1]=solve((x-Pok(1,1))^2+(y-Pok(1,2))^2==(R1)^2, (x-xw(1))^2+(y-yw(1))^2==(0.5*R2)^2, x, y);

        %Potem dla drugiego punktu styku:
        [xw1_2, yw1_2]=solve((x-Pok(1,1))^2+(y-Pok(1,2))^2==(R1)^2, (x-xw(2))^2+(y-yw(2))^2==(0.5*R2)^2, x, y);

        %Nast�pnie od R3 dla pierwszego punktu styku:
        [xw2_1, yw2_1]=solve((x-Pzk(i,1))^2+(y-Pzk(i,2))^2==(R3)^2, (x-xw(1))^2+(y-yw(1))^2==(0.5*R2)^2, x, y);    

        %Potem dla drugiego punktu styku:
        [xw2_2, yw2_2]=solve((x-Pzk(i,1))^2+(y-Pzk(i,2))^2==(R3)^2, (x-xw(2))^2+(y-yw(2))^2==(0.5*R2)^2, x, y); 

            %ETAP III
        %Prowadzimy okr�g o promieniu R2 od wyliczonego punktu (xw1_1,yw1_1) i
        %znajdujemy punkty przeci�cia na okregu najpierw R3, najpierw od
        %pierwszego punktu styku:
        [xw3_1, yw3_1]=solve((x-Pzk(i,1))^2+(y-Pzk(i,2))^2==(R3)^2, (x-xw1_1)^2+(y-yw1_1)^2==(R2)^2, x, y);

        %Potem drugi:
        [xw3_2, yw3_2]=solve((x-Pzk(i,1))^2+(y-Pzk(i,2))^2==(R3)^2, (x-xw1_2)^2+(y-yw1_2)^2==(R2)^2, x, y);

        %Potem R1, pierwszy punkt styku
        [xw4_1, yw4_1]=solve((x-Pok(1,1))^2+(y-Pok(1,2))^2==(R1)^2, (x-xw2_1)^2+(y-yw2_1)^2==(R2)^2, x, y);

        %i drugi punkt styku dla R1:
        [xw4_2, yw4_2]=solve((x-Pok(1,1))^2+(y-Pok(1,2))^2==(R1)^2, (x-xw2_2)^2+(y-yw2_2)^2==(R2)^2, x, y);

            %ETAP IV
        %funkcja atan2 wyliczamy k�t pomiedzy osi� X a pierwszym ramieniem R1,
        %konwersja na liczb� a nast�pnie na k�t
        %b�dzie 6 k�t�w fi a 1 i 3 powtarzaja sie dwa razy poniewaz z tego
        %punktu mo�na poprowadzi� dwie proste
        fi(i,1)=double(atan2(yw1_1,xw1_1))*180/pi;
        fi(i,2)=double(atan2(yw1_1,xw1_1))*180/pi;
        fi(i,3)=double(atan2(yw1_2,xw1_2))*180/pi;
        fi(i,4)=double(atan2(yw1_2,xw1_2))*180/pi;
        fi(i,5)=double(atan2(yw4_1(1),xw4_1(1)))*180/pi;
        fi(i,6)=double(atan2(yw4_1(2),xw4_1(2)))*180/pi;
        fi(i,7)=double(atan2(yw4_2(1),xw4_2(1)))*180/pi;
        fi(i,8)=double(atan2(yw4_2(2),xw4_2(2)))*180/pi;

        %funkcja atan2 wyliczamy k�t pomiedzy osia X a drugim ramieniem w
        %stopniach od razu przerabiamy na kat pomiedzy pierwszym a drugim
        %ramieniem
        delta(i,1)=180-fi(i,1)+double(atan2((yw3_1(1)-yw1_1),(xw3_1(1)-xw1_1)))*180/pi;
        delta(i,2)=180-fi(i,2)+double(atan2((yw3_1(2)-yw1_1),(xw3_1(2)-xw1_1)))*180/pi;
        delta(i,3)=180-fi(i,3)+double(atan2((yw3_2(1)-yw1_2),(xw3_2(1)-xw1_2)))*180/pi;
        delta(i,4)=180-fi(i,4)+double(atan2((yw3_2(2)-yw1_2),(xw3_2(2)-xw1_2)))*180/pi;
        delta(i,5)=180-fi(i,5)+double(atan2((yw2_1-yw4_1(1)),(xw2_1-xw4_1(1))))*180/pi;
        delta(i,6)=180-fi(i,6)+double(atan2((yw2_1-yw4_1(2)),(xw2_1-xw4_1(2))))*180/pi;
        delta(i,7)=180-fi(i,7)+double(atan2((yw2_2-yw4_2(1)),(xw2_2-xw4_2(1))))*180/pi;
        delta(i,8)=180-fi(i,8)+double(atan2((yw2_2-yw4_2(2)),(xw2_2-xw4_2(2))))*180/pi;

        %funkcja atan2 wyliczamy k�t pomiedzy osia X a trzecim ramieniem w
        %stopniach od razu przerabiamy na k�t pomiedzy drugim a trzecim
        %ramieniem
        gamma(i,1)=360-delta(i,1)-fi(i,1)+double(atan2((Pzk((i),2)-(yw3_1(1))),(Pzk((i),1)-xw3_1(1))))*180/pi;
        gamma(i,2)=360-delta(i,2)-fi(i,2)+double(atan2((Pzk((i),2)-yw3_1(2)),(Pzk((i),1)-xw3_1(2))))*180/pi;
        gamma(i,3)=360-delta(i,3)-fi(i,3)+double(atan2((Pzk((i),2)-yw3_2(1)),(Pzk((i),1)-xw3_2(1))))*180/pi;
        gamma(i,4)=360-delta(i,4)-fi(i,4)+double(atan2((Pzk((i),2)-yw3_2(2)),(Pzk((i),1)-xw3_2(2))))*180/pi;
        gamma(i,5)=360-delta(i,5)-fi(i,5)+double(atan2((Pzk((i),2)-yw2_1),(Pzk((i),1)-xw2_1)))*180/pi;
        gamma(i,6)=360-delta(i,6)-fi(i,6)+double(atan2((Pzk((i),2)-yw2_1),(Pzk((i),1)-xw2_1)))*180/pi;
        gamma(i,7)=360-delta(i,7)-fi(i,7)+double(atan2((Pzk((i),2)-yw2_2),(Pzk((i),1)-xw2_2)))*180/pi;
        gamma(i,8)=360-delta(i,8)-fi(i,8)+double(atan2((Pzk((i),2)-yw2_2),(Pzk((i),1)-xw2_2)))*180/pi;
        
            %ETAP V
        %szukanie i ewentualna zamiana k�t�w wi�kszych ni� 360 stopni
        %(jedynie dla delty i gamma gdy� przy fi jest niemo�liwe wyliczenie
        %wi�kszego k�ta)
        for j=1:8
            if(delta(i,j)>360) delta(i,j)=delta(i,j)-360;   end
            if(gamma(i,j)>360) gamma(i,j)=gamma(i,j)-360;   end
        end
    
    end

end
%copyrights Sebastian Czuma
%xD
