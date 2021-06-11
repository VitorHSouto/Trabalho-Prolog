:- module(locais, [locais/4]).

:- use_module(library(persistency)).
:- use_module(bd(chave)).

:- persistent locais(id:positive_integer,
				cidade:atom,
					cep:atom,
					end:atom).

%:- initialization(db_attach('./tbl_viajantes.pl'), []).
:- initialization( ( db_attach('./tbl_locais.pl', []),
                     at_halt(db_sync(gc(always))) ) ).

insere(Id, Cidade, Cep, End) :-
	chave:pk(locais, Id),
	with_mutex(key_locais,
		   assert_locais(Id, Cidade, Cep, End)).

remove(Id) :-
	with_mutex(key_locais,
		   retractall_locais(Id, _Cidade, _Cep, _End)).

atualiza(Id, Cidade, Cep, End) :-
	with_mutex(key_locais,
		   (retract_locais(Id, _Cidade, _Cep, _End),
		   assert_locais(Id, Cidade, Cep, End))).

remove_todos() :-
	with_mutex(key_locais,
		   retractall_locais(_Id, _Cidade, _Cep, _End)).

sincroniza :-
    db_sync(gc(always)).
