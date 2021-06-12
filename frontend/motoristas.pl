:- consult(tabelaMotoristas).

form4(_Pedido) :-
    reply_html_page(
        bootstrap,
        [title('Formulario 4')],
        [h1([class='row mx-3 p'],'Formulario 4'), p([],[]),
         h2([class='row mx-5 px-5 w-50 text-primary'],'Cadastrar motoristas'), p([],[]),
         form([action='/receptorF4', method='POST'],
               [ div([class='row justify-content-center mx-3'],
                       [
                       div([class='col-4'],[div([class='form-floating mb-3'],
                           [ input([type=textarea, class='form-control', style='min-width:200px max-width:450px', id='floatingInputGrid',placeholder=' Wanderlei Carvalho',name=nome]),
                             label([for='floatingInputGrid'],' Nome do Motorista') ]) ]),
                       div([class='col-4'],[div([class='form-floating mb-3'],
                           [ input([type=textarea, class='form-control', style='max-width: 220px', id='floatingInputGrid',placeholder=' 123.456.789-10',name=cpf]),
                             label([for='floatingInputGrid'],'CPF') ]) ])
                       ]),
                 div([class='row justify-content-center mx-3'],
                       [
                       div([class='col-3'],[div([class='form-floating mb-3'],
                           [ input([type=textarea, class='form-control', style='max-width: 350px', id='floatingInputGrid',placeholder=' 000000000000',name=num_cnh]),
                             label([for='floatingInputGrid'],' Numero do CNH do Motorista') ]) ]),
                       div([class='col-3'],[div([class='form-floating mb-3'],
                           [ input([type=date, type=textarea, class='form-control', style='max-width: 350px', id='floatingInputGrid',placeholder=' 00/00/0000',name=data_pri_habili]),
                             label([for='floatingInputGrid'],' Data da Primeira Habilitacao') ]) ])
                       ]),
                 div([class='row justify-content-center mx-3'],
                    [
                    div([class='col-2'],
                       input([class='btn btn-success', style='width: 150px',name=submit, type=submit, value='Enviar'],
                             [])),
                    div([class='col-2'], [a([class='btn btn-primary', href='/', style='width: 150px'], 'Voltar ao inicio')])
                    ]),
                 br([],[])
               ])
        ]).

recebe_form4(post, Pedido) :-
    http_read_data(Pedido,
                    [nome=Nome, cpf=Cpf, num_cnh=Num_cnh, data_pri_habili=Data_pri_habili, submit='Enviar']
                    , []),
	atom_number(Num_cnh, INum_cnh),
    motoristas:insere(_,Nome, Cpf, INum_cnh, Data_pri_habili),
    tbl_motoristas(_).

editar_form4(post, Pedido) :-
      http_read_data(Pedido,
                      [id=AtomId, nome=Nome, cpf=Cpf, num_cnh=Num_cnh, data_pri_habili=Data_pri_habili, submit='Enviar']
                      , []),
	  atom_number(Num_cnh, INum_cnh),
      atom_number(AtomId, Id),
      motoristas:atualiza(Id, Nome, Cpf, INum_cnh, Data_pri_habili),
      tbl_motoristas(_).
	  
