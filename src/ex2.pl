% #########################################################
% ## SRCR - Routify, metodos de procura aplicados.       ##
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

% Libs utilizadas nos algoritmos.

% ---- 1) Filas de espera com prioridade.
?- use_module(library(heaps)).

% ---- 2) Filas de espera.
?- use_module(library(queues)).

% ---- 3) Conjuntos.
?- use_module(library(ordsets)).

% Predicados utilizados.

% ---- 1) Nodo.
:- dynamic nodo/11.

% ---- 2) Aresta.
:- dynamic aresta/4.

% Inclui utensilios base, i.e. inverso, membro, ...
:- include('utils.pl').

% Inclui operacoes de interesse para com as entidades.
:- include('operacoes.pl').

% Inclui todos os metodos de procura.
:- include('procura.pl').

% Incluir todas as queries necessarias.
:- include('queries.pl').

% Inclui todo o povoamento desenvolvido,
:- include('povoamento.pl').

% #########################################################
