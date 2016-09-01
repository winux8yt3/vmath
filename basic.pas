unit basic;
    
interface
    
uses
    crt,dos,lang,programstr;

function Int2Str (v:Longint):String;
function Str2Int (s:string;var err:word):longint;
procedure Info;
function Date():string;
function Time():string;
procedure Color(txcolor,BgColor:byte);
procedure Help;
procedure Msg(s:variant);

implementation

function Int2Str (v:Longint):String;
var s: string;
begin
 	Str(v,s);
 	Int2Str:=s;
end;

function Str2Int (s:string;var err:word):longint;
var v:longint;
begin
 	val(s,v,err);
 	if err<>0 then write('<',s,'>:',ErrorId1)
    else Str2Int:=v;
end;

procedure Info;
begin
    writeln(ProgramInfo);
    writeln(CopyrightInfo);
    writeln(InfoText);
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

procedure Help;
begin
	writeln('?,help		: Help'); 
	writeln('clear		: Clear Screen');
	writeln('color		: Change Text And Background Color');
	writeln('date		: Print Date');
	writeln('delay		: Wait (milisecond)');
	writeln('exit		: Exit');
	writeln('info		: Info of program');
	writeln('pause		: Pause the program');
	writeln('preans		: Print last output');
	writeln('print		: Print Text');
	writeln('run		: Print Text from file or Run');
	writeln('time		: Print Time');
	writeln;
	writeln('EQUATION	 + | - | * | % | : | ^');
end;

procedure Msg(s:variant);
begin
	write(s);readln;
end;

end.