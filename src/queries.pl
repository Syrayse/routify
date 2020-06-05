% #########################################################
% ## SRCR - Routify, metodos de procura aplicados.       ##
% ## Trabalho individual aluno nº 84930.                 ##
% ## Ano letivo 2019/20 - MIEI.                          ##
% ##                                                     ##
% ## --------------------------------------------------- ##
% ##                                                     ##
% ## Ficheiro: queries.pl                                ##
% ## Descricao: O presente ficheiro  tem o  objetivo  de ##
% ## encapsular todas as interrogacoes requisitadas pelos##
% ## docentes.                                           ##
% #########################################################

% #########################################################
% 1) Calcular trajeto entre dois pontos.
trajeto_base(FSearch, X, Y, R) :-
      call(FSearch, X, Y, R).

% #########################################################
% 2) Selecionar apenas algumas operadoras de transporte
% para um determinado percurso.

escolhe_operadoras(FSearch, X, Y, L, Path) :-
      findall(
            aresta(Pt, A, B, C),
            ( aresta(Pt,A,B,C),
             (nodo(A,_,_,_,_,_,Ptt,_,_,_,_);
              nodo(B,_,_,_,_,_,Ptt,_,_,_,_)),
             nao(membro(Ptt, L))),
            R
      ),
      retract_all(R),
      (call(FSearch, X, Y, Path) ; true),
      assert_all(R).

% #########################################################
% 3) Excluir um ou mais operadores de transporte para o
% percurso.

exclui_operadoras(FSearch, X, Y, L, Path) :-
      findall(
            aresta(Pt, A, B, C),
            ( aresta(Pt,A,B,C),
             (nodo(A,_,_,_,_,_,Ptt,_,_,_,_);
              nodo(B,_,_,_,_,_,Ptt,_,_,_,_)),
             membro(Ptt, L)),
            R
      ),
      retract_all(R),
      (call(FSearch, X, Y, Path) ; true),
      assert_all(R).

% #########################################################
% 4) Escolher o menor percuso(usando numero de paragens).
menor_num_paragens(X, Y, R) :-
      breadth_first(X, Y, R).

% #########################################################
% 5) Escolher o percurso mais rapido(usando distancia).
menor_distancia(X,Y,R) :-
      a_star(X, Y, R).

% #########################################################
% 6) Escolher o percurso que passe apenas por abrigos com
% publicidade.

com_publicidade(FSearch, X, Y, Path) :-
      findall(
            aresta(Pt, A, B, C),
            ( aresta(Pt,A,B,C),
             (nodo(A,_,_,_,_,'No',_,_,_,_,_);
              nodo(B,_,_,_,_,'No',_,_,_,_,_))),
            R
      ),
      retract_all(R),
      (call(FSearch, X, Y, Path) ; true),
      assert_all(R).

% #########################################################
% 7) Escolher o percurso que passe apenas por paragens
% abrigadas.

com_abrigo(FSearch, X, Y, Path) :-
      findall(
            aresta(Pt, A, B, C),
            ( aresta(Pt,A,B,C),
             (nodo(A,_,_,_,'Sem Abrigo',_,_,_,_,_,_);
              nodo(B,_,_,_,'Sem Abrigo',_,_,_,_,_,_))),
            R
      ),
      retract_all(R),
      (call(FSearch, X, Y, Path) ; true),
      assert_all(R).

% #########################################################
% 8) Escolher um ou mais pontos intermedios por onde o
% percurso devera passar.

pontos_intermedios(FSearch, T, L) :-
      pontos_intermedios(FSearch, T, [], L).
pontos_intermedios(FSearch, [X,Y],P,L) :-
      call(FSearch, X, Y, Path),
      concatenar(P,Path,L).
pontos_intermedios(FSearch,[X,Y|T],P,L) :-
      call(FSearch,X,Y,Path),
      concatenar(P,Path,C),
      pontos_intermedios(FSearch,[Y|T],C,L).

% #########################################################
