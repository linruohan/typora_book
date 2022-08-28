# sddm theme of gitlab.com/dwt1

#+TITLE: README
#+DESCRIPTION: A multicolor sddm theme created for DTOS.
#+AUTHOR: Derek Taylor (DistroTube)

* About multicolor-sddm-theme
#+CAPTION: Theme Scrot
#+ATTR_HTML: :alt Theme Scrot :title Theme Scrot :align left
![img](https://gitlab.com/dwt1/multicolor-sddm-theme/-/raw/main/screenshot-small.png)
This theme was created to be the default sddm theme for [[https://gitlab.com/dwt1/dtos/][DTOS]].  This theme is more than just a single theme.  It is actually nine themes, each based on a popular terminal colorscheme:
1. Doom One
2. Dracula
3. Gruvbox Dark
4. Monokai Pro
5. Nord
6. Oceanic Next
7. Solarized Dark
8. Solarized Light
9. Tomorrow Night

I had never used sddm prior to this or tried to theme sddm, so the QML file is essentially the same one from the [[https://github.com/MalditoBarbudo/solarized_sddm_theme][solarized_sddm_theme]].  The artwork is original but I am, by no means, a professional graphics designer.  The background images were all created using [[https://gimp.org/][Gimp]].  You will find two versions of each background, one .png and one .xcf.  The .xcf files are included so those that wish to modify the colors can do so more easily.

* Dependencies
The following dependencies are needed:
+ sddm
+ Font awesome
+ Raleway font

On Arch Linux, Fontawesome can be installed with the =otf-font-awesome package= and Raleway can be installed with the =otf-raleway= from the AUR.
### download and paste files
```bash
git clone https://gitlab.com/dwt1/multicolor-sddm-theme
sudo cp -r multicolor-sddm-theme/ /usr/share/sddm/themes/
```

### Then, change the current theme in your sddm configuration file.  This file may located in a number of places, including:
+ /usr/lib/sddm/sddm.conf.d/default.conf
+ /etc/sddm.conf (Manjaro KDE uses this)
+ /etc/sddm.conf.d/kde_settings.conf (Some versions of ArcoLinux use this)

```bash
[THEME]
Current=multicolor-sddm-theme
```

### Changing colorschemes
To change the colorscheme, you need to edit =/usr/share/sddm/themes/multicolor-sddm-theme/theme.conf=.

#+begin_example
...

[General]
background=png/doom-one-01.png

...
#+end_example

Change the background image (.png) to the appropriate colorscheme:
| THEME           | BACKGROUND IMAGE           |
|-----------------+----------------------------|
| Doom One        | png/doom-one-01.png        |
| Dracula         | png/dracula-01.png         |
| Gruvbox Dark    | png/gruvbox-dark-01.png    |
| Monokai Pro     | png/monokai-pro-01.png     |
| Nord            | png/nord-01.png            |
| Oceanic Next    | png/oceanic-next-01.png    |
| Solarized Dark  | png/solarized-dark-01.png  |
| Solarized Light | png/solarized-light-01.png |
| Tomorrow Night  | png/tomorrow-night-01.png  |



