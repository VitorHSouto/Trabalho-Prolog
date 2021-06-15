% http_handler, http_reply_file
:- use_module(library(http/http_dispatch)).

% http:location
:- use_module(library(http/http_path)).

/*********************
 *                   *
 *      Rotas        *
 *                   *
 *********************/

:- multifile http:location/3.
:- dynamic   http:location/3.

% http:location(Apelido, Rota, Opções)
%      Apelido é como será chamada uma Rota do servidor.
%      Os apelidos css, icons e js já estão definidos na
%      biblioteca http/http_server_files, os demais precisam
%      ser definidos.

http:location(img, root(img), []).
http:location(api, root(api), []).
http:location(api1, api(v1), []).
http:location(webfonts, root(webfonts), []).

% Recursos estáticos
:- http_handler(css(.),
                serve_files_in_directory(dir_css), [prefix]).
:- http_handler(js(.),
                serve_files_in_directory(dir_js), [prefix]).

/********************************
*   ROTAS PRIMÁRIAS
*********************************/
:- http_handler(root(.), login('') , []).
:- http_handler(root(administrador), tabelas_adm , []).
:- http_handler(root(equipe), equipe , []).
:- http_handler(root(cadastro), cadastro , []).
:- http_handler(root(home), home, []).


:- http_handler(root(form1), form1 , []).
:- http_handler(root(form2), form2 , []).
:- http_handler(root(form3), form3 , []).
:- http_handler(root(form4), form4 , []).
:- http_handler(root(form5), form5 , []).
:- http_handler(root(form6), form6 , []).

/********************************
*   ROTAS FORMULÁRIOS
*********************************/
:- http_handler(root(viajantes), form1, []).
:- http_handler(root(locais), form2, []).
:- http_handler(root(veiculo), form3, []).
:- http_handler(root(motoristas), form4, []).
:- http_handler(root(viagens), form5, []).
:- http_handler(root(alocacao), form6, []).

/********************************
*   ROTAS TABELAS
*********************************/
:- http_handler(root(tbl_viajantes), tbl_viajantes , []).
:- http_handler(root(tbl_locais), tbl_locais , []).
:- http_handler(root(tbl_alocacao), tbl_alocacao , []).
:- http_handler(root(tbl_viagens), tbl_viagens , []).
:- http_handler(root(tbl_cadastros), tbl_cadastros , []).
:- http_handler(root(tbl_veiculo), tbl_veiculo , []).
:- http_handler(root(tbl_motoristas), tbl_motoristas , []).

/********************************
*   ROTAS RECEBEM CADASTRO
*********************************/
:- http_handler('/recebeCadastro', recebe_cadastro(Method),
                [ method(Method),
                  methods([post]) ]).

:- http_handler('/recebeLogin', recebe_login(Method),
                [ method(Method),
                  methods([post]) ]).

:- http_handler('/receptorF1', recebe_form1(Method),
                [ method(Method),
                  methods([post]) ]).

:- http_handler('/receptorF2', recebe_form2(Method),
                [ method(Method),
                  methods([post]) ]).

:- http_handler('/receptorF3', recebe_form3(Method),
                [ method(Method),
                  methods([post]) ]).

:- http_handler('/receptorF4', recebe_form4(Method),
                [ method(Method),
                  methods([post]) ]).

:- http_handler('/receptorF5', recebe_form5(Method),
                [ method(Method),
                  methods([post]) ]).

:- http_handler('/receptorF6', recebe_form6(Method),
                [ method(Method),
                  methods([post]) ]).

/*************************************
*   ROTAS RECEBEM CADASTRO "EDIÇÃO"
**************************************/
:- http_handler('/editarUsuario', editar_user(Method),
                [ method(Method),
                  methods([post]) ]).

:- http_handler('/editarF1', editar_form1(Method),
                [ method(Method),
                  methods([post]) ]).

:- http_handler('/editarF2', editar_form2(Method),
                [ method(Method),
                  methods([post]) ]).

:- http_handler('/editarF3', editar_form3(Method),
                [ method(Method),
                  methods([post]) ]).

:- http_handler('/editarF4', editar_form4(Method),
                [ method(Method),
                  methods([post]) ]).

:- http_handler('/editarF5', editar_form5(Method),
                [ method(Method),
                  methods([post]) ]).

:- http_handler('/editarF6', editar_form6(Method),
                [ method(Method),
                  methods([post]) ]).

/*************************************
*   ROTAS RECEBEM ID PARA "EDIÇÃO"
**************************************/
:- http_handler( root(user/editar/Id), edita_usuario_adm(Id), []).
:- http_handler( root(user/apagar/Id), apaga_usuario(Id), []).

:- http_handler( root(locs/editar/Id), editarLocs(Id), []).
:- http_handler( root(locs/apagar/Id), apagarLocs(Id), []).

:- http_handler( root(viajantes/editar/Id), editarViajantes(Id), []).
:- http_handler( root(viajantes/apagar/Id), apagarViajantes(Id), []).

:- http_handler( root(veiculo/editar/Id), editarVeiculo(Id), []).
:- http_handler( root(veiculo/apagar/Id), apagarVeiculo(Id), []).

:- http_handler( root(motoristas/editar/Id), editarMotoristas(Id), []).
:- http_handler( root(motoristas/apagar/Id), apagarMotoristas(Id), []).

:- http_handler( root(alocacao/editar/Id), editarAlocacao(Id), []).
:- http_handler( root(alocacao/apagar/Id), apagarAlocacao(Id), []).

:- http_handler( root(viagens/editar/Id), editarViagem(Id), []).
:- http_handler( root(viagens/apagar/Id), apagarViagem(Id), []).

% Rotas da API
:- http_handler( api1(locs/Id), locs(Metodo, Id),
                 [ method(Metodo),
                   methods([ get, post, put, delete ]) ]).

:- http_handler( api1(viajante/Id), viajante(Metodo, Id),
                [ method(Metodo),
                methods([ get, post, put, delete ]) ]).

:- http_handler( api1(veiculo/Id), veiculo(Metodo, Id),
                 [ method(Metodo),
                   methods([ get, post, put, delete ]) ]).

:- http_handler( api1(motoristas/Id), motoristas(Metodo, Id),
                [ method(Metodo),
                methods([ get, post, put, delete ]) ]).