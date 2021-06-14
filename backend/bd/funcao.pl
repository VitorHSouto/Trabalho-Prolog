:- module(
       funcao,
       [ funcao/4]
   ).

:- use_module(library(persistency)).

:- use_module(chave, []).

:- persistent
   funcao(
       funcao_id:positive_integer,
       funcao:oneof([admin,user]),
       data_cad:constant,
       data_mod:constant
   ).

:- initialization( ( db_attach('./tbl_funcao.pl', []),
                     at_halt(db_sync(gc(always))) ) ).

insere(Id, Funcao):-
    chave:pk(funcao, Id),
    with_mutex(funcao,
               ( get_time(T),
                 Data_Cad = T,
                 Data_Mod = T,
                 assert_funcao(Id,
                               Funcao,
                               Data_Cad,
                               Data_Mod
                              ))).

remove(Id):-
    with_mutex(funcao,
               retractall_funcao(Id,
                                 _Funcao,
                                 _Data_Cad,
                                 _Data_Mod)).


atualiza(Id, Funcao):-
    with_mutex(funcao,
               (retract_funcao(Id,
                               _FuncaoAntiga,
                               Data_Cad,
                               _Data_Mod),
                get_time(T), % data e hora desse instante
                Data_Mod = T,
                assert_funcao(Id,
                              Funcao,
                              Data_Cad,
                              Data_Mod))).
