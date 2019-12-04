unit ufanalisadorlexico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls,
  Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.ExtCtrls;

type
  TFAnalisadorLexico = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label3: TLabel;
    edt_entrada: TEdit;
    btn_add: TButton;
    btn_limpar: TButton;
    lst_vw: TListView;
    btn_remover: TButton;
    Label2: TLabel;
    edt_busca: TEdit;
    stg_analisador: TStringGrid;
    shp_status: TShape;
    lbl_obs: TLabel;
    procedure btn_addClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edt_entradaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btn_limparClick(Sender: TObject);
    procedure IncluirDados(palavra:string);
    procedure btn_removerClick(Sender: TObject);
    procedure edt_entradaChange(Sender: TObject);
    procedure edt_entradaKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure edt_buscaKeyPress(Sender: TObject; var Key: Char);
    procedure edt_buscaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    slEntrada: TStringList;
    q: Array of Char;
    sTemp: string;
    Teste: boolean;
  public
    { Public declarations }
  end;

var
  FAnalisadorLexico: TFAnalisadorLexico;
  Num_Tokens: integer;

implementation

{$R *.dfm}

procedure TFAnalisadorLexico.btn_addClick(Sender: TObject);
var
  Item: TListItem;
begin
  try
    if edt_entrada.Text<>'' then
    begin
      if slEntrada.IndexOf(edt_entrada.Text)>=0 then
      begin
        ShowMessage('Palavra: "'+edt_entrada.Text+'" já adicionada na lista!');
        Exit;
      end;
      slEntrada.Add(edt_entrada.Text);
      // ListView
      Item := lst_vw.Items.Add;
      Item.Caption := edt_entrada.Text;
      IncluirDados(edt_entrada.Text);
    end
    else
      MessageDlg('O campo está em branco!', mtWarning, mbOKCancel, 0);
  finally
    edt_entrada.Text := '';
    edt_entrada.SetFocus;
  end;
end;

procedure TFAnalisadorLexico.btn_limparClick(Sender: TObject);
begin
  if MessageDlg('Deseja excluir todas as Palavras?', mtInformation, mbYesNo, 0) = mrYes then
  begin
    Num_Tokens := 1;
    slEntrada.Clear;
    lst_vw.Clear;
    FAnalisadorLexico.FormActivate(Sender);
  end;
end;

procedure TFAnalisadorLexico.btn_removerClick(Sender: TObject);
begin
  if lst_vw.ItemIndex >= 0 then
  begin
    slEntrada.Delete(slEntrada.IndexOf(lst_vw.Selected.Caption));
    lst_vw.DeleteSelected;
  end
  else
    ShowMessage('Selecione um registro para remover');

end;

procedure TFAnalisadorLexico.edt_buscaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  cont, posi, I, J: integer;
begin
  posi  := 1;
  Teste := True;
  cont  := Length(edt_busca.Text);

  for I := 1 to cont do
  begin
    for j := 1 to 27 do
    begin
      if (stg_analisador.Cells[j, 0] = edt_busca.Text[I]) and (Teste = True) then
      begin
        stg_analisador.Options := stg_analisador.Options - [goRowSelect];

        if (stg_analisador.Cells[j, posi] <> '') then
        begin
          shp_status.Brush.Color := clGreen;
          sTemp := copy(stg_analisador.Cells[0, posi],
            Length(stg_analisador.Cells[0, posi]), 1);
          posi  := StrToInt(stg_analisador.Cells[j, posi]) + 1;
        end
        else
        begin
          shp_status.Brush.Color := clRed;
          Teste := False;
        end;

        if sTemp <> '*' then
        begin
          stg_analisador.Options := stg_analisador.Options + [goRowSelect];
          stg_analisador.Row := posi;
        end
        else
          stg_analisador.Options := stg_analisador.Options - [goRowSelect];
      end;
    end;
  end;
end;

procedure TFAnalisadorLexico.edt_buscaKeyPress(Sender: TObject; var Key: Char);
begin
  if trim(edt_entrada.Text) = EmptyStr then
    shp_status.Brush.Color := clYellow;
  // espaço
  If Ord(Key) = 32 Then
  begin
    if trim(edt_busca.Text) <> EmptyStr then
    begin
      if ((sTemp = '*') and (Teste = True)) then
      begin
        MessageDlg('"' + trim(edt_busca.Text) + '"  ' + 'foi reconhecida!', mtInformation, mbOKCancel, 0);
        edt_busca.Clear;
        // Acompanha linha com a seleção
        stg_analisador.Row := 1;
      end
      else
      begin
        MessageDlg('"' + trim(edt_busca.Text) + '"  ' + 'não foi reconhecida!', mtError, mbOKCancel, 0);
        edt_busca.Clear;
        // Acompanha linha com a seleção
        stg_analisador.Row := 1;
      end;
    end
    else
      MessageDlg('O campo está em Branco!', mtWarning, mbOKCancel, 0);
  end;
end;

procedure TFAnalisadorLexico.edt_entradaChange(Sender: TObject);
var iTam : Integer;
begin
  iTam := 100;
  iTam := iTam - Length(edt_entrada.Text);
end;

procedure TFAnalisadorLexico.edt_entradaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=13 then
    btn_addClick(Sender);
end;

procedure TFAnalisadorLexico.edt_entradaKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (Key in['a'..'z','A'..'Z',#8]) then
    Key := #0;
end;

procedure TFAnalisadorLexico.FormActivate(Sender: TObject);
var I, j, Num_Linhas, Num_Colunas: integer;
begin
  shp_status.Brush.Color := clWhite;
  Num_Tokens := 1;

  Num_Linhas  := 101;
  Num_Colunas := 26;

  stg_analisador.RowCount := Num_Linhas;
  stg_analisador.ColCount := Num_Colunas + 1;

  // insere o cabeçalho nas colunas {a,b,c,...,z}
  for I := 1 to (Num_Colunas) do
  begin
    for j := 0 to Num_Linhas + 1 do
      stg_analisador.Cells[I, j] := '';

    stg_analisador.Cells[I, 0] := Chr(Ord('a') - 1 + I);
  end;

  // insere o numero das linhas
  for I := 1 to Num_Linhas do
    stg_analisador.Cells[0, I] := IntToStr(I);
end;

procedure TFAnalisadorLexico.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  slEntrada.Free;
  Action := caFree;
end;

procedure TFAnalisadorLexico.FormShow(Sender: TObject);
begin
  slEntrada := TStringList.Create;
  edt_entrada.SetFocus;
end;

procedure TFAnalisadorLexico.IncluirDados(palavra:string);
var Linha, Coluna, iTam: integer;
    sTemp: string;
begin
  iTam := Length(palavra);

  for Linha := 1 to iTam do
  begin
    for Coluna := 1 to stg_analisador.ColCount do
    begin
      // Encontra Coluna do caractere
      if (stg_analisador.Cells[Coluna, 0] = palavra[Linha]) then
      begin
        stg_analisador.Cells[Coluna, Linha] := IntToStr(Linha);
        if (Linha = iTam) then
        begin
          sTemp := copy(stg_analisador.Cells[0, Linha],
            Length(stg_analisador.Cells[0, Linha]), 1);

          if stemp <> '*' then
            stg_analisador.Cells[0, Linha] := stg_analisador.Cells[0, Linha] + '*';
        end;
      end;
    end;
  end;
end;

end.
