% #########################################################
% ## SRCR - Routify, metodos de procura aplicados.       ##
% ## Trabalho individual aluno nº 84930.                 ##
% ## Ano letivo 2019/20 - MIEI.                          ##
% ##                                                     ##
% ## --------------------------------------------------- ##
% ##                                                     ##
% ## Ficheiro: utils.pl                                  ##
% ## Descricao: O presente ficheiro  tem o  objetivo  de ##
% ## definir predicados de interesse do ponto de vista   ##
% ## funcional para o sistema.                           ##
% #########################################################

% #########################################################
% Predicados de extensao de logica.

% Extensao do meta-predicado nao: Questao -> {V,F}.
nao( Questao ) :-
    Questao, !, fail.
nao( Questao ).

% #########################################################

% #########################################################
% Outros predicados de interesse.

% Teste de pertence de elemento a lista.
membro(X,[X|_]) :- !.
membro(X,[_|T]) :- membro(X,T).

% Inverte ordem da lista de entrada.
inverso(Xs, Ys):-
	inverso(Xs, [], Ys).

inverso([], Xs, Xs).
inverso([X|Xs], Ys, Zs):-
	inverso(Xs, [X|Ys], Zs).

% #########################################################
