-module(metrics).
-author("Jeff Bell<jeff@5nineshq.com>").

-mod_title("Learning Site").
-mod_description("Site for learning Zotonic").
-mod_prio(10).

%% gen_server exports
-export([init/1]).
-export([event/2]).

-include_lib("zotonic.hrl").

%% @doc Initialize the datamodel
init(Context) ->
    z_datamodel:manage(?MODULE, datamodel(), Context).

event({postback, {take_down, Props}, _TriggerId, _TargetId}, Context) ->
    Node = proplists:get_value(node, Props),
    Context1 = z_render:wire(Node, {fade_out, []}, Context),
    Context2 = z_render:wire(["down_"|Node], {fade_in, []}, Context1),
    Context2;

event({postback, {bring_up, Props}, _TriggerId, _TargetId}, Context) ->
    DownNode = proplists:get_value(node, Props),
    "down_" ++ Node = DownNode,
    Context1 = z_render:wire(DownNode, {fade_out, []}, Context),
    Context2 = z_render:wire(Node, {fade_in, []}, Context1),
    Context2;

event({postback, {make_unavailable, Props}, _TriggerId, _TargetId}, Context) ->
    Id = proplists:get_value(id, Props),
    Node = proplists:get_value(node, Props),
    {ok, _} = z_db:update(rsc, Id, [{status, "down"}], Context),
    z_depcache:flush(Context),
    mod_signal:emit({node, [{node_id, Node}]}, Context),
    Context;

event({postback, {make_available, Props}, _TriggerId, _TargetId}, Context) ->
    Id = proplists:get_value(id, Props),
    Node = proplists:get_value(node, Props),
    {ok, _} = z_db:update(rsc, Id, [{status, "up"}], Context),
    z_depcache:flush(Context),
    mod_signal:emit({node, [{down_node_id, Node}]}, Context),
    Context.

datamodel() ->
    [
     {resources,
      [
       %% MENU ENTRIES
       {page_home,
        text,
        [{title, <<"Home">>},
         {summary, <<"Welcome to your blog!">>},
         {page_path, <<"/">>}]
       },

       %% KEYWORDS

       {kw_announcement,
        keyword,
        [{title, <<"Announcement">>}]
       },
       {kw_technical,
        keyword,
        [{title, <<"Technical">>}]
       },
       {kw_support,
        keyword,
        [{title, <<"Support">>}]
       }

      ]
     },

     {menu,
      [page_home]
     }
    ].
