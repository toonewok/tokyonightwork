# Tokyo Night Work install
This install assumes you have installed arch and hyprland via archinstall

(During the install process I recommend getting git and a gui network manager if you need one)

## Installing
once logged into hyprland clone this repo and cd into it

by default hyprlands bind to open a terminal is SUPER+Q

-git clone https://github.com/toonewok/tokyonightwork

once in the directory execute install

-./install

enter your AIX name and sudo password when prompted

it will install and reboot when done...and that's it....


## Post Install
Note - hyprlock setup doesnt have an input bar, type pw and hit enter to login

You can use nwg-look/Gtk settings to change the default theme to Tokyonight for apps and change the default font to jetbrainsmono

In your home directory there is a hidden folder for sqldeveloper (\~/.sqldeveloper)

Inside of that folder there is an example product.conf, copy it into the version of sqldeveloper being used

(\~/.sqldeveloper/24.3.1(insert version here))

You do not have the nord theme by default, get the gtk theme you want, place it in \~/.themes, use nwg-look/gtk settings to get the name of the theme

Note: not all themes look right, hence why im using nord instead of tokyo night personally
