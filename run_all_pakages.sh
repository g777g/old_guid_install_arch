#!/bin/bash

# Переконайтеся, що скрипт запускається з правами root або здатний використовувати sudo
if [[ $EUID -ne 0 ]]; then
   echo "Цей скрипт спробує використати sudo для встановлення пакетів."
   echo "Якщо з'явиться запит пароля, будь ласка, введіть його."
fi

# Список пакетів для встановлення
PACKAGES="
ly xorg xorg-xinit micro mousepad bspwm sxhkd thunar alacritty polybar brightnessctl 
nm-connection-editor networkmanager pulseaudio pipewire pipewire-pulse bluez bluez-utils 
blueman playerctl ttf-jetbrains-mono-nerd scrot zip unzip feh picom udisks2 gvfs gvfs-mtp 
gvfs-gphoto2 gvfs-afc polkit
"

echo "Починаю процес встановлення пакетів..."

# Оновлення системних дзеркал перед встановленням (рекомендовано)
sudo pacman -Syu --noconfirm

# Встановлення пакетів
# Використовуємо --noconfirm, щоб не зупинятися на запиті підтвердження "Proceed with installation? [Y/n]"
sudo pacman -S $PACKAGES --noconfirm

# Перевірка статусу завершення команди
if [ $? -eq 0 ]; then
    echo "====================================================="
    echo "✅ Встановлення всіх пакетів успішно завершено."
    echo "====================================================="
    
    # Додаткові кроки: активація системних сервісів
    echo "Активація необхідних системних сервісів (NetworkManager, Bluetooth...)"
    sudo systemctl enable NetworkManager.service
    sudo systemctl enable bluetooth.service
    
    echo "Готово до налаштування вашого робочого середовища BSPWM."

else
    echo "====================================================="
    echo "❌ Сталася помилка під час встановлення одного або декількох пакетів."
    echo "Перевірте вивід помилок вище, щоб визначити проблему."
    echo "Можливо, деякі пакети вже встановлено або ваше інтернет-з'єднання відсутнє."
    echo "====================================================="
fi
