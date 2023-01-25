function fish_greeting
    ## TODO change to DT color scripts
    ## Run neofetch if session is interactive
    if status --is-interactive && type -q colorscript
        colorscript -r
    end
end
