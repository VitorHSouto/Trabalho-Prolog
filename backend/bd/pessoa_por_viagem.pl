:- module(pessoaPorViagem, [pessoaPorViagem/5]).

:- use_module(library(persistency)).
:- use_module(bd(chave)).

:- persistent pessoaPorViagem(id:positive_integer,
                    id_viagens:positive_integer,
					id_viajantes:positive_integer,
					diarias:positive_integer,
					funcao:atom).

:- initialization( ( db_attach('./tbl_pessoaPorViagem.pl', []),
                     at_halt(db_sync(gc(always))) ) ).

insere(Id, Id_viagens, Id_viajantes, Diarias, Funcao) :-
	chave:pk(pessoa_por_viagem_key, Id),
	with_mutex(pessoa_por_viagem,
		   assert_pessoaPorViagem(Id, Id_viagens, Id_viajantes, Diarias, Funcao)).

remove(Id) :-
	with_mutex(pessoa_por_viagem_key,
		   retractall_pessoaPorViagem(_, Id, _, _, _)).

atualiza(Id, Id_viagens, Id_viajantes, Diarias, Funcao) :-
	with_mutex(pessoa_por_viagem_key,
		   (retract_pessoaPorViagem(Id, _, _, _, _),
		   assert_pessoaPorViagem(Id, Id_viagens, Id_viajantes, Diarias, Funcao))).

remove_todos() :-
	with_mutex(pessoa_por_viagem_key,
		   retractall_pessoaPorViagem(_, _, _, _, _)).

sincroniza :-
    db_sync(gc(always)).
