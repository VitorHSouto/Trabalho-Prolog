:- use_module(library(http/http_parameters)).

:- use_module(library(http/http_header)).

:- use_module(library(http/http_json)).

:- use_module(bd(motoristas), []).

motoristas(get, '', _Pedido):- !,
    envia_tabela.

motoristas(get, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    envia_tupla(Id).

motoristas(post, _, Pedido):-
    http_read_json_dict(Pedido, Dados),
    !,
    insere_tupla(Dados).

motoristas(put, AtomId, Pedido):-
    atom_number(AtomId, Id),
    http_read_json_dict(Pedido, Dados),
    !,
    atualiza_tupla(Dados, Id).

motoristas(delete, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    motoristas:remove(Id),
    throw(http_reply(no_content)).

motoristas(Metodo, Id, _Pedido) :-
    throw(http_reply(method_not_allowed(Metodo, Id))).

insere_tupla( _{ nome:Nome, cpf:Cpf, num_cnh:Num_cnh, data_pri_habili:Data_pri_habili}):-
    motoristas:insere(Id, Nome, Cpf, Num_cnh, Data_pri_habili)
    -> envia_tupla(Id)
    ;  throw(http_reply(bad_request('URL ausente'))).

atualiza_tupla( _{ nome:Nome, cpf:Cpf, num_cnh:Num_cnh, data_pri_habili:Data_pri_habili}, Id):-
    motoristas:atualiza(Id, Nome, Cpf, Num_cnh, Data_pri_habili)
    -> envia_tupla(Id)
    ;  throw(http_reply(not_found(Id))).


envia_tupla(Id):-
    motoristas:motoristas(Id, Nome, Cpf, Num_cnh, Data_pri_habili)
    -> reply_json_dict( _{nome:Nome, cpf:Cpf, num_cnh:Num_cnh, data_pri_habili:Data_pri_habili} )
    ;  throw(http_reply(not_found(Id))).


envia_tabela :-
    findall( _{id:Id, nome:Nome, cpf:Cpf, num_cnh:Num_cnh, data_pri_habili:Data_pri_habili},
             motoristas:motoristas(Id, Nome, Cpf, Num_cnh, Data_pri_habili),
             Tuplas ),
    reply_json_dict(Tuplas).
