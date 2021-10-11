unit FP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, Buttons, LbSpeedButton;

type
  TAddFilterFrm = class(TForm)
    FilterList: TListView;
    AddBt: TLbSpeedButton;
    DelBt: TLbSpeedButton;
    Cancel: TLbSpeedButton;

    procedure AddBtClick(Sender: TObject);
    procedure DelBtClick(Sender: TObject);
    procedure CancelClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

  private

  public

    procedure LoadFilters;

  end;

var
  AddFilterFrm: TAddFilterFrm;

  List:TStringList;

implementation

{$R *.dfm}

procedure TAddFilterFrm.LoadFilters;
var
i:integer;
ListItem: TListItem;
begin
FilterList.Clear;
For i:=0 to List.Count-1 do begin
ListItem:=AddFilterFrm.FilterList.Items.Add;
ListItem.Caption :=List.Strings[i];
Listitem.Checked:=true;
end;
end;

procedure TAddFilterFrm.AddBtClick(Sender: TObject);
var
f:string;
ListItem: TListItem;
begin
try
f:=InputBox('Добавить фильтр','Введите фильтр:','');
if Trim(f)<>'' then begin
ListItem:=AddFilterFrm.FilterList.Items.Add;
ListItem.Caption :=f;
List.Add(f);
List.SaveToFile('Filters.dat');
end;
except
end;
end;

procedure TAddFilterFrm.DelBtClick(Sender: TObject);
begin
List.Delete(FilterList.Selected.Index);
FilterList.Selected.Delete;
List.SaveToFile('Filters.dat');
end;

procedure TAddFilterFrm.CancelClick(Sender: TObject);
begin
Close;
end;

procedure TAddFilterFrm.FormDestroy(Sender: TObject);
begin
AddFilterFrm.OnActivate := nil;
FilterList.Free;
Cancel.Free;
DelBt.Free;
AddBt.Free;
end;

end.
