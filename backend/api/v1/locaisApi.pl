/* http_parameters   */
:- use_module(library(http/http_parameters)).
/* http_reply        */
:- use_module(library(http/http_header)).
/* reply_json_dict   */
:- use_module(library(http/http_json)).

:- use_module(bd(locais), []).

/*
   GET api/v1/locs/
   Retorna uma lista com todos os locs.
*/
locs(get, '', _Pedido):- !,
    envia_tabela.

/*
   GET api/v1/locs/Id
   Retorna o `bookmark` com Id 1 ou erro 404 caso o `bookmark` não
   seja encontrado.
*/
locs(get, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    envia_tupla(Id).

/*
   POST api/v1/locs
   Adiciona um novo bookmark. Os dados deverão ser passados no corpo da
   requisição no formato JSON.

   Um erro 400 (BAD REQUEST) deve ser retornado caso a URL não tenha sido
   informada.
*/
locs(post, _, Pedido):-
    http_read_json_dict(Pedido, Dados),
    !,
    insere_tupla(Dados).

/*
  PUT api/v1/locs/Id
  Atualiza o bookmark com o Id informado.
  Os dados são passados no corpo do pedido no formato JSON.
*/
locs(put, AtomId, Pedido):-
    atom_number(AtomId, Id),
    http_read_json_dict(Pedido, Dados),
    !,
    atualiza_tupla(Dados, Id).

/*
   DELETE api/v1/locs/Id
   Apaga o bookmark com o Id informado
*/
locs(delete, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    locais:remove(Id),
    throw(http_reply(no_content)).

/* Se algo ocorrer de errado, a resposta de método não
   permitido será retornada.
 */
locs(Metodo, Id, _Pedido) :-
    throw(http_reply(method_not_allowed(Metodo, Id))).

insere_tupla( _{ cidade:Cidade, cep:Cep, end:End}):-
    % Validar URL antes de inserir
    locais:insere(Id, Cidade, Cep, End)
    -> envia_tupla(Id)
    ;  throw(http_reply(bad_request('URL ausente'))).

atualiza_tupla( _{ cidade:Cidade, cep:Cep, end:End}, Id):-
    locais:atualiza(Id, Cidade, Cep, End)
    -> envia_tupla(Id)
    ;  throw(http_reply(not_found(Id))).


envia_tupla(Id):-
    locais:locais(Id, Cidade, Cep, End)
    -> reply_json_dict( _{cidade:Cidade, cep:Cep, end:End} )
    ;  throw(http_reply(not_found(Id))).


envia_tabela :-
    findall( _{id:Id, cidade:Cidade, cep:Cep, end:End},
             locais:locais(Id, Cidade, Cep, End),
             Tuplas ),
    reply_json_dict(Tuplas).
