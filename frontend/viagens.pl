:- consult(tabelaViagens).

form5(_Pedido) :-
    reply_html_page(
        bootstrap,
        [title('Formulario 5')],
        [h1([class='row mx-3 p'],'Formulario 5'), p([],[]),
         h2([class='row mx-5 px-5 w-50 text-primary'],'Cadastrar viagens'), p([],[]),
         form([action='/receptorF5', method='POST'], 
             \form_viagens('', '', '', '', '', '', '', '', '', '',
            '', '', '', '', '', '', '', '', '', '', ''))
            ]).

form_viagens(_, _, _, _, _DInicio, _MInicio, _AInicio, _DFinal, _MFinal, _AFinal,
    Siga, Scpd, KmInicio, KmFinal, HSaida, HChegada, KmUtilizado, Obs, _, _, _) -->
    {},
    html(
            div([],
            [
            %%%% Label LOCAIS ORIGEM %%%%
            br([],[]),
            div([class='row justify-content-center mx-3'],
            [
            div([class='form-floating col-4'], [
                select([class='form-select',name=origem, value='Cidade 1', id='floatingSelectGrid'],
                \locais_html),
                label([class='mx-2',for="floatingSelectGrid"],' Origem')])
            ]),
            %%%% Label LOCAIS DESTINO %%%%
            br([],[]),
            div([class='row justify-content-center mx-3'],
            [
            div([class='form-floating col-4'], [
                select([class='form-select',name=destino, value='Cidade 1', id='floatingSelectGrid'],
                \locais_html),
                label([class='mx-2',for="floatingSelectGrid"],' Destino')])
            ]),
            %%% Data SAIDA
            br([],[]),
            div([class='row justify-content-center mx-3'],
            [
            div([class='form-floating col-4'],
                [input([type=date, type=textarea, class='form-control'/*, value=DSaida*/, style='max-width: 350px', id='floatingInputGrid', placeholder=' 00/00/0000',name=data_inicio]),
                label([for='floatingInputGrid'],' Data inicio') ])
            ]),
            %%% Data RETORNO
            br([],[]),
            div([class='row justify-content-center mx-3'],
            [
            div([class='form-floating col-4'],
                [input([type=date, type=textarea, class='form-control'/*, value=DRetorno*/, style='max-width: 350px', id='floatingInputGrid', placeholder=' 00/00/0000',name=data_final]),
                label([for='floatingInputGrid'],' Data final') ])
            ]),
            %%%% Label VIAJANTES %%%%
            br([],[]),
            div([class='row justify-content-center mx-3'],
            [
            div([class='form-floating col-4'], [
                select([class='form-select',name='viajante', value='Maria', id='floatingSelectGrid'],
                \viajantes_html),
                label([class='mx-2',for="floatingSelectGrid"],' Viajante')])
            ]),
            %%%% ADD VIAJANTE %%%%
            br([],[]),
            a([ class(['flex-sm-fill text-sm-center nav-link']),
            href('/form1')],
            'Adicionar viajante'),
            %%% Qt. Diarias
            br([],[]),
            div([class='row justify-content-center mx-3'],
            [
            div([class='form-floating col-4'], [
                select([class='form-select',name='qtDia', value='1', id='floatingSelectGrid'],
                [option([value='1'], '1'),
                option([value='2'], '2'),
                option([value='3'], '3'),
                option([value='4'], '4'),
                option([value='5'], '5') ]),
                label([class='mx-2',for="floatingSelectGrid"],' Qt. Diarias')])
            ]),
            %%% Função
            br([],[]),
            div([class='row justify-content-center mx-3'],
            [
            div([class='form-floating col-4'], [
                select([class='form-select',name='funcao', value='Motorista', id='floatingSelectGrid'],
                [option([id='floatingSelectGrid', value='Passageiro'], 'Passageiro'),
                option([id='floatingSelectGrid', value='Motorista'], 'Motorista') ]),
                label([class='mx-2',for="floatingSelectGrid"],'Funcao')])
            ]),
            %%% NMR SIGA
            br([],[]),
            div([class='row justify-content-center mx-3'],
            [
            div([class='form-floating col-4'],
                [input([type=textarea, class='form-control', style='max-width:300px', value=Siga, id='floatingInputGrid',placeholder='1234',name=siga]),
                label([for='floatingInputGrid'],' Nmr SIGA') ])
            ]),
            %%% NMR SCPD
            br([],[]),
            div([class='row justify-content-center mx-3'],
            [
            div([class='form-floating col-4'],
                [input([type=textarea, class='form-control', style='max-width:300px', value=Scpd, id='floatingInputGrid',placeholder='1234',name=scpd]),
                label([for='floatingInputGrid'],' Nmr SCDP') ])
            ]),
            %%% Km Inicial
            br([],[]),
            div([class='row justify-content-center mx-3'],
            [
            div([class='form-floating col-4'],
                [input([type=textarea, class='form-control', style='max-width:300px', value=KmInicio, id='floatingInputGrid',placeholder='1234',name=kmi]),
                label([for='floatingInputGrid'],' Km Inicial') ])
            ]),
            %%% Km Final
            br([],[]),
            div([class='row justify-content-center mx-3'],
            [
            div([class='form-floating col-4'],
                [input([type=textarea, class='form-control', style='max-width:300px', value=KmFinal, id='floatingInputGrid',placeholder='1234',name=kmf]),
                label([for='floatingInputGrid'],' Km Final') ])
            ]),
            %%% Horario SAIDA
            br([],[]),
            div([class='row justify-content-center mx-3'],
            [
            div([class='form-floating col-4'],
                [input([type=textarea, class='form-control', style='max-width:300px', value=HSaida, id='floatingInputGrid',placeholder='--:--',name=hSaida]),
                label([for='floatingInputGrid'],' Horario de Saida') ])
            ]),
            %%% Horario Chegada
            br([],[]),
            div([class='row justify-content-center mx-3'],
            [
            div([class='form-floating col-4'],
                [input([type=textarea, class='form-control', style='max-width:300px', value=HChegada, id='floatingInputGrid',placeholder='--:--',name=hChegada]),
                label([for='floatingInputGrid'],' Horario de Chegada') ])
            ]),
            %%%% Label MOTORISTAS %%%%
            br([],[]),
            div([class='row justify-content-center mx-3'],
            [
            div([class='form-floating col-4'], [
                select([class='form-select',name='motorista', value='Maria', id='floatingSelectGrid'],
                \motoristas_html),
                label([class='mx-2',for="floatingSelectGrid"],' Motorista')])
            ]),
            %%%% Label Veiculos %%%%
            br([],[]),
            div([class='row justify-content-center mx-3'],
            [
            div([class='form-floating col-4'], [
                select([class='form-select',name='veiculo', value='Ford HFV-1234', id='floatingSelectGrid'],
                \veiculos_html),
                label([class='mx-2',for="floatingSelectGrid"],' Veiculo')])
            ]),
            %%% Diarias Emp
            br([],[]),
            div([class='row justify-content-center mx-3'],
            [
            div([class='form-floating col-4'], [
                select([class='form-select',name='qtDiarias', value='1', id='floatingSelectGrid'],
                [option([id='floatingSelectGrid', value='1'], '1'),
                option([id='floatingSelectGrid', value='2'], '2'),
                option([id='floatingSelectGrid', value='3'], '3'),
                option([id='floatingSelectGrid', value='4'], '4'),
                option([id='floatingSelectGrid', value='5'], '5') ]),
                label([class='mx-2',for="floatingSelectGrid"],' Diarias Emp')])
            ]),
            %%% Km Uti
            br([],[]),
            div([class='row justify-content-center mx-3'],
            [
            div([class='form-floating col-4'],
                [input([type=textarea, class='form-control', style='max-width:300px', value=KmUtilizado, id='floatingInputGrid',placeholder='--:--',name=kmUl]),
                label([for='floatingInputGrid'],' Km Utilizado') ])
            ]),
            %%% OBSERVAÇÕES
            br([],[]),
            div([class='row justify-content-center mx-3'],
            [
                div([class='form-floating col-4'],
                    [input([type=textarea, class='form-control', style='height: 200px; width: 400px', value=Obs, id='floatingInputGrid', placeholder=' Exemplo',name=obs]),
                    label([for='floatingInputGrid'],' Observacoes') 
                ])
            ]),
            %%%%%% BOTOES
            br([],[]),
            div([class='row justify-content-center mx-3'],
                [
                div([class='col-md-2'],
                   input([class='btn btn-success', style='width: 150px',name=submit, type=submit, value='Enviar'], [])),
                div([class='col-md-2'], 
                    [a([class='btn btn-primary', href='/administrador', style='width: 150px'], 'Voltar as Tabelas')])
                ]),
                br([],[])
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
        get_time(T),
        atom_number(AtomT, T),
        viagens:insere(Id_viagens,AtomT,Origem,Destino,DI,MI,AI,DF,MF,AF,Siga,Scpd,Kmi,Kmf,
                        HSaida,HChegada,KmUl,Obs,IdVeic,IdMot,IdLoc),
        viajantes(Id_viajantes, _, Viajante, _, _, _, _),
        atom_number(AtomQtDiarias, QtDiarias),
        pessoaPorViagem:insere(_, Id_viagens, Id_viajantes, QtDiarias, Funcao),
        tbl_viagens(_).

devolve_data(Data,Dia,Mes,Ano) :-
    atom_chars(Data, [E1,E2,E3,E4,_E5,E6,E7,_E8,E9,E10]),
    atomic_concat(E9,E10,AtomDia), atom_number(AtomDia, Dia),
    atomic_concat(E6,E7,AtomMes), atom_number(AtomMes, Mes),
    atomic_concat(E1,E2,X1),atomic_concat(X1,E3,X2),atomic_concat(X2,E4,AtomAno),atom_number(AtomAno, Ano).

editar_form5(post, Pedido) :-
      http_read_data(Pedido,
                      [id=AtomId,origem=Origem,destino=Destino,data_inicio=DInicio,data_final=DFinal,viajante=Viajante,
                      qtDia=_QtDia,funcao=Funcao,siga=Siga,scpd=Scpd,kmi=Kmi,kmf=Kmf,hSaida=HSaida,hChegada=HChegada,
                      motorista=Motorista,veiculo=Veiculo,qtDiarias=AtomQtDiarias,kmUl=KmUl,obs=Obs,
                    submit='Enviar']
                      , []),
        devolve_data(DInicio,DI,MI,AI),
        devolve_data(DFinal,DF,MF,AF),
        veiculo(IdVeic, _Ano, Veiculo, _Modelo, _Placa),
        motoristas(IdMot, Motorista, _Cpf, _Num_cnh, _Data_pri_habili),
        locais(IdLoc,Destino,_,_),
        get_time(T),
        atom_number(AtomT, T),
        atom_number(AtomId, Id),
        viagens:atualiza(Id,AtomT,Origem,Destino,DI,MI,AI,DF,MF,AF,Siga,Scpd,Kmi,Kmf,
                        HSaida,HChegada,KmUl,Obs,IdVeic,IdMot,IdLoc),
        viajantes(Id_viajantes, _, Viajante, _, _, _, _),
        atom_number(AtomQtDiarias, QtDiarias),
        pessoaPorViagem:remove(Id),
        pessoaPorViagem:insere(_, Id, Id_viajantes, QtDiarias, Funcao),
        tbl_viagens(_).
