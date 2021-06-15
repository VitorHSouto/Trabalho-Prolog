tbl_cadastros(_Pedido) :-
    reply_html_page(
        bootstrap,
        [title('Tabela')],
        [
            \titulo_da_tabela('Cadastros'),
            \tabela_usuarios,
            div([class='row justify-content-center mx-3'],
            [
                div([class='col-md-2'],
                [
                    a([class='btn btn-primary', href='/', style='width: 150px'], 'Voltar ao inicio')])
            ])
        ]).

tabela_usuarios --> 
    html(
            div([class='row justify-content-center mx-3'],[
            table([class='table table-striped table-bordered table-condensed table-hover'],
                [
                    thead([], [
                        tr([],[
                            th([scope="col"], "#Id"),
                            th([scope="col"], "Nome"),
                            th([scope="col"], "Email"),
                            th([scope="col"], "Funcao")
                        ]) ]),
                    tbody([], \corpo_tabela_user)
                ]) ])
        ).

corpo_tabela_user -->
    {
        findall( tr([th(scope(row), Id),
                        td(Nome),
                        td(Email),
                        td(Funcao),
                        td(Acoes)]),
                 linhaUser(Id, Nome, Funcao, Email, Acoes),
                 Linhas )
    },
    html(Linhas).


linhaUser(Id, Nome, Funcao, Email, AcoesUser):-
    usuario(Id, Nome, Email, _, _, _),
    funcao(Id_func,Funcao,_,_),
    usuario_funcao(_,Id,Id_func,_,_),
    acoesUser(Id,AcoesUser).


acoesUser(Id, Campo):-
    Campo = [ a([ class('text-success'), title('Alterar'),
                  href('/user/editar/~w' - Id),
                  'data-toggle'(tooltip)],
                [ \lapis ]),
              a([ class('text-danger ms-1'), title('Excluir'),
                    href('/user/apagar/~w' - Id),
                  'data-toggle'(tooltip)],
                [ \lixeira ])
            ].

apaga_usuario(AtomId,_Pedido) :-
    atom_number(AtomId, Id), 
    usuario:remove(Id), 
    usuario_funcao(Id_UF,Id,Id_func,_,_),
    usuario_funcao:remove(Id_UF),
    funcao:remove(Id_func),
    tabelas_adm(_).
