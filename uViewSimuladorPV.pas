unit uViewSimuladorPV;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.StdCtrls, Vcl.ExtCtrls,Vcl.Dialogs,
  Vcl.Imaging.jpeg;

type
  TFSimuladorPVView = class(TForm)
    Panel2: TPanel;
    Button1: TButton;
    BtnSair: TButton;
    Panel1: TPanel;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FSimuladorPVView: TFSimuladorPVView;

implementation

{$R *.dfm}

procedure TFSimuladorPVView.Button1Click(Sender: TObject);
begin
  MessageDlg('Em Desenvolvimento!', TMsgDlgType.mtWarning, [TMsgDlgBtn.mbOK], 0);
end;

procedure TFSimuladorPVView.BtnSairClick(Sender: TObject);
begin
  close;
end;

procedure TFSimuladorPVView.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := cafree;
  release;
  FSimuladorPVView := nil;
end;

end.
