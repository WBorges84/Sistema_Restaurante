unit UPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls;

type
  TFrmPrincipal = class(TForm)
    Image1: TImage;
    MainMenu1: TMainMenu;
    Cadastros1: TMenuItem;
    Produtos1: TMenuItem;
    Movimentaes1: TMenuItem;
    Pedidos1: TMenuItem;
    Reltorios1: TMenuItem;
    Reservas1: TMenuItem;
    Sair1: TMenuItem;
    Funcionrios1: TMenuItem;
    Fornecedores1: TMenuItem;
    Mesas1: TMenuItem;
    CadastrosProdutos1: TMenuItem;
    EntradadeProdutos1: TMenuItem;
    PosiodoEstoque1: TMenuItem;
    NovaVenda1: TMenuItem;
    EntradaseSadas1: TMenuItem;
    Gastos1: TMenuItem;
    Pagamentos1: TMenuItem;
    NovoPedido1: TMenuItem;
    NovaReserva1: TMenuItem;
    ConsultarReserva1: TMenuItem;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    Pratos1: TMenuItem;
    Cargos1: TMenuItem;
    lblUsuario: TLabel;
    lblfunc: TLabel;
    lblcargo: TLabel;
    Label1: TLabel;
    procedure Funcionrios1Click(Sender: TObject);
    procedure CadastrosProdutos1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Cargos1Click(Sender: TObject);
    procedure Fornecedores1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}

uses Funcionarios, produtos, modulo, Login, cargo, UFuncoes, fornecedores;

procedure TFrmPrincipal.CadastrosProdutos1Click(Sender: TObject);
begin
  FrmProdutos := TFrmProdutos.Create(Self);
  FrmProdutos.ShowModal;
end;

procedure TFrmPrincipal.Cargos1Click(Sender: TObject);
begin
    FrmCargo := TFrmCargo.Create(self);
    FrmCargo.ShowModal;

end;

procedure TFrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Application.Terminate;
end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
 //lblUsuario.Caption := nomeUsuario;
 lblfunc.Caption := nomeFuncionario;
 lblcargo.Caption := cargofunc;
end;

procedure TFrmPrincipal.Fornecedores1Click(Sender: TObject);
begin
 FrmFornecedores := TFrmFornecedores.Create(Self);
 FrmFornecedores.ShowModal;
end;

procedure TFrmPrincipal.Funcionrios1Click(Sender: TObject);
begin
 Frmfuncionarios := TFrmfuncionarios.Create(Self);
 Frmfuncionarios.ShowModal;
end;

procedure TFrmPrincipal.Sair1Click(Sender: TObject);
begin

 FrmLogin := TFrmLogin.Create(FrmPrincipal);
 FrmPrincipal.Hide;
 //Application.Terminate;
 FrmLogin.ShowModal;


end;

procedure TFrmPrincipal.SpeedButton1Click(Sender: TObject);
begin
 FrmProdutos := TFrmProdutos.Create(Self);
 FrmProdutos.ShowModal;
end;

end.
