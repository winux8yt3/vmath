unit basic;
    
interface
    
uses
    crt,dos,lang,programstr;

type 
	TStr2Num = record
		Check:boolean;
		Value:extended;
	end;

function ClrSpace (s:string):string;
function Num2Str (v:extended;d:byte):String;
function Str2Num (s:string):TStr2Num;
function Str2Int (s:string):longint;
function PosLast (ch,s:string):word;
procedure Info;
function Date():string;
function Time():string;
procedure Color(txcolor,BgColor:byte);
procedure Help;
procedure Msg(s:string);
function FunFact(r:byte):string;
procedure Cat(s:string);
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

function Str2Int (s:string):longint;
var err:byte;
begin
 	val(s,Str2Int,err);
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
	writeln('Cat		: ',HelpTextCat);
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
	writeln('EQUATION    + | - | * | / | ^');
end;

procedure Msg(s:string);
begin
	write(s);readln;
end;

function FunFact(r:byte):string;
begin
	while r=0 do r:=random(5);
	Funfact:='Fact #'+Num2Str(r,0)+': ';
	case r of
		1	:FunFact:=FunFact+Fact1;
		2	:FunFact:=FunFact+Fact2;
		3	:FunFact:=FunFact+Fact3;
		4	:FunFact:=FunFact+Fact4;
	end;
end;

procedure Cat(s:string);
var
	k:word;
	err1,err2:cardinal;
	f1,f2:text;
	str,FName1,FName2:string;
begin
	delete(s,1,3);
	s:=ClrSpace(s);
	if (pos('<<',s)<>0) or (pos('>>',s)<>0) then begin
		if (pos('<<',s)<>0) then
		begin 
			k:=pos('<<',s);
			FName1:=copy(s,k+2,(length(s)-k-1));
			FName2:=copy(s,1,k-1);
		end
		else if (pos('>>',s)<>0) then 
			begin 
				k:=pos('>>',s);
				FName1:=copy(s,1,k-1);
				FName2:=copy(s,k+2,(length(s)-k-1));
			end;
		{$I-}
		assign(f2,FName2);
		rewrite(f2);
		{$I+}
		err2:=IOResult;close(f2);
		{$I-}
		assign(f1,FName1);
		Reset(f1);
		{$I+}
		err1:=IOResult;close(f1);
		if (err1=0) and (err2=0) then
			while not eof(f1) do begin
				Reset(f1);
				readln(f1,str);
				close(f1);
				append(f2);
				writeln(f2,str);
				close(f2);
			end
		else writeln(EReport(FName1+','+FName2,ErrorId3))
	end
	else writeln(EReport('',ErrorId1));
end;

function EReport(str:string;err:string):string;
begin
	EReport:='<'+str+'>:'+err;
end;

end.