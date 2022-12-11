i=imread('TwinkleTwinkleLittleStar.bmp');
i=rgb2gray(i);
i=imbinarize(i);
lines=i;%de 3shan a3ml sora ll lines
%hna b2sm l sora bta3t l lines
lines_left=imcrop(lines,[43 1 577 253]);
lines_right=imcrop(lines,[622 1 100 253]);
%nfs l klam ll sora bta3t l objects b3mlha = 3shan hya nfs l sora l7d dlwa2ty
i_left=lines_left;
i_right=lines_right;
%dol hst5dmhom t7t shan afsl l objects w lines
xrow=[];
xcol=[];
xr=[];
xrow2=[];
xcol2=[];
xr2=[];
%bgyb l lines bta3 goz2 l ymen
for row=1 : size(lines_right,1)
    zeros=0;
    for col =1 :size(lines_right,2)
        if lines_right(row,col)==0
            zeros=zeros+1;
        end
    end
    if zeros>50
        lines_right(row,:)=1;
    else
        lines_right(row,:)=0;
    end
end
%bgyb l lines bta3 goz2 l shmal
for row=1 : size(lines_left,1)
    zeros=0;
    for col =1 :size(lines_left,2)
        if lines_left(row,col)==0
            zeros=zeros+1;
        end
    end
    if zeros>150
        lines_left(row,:)=1;
    else
        lines_left(row,:)=0;
    end
end

%bgyb l objects bta3 goz2 l shmal
for row=1 : size(i_left,1)
    zeros=0;
    for col =1 :size(i_left,2)
        if i_left(row,col)==0
            zeros=zeros+1;
        end
        if row~=1 && row~=size(i_left,1)
            if i_left(row+1,col)==0 && i_left(row-1,col)==0
            xrow(end+1)=row;
            xcol(end+1)=col;
            end
        end
    end
    if zeros>90
        xr(end+1)=row;
    end
end
for zz=1 : length(xr)
    i_left(xr(zz),:)=1;
end
for z=1 : length(xrow)
    i_left(xrow(z),xcol(z))=0;
    i_left(xrow(z)+1,xcol(z))=0;
    i_left(xrow(z)-1,xcol(z))=0;
end
%bgyb l objects bta3 goz2 l ymen
for row=1 : size(i_right,1)
    zeros=0;
    for col =1 :size(i_right,2)
        if i_right(row,col)==0
            zeros=zeros+1;
        end
        if row~=1 && row~=size(i_right,1)
            if i_right(row+1,col)==0 && i_right(row-1,col)==0
            xrow2(end+1)=row;
            xcol2(end+1)=col;
            end
        end
    end
    if zeros>11
        xr2(end+1)=row;
    end
end
for zz=1 : length(xr2)
    i_right(xr2(zz),:)=1;
end
for z=1 : length(xrow2)
    i_right(xrow2(z),xcol2(z))=0;
    i_right(xrow2(z)+1,xcol2(z))=0;
    i_right(xrow2(z)-1,xcol2(z))=0;
end

i_left=~i_left;
i_left2=i_left;%de b3mlha 3shan ast5dmha fe l loop l t7t 3shan mynf3sh ast5dm nfs l variable
i_right=~i_right;
i_right2=i_right;%nfs l klam hna
lines_left2=lines_left;%w hna
lines_right2=lines_right;%w hna
%de ba2a l loop l btsm l sora tlata fe kol iteration byb2a m3aya goz2 mn sora
start=1;
array_of_strings = []; % empty array of size 1x50 (1 row x 50 col)
timer=[];
for l=1:3
    i_left=i_left2(start:start+83, :);%de telt l awl l objects l goz2 l shmal
    i_left_filled=imfill(i_left,'holes');
    i_right=i_right2(start:start+83, :);%w de l telt l awl objects goz2 l ymen
    i_right_filled=imfill(i_right,'holes');
    lines_left=lines_left2(start:start+83, :);%nfs l klam ll sora bta3t l lines
    lines_right=lines_right2(start:start+83, :);
    label_left_i = bwlabel(i_left);
    label_left_i_filled = bwlabel(i_left_filled);
    %hna ba2a bgyb l label bta3 kol goz2(ymen w shmal) ll sortan(lines w object)
    label_right_i = bwlabel(i_right);
    label_right_i_filled = bwlabel(i_right_filled);
    label_left_lines = bwlabel(lines_left);
    label_right_lines = bwlabel(lines_right);
    %b3dan b3ml boundingbox l kol wa7da fehom
    stat_left_i = regionprops(label_left_i,'boundingbox','Area');
    stat_left_i_filled = regionprops(label_left_i_filled,'boundingbox','Area');
    stat_right_i = regionprops(label_right_i,'boundingbox','Area');
    stat_right_i_filled = regionprops(label_right_i_filled,'boundingbox','Area');
    stat_left_lines = regionprops(label_left_lines,'boundingbox','Area');
    stat_right_lines = regionprops(label_right_lines,'boundingbox','Area');
    %hna b3m loop 3ala l objects bs ana 3amlha l goz2 l shmal bs
    count=0;
    for cnt = 1 : numel(stat_left_i)
        if count==4
            count=0;
            continue;
        end
        a=stat_left_i(cnt).Area;
        a_filled=stat_left_i_filled(cnt).Area;
        bb = stat_left_i(cnt).BoundingBox;%da boundingbox bta3 l object
        bb1 = stat_left_lines(1).BoundingBox;%w da awl object fe sora bta3t l lines ya3ny awl line
        bb2 = stat_left_lines(2).BoundingBox;%w da l tany
        bb3 = stat_left_lines(3).BoundingBox;% l talt
        bb4 = stat_left_lines(4).BoundingBox;% l rabe3
        bb5 = stat_left_lines(5).BoundingBox;% l khames
        %de 3shan yshel l 7gat l so8ayara
        if a<20
             continue;
        end
        if l==1 && cnt==1
            continue;
        end
        if bb(4)<20 && l==2
            array_of_strings(end+1)='F';
            timer(end+1)=1;
            count=count+1;
            continue;
        end
        if bb(4)<20 && l==3
            array_of_strings(end+1)='C';
            timer(end+1)=1;
            count=count+1;
            continue;
        end
        if bb(4)>20
            % mafrood el conditions kolaha tet7at fyh for loop 3ala kol objects
            %hna kont bgrb l 7gat l ban l aawl w tany
            if bb1(2)<bb(2) && bb2(2)>bb(2)
                array_of_strings(end+1)='E';
            %hna kont bgrb l 7gat l ban l tany w talet
            elseif bb2(2)<bb(2) && bb3(2)>bb(2)
                array_of_strings(end+1)='C';
            %law el object 3al khat el awlany 
            elseif bb1(2)==bb(2)
                array_of_strings(end+1)='F';
            %law el object 3al khat el tany  
            elseif bb2(2)==bb(2)
                array_of_strings(end+1)='D';
            %law el object ta7t el khat el awlany be sena lesa fadel a7aded
            %distance
            elseif bb1(2)>bb(2)+3
                array_of_strings(end+1)='A';
            %law el object ta7t el khat el awlany be distance akbar mel fatet lesa fadel a7aded
            %distance  
            elseif bb1(2)==bb(2)+2||bb1(2)==bb(2)+3
                array_of_strings(end+1)='G';
            end
            if a==a_filled
                timer(end+1)=1;
                count=count+1;
            else
                timer(end+1)=2;
                count=count+2;
            end
        end        
    end

    %hna b3m loop 3ala l objects 3al goz2 el yemeen
    for cnt = 1 : numel(stat_right_i)
        a=stat_right_i(cnt).Area;
        a_filled=stat_right_i_filled(cnt).Area;
        bb = stat_right_i(cnt).BoundingBox;%da boundingbox bta3 l object
        bb1 = stat_right_lines(1).BoundingBox;%w da awl object fe sora bta3t l lines ya3ny awl line
        bb2 = stat_right_lines(2).BoundingBox;%w da l tany
        bb3 = stat_right_lines(3).BoundingBox;% l talt
        bb4 = stat_right_lines(4).BoundingBox;% l rabe3
        bb5 = stat_right_lines(5).BoundingBox;% l khames
        if count==4
            count=0;
            continue;
        end
        if bb(4)>20   
            if bb1(2)<bb(2) && bb2(2)>bb(2)
                array_of_strings(end+1)='E';
            %hna kont bgrb l 7gat l ban l tany w talet
            elseif bb2(2)<bb(2) && bb3(2)>bb(2)
                array_of_strings(end+1)='C';
            %law el object 3al khat el awlany 
            elseif bb1(2)==bb(2)
                array_of_strings(end+1)='F';
            %law el object 3al khat el tany  
            elseif bb2(2)==bb(2)
                array_of_strings(end+1)='D';
            %law el object ta7t el khat el awlany be sena lesa fadel a7aded
            %distance
            elseif bb1(2)>bb(2)+3
                array_of_strings(end+1)='A';
            %law el object ta7t el khat el awlany be distance akbar mel fatet lesa fadel a7aded
            %distance  
            elseif bb1(2)==bb(2)+2||bb1(2)==bb(2)+3
                array_of_strings(end+1)='G';
            end
            if a==a_filled
                timer(end+1)=1;
                count=count+1;
            else
                timer(end+1)=2;
                count=count+2;
            end
        end
    end
    %hna 3shan ynzl 3ala l goz2 l ta7to
    start=start+84;
end
Fs=10000;
 Ts=1/Fs;
 A = 440; %Frequency of note A is 440 Hz
 B = 493.88;
 C = 523.25;
 Csharp = 554.37; 
 D = 587.33;
 E = 659.26;
 F = 698.46;
 Fsharp = 739.9;
 G = 783.99;
 Gsharp = 830.61;
 freq_of_notes = 0;
 for splits = 1 : length(array_of_strings)
     if timer(splits)==1
        t=[0:Ts:0.2];
     end
     if timer(splits)==2
        t=[0:Ts:0.4];
     end
     if timer(splits)==4
        t=[0:Ts:0.8];
     end
     if array_of_strings(splits) == 65;
         freq_of_notes = A;
     end
     if array_of_strings(splits) == 'B';
         freq_of_notes = B;
     end
     if array_of_strings(splits) == 67;
         freq_of_notes = C;
     end
     if array_of_strings(splits) == 'C#';
         freq_of_notes = Csharp;
     end
     if array_of_strings(splits) == 68;
         freq_of_notes = D;
     end
     if array_of_strings(splits) == 69;
         freq_of_notes = E;
     end
     if array_of_strings(splits) == 70;
         freq_of_notes = F;
     end
     if array_of_strings(splits) == 'F#';
         freq_of_notes = Fsharp;
     end
     if array_of_strings(splits) == 71;
         freq_of_notes = G;
     end
     if array_of_strings(splits) == 'G#';
         freq_of_notes = Gsharp;
     end
      x = cos(2*pi*freq_of_notes*t); 
      soundsc(x,1/Ts)
      
      if timer(splits)==1
        pause(0.4);
     end
     if timer(splits)==2
        pause(0.6);
     end
     if timer(splits)==4
        pause(1.0);
     end
 end