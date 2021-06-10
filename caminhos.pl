:- multifile user:file_search_path/2.

user:file_search_path(dir_base, 'd:/UFU/pl/projeto').
user:file_search_path(projeto, dir_base(gestao)).

user:file_search_path(frontend, projeto(frontend)).
user:file_search_path(gabaritos, frontend(gabaritos)).
user:file_search_path(js, frontend(js)).
user:file_search_path(css, frontend(css)).

user:file_search_path(backend, projeto(backend)).
user:file_search_path(bd, backend(bd)).

user:file_search_path(api,  backend(api)).
user:file_search_path(api1, api(v1)).

% Localização dos diretórios no sistema de arquivos
:- multifile user:file_search_path/2.
user:file_search_path(dir_css, 'css').
user:file_search_path(dir_js,  'js').