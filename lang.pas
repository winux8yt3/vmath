unit lang;
    
interface

uses sysutils,programStr;

var 
    ProgramInfo,WelcomeMsg,DoneMsg,LangLoadMsg:string;
    LoadText,DateText,TimeText,InputText,OutputText,InfoText:string;
    DayNum:array[0..6] of string;
    HelpTextClear,HelpTextColor,HelpTextDate,HelpTextDelay,HelpTextExit,HelpTextHelp:string;
    HelpTextInfo,HelpTextPause,HelpTextPreans,HelpTextPrint,HelpTextRun,HelpTextTime:string;
    ErrorId0,ErrorId1,ErrorId2,ErrorId3:string;

procedure ActiveLang(s:string);

implementation

procedure LangVi;
begin
    write('Dang Tai Goi Ngon Ngu . . .');writeln;

    ProgramInfo:=ProgramName+' '+VersionInfo+' '+Version+' Ban Dung So '+VersionBuild+'.';
    DoneMsg:='Xong!';
    WelcomeMsg:='Chao mung ban den voi '+ProgramInfo;

    LoadText:='Dang Tai...';
    InfoText:='Lap Trinh Boi Winux8yt3. Website Du An: bit.ly/vmath-xplorer';
    DateText:='Hom nay la: ';
    TimeText:='Bay gio la: ';
    InputText:='Nhap';
    OutputText:='Xuat';
    
    DayNum[0]:='Chu Nhat';
    DayNum[1]:='Thu Hai';
    DayNum[2]:='Thu Ba';
    DayNum[3]:='Thu Tu';
    DayNum[4]:='Thu Nam';
    DayNum[5]:='Thu Sau';
    DayNum[6]:='Thu Bay';

    HelpTextInfo:='Thong tin ve phan mem';
    HelpTextClear:='Xoa man hinh';
    HelpTextColor:='Thay doi mau chu va phong nen';
    HelpTextDate:='In ra ngay';
    HelpTextDelay:='Cho (mili giay)';
    HelpTextExit:='Thoat';
    HelpTextHelp:='Huong dan su dung';
    HelpTextPause:='Tam dung chuong trinh';
    HelpTextPreans:='In ra ket qua luc truoc';
    HelpTextPrint:='In dong chu';
    HelpTextRun:='Chay File .vmath';
    HelpTextTime:='In ra thoi gian';

    ErrorId1:='Sai cau truc hoac sai cau lenh.';
    ErrorId2:='Phep chia cho 0.';
    ErrorId3:='Tep khong ton tai.';
end;

procedure LangEn;
begin
    write('Loading Language Pack . . .');writeln;

    ProgramInfo:=ProgramName+' '+VersionInfo+' '+Version+' Build '+VersionBuild+'.';
    DoneMsg:='Done';    
    WelcomeMsg:='Welcome you to '+ProgramInfo;

    LoadText:='Loading...';
    InfoText:='Programmed by Winux8yt3. Project Website: bit.ly/vmath-xplorer';
    DateText:='Today is: ';
    TimeText:='Now is: ';
    InputText:='Input';
    OutputText:='Output';

    DayNum[0]:='Sunday';
    DayNum[1]:='Monday';
    DayNum[2]:='Tuesday';
    DayNum[3]:='Wednesday';
    DayNum[4]:='Thursday';
    DayNum[5]:='Friday';
    DayNum[6]:='Saturday';

    HelpTextInfo:='About the Program';
    HelpTextClear:='Clear screen';
    HelpTextColor:='Change text and background color';
    HelpTextDate:='Print date';
    HelpTextDelay:='Wait (milisecond)';
    HelpTextExit:='Exit';
    HelpTextHelp:='Instruction';
    HelpTextPause:='Pause the program';
    HelpTextPreans:='Print last math answer';
    HelpTextPrint:='Print text';
    HelpTextRun:='Run .vmath File';
    HelpTextTime:='Print time';

    ErrorId1:='Syntax Error or Input Error.';
    ErrorId2:='Division By Zero.';
    ErrorId3:='Invalid File.';
end;

procedure ActiveLang(s:string);
begin
    case lowercase(s) of
        'vi'    :   LangVi;
        'en'    :   LangEn
    else LangEn;
    end;
end;

finalization
begin
    write(DoneMsg);writeln;
end;

end.