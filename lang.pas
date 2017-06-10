{
	Copyright (c) Winux8YT3.
	License Under MIT License. See LICENSE in root folder for license. 
}
unit lang;

{$CODEPAGE UTF8}

interface

//Switch to Const in 1.0
var 
    WelcomeMsg,DoneMsg,TkMsg:String;
    LoadText,DateText,TimeText,InputText,OutputText,ExitText,DPText:String;
    HelpTextClear,HelpTextDate,HelpTextdecn,HelpTextExit:String;
    HelpTextHelp,HelpTextInfo:String;
    HelpTextRun,HelpTextTime,HelpTextEqn2,HelpTextGcd,HelpTextLcm:String;
    HelpTextFact,HelpTextGraph,HelpTextVer:String;
    eqn0Text,eqn1Text,eqn2Text:String;
    GNotEnabledMsg,GEnabledMsg,GDisabledMsg,GLoadMsg,GCloseMsg:string;
    ErrorTx,ErrorId1,ErrorId2,ErrorId3,ErrorId4,ErrorId5,ErrorId6:String;
    MenuCmd,MenuPlot,MenuAdvMath,MenuExit,MenuOption,MenuAns:string;
    MenuOptionLang,MenuOptionLog,MenuAdvMathInfo,MenuCmdInfo,MenuPlotInfo:string;

procedure ActiveLang(c:char);

implementation

uses programStr,f,crt,basic;

procedure LangVi;
begin
    write('Đang Tải Gói Ngôn Ngữ . . .');

    DoneMsg:='Xong!';
    WelcomeMsg:='Chào mừng bạn đến với VMath';

    LoadText:='Đang Tải...';
    ExitText:='Thoát chương trình ?';
    DPText:='Vị trí thập phân';

    HelpTextInfo:='Thông tin phần mềm';
    HelpTextClear:='Xoá màn hình';
    HelpTextDate:='In ra ngày';
    HelpTextdecn:='Độ dài thập phân';
    HelpTextExit:='Thoát';
    HelpTextHelp:='In ra hướng dẫn này';
    HelpTextRun:='Chạy File .vmath';
    HelpTextTime:='In ra thời gian';
    HelpTexteqn2:='Tính phuơng trình bậc 2';
    HelpTextGcd:='Ước chung lớn nhất';
    HelpTextLcm:='Bội chung nhỏ nhất';
    HelpTextFact:='Phân tích thành các thừa số nguyên tố';
    HelpTextGraph:='BẬT/TẮT chế độ đồ họa';
    HelpTextVer:='Phiên bản phần mềm';

    eqn0Text:='Không có nghiệm';
    eqn1Text:='1 nghiệm: ';
    eqn2Text:='2 nghiệm: ';

    GNotEnabledMsg:='Đồ họa chưa được kích hoạt';
    GEnabledMsg:='Đồ họa đã được kích hoạt.';
    GDisabledMsg:='Đồ họa đã bị tắt.';
    GLoadMsg:='Đang nạp chế độ đồ họa . . .';
    GCloseMsg:='Đang tắt chế độ đồ họa . . .';

    ErrorTx:='LỖI';
    ErrorId1:='Sai cấu trúc hoặc câu lệnh. Gõ `help`/`giup` để trợ giúp.';
    ErrorId2:='Phép chia cho 0.';
    ErrorId3:='Tệp không tồn tại.';
    ErrorId4:='Chờ Nhập Số';
    ErrorId5:='Lỗi đồ họa';
    ErrorId6:='Lỗi ngữ pháp';

    MenuCmd:='Chạy lệnh';
    MenuPlot:='Vẽ đồ thị';
    MenuAdvMath:='Toán nâng cao';
    MenuExit:='Thoát';
    MenuOption:='Tùy chọn';
    MenuAns:='Kết quả';

    MenuCmdInfo:='Cho phép bạn tính toán, tùy chỉnh tính năng phần mềm';
    MenuPlotInfo:='Cho phép bạn vẽ đồ thị hàm số, hình học';
    MenuAdvMathInfo:='Cho phép bạn tính công thức, hàm toán học';

    MenuOptionLang:='Ngôn ngữ';
    MenuOptionLog:='Ghi nhật kí';
end;

procedure LangEn;
begin
    write('Loading Language Pack . . .');

    DoneMsg:='Done!';    
    WelcomeMsg:='Welcome you to VMath';

    LoadText:='Loading...';
    ExitText:='Exit program ?';
    DPText:='Decimal Place(s)';

    HelpTextInfo:='About the Program';
    HelpTextClear:='Clear screen';
    HelpTextDate:='Print date';
    HelpTextdecn:='Number of decimal place in math result';
    HelpTextExit:='Exit';
    HelpTextHelp:='This Help';
    HelpTextRun:='Run .vmath File';
    HelpTextTime:='Print time';
    HelpTexteqn2:='Calculate quadratic equation';
    HelpTextGcd:='Greatest common divisor';
    HelpTextLcm:='Least common multiple';
    HelpTextFact:='Factorization to Prime';
    HelpTextGraph:='ACTIVE/EXIT Graph mode';
    HelpTextVer:='Program Version';

    eqn0Text:='No Solution';
    eqn1Text:='1 Solution: ';
    eqn2Text:='2 Solutions: ';

    GNotEnabledMsg:='Graphic Not Yet Activated';
    GEnabledMsg:='Graphic Already Activated.';
    GDisabledMsg:='Graphic Already Closed.';
    GLoadMsg:='Loading Graphic . . .';
    GCloseMsg:='Closing Graphic . . .';

    ErrorTx:='ERROR';
    ErrorId1:='Syntax Error or Input Error. Enter `help`/`giup` for commands list';
    ErrorId2:='Division By Zero.';
    ErrorId3:='Invalid File.';
    ErrorId4:='Expecting Number.';
    ErrorId5:='Graphic Error';
    ErrorId6:='Grammar Error';

    MenuCmd:='Command';
    MenuPlot:='Draw graph';
    MenuAdvMath:='Advanced Math';
    MenuExit:='Exit';
    MenuOption:='Settings';
    MenuAns:='Answer';

    MenuCmdInfo:='Allow you to calculate, configure feature of program';
    MenuPlotInfo:='Allow you to draw linear equations, shapes';
    MenuAdvMathInfo:='Allow you to calculate math formula, function';

    MenuOptionLang:='Languages';
    MenuOptionLog:='Logging';

end;

procedure ActiveLang(c:char);
    procedure Custom;
    var s:string;
    begin
        write('Lang File Name:');readln(s);
        if FileIO(s)=0 then ReadLang(s) else LangEn;
    end;
begin
    if c=#0 then c:=readkey;
    case upcase(c) of
        'V' :   LangVi;
        'E' :   LangEn;
    else LangEn;
    end;
end;
end.