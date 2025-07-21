# Add Homebrew to PATH
fish_add_path /opt/homebrew/bin

if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source
end
