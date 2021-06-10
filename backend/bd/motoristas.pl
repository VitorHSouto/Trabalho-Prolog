:- module(motoristas, [motoristas/5]).

:- use_module(library(persistency)).
:- use_module(bd(chave)).

:- persistent motoristas(id:nonneg, nome:atom, cpf:atom, num_cnh:positive_integer, data_pri_habili:atom).

:- initialization( ( db_attach('./tbl_motoristas.pl', []),
                     at_halt(db_sync(gc(always))) ) ).

insere(Id, Nome, Cpf, Num_cnh, Data_pri_habili) :- chave:pk(motoristas, Id),with_mutex(key_motoristas, assert_motoristas(Id, Nome, Cpf, Num_cnh, Data_pri_habili)).

remove(Id) :- with_mutex(key_motoristas, retract_motoristas(Id, _Nome, _Cpf, _Num_cnh, _Data_pri_habili)).

atualiza(Id, Nome, Cpf, Num_cnh, Data_pri_habili) :- with_mutex(key_motoristas, (retract_motoristas(Id, _Nome, _Cpf, _Num_cnh, _Data_pri_habili), assert_motoristas(Id, Nome, Cpf, Num_cnh, Data_pri_habili))).

remove_todos() :- with_mutex(key_motoristas, retractall_motoristas(_Id, _Nome, _Cpf, _Num_cnh, _Data_pri_habili)).

sincroniza :- db_sync(gc(always)).