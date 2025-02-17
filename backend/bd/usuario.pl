:- module(
       usuario,
       [ usuario/6]
   ).

:- use_module(library(persistency)).
:- use_module(library(crypto)).

:- use_module(chave, []).

:- persistent
   usuario(
       usuario_id:positive_integer,
       nome:string,
       email:string,
       senha:atom,
       data_cad:constant,
       data_mod:constant
   ).

:- initialization( ( db_attach('./tbl_usuarios.pl', []),
                     at_halt(db_sync(gc(always))) ) ).

insere( Id,
        Nome,
        Email,
        Senha ):-
    chave:pk(usuario, Id),
    with_mutex(usuario,
               ( get_time(T),
                 Data_Cad = T,
                 Data_Mod = T,
                 crypto_password_hash(Senha,Hash),
                 assert_usuario(Id,
                                Nome,
                                Email,
                                Hash,
                                Data_Cad,
                                Data_Mod))).

remove(Id):-
    with_mutex(usuario,
               retractall_usuario(Id,
                                  _Nome,
                                  _Email,
                                  _Hash,
                                  _Data_Cad,
                                  _Data_Mod)).


atualiza(Id, Nome, Email):-
    with_mutex(usuario,
               (retract_usuario(Id,
                                _NomeAntigo,
                                _EmailAntigo,
                                Hash,
                                Data_Cad,
                                _Data_Mod),
                get_time(T),
                Data_Mod = T,
                assert_usuario(Id,
                               Nome,
                               Email,
                               Hash,
                               Data_Cad,
                               Data_Mod))).

atualiza_senha(Id, Senha):-
    with_mutex(usuario,
               (retract_usuario(Id,
                                Nome,
                                Email,
                                _HashAntigo,
                                Data_Cad,
                                _Data_Mod),
                get_time(T),
                Data_Mod = T,
                crypto_password_hash(Senha,Hash),
                assert_usuario(Id,
                               Nome,
                               Email,
                               Hash,
                               Data_Cad,
                               Data_Mod))).


% Verifica se a senha para um usuario com o dado e-mail é valida.
% Para o teste ter sucesso tanto a senha quanto o hash devem
% estar ligados a valores e o hash da Senha deve ser comparavel
% ao armazenado anteriormente.

senha_valida(Email, Senha, Id):-
    usuario(Id, _Nome, Email, Hash, _Data_Cad, _Data_Mod),
    !,
    crypto_password_hash(Senha,Hash).










