program Vmath;

uses sysutils,crt,io,lang,programStr,basic,equ,f;
// vmathui;
var 
	tmpString:string;
	i,c:longint;

procedure console(lang:string);
begin
	Window(1,1,80,255);
	clrscr;
	if lang='' then begin
		write('Choose Your Language [Default is English]');writeln;
		write('Chon ngon ngu [Mac dinh la Tieng Anh]');writeln;
		write('(En | Vi) >> ');readln(tmpString);		
		ActiveLang(tmpString);
	end
	else ActiveLang(lang);
	clrscr;
	writeln('===========================================');
	writeln('               VMath Xplorer               ');
	writeln('===========================================');
	
	writeln(WelcomeMsg);
	writeln(FunFact(0));
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
	writeln(ProgramInfo);
	writeln(CopyrightInfo);
	if (paramstr(1)='-e') and (paramstr(2)<>'') then begin
		c:=2;
		if (paramstr(2)='-d') and (Str2Num(paramstr(2)).check=True) then
		begin
			dec:=Str2Int(paramstr(3)).value;
			c:=4;
		end;
		for i:=c to ParamCount do tmpString:=tmpString+paramstr(i);
		write('[VMath] >> ');Equation(tmpString);
	end else
	if (Paramstr(1)<>'') and (chkFile(paramstr(1))=0) then begin
		writeln('[VMath] >> Processing . . .');
		RunFile(paramstr(1),0);
	end 
	else if (lowercase(Paramstr(1))='-l') then
		Console(Paramstr(2))
	else console('');
end.