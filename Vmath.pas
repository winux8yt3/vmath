program Vmath;

uses sysutils,crt,io,lang,programStr,basic;

var 
	tmpString:string;

procedure Paramchk;
begin
	writeln(ProgramName,' ',VersionInfo,' Version ',Version,' Build ',VersionBuild);
	writeln(CopyrightInfo);
	if paramstr(1)='-e' then begin
		for i:=2 to ParamCount do tmpString:=tmpString+paramstr(i);
		write('[VMath] >> ');Equation(tmpString);
	end else
	if paramstr(1)='-r' then begin
		write('[VMath] >> Processing . . .');
		RunFile(paramstr(2));
	end else ui;

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

procedure ui;
begin
	write('Choose Your Language [Default is English]');writeln;
	write('Chon ngon ngu [Mac dinh la Tieng Anh]');writeln;
	write('(En | Vi) >> ');readln(tmpString);
	ActiveLang(tmpString);
	clrscr;
	Welcome;
	{$I-}
		assign(f,'start.vmath');
		Reset(f);
	{$I+}
	if (IOResult=0) then 
		repeat
			readln(f,tmpString);
			CmdProcess(tmpString);
		until eof(f);
	end;
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
	ParamChk;
end.	