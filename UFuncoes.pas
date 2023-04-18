unit UFuncoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,System.UITypes;

type
  TFrmFuncoes = class(TForm)

  end;
  var
    usu , senha : String;  
  
function ConverterRGB(r, g, b : Byte) : TColor;
procedure chamarLogin(usu, senha : String);
procedure habilitarcamposFunc();
procedure desabilitarcamposFunc();
procedure limparcamposFunc();
procedure habilitarcamposProd();
procedure desabilitarcamposProd();
procedure limparcamposProd();
procedure habilitarcamposCargo();
procedure desabilitarcamposCargo();
procedure limparcamposCargo();
procedure carregarComboboxCargo();
procedure carregarComboboxProd();
function validarCPF(num: String): Integer;
//procedure buscarNome();

implementation

{$R *.dfm}

uses Funcionarios, produtos, UPrincipal, Login, modulo, cargo;
 //converter cor para RGB
function ConverterRGB(r, g, b : Byte) : TColor;
begin
  Result := RGB(r, g, b);
end;





function validarCPF(num: String) : Integer;
var aux, aux2, soma1, soma2 : Integer;

begin
  aux :=(strtoint(num[1]) + strtoint(num[2]) + strtoint(num[3]) +strtoint(num[4]) +strtoint(num[5]) +strtoint(num[6]) +strtoint(num[7]) +strtoint(num[8]) +strtoint(num[9]) +strtoint(num[10]) +strtoint(num[11]));

  if (aux <> 11) and(aux <> 12) and (aux <> 21) and (aux <> 22) and (aux <> 23) and(aux <> 32) and (aux <> 33) and (aux <> 34) and (aux <> 43) and (aux <> 44) and (aux <> 45) and (aux <> 54) and (aux <> 55) and (aux <> 56) and (aux <> 65) and (aux <> 66) and (aux <> 67) and (aux <> 76) and (aux <> 77) and (aux <> 78) and (aux <> 87) and (aux <> 88) then
  {if (aux <> 11) and (aux <> 33) and (aux <> 32)then}
  Begin
    //ShowMessage('CPF invalido');
    Result := 0;
    exit;
  End
  else
  Begin
  //ShowMessage('CPF válido');
  Result := 1;
  exit;
  End;

end;




procedure carregarComboboxCargo();
Begin
  with DataModule1.tb_cargo do
  Begin

  Active := false;
  Active := true;
  if not isEmpty then

      begin
          while not Eof do
            begin
              Frmfuncionarios.cbCargo.Items.Add(FieldByName('nome').AsString);
              next;

            end;

      end;

  End;

end;

procedure carregarComboboxProd();
Begin
  with DataModule1.tb_fornecedores do
  Begin
    if not isEmpty then

        begin
            while not Eof do
              begin
                FrmProdutos.cbFornecedor.Items.AddObject(FieldByName('nome').AsString, TObject(FieldByName('id').AsInteger));
                next;

              end;

        end;

  End;

end;

//login do sistema
procedure chamarLogin(usu, senha : String);
var usuario, lsenha : String;
begin

  Begin
   if (usu <> '') and (senha <> '') then
    begin
        //USUARIO lLOGADO
        nomeUsuario := usu;

      //validar login
        usuario := Trim(FrmLogin.edtUsuario.Text);
        lsenha   := Trim(FrmLogin.edtSenha.Text);

         //VERIFICA USUARIO
        DataModule1.QueryConFunc.Close;
        DataModule1.QueryConFunc.SQL.Clear;
        DataModule1.QueryConFunc.SQL.Add('select * from funcionarios where usuario = :usuario');
        DataModule1.QueryConFunc.ParamByName('usuario').Value := trim(FrmLogin.edtUsuario.Text);
        DataModule1.QueryConFunc.Open;

        if not DataModule1.QueryConFunc.IsEmpty then
        Begin
           nomeFuncionario := DataModule1.QueryConFunc['nome'];
           cargofunc := DataModule1.QueryConFunc['cargo'];
          //VERIFICA SENHA
          DataModule1.QueryConFunc.Close;
          DataModule1.QueryConFunc.SQL.Clear;
          DataModule1.QueryConFunc.SQL.Add('select * from funcionarios where senha = :senha and usuario = :usuario');
          DataModule1.QueryConFunc.ParamByName('senha').Value := trim(FrmLogin.edtSenha.Text);
          DataModule1.QueryConFunc.ParamByName('usuario').Value := trim(FrmLogin.edtUsuario.Text);
          DataModule1.QueryConFunc.Open;

          if  not DataModule1.QueryConFunc.IsEmpty then
          begin
           FrmPrincipal := TFrmPrincipal.Create(FrmLogin);
           FrmLogin.Hide;
           FrmPrincipal.ShowModal;


          end
          Else
          Begin
           MessageDlg('Senha incorreta!', mtWarning, [mbOK], 0);
           FrmLogin.edtUsuario.Text := usuario;
           FrmLogin.edtSenha.Text := '';
           FrmLogin.edtSenha.SetFocus;


          End;

        End
        else
        begin
          MessageDlg('Usuário não cadastrado!', mtWarning, [mbOK], 0);
          FrmLogin.edtUsuario.Text := '';
          FrmLogin.edtSenha.Text := '';
          FrmLogin.edtUsuario.SetFocus;

        end;



  end
  else
  Begin
  MessageDlg('Preencha os Campos!!', mtWarning, [mbOK], 0);

  End;
 end;
end;

// HABILITA / DESABILITA / LIMPA CARGO
procedure habilitarcamposCargo();
begin
  with FrmCargo do
    Begin
    edtNome.Enabled := true;

    End;

end;

procedure desabilitarcamposCargo();
begin
  with FrmCargo do
    Begin
    //limparcamposCargo;
    edtNome.Enabled := false;


    End;

end;

procedure limparcamposCargo();
begin
  with FrmCargo do
    Begin
    edtNome.Text := '';
    End;

end;


// HABILITA / DESABILITA / LIMPA FUNCIONARIOS
procedure habilitarcamposFunc();
begin
  with Frmfuncionarios do
    Begin
    edtNome.Enabled := true;
    edtCPF.Enabled := true;
    edtTel.Enabled := true;
    edtEndereco.Enabled := true;
    cbCargo.Enabled := true;
    edtsenha.Enabled := true;
    edtConfSenha.Enabled := true;
    edtUsuario.Enabled := true;
    End;

end;

procedure desabilitarcamposFunc();
begin
  with Frmfuncionarios do
    Begin
    limparcamposFunc;
    edtNome.Enabled := false;
    edtCPF.Enabled := false;
    edtTel.Enabled := false;
    edtEndereco.Enabled := false;
    cbCargo.Enabled := false;
    edtsenha.Enabled := false;
    edtConfSenha.Enabled := false;
    edtUsuario.Enabled := false;
    End;

end;

procedure limparcamposFunc();
begin
  with Frmfuncionarios do
    Begin
    edtNome.Text := '';
    edtCPF.Text := '';
    edtTel.Text := '';
    edtEndereco.Text := '';
    edtsenha.Text := '';
    edtConfSenha.Text := '';
    edtUsuario.Text := '';
    End;

end;


// HABILITA / DESABILITA / LIMPA PRODUTOS
procedure habilitarcamposProd();
begin
  with FrmProdutos do
    Begin
    edtNome.Enabled := true;
    edtDescricao.Enabled := true;
    edtValor.Enabled := true;
    edtQuantidade.Enabled := true;
    cbFornecedor.Enabled := true;
     btnAddImg.Enabled := true;
    End;

end;

procedure desabilitarcamposProd();
begin
  with FrmProdutos do
    Begin
    //limparcamposFunc;
    edtNome.Enabled := false;
    edtDescricao.Enabled := false;
    edtValor.Enabled := false;
    edtQuantidade.Enabled := false;
    cbFornecedor.Enabled := false;
    btnAddImg.Enabled := false;
    End;

end;

procedure limparcamposProd();
begin
  with FrmProdutos do
    Begin
    edtNome.Text := '';
    edtDescricao.Text := '';
    edtValor.Text := '0';
    cbFornecedor.Text := '';
    edtQuantidade.Text := '0';
    End;

end;








  
end.
