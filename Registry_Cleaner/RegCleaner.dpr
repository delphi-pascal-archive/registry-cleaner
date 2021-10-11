program RegCleaner;

uses
  Forms,
  NP in 'NP.pas' {MainFrm},
  FP in 'FP.pas' {AddFilterFrm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Registry Cleaner';
  Application.CreateForm(TMainFrm, MainFrm);
  Application.CreateForm(TAddFilterFrm, AddFilterFrm);
  Application.Run;
end.
