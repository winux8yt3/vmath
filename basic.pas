unit basic;
    
interface
    
uses
    crt,dos,lang,programstr;

type 
	TStr2Num = record
		Check:boolean;
		Value:extended;
	end;
	TStr2Int = record
		Check:boolean;
		Value:longint;
	end;

function ClrSpace (s:string):string;
function Num2Str (v:extended;d:byte):String;
function Str2Num (s:string):TStr2Num;
function Str2Int (s:string):TStr2Int;
function PosLast (ch,s:string):word;
procedure Info;
function Date():string;
function Time():string;
procedure Color(txcolor,BgColor:byte);
procedure Help;
procedure Msg(s:string);
function FunFact(r:byte):string;
function EReport(str,err:string):string;
function Trim(s:string):string;
function TrimLeft(s:string):string;
function TrimRight(s:string):string;

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

function CleanSpace(s:string):string;
var i:byte;
begin
	s:=Trim(s);
	for i:=1 to length(s) do
		while (s[i]=' ') and (s[i+1]=' ') do delete(s,i,1);
	CleanSpace:=s;
end;

function Num2Str (v:extended;d:byte):String;
begin
 	Str(v:0:d,Num2Str);
end;

function Str2Num(s:string):TStr2Num;
var err:byte;
begin
	Str2Num.Check:=False;
 	val(s,Str2Num.value,err);
	if err=0 then Str2Num.Check:=True;
end;

function Str2Int (s:string):TStr2Int;
var err:byte;
begin
	Str2Int.Check:=False;
 	val(s,Str2Int.value,err);
	if err=0 then Str2Int.Check:=True;
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
		Date:=DateText+DayNum[Num]+', '+Num2Str(Day,0)+'/'+Num2Str(Month,0)+'/'+Num2Str(Year,0)+'.';
	end;
	
function Time():string;
	var 
		Hr,Min,Sec,Milisec : word;
	begin
		GetTime(Hr,Min,Sec,Milisec);
        Time:=TimeText+Num2Str(Hr,0)+':'+Num2Str(Min,0)+':'+Num2Str(Sec,0)+'.'+Num2Str(Milisec,0);
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
	writeln('fact,ptnt  : ',HelpTextFact);
	writeln('funfact    : ',HelpTextFunFact);
	writeln('gcd,ucln   : ',HelpTextGcd);
	writeln('lcm,bcnn   : ',HelpTextLcm);
	writeln('help       : ',HelpTextHelp);
	writeln('pause      : ',HelpTextPause);
	writeln('preans     : ',HelpTextPreans);
	writeln('print      : ',HelpTextPrint);
	writeln('ptb2,eqn2  : ',HelpTexteqn2);
	writeln('run        : ',HelpTextRun);
	writeln('time       : ',HelpTextTime);
	writeln;
	writeln('EQUATION    + | - | * | / | # (root) | ^');
end;

procedure Msg(s:string);
begin
	write(s);readln;
end;

function FunFact(r:byte):string;
begin
	randomize;
	while r=0 do r:=random(7);
	Funfact:='Fact #'+Num2Str(r,0)+': ';
	case r of
		1	:FunFact:=FunFact+Fact1;
		2	:FunFact:=FunFact+Fact2;
		3	:FunFact:=FunFact+Fact3;
		4	:FunFact:=FunFact+Fact4;
		5	:FunFact:=FunFact+Fact5;
		6	:FunFact:=FunFact+Fact6;
	end;
end;

function EReport(str:string;err:string):string;
begin
	EReport:='<'+str+'>:'+err;
end;

function Trim(s:string):string;
begin
	s:=TrimLeft(s);
	Trim:=TrimRight(s);
end;

function TrimLeft(s:string):string;
begin
	while pos(' ',s)=1 do delete(s,1,1);
	TrimLeft:=s;
end;

function TrimRight(s:string):string;
begin
	while poslast(' ',s)=length(s) do delete(s,length(s),1);
	TrimRight:=s;
end;

end.