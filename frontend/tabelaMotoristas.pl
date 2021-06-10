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
    acoes(Id,Acoes).


acoes(Id, Campo):-
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

lapis -->
    html(svg([ xmlns('http://www.w3.org/2000/svg'),
               width(16),
               height(16),
               fill(currentColor),
               class('bi bi-pencil'),
               viewBox('0 0 16 16')
             ],
             path(d(['M12.146.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-10 10a.5.5 0 0',
             ' 1-.168.11l-5 2a.5.5 0 0 1-.65-.65l2-5a.5.5 0 0 1 .11-.168l10-10zM11.207 2.5',
             ' 13.5 4.793 14.793 3.5 12.5 1.207 11.207 2.5zm1.586 3L10.5 3.207 4',
             ' 9.707V10h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.293l6.5-6.5zm-9.761',
             ' 5.175-.106.106-1.528 3.821 3.821-1.528.106-.106A.5.5 0 0 1 5',
             ' 12.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.468-.325z']),
                  []))).

lixeira -->
    html(svg([ xmlns('http://www.w3.org/2000/svg'),
               width(16),
               height(16),
               fill(currentColor),
               class('bi bi-trash'),
               viewBox('0 0 16 16')
             ],
             [ path(d(['M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1',
                       ' .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5',
                       ' 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z']),
                    []),
               path(['fill-rule'(evenodd),
                     d(['M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0',
                        ' 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1',
                        ' 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4 4',
                        ' 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882',
                        ' 4H4.118zM2.5 3V2h11v1h-11z'])],
                    [])])).