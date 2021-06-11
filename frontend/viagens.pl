:- consult(tabelaLocais).

form5(_Pedido) :-
    reply_html_page(
        bootstrap,
        [title('Formulario 5')],
        [h1([class='row mx-3 p'],'Formulario 5'), p([],[]),
         h2([class='row mx-5 px-5 w-50 text-primary'],'Cadastrar viagens'), p([],[]),
         form([action='/receptorF5', method='POST'], \form_viagens)
            ]).

form_viagens -->
    {},
    html(
            div([],[
            %%%% Label LOCAIS ORIGEM %%%%
            div([class='form-floating col-md-2'], [
                select([class='form-select',name='origem', value='Cidade 1', id='floatingSelectGrid'],
                \locais_html),
                label([class='mx-2',for="floatingSelectGrid"],'Origem')]),
            %%%% Label LOCAIS DESTINO %%%%
            div([class='form-floating col-md-2'], [
                select([class='form-select',name='destino', value='Cidade 1', id='floatingSelectGrid'],
                \locais_html),
                label([class='mx-2',for="floatingSelectGrid"],'Destino')]),
            %%% Data SAIDA
            div([class='form-floating col-md-2'],
                [input([type=date, type=textarea, class='form-control'/*, value=DSaida*/, style='max-width: 350px', id='floatingInputGrid', placeholder=' 00/00/0000',name=data_inicio]),
                label([for='floatingInputGrid'],'Data inicio') ]),
            %%% Data RETORNO
            div([class='form-floating col-md-2'],
                [input([type=date, type=textarea, class='form-control'/*, value=DRetorno*/, style='max-width: 350px', id='floatingInputGrid', placeholder=' 00/00/0000',name=data_final]),
                label([for='floatingInputGrid'],'Data final') ]),
            %%%% Label VIAJANTES %%%%
            div([class='form-floating col-md-2'], [
                select([class='form-select',name='viajante', value='Maria', id='floatingSelectGrid'],
                \viajantes_html),
                label([class='mx-2',for="floatingSelectGrid"],'Viajante')]),
            %%%% ADD VIAJANTE %%%%
            a([ class(['nav-link']),
            href('/form1')],
            'Adicionar viajante'),
            %%% Qt. Diarias
            div([class='form-floating col-md-2'], [
                select([class='form-select',name='qtDia', value='1', id='floatingSelectGrid'],
                [option([id='floatingSelectGrid', value='1'], '1'),
                option([id='floatingSelectGrid', value='2'], '2'),
                option([id='floatingSelectGrid', value='3'], '3'),
                option([id='floatingSelectGrid', value='4'], '4'),
                option([id='floatingSelectGrid', value='5'], '5') ]),
                label([class='mx-2',for="floatingSelectGrid"],'Qt. Diárias')]),
            %%% Função
            div([class='form-floating col-md-2'], [
                select([class='form-select',name='funcao', value='Motorista', id='floatingSelectGrid'],
                [option([id='floatingSelectGrid', value='Passageiro'], 'Passageiro'),
                option([id='floatingSelectGrid', value='Motorista'], 'Motorista') ]),
                label([class='mx-2',for="floatingSelectGrid"],'Função')]),
            %%% NMR SIGA
            div([class='form-floating col-md-2'],
                [input([type=textarea, class='form-control', style='max-width:300px', id='floatingInputGrid',placeholder='1234',name=siga]),
                label([for='floatingInputGrid'],'Nmr SIGA') ]),
            %%% NMR SCPD
            div([class='form-floating col-md-2'],
                [input([type=textarea, class='form-control', style='max-width:300px', id='floatingInputGrid',placeholder='1234',name=scpd]),
                label([for='floatingInputGrid'],'Nmr SCDP') ]),
            %%% Km Inicial
            div([class='form-floating col-md-2'],
                [input([type=textarea, class='form-control', style='max-width:300px', id='floatingInputGrid',placeholder='1234',name=kmi]),
                label([for='floatingInputGrid'],'Km Inicial') ]),
            %%% Km Final
            div([class='form-floating col-md-2'],
                [input([type=textarea, class='form-control', style='max-width:300px', id='floatingInputGrid',placeholder='1234',name=kmf]),
                label([for='floatingInputGrid'],'Km Final') ]),
            %%% Horario SAIDA
            div([class='form-floating col-md-2'],
                [input([type=textarea, class='form-control', style='max-width:300px', id='floatingInputGrid',placeholder='--:--',name=hSaida]),
                label([for='floatingInputGrid'],'Horario de Saida') ]),
            %%% Horario Chegada
            div([class='form-floating col-md-2'],
                [input([type=textarea, class='form-control', style='max-width:300px', id='floatingInputGrid',placeholder='--:--',name=hChegada]),
                label([for='floatingInputGrid'],'Horario de Chegada') ]),
            %%%% Label MOTORISTAS %%%%
            div([class='form-floating col-md-2'], [
                select([class='form-select',name='motorista', value='Maria', id='floatingSelectGrid'],
                \motoristas_html),
                label([class='mx-2',for="floatingSelectGrid"],'Motorista')]),
            %%%% Label Veiculos %%%%
            div([class='form-floating col-md-2'], [
                select([class='form-select',name='veiculo', value='Ford HFV-1234', id='floatingSelectGrid'],
                \veiculos_html),
                label([class='mx-2',for="floatingSelectGrid"],'Veiculo')]),
            %%% Diarias Emp
            div([class='form-floating col-md-2'], [
                select([class='form-select',name='qtDiarias', value='1', id='floatingSelectGrid'],
                [option([id='floatingSelectGrid', value='1'], '1'),
                option([id='floatingSelectGrid', value='2'], '2'),
                option([id='floatingSelectGrid', value='3'], '3'),
                option([id='floatingSelectGrid', value='4'], '4'),
                option([id='floatingSelectGrid', value='5'], '5') ]),
                label([class='mx-2',for="floatingSelectGrid"],'Diarias Emp')]),
            %%% Km Uti
            div([class='form-floating col-md-2'],
                [input([type=textarea, class='form-control', style='max-width:300px', id='floatingInputGrid',placeholder='--:--',name=kmUl]),
                label([for='floatingInputGrid'],'Km Utilizado') ]),
            %%% OBSERVAÇÕES
            div([class='form-floating mb-3'],
                [input([type=textarea, class='form-control', style='height: 200px; width: 400px', id='floatingInputGrid', placeholder=' 00/00/0000',name=obs]),
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

motoristas_html --> 
    {
        findall(
                    option([id='floatingSelectGrid', value=Nome],Nome),
                    motoristas(_Id, Nome, _Cpf, _Num_cnh, _Data_pri_habili),
                    Linhas
               )
    },
    html(Linhas).

veiculos_html --> 
    {
        findall(
                    option([id='floatingSelectGrid', value=Marca],'~w ~w'-[Marca, Placa]),
                    veiculo(_Id, _Ano, Marca, _Modelo, Placa),
                    Linhas
               )
    },
    html(Linhas).

recebe_form5(post, Pedido) :-
      http_read_data(Pedido,
                      [origem=Origem,destino=Destino,data_inicio=DInicio,data_final=DFinal,viajante=Viajante,
                      qtDia=_QtDia,funcao=Funcao,siga=Siga,scpd=Scpd,kmi=Kmi,kmf=Kmf,hSaida=HSaida,hChegada=HChegada,
                      motorista=Motorista,veiculo=Veiculo,qtDiarias=AtomQtDiarias,kmUl=KmUl,obs=Obs,
                    submit='Enviar']
                      , []),
        devolve_data(DInicio,DI,MI,AI),
        devolve_data(DFinal,DF,MF,AF),
        veiculo(IdVeic, _Ano, Veiculo, _Modelo, _Placa),
        motoristas(IdMot, Motorista, _Cpf, _Num_cnh, _Data_pri_habili),
        locais(IdLoc,Destino,_,_),
        viagens:insere(Id_viagens,'Data',Origem,Destino,DI,MI,AI,DF,MF,AF,Siga,Scpd,Kmi,Kmf,
                        HSaida,HChegada,KmUl,Obs,IdVeic,IdMot,IdLoc),
        viajantes(Id_viajantes, _, Viajante, _, _, _, _),
        atom_number(AtomQtDiarias, QtDiarias),
        pessoaPorViagem:insere(_, Id_viagens, Id_viajantes, QtDiarias, Funcao),
        home(_).

devolve_data(Data,Dia,Mes,Ano) :-
    atom_chars(Data, [E1,E2,E3,E4,_E5,E6,E7,_E8,E9,E10]),
    atomic_concat(E9,E10,AtomDia), atom_number(AtomDia, Dia),
    atomic_concat(E6,E7,AtomMes), atom_number(AtomMes, Mes),
    atomic_concat(E1,E2,X1),atomic_concat(X1,E3,X2),atomic_concat(X2,E4,AtomAno),atom_number(AtomAno, Ano).

editar_form5(post, Pedido) :-
      http_read_data(Pedido,
                      [id=AtomId, city=Cidade, cep=Cep, address=End, submit='Enviar']
                      , []),
      atom_number(AtomId, Id),
      locais:atualiza(Id,Cidade,Cep,End),
      tbl_locais(_).
