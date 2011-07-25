%% @author Jeff Bell <jeff.5nines@gmail.com>
%% @copyright 2010 Jeff Bell
%% @date 2011-071-16
%% @doc Simple chat log system 

%% Copyright 2010 Jeff Bell
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%% 
%%     http://www.apache.org/licenses/LICENSE-2.0
%% 
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.

-module(mod_chitchat).
-author("Jeff Bell <jeff.5nines@gmail.com").

-mod_title("Chat Log").
-mod_description("Chat logger for pages").

%% gen_server exports
-export([init/1]).

-export([
    event/2,
    observe_search_query/2
]).

-include_lib("zotonic.hrl").


%% @doc Handle the submit event of a new chitchat

event({postback, {newchitchat, Args}, _TriggerId, _TargetId}, Context) ->
    z_depcache:flush(Context),
    {id, Id} = proplists:lookup(id, Args),
    Props = [{id, Id}],
    Context1 = z_render:wire([
            %{dialog_open, [{title, "Enter a nick and start chatting"},{template, "_add_chat.tpl"}, {id,Id}]},
            {focus, [{target, "message"}]}], Context),
    {HTML, Context2} = z_template:render_to_iolist("_chitchats.tpl", Props, Context1),
    z_render:update("chat-box", HTML, Context2);


event({submit, {newchitchat, Args}, _TriggerId, _TargetId}, Context) ->
    {id, Id} = proplists:lookup(id, Args),
    Name = z_context:get_q_validated("name", Context),
    Message = z_context:get_q_validated("message", Context),
    case m_chitchat:insert(Id, Name, Message, Context) of
        {ok, ChitChatId} ->
            mod_signal:emit({chat, [{session, Id}]}, Context),
            ChitChat = m_chitchat:get(ChitChatId, Context),
            z_render:wire([
                {set_value, [{target, "message"}, {value, ""}]},
                {focus, [{target, "message"}]}
                ], Context);
        {error, _} ->
            Context
    end.

%% @doc Return the list of recent chitchats.  Returned values are the complete records.
observe_search_query({search_query, {recent_chitchats, []}, OffsetLimit}, Context) ->
    m_chitchat:search({recent_chitchats, []}, OffsetLimit, Context);
observe_search_query(_, _Context) ->
    undefined.


%% @doc Check the installation of the chitchat table. A bit more complicated because 0.1 and 0.2 had a table
%% in the default installer, this module installs a different table.
init(Context) ->
    ok = z_db:transaction(fun install1/1, Context),
    z_depcache:flush(Context),
    ok.
    
install1(Context) ->
    ok = install_chitchat_table(z_db:table_exists(chitchat, Context), Context),
    ok.

install_chitchat_table(true, _Context) ->
        ok;

install_chitchat_table(false, Context) ->
    z_db:q("
            create table chitchat (
            id serial not null,
            is_visible boolean not null default true,
            rsc_id int not null,
            name character varying(80) not null default ''::character varying,
            message character varying(180) not null default ''::character varying,
            ip_address character varying(40) not null default ''::character varying,
            props bytea,
            created timestamp with time zone not null default now(),
            constraint chitchat_pkey primary key (id),
            constraint fk_chitchat_rsc_id foreign key (rsc_id)
            references rsc(id) on delete cascade on update cascade
            )
    ", Context),
    Indices = [
        {"fki_chitchat_rsc_id", "rsc_id"},
        {"fki_chitchat_ip_address", "ip_address"},
        {"chitchat_rsc_created_key", "rsc_id, created"},
        {"chitchat_created_key", "created"}
    ],
    [ z_db:q("create index "++Name++" on chitchat ("++Cols++")", Context) || {Name, Cols} <- Indices ],
    ok.
