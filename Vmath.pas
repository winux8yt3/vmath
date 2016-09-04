program Vmath;

uses sysutils,crt,io,lang,programStr,basic,equ;

var 
	tmpString:string;
	i,c:longint;

procedure Welcome;
begin
	writeln('===========================================');
	writeln('               VMath Xplorer               ');
	writeln('===========================================');
	writeln(WelcomeMsg);
end;

procedure console;
begin
	clrscr;
	write('Choose Your Language [Default is English]');writeln;
	write('Chon ngon ngu [Mac dinh la Tieng Anh]');writeln;
	write('(En | Vi) >> ');readln(tmpString);
	clrscr;
	Welcome;
	ActiveLang(tmpString);
	write(FunFact(0));
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
		c:=2;
		if (paramstr(2)='-d') and (chkS2N(paramstr(2))=0) then
		begin
			dec:=Str2Num(paramstr(3));
			c:=4;
		end;
		for i:=c to ParamCount do tmpString:=tmpString+paramstr(i);
		write('[VMath] >> ');Equation(tmpString);
	end else
	if (paramstr(1)='-r') and (paramstr(2)<>'') then begin
		writeln('[VMath] >> Processing . . .');
		RunFile(paramstr(2),1);
	end 
	else console;
end.