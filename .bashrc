# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# --- MEJORAS DE AUTOCOMPLETADO (TAB) ---
 
# Si el autocompletado tiene varias opciones, la primera pulsación de Tab muestra la lista.
# La segunda pulsación empieza a recorrer las opciones en un menú.
bind 'set show-all-if-ambiguous on'
bind 'set menu-complete-display-prefix on'
bind '"\t": menu-complete'
 
# Ignorar mayúsculas y minúsculas al autocompletar con Tab
bind 'set completion-ignore-case on'
 
alias ls='lsd --group-directories-first'
alias la='lsd --group-directories-first -lah'
alias cat='bat'
alias grep='grep --color=auto'
alias xi='sudo xbps-install -S'
alias xu='sudo xbps-install -Su'
alias xq='xbps-query -Rs'
alias xr='sudo xbps-remove -R'
alias xo='sudo xbps-remove -O'
alias vim='/usr/bin/vim-normal'
alias py='python3'

xqi() {
    xbps-query -Rs "$1" | grep "^\[\*\]"
}

xqa() {
    xbps-query -Rs "$1" | grep "^\[.\] [^ ]*$1"

}

ayuda() {
    clear
    echo -e "\e[1;34m===============================================================================\e[0m"
    echo -e "\e[1;32m                  💡 GUÍA DE COMANDOS PERSONALIZADOS    \e[0m"
    echo -e "\e[1;34m===============================================================================\e[0m"
    
    \cat << 'EOF'

  📦 GESTIÓN DE PAQUETES (XBPS)
  --------------------------------------------------
  xi <pkg>      -> Instala un paquete (sincroniza repositorios primero).
  xu            -> Actualiza todo el sistema Void Linux.
  xr <pkg>      -> Elimina un paquete y todas sus dependencias huérfanas.
  xo            -> Limpia el sistema borrando paquetes huérfanos/caché.
  xq <texto>    -> Busca paquetes en los repositorios por nombre o descripción.

  🔍 BÚSQUEDAS AVANZADAS (FUNCIONES)
  --------------------------------------------------
  xqi <texto>   -> Muestra SOLO los paquetes que ya tienes INSTALADOS [*].
  xqa <texto>   -> Busca SOLO por nombre de paquete (ignora descripciones).

  📂 NAVEGACIÓN Y SISTEMA
  --------------------------------------------------
  ls            -> Lista archivos usando 'lsd' ordenando directorios primero.
  la            -> Lista todo (incluyendo ocultos) en formato detallado/humano.
  cat <archivo> -> Muestra el contenido de un archivo usando 'bat' (con color).
  grep <texto>  -> Busca texto dentro de archivos resaltando las coincidencias.
  vim           -> Abre el editor Vim normal (/usr/bin/vim-normal).
  py            -> Atajo rápido para iniciar la consola de Python 3.

EOF
    echo -e "\e[1;34m===============================================================================\e[0m"
}


if [[ $EUID -eq 0 ]]; then
  # Prompt para root (rojo)
  PS1='\[\e[1;31m\][\u@\h \[\e[1;34m\]\w\[\e[0m\]\[\e[1;31m\]]\n# \[\e[0m\]'
else
  # Prompt para usuarios normales (verde)
  PS1='\[\e[1;32m\][\u@\h \[\e[1;34m\]\w\[\e[0m\]\[\e[1;32m\]]\n$ \[\e[0m\]'
fi

# Cargar bash-completion si existe
if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

