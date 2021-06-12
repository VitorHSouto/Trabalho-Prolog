:- consult(tabelaVeiculo).

form3(_Pedido) :-
    reply_html_page(
        bootstrap,
        [title('Formulario 3')],
        [h1([class='row mx-3 p'],'Formulario 3'), p([],[]),
         h2([class='row mx-5 px-5 w-50 text-primary'],'Cadastrar Veiculo'), p([],[]),
         form([action='/receptorF3', method='POST'],
               [
                 br([],[]),
                 br([],[]),
                  div([class='row justify-content-center mx-3'],
                  [
                       div([class='col-md-2'],[div([class='form-floating mb-3'],
                        [ input([type=textarea, class='form-control', style='max-width:300px', id='floatingInputGrid',placeholder=' 2021',name=ano]),
                        label([for='floatingInputGrid'],' Ano do Veiculo') ]) ])
                  ]),
                 div([class='row justify-content-center mx-3'],
                       [
                       div([class='col-md-2'],[div([class='form-floating mb-3'],
                           [ input([type=textarea, class='form-control', style='max-width: 200px', id='floatingInputGrid',placeholder=' Doege',name=marca]),
                             label([for='floatingInputGrid'],' Marca do Veiculo') ]) ])
                       ]),
                 div([class='row justify-content-center mx-3'],
                       [
                       div([class='col-md-2'],[div([class='form-floating mb-3'],
                           [ input([type=textarea, class='form-control', style='max-width: 400px', id='floatingInputGrid',placeholder=' Viper',name=modelo]),
                             label([for='floatingInputGrid'],' Modelo do Veiculo') ]) ])
                       ]),
				div([class='row justify-content-center mx-3'],
                       [
                       div([class='col-md-2'],[div([class='form-floating mb-3'],
                           [ input([type=textarea, class='form-control', style='max-width: 400px', id='floatingInputGrid',placeholder=' ABC-1234',name=placa]),
                             label([for='floatingInputGrid'],' Placa do Veiculo') ]) ])
                       ]),
                 br([],[]),
                 div([class='row justify-content-center mx-3'],
                    [
                    div([class='col-md-2'],
                       input([class='btn btn-success', style='width: 150px',name=submit, type=submit, value='Enviar'],
                             [])),
                    div([class='col-md-2'], [a([class='btn btn-primary', href='/', style='width: 150px'], 'Voltar ao inicio')])
                    ]),
                    br([],[])
               ])
        ]).

recebe_form3(post, Pedido) :-
      http_read_data(Pedido,
                      [ano=Ano, marca=Marca, modelo=Modelo, placa=Placa, submit='Enviar']
                      , []),
      veiculo:insere(_,Ano, Marca, Modelo, Placa),
      tbl_veiculo(_).

editar_form3(post, Pedido) :-
      http_read_data(Pedido,
                      [id=AtomId, ano=Ano, marca=Marca, modelo=Modelo, placa=Placa, submit='Enviar']
                      , []),
      atom_number(AtomId, Id),
      veiculo:atualiza(Id, Ano, Marca, Modelo, Placa),
      tbl_veiculo(_).
