unit NP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, XpMan, XPCheckBox, StdCtrls, ExtCtrls, LbSpeedButton, XPLabel,
  Math, ComCtrls, Menus, Registry, Buttons, ShellApi, XPEdit, IniFiles;

  function OpenSaveFileDialog(ParentHandle: THandle; const DefExt, Filter, InitialDir,
  Title: string; var FileName: string; IsOpenDialog: Boolean): Boolean;

type
  TMainFrm = class(TForm)
    PageControl: TPageControl;
    UninstallTab: TTabSheet;
    UninstallList: TListBox;
    ProtectTab: TTabSheet;
    ch1: TXPCheckBox;
    ch2: TXPCheckBox;
    ch4: TXPCheckBox;
    ch5: TXPCheckBox;
    ch6: TXPCheckBox;
    ch7: TXPCheckBox;
    ch8: TXPCheckBox;
    ch3: TXPCheckBox;
    LicenseTab: TTabSheet;
    AboutTab: TTabSheet;
    SearchEditor: TXPEdit;
    ChangeEditor: TXPEdit;
    fr1: TPanel;
    logo: TImage;
    tx1: TXPLabel;
    tx2: TXPLabel;
    tx3: TXPLabel;
    tx8: TXPLabel;
    License: TMemo;
    tx6: TXPLabel;
    tx7: TXPLabel;
    tx4: TXPLabel;
    tx5: TXPLabel;
    tx9: TXPLabel;
    tx11: TXPLabel;
    tx10: TXPLabel;
    tx13: TXPLabel;
    tx12: TXPLabel;
    spr3: TBevel;
    spr1: TBevel;
    spr2: TBevel;
    FilesTab: TTabSheet;
    fr2: TPanel;
    ListView: TListView;
    StatusBar: TStatusBar;
    fr4: TPanel;
    UpdateUninstallListBt: TLbSpeedButton;
    DeleteFromRegBt: TLbSpeedButton;
    DeleteFromSystemBt: TLbSpeedButton;
    ChangeBt: TLbSpeedButton;
    RunBt: TLbSpeedButton;
    StopBt: TLbSpeedButton;
    FilterBt: TLbSpeedButton;
    ExceptAllBt: TLbSpeedButton;
    DeletAllBt: TLbSpeedButton;
    DeleteSelectedBt: TLbSpeedButton;
    DeleteAllBt: TLbSpeedButton;
    UpdateFromRegBt: TLbSpeedButton;
    AppleBt: TLbSpeedButton;
    SaveReportBt: TLbSpeedButton;
    procedure AppleBtClick(Sender: TObject);
    procedure UpdateFromRegBtClick(Sender: TObject);
    procedure UninstallTabShow(Sender: TObject);
    procedure SearchEditorChange(Sender: TObject);
    procedure UninstallListClick(Sender: TObject);
    procedure UpdateUninstallListBtClick(Sender: TObject);
    procedure DeleteFromRegBtClick(Sender: TObject);
    procedure DeleteFromSystemBtClick(Sender: TObject);
    procedure ChangeBtClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tx8MouseLeave(Sender: TObject);
    procedure tx8MouseUp(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
    procedure tx8MouseMove(Sender: TObject; Shift: TShiftState; X,
    Y: Integer);
    procedure tx8Click(Sender: TObject);
    procedure UninstallListKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
    procedure AboutTabShow(Sender: TObject);
    procedure ProtectTabShow(Sender: TObject);
    procedure tx9MouseLeave(Sender: TObject);
    procedure tx9MouseUp(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
    procedure tx9MouseMove(Sender: TObject; Shift: TShiftState; X,
    Y: Integer);
    procedure tx10MouseMove(Sender: TObject; Shift: TShiftState; X,
    Y: Integer);
    procedure tx10MouseLeave(Sender: TObject);
    procedure tx10MouseUp(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
    procedure tx9Click(Sender: TObject);
    procedure tx10Click(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure StopBtClick(Sender: TObject);
    procedure Find(Dir:string);
    procedure FindFiles;
    procedure DeleteFileSelected;
    function InExt(FileName:string):boolean;
    procedure GetDrives;
    procedure ShowText(f,s:real);
    procedure DeleteAll;
    procedure CheckAll(Checked:boolean);
    function FileMaskEquate(F, M: string): boolean;
    procedure EnabledButtons(Enabled:boolean);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FilterBtClick(Sender: TObject);
    procedure ExceptAllBtClick(Sender: TObject);
    procedure DeletAllBtClick(Sender: TObject);
    procedure DeleteSelectedBtClick(Sender: TObject);
    procedure DeleteAllBtClick(Sender: TObject);
    procedure RunBtClick(Sender: TObject);
    procedure SaveReportBtClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private

    INI: TINIFILE;

  public

  end;


var
  MainFrm: TMainFrm;

  R: TRegistry;

  files,size:extended;

  Exts,Drives:array of string;

  Stop:boolean;

implementation

uses FP;

{$R *.dfm}

type
   POpenFilenameA = ^TOpenFilenameA;
   POpenFilename = POpenFilenameA;
   tagOFNA = packed record
   lStructSize: DWORD;
   hWndOwner: HWND;
   hInstance: HINST;
   lpstrFilter: PAnsiChar;
   lpstrCustomFilter: PAnsiChar;
   nMaxCustFilter: DWORD;
   nFilterIndex: DWORD;
   lpstrFile: PAnsiChar;
   nMaxFile: DWORD;
   lpstrFileTitle: PAnsiChar;
   nMaxFileTitle: DWORD;
   lpstrInitialDir: PAnsiChar;
   lpstrTitle: PAnsiChar;
   Flags: DWORD;
   nFileOffset: Word;
   nFileExtension: Word;
   lpstrDefExt: PAnsiChar;
   lCustData: LPARAM;
   lpfnHook: function(Wnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): UINT stdcall;
   lpTemplateName: PAnsiChar;
   end;
   TOpenFilenameA = tagOFNA;
   TOpenFilename = TOpenFilenameA;

   function GetOpenFileName(var OpenFile: TOpenFilename): Bool; stdcall; external 'comdlg32.dll'
   name 'GetOpenFileNameA';
   function GetSaveFileName(var OpenFile: TOpenFilename): Bool; stdcall; external 'comdlg32.dll'
   name 'GetSaveFileNameA';

  const
   OFN_DONTADDTORECENT = $02000000;
   OFN_FILEMUSTEXIST = $00001000;
   OFN_HIDEREADONLY = $00000004;
   OFN_PATHMUSTEXIST = $00000800;

 function CharReplace(const Source: string; oldChar, newChar: Char): string;
 var
 i: Integer;
 begin
 Result := Source;
 for i := 1 to Length(Result) do
 if Result[i] = oldChar then
 Result[i] := newChar;
 end;

function OpenSaveFileDialog(ParentHandle: THandle; const DefExt, Filter, InitialDir, Title: string; var FileName: string; IsOpenDialog: Boolean): Boolean;
var
ofn: TOpenFileName;
szFile: array[0..MAX_PATH] of Char;
begin
Result := False;
FillChar(ofn, SizeOf(TOpenFileName), 0);
with ofn do
begin
lStructSize := SizeOf(TOpenFileName);
hwndOwner := ParentHandle;
lpstrFile := szFile;
nMaxFile := SizeOf(szFile);
if (Title <> '') then
lpstrTitle := PChar(Title);
if (InitialDir <> '') then
lpstrInitialDir := PChar(InitialDir);
StrPCopy(lpstrFile, FileName);
lpstrFilter := PChar(CharReplace(Filter, '|', #0)+#0#0);
if DefExt <> '' then
lpstrDefExt := PChar(DefExt);
end;
if IsOpenDialog then
begin
if GetOpenFileName(ofn) then
begin
Result := True;
FileName := StrPas(szFile);
end;
end else
begin
if GetSaveFileName(ofn) then
begin
Result := True;
FileName := StrPas(szFile);
end;
end
end;

procedure TMainFrm.AppleBtClick(Sender: TObject);
begin
try
R := TRegistry.Create;
with R do
begin
RootKey := HKEY_CURRENT_USER;
OpenKey('\Software\Microsoft\Windows\CurrentVersion\Policies\Uninstall', True);
if ch1.Checked then
WriteInteger('NoAddRemovePrograms', 1) else
WriteInteger('NoAddRemovePrograms', 0);
CloseKey;
Free;
end;
R := TRegistry.Create;
with R do
begin
RootKey := HKEY_CURRENT_USER;
OpenKey('\Software\Microsoft\Windows\CurrentVersion\Policies\Uninstall', True);
if ch2.Checked then
WriteInteger('NoRemovePage', 1) else
WriteInteger('NoRemovePage', 0);
CloseKey;
Free;
end;
R := TRegistry.Create;
with R do
begin
RootKey := HKEY_CURRENT_USER;
OpenKey('\Software\Microsoft\Windows\CurrentVersion\Policies\Uninstall', True);
if ch3.Checked then
WriteInteger('NoAddPage', 1) else
WriteInteger('NoAddPage', 0);
CloseKey;
Free;
end;
R := TRegistry.Create;
with R do
begin
RootKey := HKEY_CURRENT_USER;
OpenKey('\Software\Microsoft\Windows\CurrentVersion\Policies\Uninstall', True);
if ch4.Checked then
WriteInteger('NoWindowsSetupPage', 1) else
WriteInteger('NoWindowsSetupPage', 0);
CloseKey;
Free;
end;
R := TRegistry.Create;
with R do
begin
RootKey := HKEY_CURRENT_USER;
OpenKey('\Software\Microsoft\Windows\CurrentVersion\Policies\Uninstall', True);
if ch5.Checked then
WriteInteger('NoAddFromCDorFloppy', 1) else
WriteInteger('NoAddFromCDorFloppy', 0);
CloseKey;
Free;
end;
R := TRegistry.Create;
with R do
begin
RootKey := HKEY_CURRENT_USER;
OpenKey('\Software\Microsoft\Windows\CurrentVersion\Policies\Uninstall', True);
if ch6.Checked then
WriteInteger('NoAddFromInternet', 1) else
WriteInteger('NoAddFromInternet', 0);
CloseKey;
Free;
end;
R := TRegistry.Create;
with R do
begin
RootKey := HKEY_CURRENT_USER;
OpenKey('\Software\Microsoft\Windows\CurrentVersion\Policies\Uninstall', True);
if ch7.Checked then
WriteInteger('NoAddFromNetwork', 1) else
WriteInteger('NoAddFromNetwork', 0);
CloseKey;
Free;
end;
R := TRegistry.Create;
with R do
begin
RootKey := HKEY_CURRENT_USER;
OpenKey('\Software\Microsoft\Windows\CurrentVersion\Policies\Uninstall', True);
if ch8.Checked then
WriteInteger('NoSupportInfo', 1) else
WriteInteger('NoSupportInfo', 0);
CloseKey;
Free;
end;
except
end;
end;

procedure TMainFrm.UpdateFromRegBtClick(Sender: TObject);
var
i: Integer;
begin
try
r:=TRegistry.Create;
r.RootKey:=HKEY_CURRENT_USER;
r.OpenKeyReadOnly('\Software\Microsoft\Windows\CurrentVersion\Policies\Uninstall');
if r.ValueExists('NoAddRemovePrograms')
then i:=r.ReadInteger('NoAddRemovePrograms');
if i=0 then
ch1.Checked:=False else
ch1.Checked:=True;
r.CloseKey;
r.Free;
r:=TRegistry.Create;
r.RootKey:=HKEY_CURRENT_USER;
r.OpenKeyReadOnly('\Software\Microsoft\Windows\CurrentVersion\Policies\Uninstall');
if r.ValueExists('NoRemovePage')
then i:=r.ReadInteger('NoRemovePage');
if i=0 then
ch2.Checked:=False else
ch2.Checked:=True;
r.CloseKey;
r.Free;
r:=TRegistry.Create;
r.RootKey:=HKEY_CURRENT_USER;
r.OpenKeyReadOnly('\Software\Microsoft\Windows\CurrentVersion\Policies\Uninstall');
if r.ValueExists('NoAddPage')
then i:=r.ReadInteger('NoAddPage');
if i=0 then
ch3.Checked:=False else
ch3.Checked:=True;
r.CloseKey;
r.Free;
r:=TRegistry.Create;
r.RootKey:=HKEY_CURRENT_USER;
r.OpenKeyReadOnly('\Software\Microsoft\Windows\CurrentVersion\Policies\Uninstall');
if r.ValueExists('NoWindowsSetupPage')
then i:=r.ReadInteger('NoWindowsSetupPage');
if i=0 then
ch4.Checked:=False else
ch4.Checked:=True;
r.CloseKey;
r.Free;
r:=TRegistry.Create;
r.RootKey:=HKEY_CURRENT_USER;
r.OpenKeyReadOnly('\Software\Microsoft\Windows\CurrentVersion\Policies\Uninstall');
if r.ValueExists('NoAddFromCDorFloppy')
then i:=r.ReadInteger('NoAddFromCDorFloppy');
if i=0 then
ch5.Checked:=False else
ch5.Checked:=True;
r.CloseKey;
r.Free;
r:=TRegistry.Create;
r.RootKey:=HKEY_CURRENT_USER;
r.OpenKeyReadOnly('\Software\Microsoft\Windows\CurrentVersion\Policies\Uninstall');
if r.ValueExists('NoAddFromInternet')
then i:=r.ReadInteger('NoAddFromInternet');
if i=0 then
ch6.Checked:=False else
ch6.Checked:=True;
r.CloseKey;
r.Free;
r:=TRegistry.Create;
r.RootKey:=HKEY_CURRENT_USER;
r.OpenKeyReadOnly('\Software\Microsoft\Windows\CurrentVersion\Policies\Uninstall');
if r.ValueExists('NoAddFromNetwork')
then i:=r.ReadInteger('NoAddFromNetwork');
if i=0 then
ch7.Checked:=False else
ch7.Checked:=True;
r.CloseKey;
r.Free;
r:=TRegistry.Create;
r.RootKey:=HKEY_CURRENT_USER;
r.OpenKeyReadOnly('\Software\Microsoft\Windows\CurrentVersion\Policies\Uninstall');
if r.ValueExists('NoSupportInfo')
then i:=r.ReadInteger('NoSupportInfo');
if i=0 then
ch8.Checked:=False else
ch8.Checked:=True;
r.CloseKey;
r.Free;
except
end;
end;

procedure TMainFrm.UninstallTabShow(Sender: TObject);
begin
UpdateUninstallListBt.OnClick(Self);
end;

procedure TMainFrm.SearchEditorChange(Sender: TObject);
begin
UninstallList.Perform(LB_SELECTSTRING, -1, longint(Pchar(SearchEditor.text)));
end;

procedure TMainFrm.UninstallListClick(Sender: TObject);
begin
R:=TRegistry.Create;
R.RootKey:=HKEY_LOCAL_MACHINE;
r.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Uninstall'+'\' + UninstallList.Items[UninstallList.itemindex], true);
ChangeEditor.Text := r.ReadString('UninstallString');
end;

procedure TMainFrm.UpdateUninstallListBtClick(Sender: TObject);
begin
R:=TRegistry.Create;
R.RootKey:=HKEY_LOCAL_MACHINE;
R.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Uninstall', False);
R.GetKeyNames(UninstallList.Items);
r.CloseKey;
r.Free;
SearchEditor.Text := '';
ChangeEditor.Text := '';
SearchEditor.SetFocus;
end;

procedure TMainFrm.DeleteFromRegBtClick(Sender: TObject);
var
i: Integer;
begin
try
i := UninstallList.ItemIndex;
if UninstallList.Selected[i] = False then
Exit else
if Application.MessageBox('Вы уверены, что хотите удалить информацию о программе из реестра?',
'Registry Cleaner',
mb_IconAsterisk + mb_YesNo) = idYes then
begin
r.DeleteKey('\Software\Microsoft\Windows\CurrentVersion\Uninstall'+'\'+
UninstallList.Items[UninstallList.itemindex]);
R.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Uninstall', False);
R.GetKeyNames(UninstallList.Items);
end;
except
end;
end;

procedure TMainFrm.DeleteFromSystemBtClick(Sender: TObject);
var
w1: Word;
p1, p2: array[0..255] of Char;
begin
StrPcopy(p1, ChangeEditor.Text);
if GetModuleHandle(p1) = 0 then
begin
StrPcopy(p2, ChangeEditor.Text);
w1 := WinExec(p2, SW_Restore);
end;
end;

procedure TMainFrm.ChangeBtClick(Sender: TObject);
begin
try
R := TRegistry.Create;
R.RootKey := HKEY_LOCAL_MACHINE;
R.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Uninstall'+'\'+UninstallList.Items[UninstallList.itemindex], true);
R.WriteString('UninstallString', ChangeEditor.Text);
r.CloseKey;
r.Free;
except
end;
end;

procedure TMainFrm.FormCreate(Sender: TObject);
begin
r:=TRegistry.Create;
r.RootKey:=HKEY_LOCAL_MACHINE;
r.OpenKey('\Software\Microsoft\Windows NT\CurrentVersion', True);
tx2.Caption := ('Имя: ' + r.ReadString('ProductName'));
r.CloseKey;
r.Free;
R := TRegistry.Create;
R.RootKey := HKEY_LOCAL_MACHINE;
R.OpenKey('\HARDWARE\DESCRIPTION\System\CentralProcessor\0',false);
tx3.Caption := R.ReadString('ProcessorNameString');
r.CloseKey;
r.Free;
Ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
try
Top := Ini.ReadInteger('Position', 'Top', 100);
Left := Ini.ReadInteger('Position', 'Left', 100);
except
end;
end;

procedure TMainFrm.tx8MouseLeave(Sender: TObject);
begin
tx8.ForegroundColor := $00FF8000;
end;

procedure TMainFrm.tx8MouseUp(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
begin
tx8.ForegroundColor := $00FF8000;
end;

procedure TMainFrm.tx8MouseMove(Sender: TObject; Shift: TShiftState;
X, Y: Integer);
begin
tx8.ForegroundColor := clRed;
end;

procedure TMainFrm.tx8Click(Sender: TObject);
begin
ShellExecute(Handle, nil, 'http://www.viacoding.mylivepage.ru/', nil,nil, Sw_ShowNormal);
end;

procedure TMainFrm.UninstallListKeyDown(Sender: TObject; var Key: Word;
Shift: TShiftState);
begin
try
if Key = VK_DELETE then
DeleteFromSystemBt.OnClick(Self);
if Key = VK_ESCAPE then
Close;
except
end;
end;

procedure TMainFrm.AboutTabShow(Sender: TObject);
var
MS: TMemoryStatus;
begin
GlobalMemoryStatus(MS);
tx12.Caption := 'Физическая память: ' + FormatFloat('#,###" KB"', MS.dwTotalPhys / 1024);
tx13.Caption := 'Использовано: ' + Format('%d %%', [MS.dwMemoryLoad]);
end;

procedure TMainFrm.ProtectTabShow(Sender: TObject);
begin
UpdateFromRegBt.Click;
end;

procedure TMainFrm.tx9MouseLeave(Sender: TObject);
begin
tx9.ForegroundColor := $00FF8000;
end;

procedure TMainFrm.tx9MouseUp(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
begin
tx9.ForegroundColor := $00FF8000;
end;

procedure TMainFrm.tx9MouseMove(Sender: TObject; Shift: TShiftState; X,
Y: Integer);
begin
tx9.ForegroundColor := clRed;
end;

procedure TMainFrm.tx10MouseMove(Sender: TObject; Shift: TShiftState; X,
Y: Integer);
begin
tx10.ForegroundColor := clRed;
end;

procedure TMainFrm.tx10MouseLeave(Sender: TObject);
begin
tx10.ForegroundColor := $00FF8000;
end;

procedure TMainFrm.tx10MouseUp(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
begin
tx10.ForegroundColor := $00FF8000;
end;

procedure TMainFrm.tx9Click(Sender: TObject);
begin
ShellExecute(Handle,'open',
'mailto:GoodWinNix@mail.ru?Subject=Registry Cleaner Project'+
'',
'','',SW_SHOW);
end;

procedure TMainFrm.tx10Click(Sender: TObject);
begin
ShellExecute(Handle,'open',
'mailto:viacoding@mail.ru?Subject=Registry Cleaner Project'+
'',
'','',SW_SHOW);
end;

procedure TMainFrm.FormMouseDown(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
begin
ReleaseCapture;
Perform(Wm_SysCommand, $f012, 0);
end;

procedure TMainFrm.FormKeyDown(Sender: TObject; var Key: Word;
Shift: TShiftState);
begin
if Key = VK_ESCAPE then
Close;
end;

procedure TMainFrm.FormDestroy(Sender: TObject);
begin
MainFrm.OnActivate := nil;
UpdateUninstallListBt.Free;
DeleteFromSystemBt.Free;
DeleteSelectedBt.Free;
DeleteFromRegBt.Free;
UpdateFromRegBt.Free;
UninstallList.Free;
SaveReportBt.Free;
SearchEditor.Free;
ChangeEditor.Free;
ExceptAllBt.Free;
DeleteAllBt.Free;
PageControl.Free;
DeletAllBt.Free;
ListView.Free;
StatusBar.Free;
FilterBt.Free;
ChangeBt.Free;
AppleBt.Free;
License.Free;
RunBt.Free;
StopBt.Free;
logo.Free;
ch1.Free;
ch2.Free;
ch3.Free;
ch4.Free;
ch5.Free;
ch6.Free;
ch7.Free;
ch8.Free;
fr1.Free;
fr2.Free;
tx1.Free;
tx2.Free;
tx3.Free;
tx4.Free;
tx5.Free;
tx6.Free;
tx7.Free;
tx8.Free;
tx9.Free;
tx10.Free;
tx11.Free;
tx12.Free;
tx13.Free;
spr1.Free;
spr2.Free;
spr3.Free;
end;

procedure TMainFrm.StopBtClick(Sender: TObject);
begin
EnabledButtons(true);
Stop:=true;
end;

procedure TMainFrm.CheckAll(Checked: boolean);
var
i:integer;
begin
for i:=0 to MainFrm.ListView.Items.Count-1 do
begin
MainFrm.ListView.Items[i].Checked:=Checked;
end;
end;

procedure TMainFrm.DeleteAll;
begin
while MainFrm.ListView.Items.Count>0 do begin
if MainFrm.ListView.Items[0].Checked=true then begin
StatusBar.Panels[0].Text:='Удаление: '+MainFrm.ListView.Items[0].Caption;
if DeleteFile(MainFrm.ListView.Items[0].Caption)=false then StatusBar.Panels[0].Text:='Не могу удалить ' +
MainFrm.ListView.Items[0].Caption;
end else
StatusBar.Panels[0].Text:='Файл '+ListView.Items[0].Caption+' удален не будет';
MainFrm.ListView.Items[0].Delete;
application.ProcessMessages;
end;
StatusBar.Panels[0].Text:='';
ShowText(0,0);
end;

procedure TMainFrm.DeleteFileSelected;
begin
if (MainFrm.ListView.Selected<>nil) and (MainFrm.ListView.Selected.Caption<>'') then begin
DeleteFile(MainFrm.ListView.Selected.Caption);
MainFrm.ListView.Selected.Delete;
end;
end;

procedure TMainFrm.EnabledButtons(Enabled: boolean);
begin
MainFrm.DeletAllBt.enabled:=Enabled;
MainFrm.ExceptAllBt.enabled:=Enabled;
MainFrm.FilterBt.enabled:=Enabled;
MainFrm.DeleteSelectedBt.enabled:=Enabled;
MainFrm.DeleteAllBt.enabled:=Enabled;
end;

function TMainFrm.FileMaskEquate(F, M: string): boolean;
var
Fl, Ml: byte;
Fp, Mp: byte;
begin
F := UpperCase(F);
M := UpperCase(M);
result := true;
Fl := length(F);
Ml := length(M);
Fp := 1;
Mp := 1;
while Mp <= Ml do
begin
case M[Mp] of
'?':
begin
inc(Mp);
inc(Fp);
end;
'*':
begin
if Mp = Ml then
exit;
if M[Mp + 1] = F[Fp] then
begin
Inc(Mp);
end else
begin
if Fp = Fl then
begin
result := false;
exit;
end;
inc(Fp);
end;
end;
else
begin
if M[Mp] <> F[Fp] then
begin
result := false;
exit;
end;
if (Mp=Ml) and (Fp<>Fl) then begin
Result:=false;
exit;
end;
inc(Fp);
inc(Mp);
end
end;
end;
end;

procedure TMainFrm.Find(Dir: string);
var
DirInfo:TSearchRec;
FindRes:Integer;
ListItem: TListItem;
Ex:string;
begin
FindRes:=FindFirst(Dir+'*.*',faAnyFile,DirInfo);
While FindRes=0 do begin
if Stop=true then FindClose(DirInfo);
MainFrm.StatusBar.Panels[0].Text:='Поиск: '+Dir;
application.ProcessMessages;
if ((DirInfo.Attr and faDirectory)=faDirectory) and ((DirInfo.Name='.')or(DirInfo.Name='..')) then begin
FindRes:=FindNext(DirInfo);
Continue;
end;
if ((DirInfo.Attr and faDirectory)=faDirectory) then begin
Find(Dir+DirInfo.Name+'\');
FindRes:=FindNext(DirInfo);
Continue;
end;
if InExt(DirInfo.Name)=true then begin
ListItem:=MainFrm.ListView.Items.Add;
ListItem.Caption :=dir+dirinfo.Name;
ListItem.SubItems.Add(inttostr(Dirinfo.size));
Ex:=ExtractFileExt(Dirinfo.Name);
Delete(Ex,1,1);
ListItem.SubItems.Add('Файл "'+AnsiUpperCase(Ex)+'"');
ListItem.SubItems.Add(DateTimeToStr(FileDateToDateTime(DirInfo.Time)));
ListItem.Checked:=true;
files:=files+1;
size:=size+Dirinfo.size;
ShowText(files,size);
end;
FindRes:=FindNext(DirInfo);
end;
FindClose(DirInfo);
MainFrm.Statusbar.Panels[0].Text:='';
end;

procedure TMainFrm.FindFiles;
var
i:integer;
begin
files:=0; size:=0; stop:=false;
ShowText(0,0);
GetDrives;
MainFrm.ListView.Clear;
for i:=0 to High(Drives) do begin
Find(Drives[i]);
end;
end;

procedure TMainFrm.GetDrives;
var
Drive:char;
begin
SetLength(Drives,0);
for Drive:='A' to 'Z' do begin
if GetDriveType(PAnsiChar(Drive+':\'))=DRIVE_FIXED then begin
SetLength(Drives,Length(Drives)+1);
Drives[High(Drives)]:=Drive+':\';
end;
end;
end;

function TMainFrm.InExt(FileName: string): boolean;
var
i:integer;
begin
For i:=0 to List.Count-1 do begin
if AddFilterFrm.FilterList.Items[i].Checked=true then begin
if FileMaskEquate(FileName,list.Strings[i])=true then begin
Result:=true;
exit;
end;
end;
end;
Result:=false;
end;

procedure TMainFrm.ShowText(f, s: real);
begin
MainFrm.StatusBar.Panels[1].Text:='Найдено файлов: ' + floattostr(f);
MainFrm.StatusBar.Panels[2].Text:='Общий размер: ' + floattostr(RoundTo(s/1048576,-2)) + ' Мб';
end;

procedure TMainFrm.FormShow(Sender: TObject);
var
f:string;
ListItem: TListItem;
begin
try
if FileExists('Filters.dat') then
begin
List.Free;
List:=TStringList.Create;
List.LoadFromFile('Filters.dat');
AddFilterFrm.LoadFilters;
end else
begin
if Trim(f) <> '' then begin
ListItem := AddFilterFrm.FilterList.Items.Add;
ListItem.Caption := f;
List.Add(f);
List.SaveToFile('Filters.dat');
end;
end;
except
end;
end;

procedure TMainFrm.FormResize(Sender: TObject);
begin
listview.Column[0].Width:=(Listview.Width*50 div 100);
listview.Column[1].Width:=(Listview.Width*18 div 100);
listview.Column[2].Width:=(Listview.Width*18 div 100);
listview.Column[3].Width:=(Listview.Width*25 div 100);
StatusBar.Panels[0].Width:=(StatusBar.Width*54 div 100);
StatusBar.Panels[1].Width:=(StatusBar.Width*25 div 100);
end;

procedure TMainFrm.FilterBtClick(Sender: TObject);
begin
AddFilterFrm.Position := poMainFormCenter;
AddFilterFrm.show;
end;

procedure TMainFrm.ExceptAllBtClick(Sender: TObject);
begin
CheckAll(false);
end;

procedure TMainFrm.DeletAllBtClick(Sender: TObject);
begin
CheckAll(true);
end;

procedure TMainFrm.DeleteSelectedBtClick(Sender: TObject);
begin
DeleteFileSelected;
end;

procedure TMainFrm.DeleteAllBtClick(Sender: TObject);
begin
DeleteAll;
end;

procedure TMainFrm.RunBtClick(Sender: TObject);
begin
EnabledButtons(false);
FindFiles;
end;

procedure TMainFrm.SaveReportBtClick(Sender: TObject);
var
FFileName: String;
begin
try
if OpenSaveFileDialog(MainFrm.Handle, '*.txt', 'Текстовые документы (*.txt)|*.txt|',
ParamStr(1), 'Сохранить как', FFileName, False) then begin
if FileExists(FFileName) then
begin
PostMessage(Handle, WM_USER + 1024, 0, 0);
if Application.MessageBox(PChar('Файл "' + FFileName +
'" уже существует.' +
#13 + 'Заменить?'),
'Registry Cleaner', MB_ICONQUESTION + mb_YesNo)
<> idYes then
begin
Exit;
end else
begin
UninstallList.Items.SaveToFile(FFileName);
end;
end;
if not FileExists(FFileName) then
begin
UninstallList.Items.SaveToFile(FFileName);
end;
end;
except
end;
end;

procedure TMainFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Ini.WriteInteger('Position', 'Top', Top);
Ini.WriteInteger('Position', 'Left', Left);
end;

end.
