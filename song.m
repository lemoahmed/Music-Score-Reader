i=imread('JingleBells.bmp');
i=rgb2gray(i);
i=imbinarize(i);
i=imcrop(i,[94 121 530 650]);
lines=i;
xrow=[];
xcol=[];
xr=[];
for row=1 : size(lines,1)
    zeros=0;
    for col =1 :size(lines,2)
        if lines(row,col)==0
            zeros=zeros+1;
        end
    end
    if zeros>450
        lines(row,:)=1;
    else
        lines(row,:)=0;
    end
end

for row=1 : size(i,1)
    zeros=0;
    for col =1 :size(i,2)
        if i(row,col)==0
            zeros=zeros+1;
        end
        if row~=1 && row~=size(i,1)
            if i(row+1,col)==0 && i(row-1,col)==0
            xrow(end+1)=row;
            xcol(end+1)=col;
            end
        end
    end
    if zeros>200
        xr(end+1)=row;
    end
end
for zz=1 : length(xr)
    i(xr(zz),:)=1;
end
for z=1 : length(xrow)
    i(xrow(z),xcol(z))=0;
    i(xrow(z)+1,xcol(z))=0;
    i(xrow(z)-1,xcol(z))=0;
end
i=~i;
x=bwlabel(i);
i(x==4)=0;
i(x==5)=0;
stat=regionprops(x,'boundingbox','Area');
for cnt = 1 : numel(stat)
    bb = stat(cnt).BoundingBox;
    if bb(4)>40
        i(x==cnt)=0;
    end
end
i=imdilate(i,ones(3,3));
lines=imdilate(lines,ones(3,3));
i2=i;
lines2=lines;
start=1;
array_of_strings = []; % empty array of size 1x50 (1 row x 50 col)
timer=[];
for l=1:4
    i=i2(start:start+83, :);
    i_filled=imfill(i,'holes');
    lines=lines2(start:start+83, :);
    i_label=bwlabel(i);
    i_filled_label=bwlabel(i_filled);
    lines_label=bwlabel(lines);
    stat_i=regionprops(i_label,'boundingbox','Area');
    stat_i_fiiled=regionprops(i_filled_label,'boundingbox','Area');
    stat_lines=regionprops(lines_label,'boundingbox','Area');
    
    
     for cnt = 1 : numel(stat_i)
        a=stat_i(cnt).Area;
        a_filled=stat_i_fiiled(cnt).Area;
        bb = stat_i(cnt).BoundingBox;%da boundingbox bta3 l object
        bb1 = stat_lines(1).BoundingBox;%w da awl object fe sora bta3t l lines ya3ny awl line
        bb2 = stat_lines(2).BoundingBox;%w da l tany
        bb3 = stat_lines(3).BoundingBox;% l talt
        bb4 = stat_lines(4).BoundingBox;% l rabe3
        bb5 = stat_lines(5).BoundingBox;% l khames
        %de 3shan yshel l 7gat l so8ayara
        if bb(4)<20 && a ~=a_filled
            timer(end+1)=4;
            if bb(2)>bb5(2)
                array_of_strings(end+1)='C';
            end
            if bb(2)==bb5(2)
                array_of_strings(end+1)='D';
            end
            if bb(2)<bb5(2) && bb(2)+bb(4)>bb5(2)
                array_of_strings(end+1)='E';
            end
            if bb(2)==bb4(2)
                array_of_strings(end+1)='F';
            end
            if bb(2)<bb4(2)&&bb(2)+bb(4)
                array_of_strings(end+1)='G';
            end
            if bb(2)==bb3(2)
                array_of_strings(end+1)='A';
            end
            
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
            elseif bb1(2)>bb(2)+4
                array_of_strings(end+1)='A';
            %law el object ta7t el khat el awlany be distance akbar mel fatet lesa fadel a7aded
            %distance  
            elseif bb1(2)==bb(2)+2||bb1(2)==bb(2)+3 ||bb1(2)==bb(2)+4
                array_of_strings(end+1)='G';
            end
            if a==a_filled
                timer(end+1)=1;
            else
                timer(end+1)=2;
            end
        end        
    end

    
    start=start+160;
    
    
end
% imshow(i_right)
Fs=3000;
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
