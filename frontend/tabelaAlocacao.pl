% http_read_data está aqui
:- use_module(library(http/http_client)).

tbl_alocacao(_Pedido) :-
    reply_html_page(
        bootstrap,
        [title('Tabela')],
        [
            \tabela_alocacao,
            div([class='row justify-content-center mx-3'],
            [
                div([class='col-md-2'],
                [
                    a([class='btn btn-primary', href='/', style='width: 150px'], 'Voltar ao inicio')])
            ])
        ]).

tabela_alocacao -->
    html(
            div([class='row justify-content-center mx-3'],[
            div([class='d-flex justify-content-end mb-1'], 
                [a([class='btn btn-primary', href='/form6', style='width: 80px'], 'Novo')]),
            table([class='table table-striped table-bordered table-condensed table-hover'],
                [
                    thead([], [
                        tr([],[
                            th([scope="col"], "#Id"),
                            th([scope="col"], "Motorista"),
                            th([scope="col"], "Qt. Veic"),
                            th([scope="col"], "Id Viaj."),
                            th([scope="col"], "Data saida"),
                            th([scope="col"], "Horario saida"),
                            th([scope="col"], "Data Retorno"),
                            th([scope="col"], "Local Saida"),
                            th([scope="col"], "Trajeto Saida"),
                            th([scope="col"], "Trajeto Retorno")
                        ]) ]),
                    tbody([], \corpo_tabela_aloc)
                ]) ])
        ).

corpo_tabela_aloc -->
    {
        findall( tr([th(scope(row), Id), td(Motorista), td(QtVeic), 
                                td(IdViaj), td(DSaida), td(HSaida), td(DRetorno),
                                td(LocSaida), td(LSaida), td(LRetorno), td(Acoes)]),
                 linhaAloc(Id, Motorista, QtVeic, IdViaj, DSaida, HSaida, DRetorno, LocSaida, LSaida, LRetorno, Acoes),
                 Linhas )
    },
    html(Linhas).


linhaAloc(Id,Motorista, QtVeic, IdViaj, DSaida, HSaida, DRetorno, LocSaida, LSaida, LRetorno, Acoes):-
    alocacao(Id,Motorista, QtVeic, IdViaj, DSaida, HSaida, DRetorno, LocSaida, LSaida, LRetorno, _Obs),
    acoesAloc(Id,Acoes).


acoesAloc(Id, Campo):-
    Campo = [ a([ class('text-success'), title('Alterar'),
                  href('/alocacao/editar/~w' - Id),
                  'data-toggle'(tooltip)],
                [ \lapis ]),
              a([ class('text-danger ms-1'), title('Excluir'),
                    href('/alocacao/apagar/~w' - Id),
                  'data-toggle'(tooltip)],
                [ \lixeira ])
            ].

apagarAlocacao(AtomId,_Pedido) :-
    atom_number(AtomId, Id), alocacao:remove(Id), tbl_alocacao(_).

editarAlocacao(AtomId,_Pedido) :-
    atom_number(AtomId, Id),
    (alocacao(Id, _, _, _, DSaida, HSaida, DRetorno, _, _, _, Obs)) ->
    reply_html_page(
        bootstrap,
        [title('Atualiza Cadastro Alocacao')],
        [
            h1([class='row mx-3 p'],'Formulario 6 - EDITAR'), p([],[]),
            h2([class='row mx-5 px-5 w-50 text-primary'],'Editar Alocacao'), p([],[]),
            form([action='/editarF6', method='POST'], 
            [
                div([class='col'],[div([class='form-floating mb-3'],
                            [ input([type=text, class='form-control', style='max-width:75px', id='floatingInputGrid',value=AtomId,readonly,name=id]),
                            label([for=id],'Id') ]) ]),
                \form_alocacao(DSaida,HSaida,DRetorno,Obs)
            ])
        ]).