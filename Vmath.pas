program Vmath;

uses sysutils,crt,io,lang,programStr,basic;

var 
	tmpString:string;
	i:longint;

procedure Welcome;
var 
	f:text;
begin
	{$I-}
	assign(f,'Welcome.dat');
	Reset(f);
	{$I+}
	if IOResult<>0 then begin
		assign(f,'Welcome.dat');
		rewrite(f);
		writeln(f,'===========================================');
		writeln(f,'               VMath Xplorer               ');
		writeln(f,'===========================================');
		close(f);
	end;
	ReadFile('Welcome.dat');
	writeln(WelcomeMsg);
end;

procedure ui;
begin
	write('Choose Your Language [Default is English]');writeln;
	write('Chon ngon ngu [Mac dinh la Tieng Anh]');writeln;
	write('(En | Vi) >> ');readln(tmpString);
	ActiveLang(tmpString);
	clrscr;
	Welcome;
	RunFile('start.vmath',0);
	repeat
		writeln;
		write(InputText,' >> ');readln(tmpString);
		writeln;
		write(OutputText,' >> ');
		CmdProcess(tmpString);
	until tmpString='exit';
end;

begin
	ActiveLang('en');
	writeln(ProgramName,' ',VersionInfo,' Version ',Version,' Build ',VersionBuild);
	writeln(CopyrightInfo);
	if (paramstr(1)='-e') and (paramstr(2)<>'') then begin
		for i:=2 to ParamCount do tmpString:=tmpString+paramstr(i);
		write('[VMath] >> ');Equation(tmpString);
	end else
	if (paramstr(1)='-r') and (paramstr(2)<>'') then begin
		write('[VMath] >> Processing . . .');
		RunFile(paramstr(2),1);
	end 
	else ui;
end.	