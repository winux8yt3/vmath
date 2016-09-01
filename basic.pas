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
procedure Msg(s:string);

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
	err:=0;
 	val(s,v,err);
 	if err<>0 then writeln('<',s,'> : ',ErrorId1)
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
	writeln(LoadText);
	TextColor(txcolor);
	TextBackground(BgColor);
end;

procedure Help;
begin
	writeln;
	writeln('?,info     : About the Program'); 
	writeln('clear      : Clear screen');
	writeln('color      : Change text and background color');
	writeln('date       : Print date');
	writeln('delay      : Wait (milisecond)');
	writeln('exit       : Exit');
	writeln('help       : Instruction');
	writeln('pause      : Pause the program');
	writeln('preans     : Print last math answer');
	writeln('print      : Print text');
	writeln('run        : Print text from file or Run');
	writeln('time       : Print time');
	writeln;
	writeln('EQUATION    + | - | * | /');
end;

procedure Msg(s:string);
begin
	write(s);readln;
end;

end.