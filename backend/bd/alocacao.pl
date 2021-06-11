:- module(alocacao, [alocacao/11]).

:- use_module(library(persistency)).
:- use_module(bd(chave)).

:- persistent alocacao(id:nonneg,
                    motorista:atom, 
                    qtVeic:atom, 
                    id_viaj:nonneg, 
                    dSaida:atom,
                    hSaida:atom,
                    dRetorno:atom,
                    locSaida:atom,
                    lSaida:atom,
                    lRetorno:atom,
                    obs:atom).

:- initialization( ( db_attach('./tbl_alocacao.pl', []),
                     at_halt(db_sync(gc(always))) ) ).

insere(Id, Motorista, QtVeic, IdViaj, DSaida, HSaida, DRetorno, LocSaida, LSaida, LRetorno, Obs) :- 
    chave:pk(alocacao, Id),
    with_mutex(key_alocacao, 
        assert_alocacao(Id, Motorista, QtVeic, IdViaj, DSaida, HSaida, DRetorno, LocSaida, LSaida, LRetorno, Obs)).

remove(Id) :- 
    with_mutex(key_alocacao, 
        retract_alocacao(Id, _, _, _, _, _, _, _, _, _, _)).

atualiza(Id, Motorista, QtVeic, IdViaj, DSaida, HSaida, DRetorno, LocSaida, LSaida, LRetorno, Obs) :- 
    with_mutex(key_alocacao, 
        (retract_alocacao(Id, _, _, _, _, _, _, _, _, _, _), 
        assert_alocacao(Id, Motorista, QtVeic, IdViaj, DSaida, HSaida, DRetorno, LocSaida, LSaida, LRetorno, Obs))).

remove_todos() :- 
    with_mutex(key_alocacao, 
        retractall_alocacao(_Id, _, _, _, _, _, _, _, _, _, _)).

sincroniza :- db_sync(gc(always)).