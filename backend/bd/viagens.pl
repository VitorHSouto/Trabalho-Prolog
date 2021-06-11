:- module(viagens, [viagens/21]).

:- use_module(library(persistency)).
:- use_module(bd(chave)).

:- persistent viagens(id:positive_integer,
				    data:atom,
					origem:atom,
					destino:atom,
					dia_inicio:positive_integer,
					mes_inicio:positive_integer,
					ano_inicio:positive_integer,
                    dia_final:positive_integer,
					mes_final:positive_integer,
					ano_final:positive_integer,
					siga:atom,%voltar
					scpd:atom,%voltar
					km_inicial:atom,%voltar
					km_final:atom,%voltar
                    hora_saida:atom,
                    hora_chegada:atom,
                    km_utilizados:atom,%voltar
                    observacao:atom,
                    id_veiculo:positive_integer,
                    id_motoristas:positive_integer,
					id_locais:positive_integer).

%:- initialization(db_attach('./tbl_viajantes.pl'), []).
:- initialization( ( db_attach('./tbl_viagens.pl', []),
                     at_halt(db_sync(gc(always))) ) ).

insere(Id, Data, Origem, Destino, DInicio, MInicio, AInicio, DFinal, MFinal, AFinal,
       Siga, Scpd, KmInicio, KmFinal, HrSaida, HrChegada, KmUtilizado, Obs, IdVeic, IdMot, IdLoc) :-
	chave:pk(viagens, Id),
	with_mutex(key_viagens,
		   assert_viagens(Id, Data, Origem, Destino, DInicio, MInicio, AInicio, DFinal, MFinal, AFinal,
            Siga, Scpd, KmInicio, KmFinal, HrSaida, HrChegada, KmUtilizado, Obs, IdVeic, IdMot, IdLoc)).

remove(Id) :-
	with_mutex(key_viagens,
		   retractall_viagens(Id, _Data, _Origem, _Destino, _DInicio, _MInicio, _AInicio, _DFinal, _MFinal, _AFinal,
            _Siga, _Scpd, _KmInicio, _KmFinal, _HrSaida, _HrChegada, _KmUtilizado, _Obs, _IdVeic, _IdMot, _IdLoc)).

atualiza(Id, Data, Origem, Destino, DInicio, MInicio, AInicio, DFinal, MFinal, AFinal,
    Siga, Scpd, KmInicio, KmFinal, HrSaida, HrChegada, KmUtilizado, Obs, IdVeic, IdMot, IdLoc) :-
	with_mutex(key_viagens,
		   (retract_viagens(Id, _Data, _Origem, _Destino, _DInicio, _MInicio, _AInicio, _DFinal, _MFinal, _AFinal,
            _Siga, _Scpd, _KmInicio, _KmFinal, _HrSaida, _HrChegada, _KmUtilizado, _Obs, _IdVeic, _IdMot, _IdLoc),
		   assert_viagens(Id, Data, Origem, Destino, DInicio, MInicio, AInicio, DFinal, MFinal, AFinal,
           Siga, Scpd, KmInicio, KmFinal, HrSaida, HrChegada, KmUtilizado, Obs, IdVeic, IdMot, IdLoc))).

remove_todos() :-
	with_mutex(key_viagens,
		   retractall_viagens(_Id, _Data, _Origem, _Destino, _DInicio, _MInicio, _AInicio, _DFinal, _MFinal, _AFinal,
            _Siga, _Scpd, _KmInicio, _KmFinal, _HrSaida, _HrChegada, _KmUtilizado, _Obs, _IdVeic, _IdMot, _IdLoc)).

sincroniza :-
    db_sync(gc(always)).
