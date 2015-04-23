

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

{{ home }}/.bashrc:
  file.managed:
    - source: salt://home/.bashrc
    - user: {{ name }} 
    - group: {{ user_group }}
    - mode: 644

{{ home }}/.bash_prompt:
  file.managed:
    - source: salt://home/.bash_prompt
    - user: {{ name }} 
    - group: {{ user_group }}
    - mode: 644

{% endfor %}
