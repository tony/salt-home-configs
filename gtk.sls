include:
  - wm.gtk

{% for name, user in pillar.get('users', {}).items() %}
{%- if user == None -%}
{%- set user = {} -%}
{%- endif -%}
{%- set home = user.get('home', "/home/%s" % name) -%}

{%- if 'prime_group' in user and 'name' in user['prime_group'] %}
{%- set user_group = user.prime_group.name -%}
{%- else -%}
{%- set user_group = name -%}
{%- endif %}

{{ home }}/.gtkrc-2.0:
  file.managed:
    - source: salt://home/.gtkrc-2.0
    - user: {{ name }}
    - group: {{ user_group }}
    - mode: 644
  require:
    - pkg: gtk2-engines

{{ home }}/.gtkrc-2.0.mine:
  file.managed:
    - source: salt://home/.gtkrc-2.0.mine
    - user: {{ name }}
    - group: {{ user_group }}
    - mode: 644
  require:
    - pkg: gtk2-engines

{% endfor %}
