include:
  - users
  - sysutils.tmux
  - vcs.git

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

{{ name }}_tmux-config:
    git.latest:
      - name: https://github.com/tony/tmux-config.git
      - runas: {{ name }}
      - target: {{ home }}/.tmux
      - submodules: true
      - require:
        - pkg: git
        - pkg: tmux
        - user: {{ name }}_user
    file.symlink:
      - name: {{ home }}/.tmux.conf
      - target: {{ home }}/.tmux/.tmux.conf
      - require:
        - git: {{ name }}_tmux-config

{% endfor %}
