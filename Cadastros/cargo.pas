unit cargo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.Buttons, Vcl.Imaging.pngimage, Vcl.ExtCtrls,System.UITypes,
  System.Rtti, System.Bindings.Outputs, Vcl.Bind.Editors, Data.Bind.EngExt,
  Vcl.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope;

type
  TFrmCargo = class(TForm)
    Image1: TImage;
    btnNovo: TSpeedButton;
    btnEditar: TSpeedButton;
    btnSalvar: TSpeedButton;
    btnExcluir: TSpeedButton;
    grid: TDBGrid;
    edtNome: TEdit;
    Label2: TLabel;
    edtCodigo: TEdit;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    procedure btnNovoClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure gridCellClick(Column: TColumn);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCargo: TFrmCargo;
  var carg : String;

implementation

{$R *.dfm}

uses modulo, UFuncoes;

procedure TFrmCargo.btnEditarClick(Sender: TObject);
var buscCarg : String;
begin
   if Trim(edtNome.Text) <> '' then
   Begin

      DataModule1.QueryCargo.SQL.Clear;
      DataModule1.QueryCargo.SQL.Add('select nome from cargo where nome =' +QuotedStr(Trim(edtNome.Text)));
      DataModule1.QueryCargo.Open;


       if not DataModule1.QueryCargo.IsEmpty then
       Begin
         buscCarg := DataModule1.QueryCargo['nome'];
          if buscCarg = carg then
            begin
              DataModule1.tb_cargo.Edit;

            MessageDlg('Editado com Sucesso!!', mtInformation, [mbOK], 0);
          //limparcamposCargo;
            desabilitarcamposCargo;
            btnNovo.Enabled := true;
            btnEditar.Enabled:= false;
            btnSalvar.Enabled := false;
            btnExcluir.Enabled := false;
            edtNome.Text := '';
            exit;
            end
            else
            Begin
             MessageDlg('O cargo: ' + edtNome.Text + ' J� existe no Banco de Dados!!' , mtInformation, [mbOK], 0);
             exit;
             End;
        DataModule1.tb_cargo.Edit;

        MessageDlg('Editado com Sucesso!!', mtInformation, [mbOK], 0);
      //limparcamposCargo;
        desabilitarcamposCargo;
        btnNovo.Enabled := true;
        btnEditar.Enabled:= false;
        btnSalvar.Enabled := false;
        btnExcluir.Enabled := false;
        edtNome.Text := '';


    End
    else
    Begin
       DataModule1.tb_cargo.Edit;

        MessageDlg('Editado com Sucesso!!', mtInformation, [mbOK], 0);
      //limparcamposCargo;
        desabilitarcamposCargo;
        btnNovo.Enabled := true;
        btnEditar.Enabled:= false;
        btnSalvar.Enabled := false;
        btnExcluir.Enabled := false;
        edtNome.Text := '';
    End;
 end
 else
 Begin
   MessageDlg('Preencha os campos!!', mtInformation, [mbOK], 0);
 End;
end;

procedure TFrmCargo.btnExcluirClick(Sender: TObject);
begin
if MessageDlg('Deseja excluir o registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
       if edtCodigo.Text <> '' then
    Begin
    DataModule1.tb_cargo.Delete;
    limparcamposCargo;
    desabilitarcamposCargo;
    btnNovo.Enabled := true;
    btnEditar.Enabled:= false;
    btnSalvar.Enabled := false;
    btnExcluir.Enabled := false;

    MessageDlg('Excluido com Sucesso!!', mtInformation, [mbOK], 0);


    End;

  end;
end;

procedure TFrmCargo.btnNovoClick(Sender: TObject);
begin

 limparcamposCargo;
 habilitarcamposCargo;
 btnNovo.Enabled := false;
 btnEditar.Enabled:= false;
 btnSalvar.Enabled := true;
 btnExcluir.Enabled := false;
 edtNome.SetFocus;
 DataModule1.tb_cargo.Insert;
end;

procedure TFrmCargo.btnSalvarClick(Sender: TObject);
begin
 if Trim(edtNome.Text) <> '' then
  Begin
    DataModule1.QueryCargo.SQL.Clear;
    DataModule1.QueryCargo.SQL.Add('select nome from cargo where nome =' +QuotedStr(Trim(edtNome.Text)) );
    DataModule1.QueryCargo.Open;

    if not DataModule1.QueryCargo.IsEmpty then
    Begin
     MessageDlg('Cargo ** ' + edtNome.Text + ' ** j� existe no Banco de Dados!', mtWarning, [mbOK], 0);
     edtNome.SetFocus;
     exit;
    End;

      DataModule1.tb_cargo.Post;
      limparcamposCargo;
      desabilitarcamposCargo;
      btnNovo.Enabled := true;
      btnEditar.Enabled:= false;
      btnSalvar.Enabled := false;
      btnExcluir.Enabled := false;
      MessageDlg('Cadastrado com Sucesso!!', mtInformation, [mbOK], 0);

  End
  else
  Begin
    MessageDlg('Preencha os campos!!', mtInformation, [mbOK], 0);
  End;
end;

procedure TFrmCargo.gridCellClick(Column: TColumn);

begin
 habilitarcamposCargo;
 btnNovo.Enabled := true;
 btnEditar.Enabled:= true;
 btnSalvar.Enabled := false;
 btnExcluir.Enabled := true;
 carg := edtNome.Text;
end;

end.
