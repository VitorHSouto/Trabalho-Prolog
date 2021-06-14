% http_read_data está aqui
:- use_module(library(http/http_client)).

tbl_viagens(_Pedido) :-
    reply_html_page(
        bootstrap,
        [title('Tabela')],
        [
            \tabela_viagens,
            div([class='row justify-content-center mx-3'],
            [
                div([class='col-md-2'],
                [
                    a([class='btn btn-primary', href='/', style='width: 150px'], 'Voltar ao inicio')
                ])
            ])
        ]).

tabela_viagens --> 
    html(
            div([class='row justify-content-center mx-3'],[
            table([class='table table-striped table-bordered table-condensed table-hover'],
                [
                    thead([], [
                        tr([],[
                            th([scope="col"], "#Id"),
                            th([scope="col"], "Origem"),
                            th([scope="col"], "Destino"),
                            th([scope="col"], "Dia inicio"),
                            th([scope="col"], "Mes inicio"),
                            th([scope="col"], "Ano inicio"),
                            th([scope="col"], "Dia final"),
                            th([scope="col"], "Mes final"),
                            th([scope="col"], "Ano final"),
                            th([scope="col"], "SIGA"),
                            th([scope="col"], "SCPD"),
                            th([scope="col"], "Km Inicial"),
                            th([scope="col"], "Km Final"),
                            th([scope="col"], "Hora Saida"),
                            th([scope="col"], "Hora Chegada"),
                            th([scope="col"], "Id Veiculo"),
                            th([scope="col"], "Id Motorista"),
                            th([scope="col"], "Id Local")
                        ]) ]),
                    tbody([], \corpo_tabela_viag)
                ])
            ])
        ).

corpo_tabela_viag -->
    {
        findall( tr([th(scope(row), Id), td(Origem), td(Destino), 
                                td(DInicio), td(MInicio), td(AInicio), 
                                td(DFinal), td(MFinal), td(AFinal), 
                                td(Siga), td(Scpd), td(KmInicio), td(KmFinal), 
                                td(HrSaida), td(HrChegada), td(IdVeic), td(IdMot), td(IdLoc),
                                td(Acoes)]),
                 linhaViag(Id, _Data, Origem, Destino, DInicio, MInicio, AInicio, DFinal, MFinal, AFinal,
                    Siga, Scpd, KmInicio, KmFinal, HrSaida, HrChegada, _KmUtilizado, _Obs, IdVeic, IdMot, IdLoc, Acoes),
                 Linhas )
    },
    html(Linhas).


linhaViag(Id, Data, Origem, Destino, DInicio, MInicio, AInicio, DFinal, MFinal, AFinal,
    Siga, Scpd, KmInicio, KmFinal, HrSaida, HrChegada, KmUtilizado, Obs, IdVeic, IdMot, IdLoc, Acoes):-
    viagens(Id, Data, Origem, Destino, DInicio, MInicio, AInicio, DFinal, MFinal, AFinal,
        Siga, Scpd, KmInicio, KmFinal, HrSaida, HrChegada, KmUtilizado, Obs, IdVeic, IdMot, IdLoc),
    acoesViag(Id,Acoes).


acoesViag(Id, Campo):-
    Campo = [ a([ class('text-success'), title('Alterar'),
                  href('/viagens/editar/~w' - Id),
                  'data-toggle'(tooltip)],
                [ \lapis ]),
              a([ class('text-danger ms-1'), title('Excluir'),
                    href('/viagens/apagar/~w' - Id),
                  'data-toggle'(tooltip)],
                [ \lixeira ])
            ].

apagarViagem(AtomId,_Pedido) :-
    atom_number(AtomId, Id), viagens:remove(Id), tbl_viagens(_).

editarViagem(AtomId,_Pedido) :-
    atom_number(AtomId, Id),
    (viagens(Id, _, _, _, _DInicio, _MInicio, _AInicio, _DFinal, _MFinal, _AFinal,
        Siga, Scpd, KmInicio, KmFinal, HSaida, HChegada, KmUtilizado, Obs, _, _, _)) ->
    reply_html_page(
        bootstrap,
        [title('Atualiza Cadastro Alocacao')],
        [
            h1([class='row mx-3 p'],'Formulario 6 - EDITAR'), p([],[]),
            h2([class='row mx-5 px-5 w-50 text-primary'],'Editar Alocacao'), p([],[]),
            form([action='/editarF5', method='POST'], 
            [
                div([class='col'],[div([class='form-floating mb-3'],
                            [ input([type=text, class='form-control', style='max-width:75px', id='floatingInputGrid',value=AtomId,readonly,name=id]),
                            label([for=id],'Id') ]) ]),
                \form_viagens(Id, _, _, _, _, _, _, _, _, _,
                Siga, Scpd, KmInicio, KmFinal, HSaida, HChegada, KmUtilizado, Obs, _, _, _)
            ])
        ]).