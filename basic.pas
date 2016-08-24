unit basic;
    
interface
    
uses
    crt,dos,lang,programstr;

function Int2Str (v:Longint):String;
function Str2Int (s:string):longint;
procedure Info;
procedure Clear;
function Date():string;
function Time():string;
procedure Color(txcolor,BgColor:byte);
    
implementation

function ClrSpace (s:string):string;
var p:byte;
begin
	p:=pos(' ',s);
	if p <> 0 then 
		repeat
			delete(s,p,1);
			p:=pos(' ',s);
		until (p=0)
	else ClrSpace:=s;
end;

function Int2Str (v:Longint):String;
var s: string;
begin
 Str(v,s);
 Int2Str:=s;
end;

function Str2Int (s:string):longint;
var v,err:longint;
begin
 val(s,v,err);
 if err<>0 then write('<',s,'>:',ErrorId1)
    else Str2Int:=v;
end;

procedure Info;
begin
    write(ProgramInfo);writeln;
    write('(c) 2016 Nguyen Tuan Dung (Winux8yt3)');writeln;
    write(InfoText);writeln;
end;

procedure Clear;
begin
	clrscr;	
end;

function Date():string;
	var 
		Year,Month,Day,Num : word;
	begin
		GetDate(Year,Month,Day,Num);
		Date:=DateText+DayNum[Num]+', '+Int2Str(Day)+'/'+Int2Str(Month)+'/'+Int2Str(Year)+'.';
	end;
	
function Time():string;
	var 
		Hr,Min,Sec,Milisec : word;
	begin
		GetTime(Hr,Min,Sec,Milisec);
        Time:=TimeText+Int2Str(Hr)+':'+Int2Str(Min)+':'+Int2Str(Sec)+'.'+Int2Str(Milisec);
	end;

procedure Color(txcolor,BgColor:byte);
begin
	TextColor(txcolor);
	TextBackground(BgColor);
end;

end.