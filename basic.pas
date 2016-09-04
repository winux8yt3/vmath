unit basic;
    
interface
    
uses
    crt,dos,lang,programstr;

function ClrSpace (s:string):string;
function Num2Str (v:Longint):String;
function Str2Num (s:string):longint;
function ChkS2N (s:string):byte;
function PosLast (ch,s:string):word;
procedure Info;
function Date():string;
function Time():string;
procedure Color(txcolor,BgColor:byte);
procedure Help;
procedure Msg(s:string);
function FunFact(r:byte):string;
function EReport(str,err:string):string;

implementation

function ClrSpace (s:string):string;
var p:byte;
begin
	p:=pos(' ',s);
	while p <> 0 do begin
		delete(s,p,1);
		p:=pos(' ',s);
	end;
	ClrSpace:=s;
end;


function Num2Str (v:Longint):String;
var s: string;
begin
 	Str(v,s);
 	Num2Str:=s;
end;

function Str2Num (s:string):longint;
var 
	v:longint;
	err:byte;
begin
 	val(s,v,err);
    Str2Num:=v;
end;

function ChkS2N (s:string):byte;
var 
	v:longint;
	err:byte;
begin
	val(s,v,err);
	ChkS2N:=err;
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
		Date:=DateText+DayNum[Num]+', '+Num2Str(Day)+'/'+Num2Str(Month)+'/'+Num2Str(Year)+'.';
	end;
	
function Time():string;
	var 
		Hr,Min,Sec,Milisec : word;
	begin
		GetTime(Hr,Min,Sec,Milisec);
        Time:=TimeText+Num2Str(Hr)+':'+Num2Str(Min)+':'+Num2Str(Sec)+'.'+Num2Str(Milisec);
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
	writeln('ptb2,cqe2  : ',HelpTextcqe2);
	writeln('run        : ',HelpTextRun);
	writeln('time       : ',HelpTextTime);
	writeln;
	writeln('EQUATION    + | - | * | /');
end;

procedure Msg(s:string);
begin
	write(s);readln;
end;

function FunFact(r:byte):string;
begin
	while r=0 do r:=random(5);
	write('Fact #',r,': ');
	case r of
		1	:FunFact:=Fact1;
		2	:FunFact:=Fact2;
		3	:FunFact:=Fact3;
		4	:FunFact:=Fact4;
	end;
end;

function EReport(str,err:string):string;
begin
	EReport:='<'+str+'>:'+err;
end;

end.