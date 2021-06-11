:- consult(tabelaAlocacao).

form6(_Pedido) :-
    reply_html_page(
        bootstrap,
        [title('Formulario 6')],
        [h1([class='row mx-3 p'],'Formulario 6'), p([],[]),
         h2([class='row mx-5 px-5 w-50 text-primary'],'Requisicao de locacao de veiculos'), p([],[]),
        form([action='/receptorF6', method='POST'], div([], [\form_alocacao('','','','')])
           )
         ]).

form_alocacao(DSaida,HSaida,DRetorno,Obs) -->
    {},
    html(
            div([],[
            %%% MOTORISTA
            div([class='form-floating col-md-2'], [
                select([class='form-select',name='motorista', value='Com motoristar', id='floatingSelectGrid'],
                [option([id='floatingSelectGrid', value='Com motorista'], 'Com motorista'),
                option([id='floatingSelectGrid', value='Sem motorista'], 'Sem motorista') ]),
                label([class='mx-2',for="floatingSelectGrid"],'Motorista')]),
            %%% Qt. Veiculos
            div([class='form-floating col-md-2'], [
                select([class='form-select',name='qtVeic', value='1', id='floatingSelectGrid'],
                [option([id='floatingSelectGrid', value='1'], '1'),
                option([id='floatingSelectGrid', value='2'], '2'),
                option([id='floatingSelectGrid', value='3'], '3'),
                option([id='floatingSelectGrid', value='4'], '4'),
                option([id='floatingSelectGrid', value='5'], '5') ]),
                label([class='mx-2',for="floatingSelectGrid"],'Qt. Veiculos')]),
            %%%% Label VIAJANTES %%%%
            div([class='form-floating col-md-2'], [
                select([class='form-select',name='viajante', value='Maria', id='floatingSelectGrid'],
                \viajantes_html),
                label([class='mx-2',for="floatingSelectGrid"],'Viajante')]),
            %%%% ADD VIAJANTE %%%%
            a([ class(['nav-link']),
            href('/form1')],
            'Adicionar viajante'),
            %%% Data SAIDA
            div([class='form-floating mb-3'],
                [input([type=date, type=textarea, class='form-control', value=DSaida, style='max-width: 350px', id='floatingInputGrid', placeholder=' 00/00/0000',name=data_saida]),
                label([for='floatingInputGrid'],'Data Saida') ]),
            %%% Horario SAIDA
            div([class='form-floating mb-3'],
                [input([type=textarea, class='form-control', value=HSaida, style='max-width:300px', id='floatingInputGrid',placeholder='--:--',name=hSaida]),
                label([for='floatingInputGrid'],'Horario de Saida') ]),
            %%% Data RETORNO
            div([class='form-floating mb-3'],
                [input([type=date, type=textarea, class='form-control', value=DRetorno, style='max-width: 350px', id='floatingInputGrid', placeholder=' 00/00/0000',name=data_retorno]),
                label([for='floatingInputGrid'],'Data Retorno') ]),
            %%% LOCAL DE SAIDA
            div([class='form-floating col-md-2'], [
                select([class='form-select',name='local_saida', value='Campus 1', id='floatingSelectGrid'],
                [option([id='floatingSelectGrid', value='Campus 1'], 'Campus 1'),
                option([id='floatingSelectGrid', value='Campus 2'], 'Campus 2'),
                option([id='floatingSelectGrid', value='Campus 3'], 'Campus 3'),
                option([id='floatingSelectGrid', value='Campus 4'], 'Campus 4'),
                option([id='floatingSelectGrid', value='Campus 5'], 'Campus 5') ]),
                label([class='mx-2',for="floatingSelectGrid"],'Local de saida')]),
            %%%% Label LOCAIS SAIDA %%%%
            div([class='form-floating col-md-2'], [
                select([class='form-select',name='lSaida', value='Cidade 1', id='floatingSelectGrid'],
                \locais_html),
                label([class='mx-2',for="floatingSelectGrid"],'Trajeto de')]),
            %%%% Label LOCAIS CHEGADA %%%%
            div([class='form-floating col-md-2'], [
                select([class='form-select',name='lRetorno', value='Cidade 1', id='floatingSelectGrid'],
                \locais_html),
                label([class='mx-2',for="floatingSelectGrid"],'Para')]),
            %%% OBSERVAÇÕES
            div([class='form-floating mb-3'],
                [input([type=textarea, class='form-control', value=Obs, style='height: 200px; width: 400px', id='floatingInputGrid', placeholder=' 00/00/0000',name=obs]),
                label([for='floatingInputGrid'],'Observacoes') ]),
            %%%%%% BOTOES
            div([class='row justify-content-start mx-3'],
                [
                div([class='col-md-2'],
                   input([class='btn btn-success', style='width: 150px',name=submit, type=submit, value='Enviar'], [])),
                div([class='col-md-2'], 
                    [a([class='btn btn-primary', href='/', style='width: 150px'], 'Voltar ao inicio')])
                ])
            ])
        ).

viajantes_html --> 
    {
        findall(
                    option([id='floatingSelectGrid', value=Nome],Nome),
                    viajantes(_Id, _Cpf, Nome, _Funcao, _Email, _Senha, _Nvl_acesso),
                    Linhas
               )
    },
    html(Linhas).

locais_html --> 
    {
        findall(
                    option([id='floatingSelectGrid', value=Cidade],Cidade),
                    locais(_Id,Cidade,_Cep,_End),
                    Linhas
               )
    },
    html(Linhas).

recebe_form6(post, Pedido) :-
      http_read_data(Pedido,
                      [motorista=Motorista, qtVeic=QtVeic, viajante=Viajante, data_saida=DSaida, hSaida=HSaida,
                      data_retorno=DRetorno, local_saida=LocSaida, lSaida=LSaida, lRetorno=LRetorno, obs=Obs, submit='Enviar']
                      , []),
      viajantes(IdViaj, _, Viajante, _, _, _, _),
      alocacao:insere(_,Motorista, QtVeic, IdViaj, DSaida, HSaida, DRetorno, LocSaida, LSaida, LRetorno, Obs),
      tbl_alocacao(_).

editar_form6(post, Pedido) :-
      http_read_data(Pedido,
                      [id=AtomId, motorista=Motorista, qtVeic=QtVeic, viajante=Viajante, data_saida=DSaida, hSaida=HSaida,
                      data_retorno=DRetorno, local_saida=LocSaida, lSaida=LSaida, lRetorno=LRetorno, obs=Obs, submit='Enviar']
                      , []),
      viajantes(IdViaj, _, Viajante, _, _, _, _),
      atom_number(AtomId, Id),
      alocacao:atualiza(Id, Motorista, QtVeic, IdViaj, DSaida, HSaida, DRetorno, LocSaida, LSaida, LRetorno, Obs),
      tbl_alocacao(_).
