unit uViewPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.Imaging.jpeg;

type
  TFPrincipal = class(TForm)
    MenuPrincipal: TMainMenu;
    MPISair: TMenuItem;
    MPISimulacao: TMenuItem;
    ItemPU: TMenuItem;
    ItemPV: TMenuItem;
    Image1: TImage;
    procedure MPISairClick(Sender: TObject);
    procedure ItemPUClick(Sender: TObject);
    procedure ItemPVClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FPrincipal: TFPrincipal;

implementation

{$R *.dfm}
  uses  uViewSimuladorPU,uViewSimuladorPV;

procedure TFPrincipal.ItemPUClick(Sender: TObject);
begin

  if not Assigned(FSimuladorPUView) then
  begin
    FSimuladorPUView := TFSimuladorPUView.Create(self);
  end;
  FSimuladorPUView.Show;

end;

procedure TFPrincipal.ItemPVClick(Sender: TObject);
begin
 if not Assigned(FSimuladorPVView) then
  begin
    FSimuladorPVView := TFSimuladorPVView.Create(self);
  end;
  FSimuladorPVView.Show;
end;

procedure TFPrincipal.MPISairClick(Sender: TObject);
begin
  Application.Terminate;
end;

end.
