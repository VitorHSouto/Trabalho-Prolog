:- module(veiculo, [veiculo/5]).

:- use_module(library(persistency)).
:- use_module(bd(chave)).

:- persistent veiculo(id:nonneg, ano_fab:atom, marca:atom, modelo:atom, placa:atom).

:- initialization( ( db_attach('./tbl_veiculo.pl', []),
                     at_halt(db_sync(gc(always))) ) ).

insere(Id, Ano, Marca, Modelo, Placa) :- chave:pk(veiculo, Id),with_mutex(key_veiculo, assert_veiculo(Id, Ano, Marca, Modelo, Placa)).

remove(Id) :- with_mutex(key_veiculo, retract_veiculo(Id, _Ano, _Marca, _Modelo, _Placa)).

atualiza(Id, Ano, Marca, Modelo, Placa) :- with_mutex(key_veiculo, (retract_veiculo(Id, _Ano, _Marca, _Modelo, _Placa), assert_veiculo(Id, Ano, Marca, Modelo, Placa))).

remove_todos() :- with_mutex(key_veiculo, retractall_veiculo(_Id, _Ano, _Marca, _Modelo, _Placa)).

sincroniza :- db_sync(gc(always)).