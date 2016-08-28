unit io;
    
interface

uses
	sysutils,crt,dos,lang,basic;

type 
	tSyntax = array[0..256]of string;

var
	syntax: tSyntax;
	syntaxNum:byte;
	cmd:string;
	ans:variant;

procedure CmdSyntax(s:string);
procedure CmdProcess(s:string);
procedure Equation(s:string);
procedure ReadFile(FName:string);

implementation

procedure ClrSpace (s:string);
var p:byte;
begin
	p:=pos(' ',s);
	while p <> 0 do begin
		delete(s,p,1);
		p:=pos(' ',s);
	end;
end;

procedure CmdSyntax(s:string);
var 
	p:byte;  //Position of word
begin
	syntaxNum:=0;
	p:=pos(' ',s);
	if p = 0 then syntax[syntaxNum]:=s
	else begin
		repeat
			syntax[syntaxNum]:=copy(s,1,p-1);
			delete(s,1,p-1);
			inc(syntaxNum);
			s:=Trim(s);
			p:=pos(' ',s);
		until p = 0;
		syntax[syntaxNum+1]:=copy(s,1,length(s));
	end;
end;

procedure CmdProcess(s:string);
begin
	s:=Trim(s);
	s:=lowercase(s);
	CmdSyntax(s);
	cmd:=s;
	case syntax[0] of
		'?','info'	:	Info;
		'help'		:	Help;
		'date'		:	Date;
		'delay'		:	Delay(syntax[1];
		'time'		:	Time;
		'exit'		:	exit;
		'clear'		:	clrscr;
		'preans'	:	writeln(ans);
		'run'		:	ReadFile(syntax[1]);
		'pause'		:	Msg('Press Enter To Continue . . .');
		'print'		:	for i:=1 to syntaxNum do write(syntax[i],' ');
		'color'		:	color(Str2Int(syntax[1]),Str2Int(syntax[2]));
	else Equation(s:string);
	end;
end;

procedure EquNumProcess(s:string;k:word; var n1,n2:variant);
begin
	n1:=EquProcess(copy(s,1,k-1));
	n2:=EquProcess(copy(s,k+1,(length(s)-k-1));
end;

function EquProcess(s:string):variant;
var n1,n2:variant;
begin
	if (pos('+',s)<>0) then begin
		EquNumProcess(s,pos('+',s),n1,n2);
		EquProcess:=n1+n2;
	end
	else if (pos('-',s)<>0) then begin
		EquNumProcess(s,pos('-',s),n1,n2);
		EquProcess:=n1-n2;
	end
	else if (pos('*',s)<>0) then begin
		EquNumProcess(s,pos('*',s),n1,n2);
		EquProcess:=n1*n2;
	end	
	else if (pos('/',s)<>0) then begin
		EquNumProcess(s,pos('/',s),n1,n2);
		EquProcess:=n1/n2; 
	end
	else if (pos(':',s)<>0) then begin
		EquNumProcess(s,pos(':',s),n1,n2);
		EquProcess:=n1 div n2;
	end
	else if (pos('%',s)<>0) then begin
		EquNumProcess(s,pos('%',s),n1,n2);
		EquProcess:=n1+n2;
	end
	else if (pos('^',s)<>0) then begin
		EquNumProcess(s,pos('^',s),n1,n2);
		EquProcess:=n1+n2;
	end
	else EquProcess:=Str2Int(s);
end;
// Loop back EquProcess function if there is a complex equation
procedure Equation(s:string);
var
	n1,n2,err: longint;
begin
	ClrSpace(s);
	if (pos('+',s)<>0) or (pos('-',s)<>0) or (pos('*',s)<>0) or (pos('/',s)<>0) 
		or (pos('%',s)<>0) or (pos(':',s)<>0) or (pos('^',s)<>0)
			then begin
				ans:=EquProcess(s);
				write(ans);
			end
	else write(ErrorId1);
end;


procedure ReadFile(FName:string);
var 
	f:text;
	extension,str:string;
	k:integer;
begin
	FName:=Trim(FName);
	{$I-}
	assign(f,FName);
	Reset(f);
	{$I+}
	if IOResult<>0 then write(ErrorId3)
	else begin
		k:=length(Fname)-pos('.',Fname);
		extension:=copy(Fname,pos('.',Fname)+1,k);
		repeat
			readln(f,str);
			if extension='vmath' then CmdProcess(str)
				else writeln(str);
		until eof(f);
		close(f);
	end;
end;

end.