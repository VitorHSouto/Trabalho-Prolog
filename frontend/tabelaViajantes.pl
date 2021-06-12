tbl_viajantes(_Pedido) :-
    reply_html_page(
        bootstrap,
        [title('Tabela')],
        [
            table([class='table table-striped table-bordered table-condensed table-hover'],
                [
                    thead([], [
                        tr([],[
                            th([scope="col"], "#Id"),
                            th([scope="col"], "Cpf"),
                            th([scope="col"], "Nome"),
                            th([scope="col"], "Funcao"),
                            th([scope="col"], "Email"),
                            th([scope="col"], "Senha"),
                            th([scope="col"], "Nivel de acesso")
                        ]) ]),
                    tbody([], \corpo_tabela_via)
                ]),
            div([class='row justify-content-center mx-3'],
            [
                div([class='col-md-2'],
                [
                    a([class='btn btn-primary', href='/', style='width: 150px'], 'Voltar ao inicio')])
            ])
        ]).


corpo_tabela_via -->
    {
        findall( tr([th(scope(row), Id),
                        td(Cpf),
                        td(Nome),
                        td(Funcao),
                        td(Email),
                        td(Senha),
                        td(Nvl_acesso),
                        td(Acoes)]),
                 linhaV(Id, Cpf, Nome, Funcao, Email, Senha, Nvl_acesso, Acoes),
                 Linhas )
    },
    html(Linhas).


linhaV(Id, Cpf, Nome, Funcao, Email, Senha, Nvl_acesso, AcoesV):-
    viajantes(Id, Cpf, Nome, Funcao, Email, Senha, Nvl_acesso),
    acoesV(Id,AcoesV).


acoesV(Id, Campo):-
    Campo = [ a([ class('text-success'), title('Alterar'),
                  href('/viajantes/editar/~w' - Id),
                  'data-toggle'(tooltip)],
                [ \lapis ]),
              a([ class('text-danger ms-1'), title('Excluir'),
                    href('/viajantes/apagar/~w' - Id),
                  'data-toggle'(tooltip)],
                [ \lixeira ])
            ].

editarViajantes(AtomId,_Pedido) :-
    atom_number(AtomId, Id),
    (viajantes(Id, Cpf, Nome, Funcao, Email, Senha, _Nvl_acesso) ->
    reply_html_page(
            bootstrap,
            [title('Editar Formul�rio 1')],
            [h1([class='row mx-3 p'],'Formul�rio 1'), p([],[]),
            h2([class='row mx-5 px-5 w-50 text-primary'],'Cadastrar viajantes'), p([],[]),
            form([action='/editarF1', method='POST'],
                [ div([class='row justify-content-start mx-3'],
                    [
                    div([class='col'],[div([class='form-floating mb-3'],
                        [ input([type=text, class='form-control', style='max-width:75px', id='floatingInputGrid',value=AtomId,readonly,name=id]),
                        label([for=id],'Id') ]) ])
                    ]),
                    div([class='row justify-content-start mx-3'],
                        [
                        div([class='col-md-4'],[div([class='form-floating mb-3'],
                            [ input([type=textarea, class='form-control', style='min-width:200px max-width:450px', id='floatingInputGrid',value=Nome,name=name]),
                                label([for='floatingInputGrid'],'Nome') ]) ]),
                        div([class='col-md-4'],[div([class='form-floating mb-3'],
                            [ input([type=textarea, class='form-control', style='max-width: 220px', id='floatingInputGrid',value=Cpf,name=cpf]),
                                label([for='floatingInputGrid'],'CPF') ]) ])
                        ]),
                    div([class='row justify-content-start mx-3'],
                        [
                        div([class='col-md-3'],[div([class='form-floating mb-3'],
                            [ input([type=textarea, class='form-control', style='max-width: 350px', id='floatingInputGrid',value=Email,name=email]),
                                label([for='floatingInputGrid'],'Email') ]) ]),
                        div([class='col-md-3'],[div([class='form-floating mb-3'],
                            [ input([type='password', type=textarea, class='form-control', style='max-width: 200px', id='floatingInputGrid',value=Senha,name=senha]),
                                label([for='floatingInputGrid'],'Senha') ]) ])
                        ]),
                    div([class='row justify-content-start mx-3'],
                        [div([class='form-floating col-md-2'],
                            [select([class='form-select',style='max-width: 300px',name='funcao', value='Servidor', id='floatingSelectGrid'],
                            [option([id='floatingSelectGrid', value='Colaborador'], 'Coloborador Enventual'),
                                option([id='floatingSelectGrid', value='Servidor'], 'Servidor'),
                                option([id='floatingSelectGrid', value='Tutor'], 'Tutor') ]),
                            label([class='mx-2',for="floatingSelectGrid",value=Funcao],'Escolha a func�o') ]),
                        p([class='col-md-2 mb-3 p-3'],
                        input([class='btn btn-success', style='width: 150px',name=submit, type=submit, value='Enviar'],
                                []))
                        ]),
                    p([class='mx-3 px-2'], [a([class='btn btn-primary', href='/', style='width: 200px'], 'Voltar ao início')])
                                                    ])]
        )
        ).

apagarViajantes(AtomId,_Pedido) :-
    atom_number(AtomId, Id), viajantes:remove(Id), tbl_viajantes(_).
