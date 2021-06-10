/* http_parameters   */
:- use_module(library(http/http_parameters)).
/* http_reply        */
:- use_module(library(http/http_header)).
/* reply_json_dict   */
:- use_module(library(http/http_json)).

:- use_module(bd(viajantes), []).

/*
   GET api/v1/bookmarks/
   Retorna uma lista com todos os bookmarks.
*/
viajante(get, '', _Pedido):- !,
    envia_tabela.

/*
   GET api/v1/bookmarks/Id
   Retorna o `bookmark` com Id 1 ou erro 404 caso o `bookmark` não
   seja encontrado.
*/
viajante(get, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    envia_tupla2(Id).

/*
   POST api/v1/bookmarks
   Adiciona um novo bookmark. Os dados deverão ser passados no corpo da
   requisição no formato JSON.

   Um erro 400 (BAD REQUEST) deve ser retornado caso a URL não tenha sido
   informada.
*/
viajante(post, _, Pedido):-
    http_read_json_dict(Pedido, Dados),
    !,
    insere_tupla2(Dados).

/*
  PUT api/v1/bookmarks/Id
  Atualiza o bookmark com o Id informado.
  Os dados são passados no corpo do pedido no formato JSON.
*/
viajante(put, AtomId, Pedido):-
    atom_number(AtomId, Id),
    http_read_json_dict(Pedido, Dados),
    !,
    atualiza_tupla2(Dados, Id).

/*
   DELETE api/v1/bookmarks/Id
   Apaga o bookmark com o Id informado
*/
viajante(delete, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    viajantes:remove(Id),
    throw(http_reply(no_content)).

/* Se algo ocorrer de errado, a resposta de método não
   permitido será retornada.
 */

viajante(Metodo, Id, _Pedido) :-
    throw(http_reply(method_not_allowed(Metodo, Id))).

insere_tupla2( _{ cpf:Cpf, nome:Nome, funcao:Funcao, email:Email, senha:Senha, acesso:Acesso}):-
    % Validar URL antes de inserir
    viajantes:insere(Id, Cpf, Nome, Funcao, Email, Senha, Acesso)
    -> envia_tupla2(Id)
    ;  throw(http_reply(bad_request('URL ausente'))).

atualiza_tupla2( _{ cpf:Cpf, nome:Nome, funcao:Funcao, email:Email, senha:Senha, acesso:Acesso}, Id):-
    viajantes:atualiza(Id, Cpf, Nome, Funcao, Email, Senha, Acesso)
    -> envia_tupla2(Id)
    ;  throw(http_reply(not_found(Id))).

envia_tupla2(Id):-
    viajantes:viajantes(Id, Cpf, Nome, Funcao, Email, Senha, Acesso)
    -> reply_json_dict( _{id:Id, cpf:Cpf, nome:Nome, funcao:Funcao, email:Email, senha:Senha, acesso:Acesso} )
    ;  throw(http_reply(not_found(Id))).
