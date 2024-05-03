unit uViewSimuladorPUModelo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls,
  uControllerSimulador, Vcl.Mask;

type
  TFSimuladorPUModelo = class(TForm)
    DS: TDataSource;
    DBGrid1: TDBGrid;
    Pnl1: TPanel;
    Panel2: TPanel;
    Grid: TDBGrid;
    EdtCapital: TEdit;
    LbCapital: TLabel;
    BtnSimular: TButton;
    Label2: TLabel;
    EdtTxJuros: TEdit;
    EdtMeses: TEdit;
    Label3: TLabel;
    PnlTotal: TPanel;
    LbmC: TLabel;
    LbTotal: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnSimularClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure EventKeyPressEdits(Sender: TObject; var Key: Char);
    procedure EdtCapitalExit(Sender: TObject);
    procedure EdtTxJurosExit(Sender: TObject);
    procedure EdtMesesExit(Sender: TObject);

  private
    ControllerSimulador :TControllerSimulador;
    procedure ConfiguraTela;
  public

  end;
type TDBgridPadrao = class(TDBgrid);
var
  FSimuladorPUModelo: TFSimuladorPUModelo;

implementation

uses
  Vcl.Graphics;

{$R *.dfm}

procedure TFSimuladorPUModelo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := cafree;
end;

procedure TFSimuladorPUModelo.FormCreate(Sender: TObject);
begin
  EdtCapital.OnKeyPress :=   EventKeyPressEdits;
  EdtTxJuros.OnKeyPress :=   EventKeyPressEdits;
  EdtMeses.OnKeyPress   :=   EventKeyPressEdits;
  ControllerSimulador := TControllerSimulador.Create;
end;

procedure TFSimuladorPUModelo.FormDestroy(Sender: TObject);
begin
  ControllerSimulador.Destroy;
end;

procedure TFSimuladorPUModelo.FormShow(Sender: TObject);
begin
  with ControllerSimulador, ControllerSimulador.ModelPagamentoUnico do
  begin
    EdtCapital.Text :=  formataCurToStr(Capital);
    EdtTxJuros.text  :=  formataCurToStr(TxJutos,nao);
    EdtMeses.Text    :=  inttostr( Meses);
  end;
end;

procedure TFSimuladorPUModelo.GridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if Odd(ds.DataSet.Recno)  { posição do dataset for impar }
     then grid.Canvas.Brush.Color := $00E9E9E9
     else grid.Canvas.Brush.Color := clWindow;

  if (gdSelected in State) then
  begin
    grid.Canvas.Brush.color := clred;
    grid.Canvas.font.Color := clWhite;
    grid.Canvas.font.Style := [TFontStyle.fsBold];
  end;
  grid.Canvas.FillRect(Rect);
  grid.DefaultDrawColumnCell(Rect,DataCol,Column,State);

end;

procedure TFSimuladorPUModelo.BtnSimularClick(Sender: TObject);
begin
  with ControllerSimulador, ControllerSimulador.ModelPagamentoUnico do
  begin
    ValidarComponentesPU(Tcomponent(EdtCapital));
    ValidarComponentesPU(Tcomponent(EdtTxJuros));
    ValidarComponentesPU(Tcomponent(EdtMeses));

    Capital :=  formataStrToCur(EdtCapital.Text);
    TxJutos :=  formataStrToCur(EdtTxJuros.Text);
    Meses   :=  strtoint(EdtMeses.Text);
    Calcular;
    ds.DataSet := DadosDataset;
  end;
  ds.DataSet.Open;
  ConfiguraTela;
end;

procedure TFSimuladorPUModelo.ConfiguraTela;
var i,TotalWidht:integer;

begin
  TotalWidht :=0;
  grid.BorderStyle := bsNone;
  grid.Options := [dgTitles,dgColLines,dgTabs,dgRowSelect,dgAlwaysShowSelection];

  for I := 0 to pred(grid.Columns.Count) do
  begin
    grid.Columns[i].Alignment  := taCenter;
    grid.Columns[i].font.Color := $006D5545;
    grid.Columns[i].Font.Name  := 'Arial';
    grid.Columns[i].Title.Alignment := taCenter;
    grid.Columns[i].Title.Color := $006D5545;
    grid.Columns[i].Title.Font.Name := 'Tahoma';
    grid.Columns[i].Title.Font.size := 9;
    grid.Columns[i].Title.font.Style:= [TFontStyle.fsBold];
    grid.Columns[i].Width := 120;
    TotalWidht :=  TotalWidht+grid.Columns[i].Width;
  end;

  TDBgridPadrao(grid).DefaultRowHeight := 30 ;
  TDBgridPadrao(grid).ClientHeight     := (30 * TDBgridPadrao(grid).RowCount)+30;
  BtnSimular.Left:= TotalWidht- BtnSimular.Width;
  LbTotal.Caption := ControllerSimulador.formataCurToStr(ControllerSimulador.ModelPagamentoUnico.MontanteCalculado);
  PnlTotal.Visible := true;
  Repaint;
end;

procedure TFSimuladorPUModelo.EdtCapitalExit(Sender: TObject);
begin
  with  ControllerSimulador do
  begin
    EdtCapital.Text := formataCurToStr(formataStrToCur(EdtCapital.Text));
  end;
end;

procedure TFSimuladorPUModelo.EdtMesesExit(Sender: TObject);
begin
  with  ControllerSimulador do
  begin
    EdtMeses.Text := inttostr((formataStrToInt(EdtMeses.Text)));
  end;
end;

procedure TFSimuladorPUModelo.EdtTxJurosExit(Sender: TObject);
begin
  with  ControllerSimulador do
  begin
    EdtTxJuros.Text := formataCurToStr(formataStrToCur(EdtTxJuros.Text),nao);
  end;
end;

procedure TFSimuladorPUModelo.EventKeyPressEdits(Sender: TObject; var Key: Char);
begin
  if not ((Key in ['0'..'9']) or (Key in [',','.',#8]) )
     then abort;
end;

end.
