:- module(viajantes, [viajantes/7]).

:- use_module(library(persistency)).
:- use_module(bd(chave)).

:- persistent viajantes(id:positive_integer,
		        cpf:atom,
			nome:atom,
			funcao:atom,
			email:atom,
			senha:atom,
		        nvl_acesso:atom).

%:- initialization(db_attach('tbl_viajantes.pl'), []).
:- initialization( ( db_attach('./tbl_viajantes.pl', []),
                     at_halt(db_sync(gc(always))) ) ).

insere(Id, Cpf, Nome, Funcao, Email, Senha, Nvl_acesso) :-
	chave:pk(viajantes, Id),
	with_mutex(key_viajantes,
		   assert_viajantes(Id, Cpf, Nome, Funcao, Email, Senha, Nvl_acesso)).

remove(Id) :-
	with_mutex(key_viajantes,
		   retractall_viajantes(Id, _Cpf, _Nome, _Funcao, _Email, _Senha, _Nvl_acesso)).

atualiza(Id, Cpf, Nome, Funcao, Email, Senha, Nvl_acesso) :-
	with_mutex(key_viajantes,
		   (retract_viajantes(Id, _Cpf, _Nome, _Funcao, _Email, _Senha, _Nvl_acesso),
		   assert_viajantes(Id, Cpf, Nome, Funcao, Email, Senha, Nvl_acesso))).

remove_todos() :-
	with_mutex(key_viajantes,
		   retractall_viajantes(_Id, _Cpf, _Nome, _Funcao, _Email, _Senha, _Nvl_acesso)).

sincroniza :-
    db_sync(gc(always)).
