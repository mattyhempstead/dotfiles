# Builds the i3 config file
# If on desktop/laptop, different files are used
# Uses files contained within ~/.config/config-split/

cd ~/.config/i3/config-split
WARNING="### WARNING ###\n### THIS FILE IS AUTOGENERATED ###\n### ANY CHANGES WILL NOT BE SAVED ###\n\n\n"
(echo -e $WARNING ; cat core workspace config keybinds) > ../config

