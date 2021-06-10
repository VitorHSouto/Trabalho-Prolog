:- use_module(library(http/http_parameters)).

:- use_module(library(http/http_header)).

:- use_module(library(http/http_json)).

:- use_module(bd(veiculo), []).

veiculo(get, '', _Pedido):- !,
    envia_tabela.

veiculo(get, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    envia_tupla2(Id).

veiculo(post, _, Pedido):-
    http_read_json_dict(Pedido, Dados),
    !,
    insere_tupla2(Dados).


veiculo(put, AtomId, Pedido):-
    atom_number(AtomId, Id),
    http_read_json_dict(Pedido, Dados),
    !,
    atualiza_tupla2(Dados, Id).

veiculo(delete, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    veiculo:remove(Id),
    throw(http_reply(no_content)).

veiculo(Metodo, Id, _Pedido) :-
    throw(http_reply(method_not_allowed(Metodo, Id))).

insere_tupla2( _{ ano_fab:Ano, marca:Marca, modelo:Modelo, placa:Placa}):-
    veiculo:insere(Id, Ano, Marca, Modelo, Placa)
    -> envia_tupla2(Id)
    ;  throw(http_reply(bad_request('URL ausente'))).

atualiza_tupla2( _{ ano_fab:Ano, marca:Marca, modelo:Modelo, placa:Placa}, Id):-
    veiculo:atualiza(Id, Ano, Marca, Modelo, Placa)
    -> envia_tupla2(Id)
    ;  throw(http_reply(not_found(Id))).

envia_tupla2(Id):-
    veiculo:veiculo(Id, Ano, Marca, Modelo, Placa)
    -> reply_json_dict( _{id:Id, ano_fab:Ano, marca:Marca, modelo:Modelo, placa:Placa} )
    ;  throw(http_reply(not_found(Id))).
