program Vmath;

uses sysutils,crt,io,lang,programStr,basic,equ,f;
// vmathui;
var 
	tmpString:String = '';
	i,c:longint;

procedure console(lang:String);
begin
	Window(1,1,120,255);
	clrscr;
	if lang='' then begin
		writeln('Choose Your Language [Default is English]');
		writeln('Chon ngon ngu [Mac dinh la Tieng Anh]');
		write('(En | Vi) >> ');readln(tmpString);
		ActiveLang(tmpString);
	end
	else ActiveLang(lang);
	clrscr;
	if ChkFile('vmath.cfg')=0 then ReadCfg;
	write(LoadText);
	clrscr;
	write(ProgramInfo,#13#10,WelcomeMsg);
	RunFile('start.vmath');
	repeat
		write(#13#10#13#10,InputText,' >> ');readln(tmpString);
		write(#13#10,OutputText,' >> ');
		CmdSyntax(tmpString);
		CmdProcess(tmpString);
	until tmpString='exit';
end;

begin
	Info;
	if (paramstr(1)='-e') and (paramstr(2)<>'') then begin
		c:=2;
		if (paramstr(2)='-d') and (Str2Num(paramstr(3)).check=True) then
		begin
			dec:=Str2Int(paramstr(3)).value;
			c:=4;
		end;
		for i:=c to ParamCount do tmpString:=tmpString+paramstr(i);
		write('[VMath] >> ');Equation(tmpString);
	end else
	if (Paramstr(1)<>'') and (chkFile(paramstr(1))=0) then begin
		writeln('[VMath] >> Processing . . .');
		RunFile(paramstr(1));
	end 
	else if (lowercase(Paramstr(1))='-en') then Console('en')
	else if (lowercase(Paramstr(1))='-vi') then Console('vi')
	else console('');
end.