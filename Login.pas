unit Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.Buttons;

type
  TFrmLogin = class(TForm)
    ImgBack: TImage;
    edtUsuario: TEdit;
    edtSenha: TEdit;
    btnLogin: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
    procedure edtUsuarioKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtSenhaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;

implementation

uses UFuncoes, UPrincipal, modulo;



{function ConverterRGB(r, g, b : Byte) : TColor;
begin
  Result := RGB(r, g, b);

  end;}
{$R *.dfm}




procedure TFrmLogin.btnLoginClick(Sender: TObject);
var usuario, senha : String;
begin
  chamarLogin(Trim(edtUsuario.Text), Trim(edtSenha.Text));

end;

procedure TFrmLogin.edtSenhaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if key = 13 then
 chamarLogin(Trim(edtUsuario.Text), Trim(edtSenha.Text));
end;

procedure TFrmLogin.edtUsuarioKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 13 then
  edtSenha.SetFocus;
end;

procedure TFrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Application.Terminate;
end;

procedure TFrmLogin.FormCreate(Sender: TObject);
begin
      {COR HEXADECIMAL}
      //FrmLogin.Color := $ffd9cd;

      {COR RGB}
      FrmLogin.Color := ConverterRGB(83, 186, 205);

end;

end.
