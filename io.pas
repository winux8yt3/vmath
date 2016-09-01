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

procedure CmdSyntax(s:string);
procedure CmdProcess(s:string);
procedure Equation(s:string);
function EquProcess(s:string):extended;
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

procedure Print(s:string);
begin
	delete(s,1,5);
	s:=trim(s);
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
var 
	n1,n2:longint;
	err:word;
begin
	n1:=0;n2:=0;
	ClrSyntax;
	s:=Trim(s);
	s:=lowercase(s);
	CmdSyntax(s);
	case syntax[0] of
		'?','info'	:	Info;
		'help'		:	Help;
		'date'		:	Date;
		'time'		:	Time;
		'exit'		:	exit;
		'clear'		:	clrscr;
		'print'		:	Print(s);
		'preans'	:	writeln(ans);
		'run'		:	ReadFile(syntax[1]);
		'pause'		:	Msg('Press Enter To Continue . . .');
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
						end;
	else Equation(s);
	end;
end;

procedure EquNumProcess(s:string;k:word; var n1,n2:extended);
begin
	n1:=EquProcess(copy(s,1,k-1));
	n2:=EquProcess(copy(s,k+1,(length(s)-k-1)));
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
		EquNumProcess(s,pos('-',s),n1,n2);
		EquProcess:=n1-n2;
	end
	else if (pos('*',s)<>0) then begin
		EquNumProcess(s,pos('*',s),n1,n2);
		EquProcess:=n1*n2;
	end	
	else if (pos('/',s)<>0) then begin
		EquNumProcess(s,pos('*',s),n1,n2);
		EquProcess:=n1/n2;
	end	
//	else if (pos(':',s)<>0) then begin
//		EquNumProcess(s,pos(':',s),n1,n2);
//		EquProcess:=n1 div n2;
//	end
	else if (pos('%',s)<>0) then begin
		EquNumProcess(s,pos('%',s),n1,n2);
		EquProcess:=n1+n2;
	end
	else if (pos('^',s)<>0) then begin
		EquNumProcess(s,pos('^',s),n1,n2);
		EquProcess:=n1+n2;
	end
	else EquProcess:=Str2Int(s,err);
end;
// Loop back EquProcess function if there is a complex equation
procedure Equation(s:string);
begin
	ClrSpace(s);
	if (pos('+',s)<>0) or (pos('-',s)<>0) or (pos('*',s)<>0) or (pos('/',s)<>0) 
		or (pos('%',s)<>0) or (pos(':',s)<>0) or (pos('^',s)<>0)
			then begin
				ans:=EquProcess(s);
				write(ans:0:2);
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