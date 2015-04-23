include:
  - users
  - vcs.git
  - editors.vim

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

{{ name }}_vim-config:
  git.latest:
    - name: https://github.com/tony/vim-config.git
    - user: {{ name }}
    - target: {{ home }}/.vim
    - submodules: true
    - require:
      - pkg: git
      - pkg: vim
      - user: {{ name }}_user
  file.symlink:
    - name: {{ home }}/.vimrc
    - target: {{ home }}/.vim/.vimrc
    - require:
      - git: {{ name }}_vim-config

{% endfor %}
