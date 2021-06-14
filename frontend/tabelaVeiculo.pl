tbl_veiculo(_Pedido) :-
    reply_html_page(
        bootstrap,
        [title('Tabela')], 
        [
            \tabela_veiculos,
            div([class='row justify-content-center mx-3'],
            [
                div([class='col-md-2'],
                [
                    a([class='btn btn-primary', href='/', style='width: 150px'], 'Voltar ao inicio')])
            ])
        ]).

tabela_veiculos --> 
    html(
            div([class='row justify-content-center mx-3'],[
            table([class='table table-striped table-bordered table-condensed table-hover'],
                [
                    thead([], [
                        tr([],[
                            th([scope="col"], "#Id"),
                            th([scope="col"], "Ano"),
                            th([scope="col"], "Marca"),
                            th([scope="col"], "Modelo"),
                            th([scope="col"], "Placa")
                        ]) ]),
                    tbody([], \corpo_tabela_vei)
                ]) ])
        ).

corpo_tabela_vei -->
    {
        findall( tr([th(scope(row), Id),
                        td(Ano),
                        td(Marca),
                        td(Modelo),
                        td(Placa),
                        td(Acoes)]),
                 linhaVeic(Id, Ano, Marca, Modelo, Placa, Acoes),
                 Linhas )
    },
    html(Linhas).


linhaVeic(Id, Ano, Marca, Modelo, Placa, AcoesV):-
    veiculo(Id, Ano, Marca, Modelo, Placa),
    acoesVeic(Id,AcoesV).


acoesVeic(Id, Campo):-
    Campo = [ a([ class('text-success'), title('Alterar'),
                  href('/veiculo/editar/~w' - Id),
                  'data-toggle'(tooltip)],
                [ \lapis ]),
              a([ class('text-danger ms-1'), title('Excluir'),
                    href('/veiculo/apagar/~w' - Id),
                  'data-toggle'(tooltip)],
                [ \lixeira ])
            ].

editarVeiculo(AtomId,_Pedido) :-
    atom_number(AtomId, Id),
    (veiculo(Id, Ano, Marca, Modelo, Placa) ->
    reply_html_page(
            bootstrap,
            [title('Atualiza Cadastro Veiculo')],
            [h1([class='row mx-3 p'],'Formulario 3'), p([],[]),
            h2([class='row mx-5 px-5 w-50 text-primary'],'Cadastrar veiculos'), p([],[]),
            form([action='/editarF3', method='POST'],
                [ div([class='row justify-content-start mx-3'],
                    [
                    div([class='col'],[div([class='form-floating mb-3'],
                        [ input([type=text, class='form-control', style='max-width:75px', id='floatingInputGrid',value=AtomId,readonly,name=id]),
                        label([for=id],'Id') ]) ])
                    ]),
                    div([class='row justify-content-start mx-3'],
                        [
                        div([class='col-md-4'],[div([class='form-floating mb-3'],
                            [ input([type=textarea, class='form-control', style='min-width:200px max-width:450px', id='floatingInputGrid',value=Ano,name=ano]),
                                label([for='floatingInputGrid'],'Ano') ]) ]),
                        div([class='col-md-4'],[div([class='form-floating mb-3'],
                            [ input([type=textarea, class='form-control', style='max-width: 220px', id='floatingInputGrid',value=Marca,name=marca]),
                                label([for='floatingInputGrid'],'Marca') ]) ])
                        ]),
                    div([class='row justify-content-start mx-3'],
                        [
                        div([class='col-md-3'],[div([class='form-floating mb-3'],
                            [ input([type=textarea, class='form-control', style='max-width: 350px', id='floatingInputGrid',value=Modelo,name=modelo]),
                                label([for='floatingInputGrid'],'Modelo') ]) ]),
                        div([class='col-md-3'],[div([class='form-floating mb-3'],
                            [ input([type=textarea, class='form-control', style='max-width: 200px', id='floatingInputGrid',value=Placa,name=placa]),
                                label([for='floatingInputGrid'],'Placa') ]) ])
                        ]),
                    div([class='row justify-content-start mx-3'],
						[
                        p([class='col-md-2 mb-3 p-3'],
                        input([class='btn btn-success', style='width: 150px',name=submit, type=submit, value='Enviar'],
                                [])),
                       div([class='col-md-2'], [a([class='btn btn-primary', href='/', style='width: 150px'], 'Voltar ao inicio')])
                       ])	
                                                    ])
        ])
        ).

apagarVeiculo(AtomId,_Pedido) :-
    atom_number(AtomId, Id), veiculo:remove(Id), tbl_veiculo(_).