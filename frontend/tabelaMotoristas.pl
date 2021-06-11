tbl_motoristas(_Pedido) :-
    reply_html_page(
        bootstrap,
        [title('Tabela')], 
        [
            table([class='table table-bordered'],
                [
                    thead([], [
                        tr([],[
                            th([scope="col"], "#Id"),
                            th([scope="col"], "Nome"),
                            th([scope="col"], "CPF"),
                            th([scope="col"], "Num de CNH"),
							th([scope="col"], "Data da primeira Habilitacao")
                        ]) ]),
                    tbody([], \corpo_tabela_moto)
                ]),
            div([], [a([class='btn btn-primary', href='/', style='width: 150px'], 'Voltar ao inicio')])
        ]).

corpo_tabela_moto -->
    {
        findall( tr([th(scope(row), Id), td(Nome), td(Cpf), td(Num_cnh), td(Data_pri_habili), td(Acoes)]),
                 linha(Id, Nome, Cpf, Num_cnh, Data_pri_habili,Acoes),
                 Linhas )
    },
    html(Linhas).


linha(Id, Nome, Cpf, Num_cnh, Data_pri_habili,Acoes):-
    motoristas(Id, Nome, Cpf, Num_cnh, Data_pri_habili),
    acoesM(Id,Acoes).


acoesM(Id, Campo):-
    Campo = [ a([ class('text-success'), title('Alterar'),
                  href('/motoristas/editar/~w' - Id),
                  'data-toggle'(tooltip)],
                [ \lapis ]),
              a([ class('text-danger ms-1'), title('Excluir'),
                    href('/motoristas/apagar/~w' - Id),
                  'data-toggle'(tooltip)],
                [ \lixeira ])
            ].

apagarMotoristas(AtomId,_Pedido) :-
    atom_number(AtomId, Id), motoristas:remove(Id), tbl_motoristas(_).

editarMotoristas(AtomId,_Pedido) :-
    atom_number(AtomId, Id),
    (motoristas(Id, Nome, Cpf, Num_cnh, Data_pri_habili) ->
    reply_html_page(
        bootstrap,
        [title('Atualiza Cadastro Motoristas')], 
        [
            h1([class='row mx-3 p'],'Formulário 4'), p([],[]),
            h2([class='row mx-5 px-5 w-50 text-primary'],'Cadastrar motoristas'), p([],[]),
            form([action='/editarF4', method='POST'],
                  [ div([class='row justify-content-start mx-3'],
                        [
                        div([class='col'],[div([class='form-floating mb-3'],
                            [ input([type=text, class='form-control', style='max-width:75px', id='floatingInputGrid',value=AtomId,readonly,name=id]),
                            label([for=id],' Id') ]) ])
                        ]),
                    div([class='row justify-content-start mx-3'],
                          [
                          div([class='col'],[div([class='form-floating mb-3'],
                              [ input([type=textarea, class='form-control', style='max-width:300px', id='floatingInputGrid',value=Nome,name=nome]),
                                label([for='floatingInputGrid'],' Nome') ]) ])
                          ]),
                    div([class='row justify-content-start mx-3'],
                          [
                          div([class='col'],[div([class='form-floating mb-3'],
                              [ input([type=textarea, class='form-control', style='max-width: 200px', id='floatingInputGrid',value=Cpf,name=cpf]),
                                label([for='floatingInputGrid'],' CPF') ]) ])
                          ]),
                    div([class='row justify-content-start mx-3'],
                          [
                          div([class='col'],[div([class='form-floating mb-3'],
                              [ input([type=textarea, class='form-control', style='max-width: 400px', id='floatingInputGrid',value=Num_cnh,name=num_cnh]),
                                label([for='floatingInputGrid'],' Numero do CNH do Motorista') ]) ])
                          ]),
					div([class='row justify-content-start mx-3'],
                          [
                          div([class='col'],[div([class='form-floating mb-3'],
                              [ input([type=textarea, class='form-control', style='max-width: 400px', id='floatingInputGrid',value=Data_pri_habili,name=data_pri_habili]),
                                label([for='floatingInputGrid'],' Data da Primeira Habilitacao') ]) ])
                          ]),
                    div([class='row justify-content-start mx-3'],
                       [
                       div([class='col-md-2'],
                          input([class='btn btn-success', style='width: 150px',name=submit, type=submit, value='Enviar'],
                                [])),
                       div([class='col-md-2'], [a([class='btn btn-primary', href='/', style='width: 150px'], 'Voltar ao início')])
                       ])
                                                ])
        ])
    ). 