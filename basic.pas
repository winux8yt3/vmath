unit basic;
    
interface
    
uses
    crt,dos,lang,programstr;

function Int2Str (v:Longint):String;
function Str2Int (s:string;var err:word):longint;
function PosLast (ch,s:string):word;
procedure Info;
function Date():string;
function Time():string;
procedure Color(txcolor,BgColor:byte);
procedure Help;
procedure Msg(s:string);
procedure FunFact(r:byte);

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

function PosLast (ch,s:string):word;
var k:word;
begin
	PosLast:=0;k:=1;
	for k:=1 to length(s) do
		if ch=copy(s,k,length(ch)) then PosLast:=k;
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
	writeln('?,info     : ',HelpTextInfo); 
	writeln('clear      : ',HelpTextClear);
	writeln('color      : ',HelpTextColor);
	writeln('date       : ',HelpTextDate);
	writeln('dec        : ',HelpTextDec);
	writeln('exit       : ',HelpTextExit);
	writeln('help       : ',HelpTextHelp);
	writeln('pause      : ',HelpTextPause);
	writeln('preans     : ',HelpTextPreans);
	writeln('print      : ',HelpTextPrint);
	writeln('run        : ',HelpTextRun);
	writeln('time       : ',HelpTextTime);
	writeln;
	writeln('EQUATION    + | - | * | /');
end;

procedure Msg(s:string);
begin
	write(s);readln;
end;

procedure FunFact(r:byte);
begin
	while r=0 do r:=random(5);
	write('Fact #',r,': ');
	case r of
		1	:writeln(Fact1);
		2	:writeln(Fact2);
		3	:writeln(Fact3);
		4	:writeln(Fact4);
	end;
end;

end.