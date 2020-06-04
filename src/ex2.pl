% #########################################################
% ## SRCR - Dominio de Contratacao Publica.              ##
% ## Trabalho individual aluno nº 84930.                 ##
% ## Ano letivo 2019/20 - MIEI.                          ##
% ##                                                     ##
% ## --------------------------------------------------- ##
% ##                                                     ##
% ## Ficheiro: ex2.pl                                    ##
% ## Descricao: O presente ficheiro  tem o  objetivo  de ##
% ## fazer a  juncao de todos os diferentes ficheiros de ##
% ## codigo  envolvidos  neste  sistema.                 ##
% #########################################################

% #########################################################

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

:- op(900,xfy,'::').

% Inclui utensilios base, i.e. inverso, membro, ...
:- include('utils.pl').

% Inclui operacoes de interesse para com as entidades.
:- include('operacoes.pl').

% Inclui todos os metodos de procura.
:- include('procura.pl').

% Inclui todo o povoamento desenvolvido,
:- include('povoamento.pl').

% #########################################################
