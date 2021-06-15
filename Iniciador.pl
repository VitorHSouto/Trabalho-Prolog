/**********************************************
 *         Arquivos Necessários               *
 *********************************************/
                                           /**/
:- load_files([ caminhos,                  /**/
                rotas,                     /**/
                frontend(inicio),          /**/
                frontend(viajantes),       /**/
                frontend(locais),          /**/
                api1(locaisApi),           /**/
                api1(viajantesApi),
                frontend(motoristas),
                frontend(alocacao),
                frontend(viagens),
                frontend(veiculo),
                frontend(login),
                frontend(cadastro),
                frontend(tabelasAdm),
                frontend(editar_usuario),
                frontend(navbar),
                frontend(pgEquipe)
              ],                           /**/
              [ silent(true),              /**/
                if(not_loaded) ]).         /**/
%:- consult(frontend(tabelaLocais)).       /**/
%:- consult(frontend(tabelaViajantes)).    /**/
:- ensure_loaded(gabaritos(bootstrap5)).   /**/
:- ensure_loaded(gabaritos(boot5rest)).   /**/
                                           /**/
/*********************************************/

% Bancos de DADOS
:- use_module(bd(viajantes)).
:- use_module(bd(locais)).
:- use_module(bd(motoristas)).
:- use_module(bd(veiculo)).
:- use_module(bd(pessoa_por_viagem)).
:- use_module(bd(viagens)).
:- use_module(bd(alocacao)).
:- use_module(bd(usuario)).
:- use_module(bd(funcao)).
:- use_module(bd(usuario_funcao)).

:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/html_write)).

% html_requires está aqui
:- use_module(library(http/html_head)).

% serve_files_in_directory está aqui
:- use_module(library(http/http_server_files)).

servidor(Porta) :-
    http_server(http_dispatch, [port(Porta)]).

% http_read_data está aqui
:- use_module(library(http/http_client)).
