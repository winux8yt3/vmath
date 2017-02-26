program Vmath;

uses sysutils,crt,io,lang,programStr,basic,equ,f,exec;
// vmathui;
var 
	tmpstr:String = '';
	i,c:longint;

procedure console(lang:String);
begin
	Window(1,1,120,255);
	clrscr;
	writeln('Choose Your Language [Default is English]');
	writeln('Chon ngon ngu [Mac dinh la Tieng Anh]');
	write('(En | Vi) >> ');ActiveLang(#0);
	clrscr;
	if FileIO('vmath.cfg')=0 then ReadCfg;
	write(LoadText);
	clrscr;
	write(Info,#13#10,WelcomeMsg);
	RunFile('start.vmath');
	repeat
		write(#13#10#13#10,'[Vmath] >> ');readln(tmpstr);
		if Trim(tmpStr)<>'' then write(CmdProcess(tmpstr));
	until tmpstr='exit';
end;

begin
	writeln(Info);
	if (paramstr(1)='-e') and (paramstr(2)<>'') then begin
		c:=2;
		if (paramstr(2)='-d') and (Str2Num(paramstr(3)).chk=True) then
		begin
			decn:=Str2Int(paramstr(3)).val;
			c:=4;
		end;
		for i:=c to ParamCount do tmpstr:=tmpstr+paramstr(i);
		write('[VMath] >> ');Equation(tmpstr);
	end else
	if (Paramstr(1)<>'') and (FileIO(paramstr(1))=0) then begin
		writeln('[VMath] >> Processing . . .');
		RunFile(paramstr(1));
	end 
	else console('');
end.