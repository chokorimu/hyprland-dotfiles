if status is-interactive
    # Commands to run in interactive sessions can go here
    set -g fish_greeting '                   __  
  ____ ___________/ /_ 
 / __ `/ ___/ ___/ __ \
/ /_/ / /  / /__/ / / /
\__,_/_/   \___/_/ /_/ 
                       '
    function fish_prompt
        echo (set_color white)╭─ (set_color 777777)$USER (set_color green)(prompt_pwd)
        echo (set_color white)╰─(set_color green)❯ 
    end
end
