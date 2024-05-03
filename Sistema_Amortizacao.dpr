program Sistema_Amortizacao;

uses
  Vcl.Forms,
  uViewPrincipal in 'uViewPrincipal.pas' {FPrincipal},
  uViewSimuladorPU in 'uViewSimuladorPU.pas' {FSimuladorPUView},
  uViewSimuladorPUModelo in 'uViewSimuladorPUModelo.pas' {FSimuladorPUModelo},
  uControllerSimulador in 'uControllerSimulador.pas',
  uModelException in 'uModelException.pas',
  uModelPagamentoUnico in 'uModelPagamentoUnico.pas',
  uModelLog in 'uModelLog.pas',
  uModelPagamentosVariaveis in 'uModelPagamentosVariaveis.pas',
  uViewSimuladorPV in 'uViewSimuladorPV.pas' {FSimuladorPVView};

{$R *.res}

begin
  Application.Initialize;
  ReportMemoryLeaksOnShutdown :=true;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFPrincipal, FPrincipal);
  Application.Run;
end.
