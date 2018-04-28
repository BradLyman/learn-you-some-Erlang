%%% # Modules
%%%
%%% All functions are defined in modules and can be invoked using the form

% Module:Function(Arguments)
lists:seq(1, 5).

%%% Functions like 'elements', 'hd' and 'tl' are part of the 'erlang'
%%% module which is automatically imported by default.
%%% Modules can contain two things, **functions**, and **attributes**.

%%% ## Attributes
%%%
%%% Modules attributes take the form '-Name(Attribute).'
%%% Modules require only one attribute:

-module(my_module_name).

%%% The module's interface is defined with an '-export([func/arity,...])'
%%% attribute. Functions are identified by their name and the number of
%%% arguments they accept (the arity).

-export([add/2, hello/0, greet_and_add_two/1]).

%%% Modules can be imported so that the module name doesn't need to be
%%% specified to use a function. The import is a module attribute which
%%% looks like this '-import(Module, [Func/Arity])'.

-import(io, [format/1]).

%%% With the definition:

add(A, B) ->
    A + B.

%%% Functions are defined as 'Name(Args) -> Body.' where name is an atom
%%% and body can be one or more expressions separated by commas. Erlang is
%%% an expression language, so the last statement is the "return value" for
%%% a function.

hello() ->
    format("Hello world~n").

greet_and_add_two(X) ->
    hello(),
    add(X, 2).

%%% Modules can define macros which behave a bit like C-style #define.
%%% Macros are defined as a module attribute like so '-define(MACRO, value)'
%%% and are used like '?MACRO'.

-define(sub(X,Y), X-Y).

%%% ## Compiling
%%%
%%% Erlang code can be compiled on the shell using 'erlc'.

%> erlc flags file.erl

%%% Code can also be compiled from the erlang shell with the
%%% 'compile:file(Filename)' or 'c()' commands.

compile:file('./src/modules.erl').

%%% Compile flags give more control over how the module is complied.
%%% Some common flags are:
%%%   * '-debug_info'
%%%       Enables debuggers, code coverage, and static analysis tools to
%%%       do their work.
%%%   * '-{outdir,Dir}'
%%%       Place the output in a custom directory
%%%   * '-export_all'
%%%       Ignore the '-export' module attribute and exports everything instead.
%%%   * '-{d,Macro}' or '{d,Macro, Value}'
%%%       Defines a macro to be used in the module
%%% Flags can be provided to the compile method.

compile:file('./src/modules.erl', [debug_info, export_all]).

%%% Flags can be defined as a module attribute instead.

-compile([debug_info, export_all])

%%% This has the same effect as specifying them when calling the compile
%%% function.

%%% It is possible to compile Erlang to native code for a performance boost
%%% using the 'hipe' module.

hipe:c(Module, OptionsList).

%%% Alternatively, on the CLI there is a shortand option.

c(Module, [native]).

%%% Note that the .beam file (compiled result) will contain some native code
%%% which is not portable across platforms.
%%%
%%% Module attributes are stored in the module metadata. Metadata can be
%%% accessed with the 'module_info/0' function.

my_module_name:module_info()

%%% There is also a 'module_info/1' function which lets you grab only once
%%% piece of info.

my_module_name:module_info(attributes)


