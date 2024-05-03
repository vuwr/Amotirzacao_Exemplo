unit uViewSimuladorPU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  Vcl.Imaging.jpeg;

type
  TFSimuladorPUView = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Button1: TButton;
    BtnSair: TButton;
    Image1: TImage;
    procedure BtNSimulacaoClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
  end;

var
  FSimuladorPUView: TFSimuladorPUView;

implementation

{$R *.dfm}
   uses uViewSimuladorPUModelo;
procedure TFSimuladorPUView.BtnSairClick(Sender: TObject);
begin
  close;
end;

procedure TFSimuladorPUView.BtNSimulacaoClick(Sender: TObject);
begin
   if not Assigned(FSimuladorPUModelo)
      then FSimuladorPUModelo := TFSimuladorPUModelo.Create(self);
  FSimuladorPUModelo.Show;
end;

procedure TFSimuladorPUView.Button1Click(Sender: TObject);
begin
 FSimuladorPUModelo := TFSimuladorPUModelo.Create(self);
 FSimuladorPUModelo.Parent := Panel1;
 FSimuladorPUModelo.Show;
end;

procedure TFSimuladorPUView.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := cafree;
  release;
  FSimuladorPUView := nil;
end;

end.
