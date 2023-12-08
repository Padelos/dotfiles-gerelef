#!/usr/bin/env -S sudo --preserve-env="XDG_RUNTIME_DIR" --preserve-env="XDG_DATA_DIRS" --preserve-env="DBUS_SESSION_BUS_ADDRESS" bash 

if ! [ $(id -u) = 0 ]; then
    echo "The script needs to be run as root." >&2
    exit 1
fi

readonly DIR=$(dirname -- "$BASH_SOURCE")
source "$DIR/common-utils.sh"

# heredocs
# https://tldp.org/LDP/abs/html/here-docs.html
sudo --preserve-env="XDG_RUNTIME_DIR" --preserve-env="XDG_DATA_DIRS" --preserve-env="DBUS_SESSION_BUS_ADDRESS" -u "$REAL_USER" bash <<-GSETTINGS_DELIMITER
    source "$(dirname -- "$BASH_SOURCE")/common-utils.sh"
    
    gsettings set org.gnome.desktop.interface cursor-theme 'Adwaita'
    gsettings set org.gnome.desktop.interface icon-theme 'Adwaita'
    gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    
    add-gsettings-shortcut "blackbox" "/usr/bin/flatpak run --branch=stable --arch=x86_64 --command=blackbox com.raggesilver.BlackBox" "<Shift><Control>KP_Add"
    add-gsettings-shortcut "gnome-system-monitor" "gnome-system-monitor" "<Shift><Control>Escape"
    
    # reference to fix https://github.com/flameshot-org/flameshot/issues/3326#issuecomment-1838662244
    dbus-send --session --print-reply=literal --dest=org.freedesktop.impl.portal.PermissionStore /org/freedesktop/impl/portal/PermissionStore org.freedesktop.impl.portal.PermissionStore.SetPermission string:'screenshot' boolean:true string:'screenshot' string:'flameshot' array:string:'yes'
    dbus-send --session --print-reply=literal --dest=org.freedesktop.impl.portal.PermissionStore /org/freedesktop/impl/portal/PermissionStore org.freedesktop.impl.portal.PermissionStore.Lookup string:'screenshot' string:'screenshot'
    add-gsettings-shortcut "flameshot" "flameshot gui" "Print"
    
    flatpak run --branch=stable --arch=x86_64 --command=gsettings com.raggesilver.BlackBox set com.raggesilver.BlackBox command-as-login-shell true
    flatpak run --branch=stable --arch=x86_64 --command=gsettings com.raggesilver.BlackBox set com.raggesilver.BlackBox cursor-shape 1
    flatpak run --branch=stable --arch=x86_64 --command=gsettings com.raggesilver.BlackBox set com.raggesilver.BlackBox custom-shell-command ''
    flatpak run --branch=stable --arch=x86_64 --command=gsettings com.raggesilver.BlackBox set com.raggesilver.BlackBox delay-before-showing-floating-controls 400
    flatpak run --branch=stable --arch=x86_64 --command=gsettings com.raggesilver.BlackBox set com.raggesilver.BlackBox easy-copy-paste true
    flatpak run --branch=stable --arch=x86_64 --command=gsettings com.raggesilver.BlackBox set com.raggesilver.BlackBox fill-tabs true
    flatpak run --branch=stable --arch=x86_64 --command=gsettings com.raggesilver.BlackBox set com.raggesilver.BlackBox floating-controls false
    flatpak run --branch=stable --arch=x86_64 --command=gsettings com.raggesilver.BlackBox set com.raggesilver.BlackBox floating-controls-hover-area 10
    flatpak run --branch=stable --arch=x86_64 --command=gsettings com.raggesilver.BlackBox set com.raggesilver.BlackBox font 'Monospace 12'
    flatpak run --branch=stable --arch=x86_64 --command=gsettings com.raggesilver.BlackBox set com.raggesilver.BlackBox headerbar-drag-area false
    flatpak run --branch=stable --arch=x86_64 --command=gsettings com.raggesilver.BlackBox set com.raggesilver.BlackBox pixel-scrolling false
    flatpak run --branch=stable --arch=x86_64 --command=gsettings com.raggesilver.BlackBox set com.raggesilver.BlackBox pretty true
    flatpak run --branch=stable --arch=x86_64 --command=gsettings com.raggesilver.BlackBox set com.raggesilver.BlackBox remember-window-size false
    flatpak run --branch=stable --arch=x86_64 --command=gsettings com.raggesilver.BlackBox set com.raggesilver.BlackBox scrollback-mode 1
    flatpak run --branch=stable --arch=x86_64 --command=gsettings com.raggesilver.BlackBox set com.raggesilver.BlackBox show-headerbar true
    flatpak run --branch=stable --arch=x86_64 --command=gsettings com.raggesilver.BlackBox set com.raggesilver.BlackBox show-menu-button true
    flatpak run --branch=stable --arch=x86_64 --command=gsettings com.raggesilver.BlackBox set com.raggesilver.BlackBox show-scrollbars true
    flatpak run --branch=stable --arch=x86_64 --command=gsettings com.raggesilver.BlackBox set com.raggesilver.BlackBox style-preference 0
    flatpak run --branch=stable --arch=x86_64 --command=gsettings com.raggesilver.BlackBox set com.raggesilver.BlackBox terminal-cell-height 1.0
    flatpak run --branch=stable --arch=x86_64 --command=gsettings com.raggesilver.BlackBox set com.raggesilver.BlackBox terminal-cell-width 1.0
    flatpak run --branch=stable --arch=x86_64 --command=gsettings com.raggesilver.BlackBox set com.raggesilver.BlackBox theme-dark 'One Dark'
    flatpak run --branch=stable --arch=x86_64 --command=gsettings com.raggesilver.BlackBox set com.raggesilver.BlackBox theme-light 'Tomorrow'
    flatpak run --branch=stable --arch=x86_64 --command=gsettings com.raggesilver.BlackBox set com.raggesilver.BlackBox use-custom-command false
    flatpak run --branch=stable --arch=x86_64 --command=gsettings com.raggesilver.BlackBox set com.raggesilver.BlackBox use-overlay-scrolling true
    flatpak run --branch=stable --arch=x86_64 --command=gsettings com.raggesilver.BlackBox set com.raggesilver.BlackBox window-width 1280
    flatpak run --branch=stable --arch=x86_64 --command=gsettings com.raggesilver.BlackBox set com.raggesilver.BlackBox.terminal.search match-case-sensitive false
    flatpak run --branch=stable --arch=x86_64 --command=gsettings com.raggesilver.BlackBox set com.raggesilver.BlackBox.terminal.search match-regex false
    flatpak run --branch=stable --arch=x86_64 --command=gsettings com.raggesilver.BlackBox set com.raggesilver.BlackBox.terminal.search match-whole-words false
    flatpak run --branch=stable --arch=x86_64 --command=gsettings com.raggesilver.BlackBox set com.raggesilver.BlackBox.terminal.search wrap-around true
    gsettings set org.gnome.nautilus.preferences show-create-link true
    gsettings set org.gnome.nautilus.preferences show-delete-permanently false
    gsettings set org.gnome.nautilus.preferences show-hidden-files true
    gsettings set org.gnome.nautilus.preferences recursive-search 'local-only'
    gsettings set org.gnome.nautilus.preferences mouse-use-extra-buttons false
    gsettings set org.gnome.nautilus.list-view default-zoom-level 'small'
    gsettings set org.gnome.nautilus.preferences default-folder-viewer 'list-view'
    gsettings set org.gtk.Settings.FileChooser clock-format '24h'
    gsettings set org.gtk.Settings.FileChooser date-format 'regular'
    gsettings set org.gtk.Settings.FileChooser show-hidden true
    gsettings set org.gtk.Settings.FileChooser show-size-column true
    gsettings set org.gtk.Settings.FileChooser show-type-column true
    gsettings set org.gtk.Settings.FileChooser sort-directories-first true
    gsettings set org.gtk.Settings.FileChooser type-format 'category'
    gsettings set org.gtk.Settings.FileChooser sidebar-width 140
    gsettings set org.gtk.gtk4.Settings.FileChooser clock-format '24h'
    gsettings set org.gtk.gtk4.Settings.FileChooser date-format 'regular'
    gsettings set org.gtk.gtk4.Settings.FileChooser show-hidden true
    gsettings set org.gtk.gtk4.Settings.FileChooser sort-directories-first true
    gsettings set org.gtk.gtk4.Settings.FileChooser type-format 'category'
    gsettings set org.gtk.gtk4.Settings.FileChooser view-type 'list'
    gsettings set org.gtk.gtk4.Settings.FileChooser sort-directories-first true
    gsettings set org.gnome.shell.keybindings screenshot "[]"
    gsettings set org.gnome.shell.keybindings screenshot-window "[]"
    gsettings set org.gnome.shell.keybindings show-screenshot-ui "[]"
    gsettings set org.gnome.desktop.wm.keybindings activate-window-menu "['Menu']"
    gsettings set org.gnome.desktop.wm.keybindings always-on-top  "[]"
    gsettings set org.gnome.desktop.wm.keybindings begin-move  "[]"
    gsettings set org.gnome.desktop.wm.keybindings begin-resize  "[]"
    gsettings set org.gnome.desktop.wm.keybindings close "['<Super>d']"
    gsettings set org.gnome.desktop.wm.keybindings cycle-group "['<Alt>grave']"
    gsettings set org.gnome.desktop.wm.keybindings cycle-group-backward "['<Shift><Alt>grave']"
    gsettings set org.gnome.desktop.wm.keybindings cycle-panels  "[]"
    gsettings set org.gnome.desktop.wm.keybindings cycle-panels-backward  "[]"
    gsettings set org.gnome.desktop.wm.keybindings cycle-windows  "[]"
    gsettings set org.gnome.desktop.wm.keybindings cycle-windows-backward  "[]"
    gsettings set org.gnome.desktop.wm.keybindings lower  "[]"
    gsettings set org.gnome.desktop.wm.keybindings maximize  "[]"
    gsettings set org.gnome.desktop.wm.keybindings maximize-horizontally  "[]"
    gsettings set org.gnome.desktop.wm.keybindings maximize-vertically  "[]"
    gsettings set org.gnome.desktop.wm.keybindings minimize "['<Super>z']"
    gsettings set org.gnome.desktop.wm.keybindings move-to-center  "[]"
    gsettings set org.gnome.desktop.wm.keybindings move-to-corner-ne  "[]"
    gsettings set org.gnome.desktop.wm.keybindings move-to-corner-nw  "[]"
    gsettings set org.gnome.desktop.wm.keybindings move-to-corner-se  "[]"
    gsettings set org.gnome.desktop.wm.keybindings move-to-corner-sw  "[]"
    gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-down  "[]"
    gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-left  "[]"
    gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-right  "[]"
    gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-up  "[]"
    gsettings set org.gnome.desktop.wm.keybindings move-to-side-e  "[]"
    gsettings set org.gnome.desktop.wm.keybindings move-to-side-n  "[]"
    gsettings set org.gnome.desktop.wm.keybindings move-to-side-s  "[]"
    gsettings set org.gnome.desktop.wm.keybindings move-to-side-w  "[]"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-1 "['<Super><Shift>Home']"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-10  "[]"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-11  "[]"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-12  "[]"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-2  "[]"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-3  "[]"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-4  "[]"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-5  "[]"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-6  "[]"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-7  "[]"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-8  "[]"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-9  "[]"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-down  "[]"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-last  "[]"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left "['<Shift><Control>Home']"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right "['<Shift><Control>End']"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-up  "[]"
    gsettings set org.gnome.desktop.wm.keybindings panel-main-menu  "[]"
    gsettings set org.gnome.desktop.wm.keybindings panel-run-dialog "['<Alt>F2']"
    gsettings set org.gnome.desktop.wm.keybindings raise  "[]"
    gsettings set org.gnome.desktop.wm.keybindings raise-or-lower  "[]"
    gsettings set org.gnome.desktop.wm.keybindings set-spew-mark  "[]"
    gsettings set org.gnome.desktop.wm.keybindings show-desktop  "[]"
    gsettings set org.gnome.desktop.wm.keybindings switch-applications "['<Alt>Tab']"
    gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward "['<Shift><Alt>Tab']"
    gsettings set org.gnome.desktop.wm.keybindings switch-group  "[]"
    gsettings set org.gnome.desktop.wm.keybindings switch-group-backward  "[]"
    gsettings set org.gnome.desktop.wm.keybindings switch-input-source "['<Super>space']"
    gsettings set org.gnome.desktop.wm.keybindings switch-input-source-backward "['<Shift><Super>space']"
    gsettings set org.gnome.desktop.wm.keybindings switch-panels  "[]"
    gsettings set org.gnome.desktop.wm.keybindings switch-panels-backward  "[]"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1  "[]"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-10  "[]"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-11  "[]"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-12  "[]"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2  "[]"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3  "[]"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4  "[]"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-5  "[]"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-6  "[]"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-7  "[]"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-8  "[]"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-9  "[]"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-down "['<Primary><Super>Down', '<Primary><Super>j']"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-last  "[]"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Control>Home']"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Control>End']"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up "['<Primary><Super>Up', '<Primary><Super>k']"
    gsettings set org.gnome.desktop.wm.keybindings switch-windows  "[]"
    gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward  "[]"
    gsettings set org.gnome.desktop.wm.keybindings toggle-above  "[]"
    gsettings set org.gnome.desktop.wm.keybindings toggle-fullscreen  "[]"
    gsettings set org.gnome.desktop.wm.keybindings toggle-maximized "['<Super>x']"
    gsettings set org.gnome.desktop.wm.keybindings toggle-on-all-workspaces  "[]"
    gsettings set org.gnome.desktop.wm.keybindings unmaximize  "[]"
    gsettings set org.gnome.desktop.wm.preferences action-double-click-titlebar 'toggle-maximize'
    gsettings set org.gnome.desktop.wm.preferences action-middle-click-titlebar 'none'
    gsettings set org.gnome.desktop.wm.preferences action-right-click-titlebar 'menu'
    gsettings set org.gnome.desktop.wm.preferences audible-bell true
    gsettings set org.gnome.desktop.wm.preferences auto-raise false
    gsettings set org.gnome.desktop.wm.preferences auto-raise-delay 500
    gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:close'
    gsettings set org.gnome.desktop.wm.preferences disable-workarounds false
    gsettings set org.gnome.desktop.wm.preferences focus-mode 'click'
    gsettings set org.gnome.desktop.wm.preferences focus-new-windows 'smart'
    gsettings set org.gnome.desktop.wm.preferences mouse-button-modifier '<Super>'
    gsettings set org.gnome.desktop.wm.preferences num-workspaces 3
    gsettings set org.gnome.desktop.wm.preferences raise-on-click true
    gsettings set org.gnome.desktop.wm.preferences resize-with-right-button false
    gsettings set org.gnome.desktop.wm.preferences theme 'Adwaita'
    gsettings set org.gnome.desktop.wm.preferences titlebar-uses-system-font true
    gsettings set org.gnome.desktop.wm.preferences visual-bell false
    gsettings set org.gnome.desktop.wm.preferences visual-bell-type 'fullscreen-flash'
    gsettings set org.gnome.desktop.wm.preferences workspace-names  "[]"
    gsettings set org.gnome.desktop.peripherals.mouse accel-profile 'flat'
    gsettings set org.gnome.desktop.peripherals.touchpad accel-profile 'flat'
    gsettings set org.gnome.desktop.peripherals.touchpad click-method 'none'
    gsettings set org.gnome.desktop.peripherals.touchpad disable-while-typing false
    gsettings set org.gnome.desktop.peripherals.touchpad edge-scrolling-enabled false
    gsettings set org.gnome.desktop.peripherals.touchpad left-handed 'mouse'
    gsettings set org.gnome.desktop.peripherals.touchpad middle-click-emulation false
    gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll true
    gsettings set org.gnome.desktop.peripherals.touchpad send-events 'enabled'
    gsettings set org.gnome.desktop.peripherals.touchpad speed 0.10000000000000001
    gsettings set org.gnome.desktop.peripherals.touchpad tap-and-drag false
    gsettings set org.gnome.desktop.peripherals.touchpad tap-and-drag-lock false
    gsettings set org.gnome.desktop.peripherals.touchpad tap-button-map 'default'
    gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click false
    gsettings set org.gnome.desktop.peripherals.touchpad two-finger-scrolling-enabled true
    gsettings set org.gnome.TextEditor auto-indent true
    gsettings set org.gnome.TextEditor highlight-current-line true
    gsettings set org.gnome.TextEditor indent-style 'space'
    gsettings set org.gnome.TextEditor restore-session true
    gsettings set org.gnome.TextEditor right-margin-position 80
    gsettings set org.gnome.TextEditor show-line-numbers true
    gsettings set org.gnome.TextEditor show-map true
    gsettings set org.gnome.TextEditor spellcheck false
    gsettings set org.gnome.TextEditor tab-width 4
    gsettings set org.gnome.TextEditor use-system-font true
    gsettings set org.gnome.TextEditor wrap-text false
    gsettings set org.gnome.desktop.interface clock-format '24h'
    gsettings set org.gnome.desktop.interface clock-show-date false
    gsettings set org.gnome.desktop.interface clock-show-seconds true
    gsettings set org.gnome.desktop.interface clock-show-weekday true
    gsettings set org.gnome.desktop.interface color-scheme 'default'
    gsettings set org.gnome.desktop.interface cursor-blink true
    gsettings set org.gnome.desktop.interface enable-hot-corners false
    gsettings set org.gnome.desktop.interface font-antialiasing 'rgba'
    gsettings set org.gnome.desktop.interface font-hinting 'full'
    gsettings set org.gnome.desktop.interface gtk-enable-primary-paste false
    gsettings set org.gnome.desktop.interface menubar-detachable false
    gsettings set org.gnome.desktop.interface overlay-scrolling true
    gsettings set org.gnome.desktop.interface show-battery-percentage true
    gsettings set org.gnome.desktop.media-handling automount true
    gsettings set org.gnome.desktop.media-handling automount-open true
    gsettings set org.gnome.desktop.media-handling autorun-never true
    gsettings set org.gnome.desktop.notifications show-banners false
    gsettings set org.gnome.desktop.notifications show-in-lock-screen true
    gsettings set org.gnome.desktop.peripherals.keyboard numlock-state false
    gsettings set org.gnome.desktop.peripherals.keyboard remember-numlock-state false
    gsettings set org.gnome.desktop.peripherals.keyboard repeat true
    gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 25
    gsettings set org.gnome.desktop.peripherals.mouse double-click 250
    gsettings set org.gnome.desktop.peripherals.mouse middle-click-emulation false
    gsettings set org.gnome.desktop.peripherals.mouse natural-scroll false
    gsettings set org.gnome.desktop.peripherals.mouse speed -0.2
    gsettings set org.gnome.desktop.peripherals.touchpad disable-while-typing false
    gsettings set org.gnome.desktop.privacy disable-camera true
    gsettings set org.gnome.desktop.privacy disable-microphone false
    gsettings set org.gnome.desktop.privacy disable-sound-output false
    gsettings set org.gnome.desktop.privacy hide-identity false
    gsettings set org.gnome.desktop.privacy old-files-age 7
    gsettings set org.gnome.desktop.privacy recent-files-max-age -1
    gsettings set org.gnome.desktop.privacy remember-app-usage true
    gsettings set org.gnome.desktop.privacy remember-recent-files false
    gsettings set org.gnome.desktop.privacy remove-old-temp-files true
    gsettings set org.gnome.desktop.privacy remove-old-trash-files false
    gsettings set org.gnome.desktop.privacy show-full-name-in-top-bar false
    gsettings set org.gnome.desktop.privacy usb-protection true
    gsettings set org.gnome.desktop.privacy usb-protection-level 'lockscreen'
    gsettings set org.gnome.system.location enabled true
    gsettings set org.gnome.system.location max-accuracy-level 'city'
    gsettings set org.gnome.desktop.remote-desktop.rdp enable false
    gsettings set org.gnome.desktop.screensaver color-shading-type 'solid'
    gsettings set org.gnome.desktop.sound allow-volume-above-100-percent false
    gsettings set org.gnome.desktop.sound event-sounds true
    gsettings set org.gnome.mutter attach-modal-dialogs true
    gsettings set org.gnome.mutter auto-maximize true
    gsettings set org.gnome.mutter center-new-windows true
    gsettings set org.gnome.mutter check-alive-timeout 15000
    gsettings set org.gnome.shell.weather automatic-location true
    gsettings set org.gnome.software allow-updates false
    gsettings set org.gnome.software download-updates false
    gsettings set org.gnome.software download-updates-notify true
    gsettings set org.gnome.software enable-repos-dialog true
    gsettings set org.gnome.software show-nonfree-ui true
    gsettings set org.gnome.software show-ratings true
    gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
    gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-automatic false
    gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-from 0.0
    gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-to 6.0
    exit
GSETTINGS_DELIMITER
