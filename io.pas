unit io;
    
interface

uses
	sysutils,crt,dos,lang,basic;

type 
	tSyntax = array[0..256]of string;

var
	syntax: tSyntax;
	syntaxNum:byte;
	ans:extended;
	dec:word = 2;

procedure CmdSyntax(s:string);
procedure CmdProcess(s:string);
procedure Equation(s:string);
function EquProcess(s:string):extended;
procedure RunFile(FName:string;w:byte);

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

procedure Print(s:string);
begin
	delete(s,1,5);
	s:=trimleft(s);
	writeln(s);
end;

procedure ClrSyntax;
var i:word;
begin
	for i:=0 to syntaxNum do syntax[syntaxNum]:='';
	syntaxNum:=0;
end;

procedure CmdSyntax(s:string);
var 
	p:byte;  //Position of blank space
begin
	s:=lowercase(s);
	syntaxNum:=0;
	p:=pos(' ',s);
	while p<>0 do begin
		syntax[syntaxNum]:=copy(s,1,p-1);
		delete(s,1,p-1);
		inc(syntaxNum);
		s:=Trim(s);
		p:=pos(' ',s);
	end;
	syntax[syntaxNum]:=copy(s,1,length(s));
end;

procedure CmdProcess(s:string);
var 
	n1,n2:longint;
	err:word;
begin
	n1:=0;n2:=0;
	ClrSyntax;
	s:=Trim(s);
	CmdSyntax(s);
	case syntax[0] of
		'?','info'	:	Info;
		'help'		:	Help;
		'date'		:	writeln(Date);
		'time'		:	writeln(Time);
		'exit'		:	exit;
		'clear'		:	clrscr;
		'print'		:	Print(s);
		'preans'	:	writeln(ans:0:dec);
		'run'		:	RunFile(syntax[1],1);
		'pause'		:	Msg('Press Enter To Continue . . .');
		'funfact'	:	FunFact(0);
		'dec'		:	begin
							n1:=Str2Int(syntax[1],err);
							if (err = 0) and (n1>0) then begin 
								dec:=n1;
								writeln(DoneMsg);
							end;
						end;
		'delay'		:	begin
							n1:=Str2Int(syntax[1],err);
							if (err = 0) and (n1>0) then delay(n1);
						end;
		'color'		:	begin
							n1:=Str2Int(syntax[1],err);
							if (err = 0) then begin
								n2:=Str2Int(syntax[2],err);
								if (err = 0) then color(n1,n2);
							end;	 
						end
	else Equation(s);
	end;
end;

procedure Equation(s:string);
begin
	s:=ClrSpace(s);
	if (pos('+',s)<>0) or (pos('-',s)<>0) or (pos('*',s)<>0) or (pos('/',s)<>0) 
		{or (pos('%',s)<>0) or (pos(':',s)<>0) or (pos('^',s)<>0)}
		then begin
			ans:=EquProcess(s);
			writeln(ans:0:dec);
		end
	else writeln('<',s,'> : ',ErrorId1);
end;


procedure EquNumProcess(s:string;k:word; var n1,n2:extended);
begin
	n1:=EquProcess(copy(s,1,k-1));
	n2:=EquProcess(copy(s,k+1,(length(s)-k)));
end;

function EquProcess(s:string):extended;
var 
	n1,n2:extended;
	err:word;
begin
	if (pos('+',s)<>0) then begin
		EquNumProcess(s,pos('+',s),n1,n2);
		EquProcess:=n1+n2;
	end
	else if (pos('-',s)<>0) then begin
		EquNumProcess(s,poslast('-',s),n1,n2);
		EquProcess:=n1-n2;
	end
	else if (pos('*',s)<>0) then begin
		EquNumProcess(s,pos('*',s),n1,n2);
		EquProcess:=n1*n2;
	end	
	else if (pos('/',s)<>0) then begin
		EquNumProcess(s,poslast('/',s),n1,n2);
		EquProcess:=n1/n2;
	end	
//	else if (pos(':',s)<>0) then begin
//		EquNumProcess(s,pos(':',s),n1,n2);
//		EquProcess:=n1 div n2;
//	end
//	else if (pos('%',s)<>0) then begin
//		EquNumProcess(s,pos('%',s),n1,n2);
//		EquProcess:=n1 mod n2;
//	end
//	else if (pos('^',s)<>0) then begin
//		EquNumProcess(s,pos('^',s),n1,n2);
//		EquProcess:=n1n2;
//	end
	else EquProcess:=Str2Int(s,err);
end;
// Loop back EquProcess function if there is a complex Equation

function ChkFile(FName:string):word;
var f:text;
begin
	{$I-}
		assign(f,FName);
		Reset(f);
	{$I+}
	ChkFile:=IOResult;
end;

procedure RunFile(FName:string;w:byte);
var 
	f:text;
	str:string;
begin
	if pos('.',FName)=0 then FName:=FName+'.vmath';
	{$I-}
		assign(f,FName);
		Reset(f);
	{$I+}
	if IOResult = 0 then begin
		repeat
			readln(f,str);
			CmdProcess(str);
		until eof(f);
		close(f);
	end
	else if w = 1 then writeln('<',FName,'> : ',ErrorId3);
end;
end.