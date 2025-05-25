## 1 下载msys2

    https://mirrors.tuna.tsinghua.edu.cn/msys2/distrib/  

msys2-x86_64-latest.exe

## 2 2.安装完成还源

运行 msys2.exe

```bash
sed -i "s#https\?://mirror.msys2.org/#https://mirrors.tuna.tsinghua.edu.cn/msys2/#g" /etc/pacman.d/mirrorlist*
```
## 3 3.安装gtk4

```bash
pacman -S mingw-w64-x86_64-gtk4
```

## 4 4.安装 相关软件 pkg-config  gcc vim
```bash
pacman -S pkg-config
pacman -S gcc
pacman -S vim
```

## 5 cd /usr/lib/pkgconfig   
# 增加配置文件
新建文件 gtk4.pc

里面的内容
```pc
Name: gtk4
Description: gtk4.0 library
URL: https://www.gtk.org/
Version: 4.0
Libs: -pthread -L/mingw64/lib -lgtk-4 -lgio-2.0 -lpangoft2-1.0 -lgdk_pixbuf-2.0 -lpangocairo-1.0 -lcairo -lpango-1.0 -lfreetype -lfontconfig -lgobject-2.0 -lgmodule-2.0 -lgthread-2.0 -lrt -lglib-2.0
Cflags: -pthread -I/mingw64/include/gtk-4.0 -I/mingw64/include/cairo -I/mingw64/include/pango-1.0 -I/mingw64/include/glib-2.0 -I/mingw64/include/pixman-1 -I/mingw64/include/freetype2 -I/mingw64/include/libpng16 -I/mingw64/lib/glib-2.0/include -I/mingw64/include/harfbuzz -I/mingw64/include/gdk-pixbuf-2.0 -I/mingw64/include/graphene-1.0 -I/mingw64/lib/graphene-1.0/include
```

## 1 6.新建测试文件 Hello.c
```bash
cd ~
mkdir DownTool
```

hello.c文件里面的内容
```c
#include <gtk/gtk.h>

static void
print_hello (GtkWidget *widget,
             gpointer   data)
{
  g_print ("Hello World\n");
}

static void
activate (GtkApplication *app,
          gpointer        user_data)
{
  GtkWidget *window;
  GtkWidget *button;

  window = gtk_application_window_new (app);
  gtk_window_set_title (GTK_WINDOW (window), "Window");
  gtk_window_set_default_size (GTK_WINDOW (window), 200, 200);

  button = gtk_button_new_with_label ("Hello World");
  g_signal_connect (button, "clicked", G_CALLBACK (print_hello), NULL);
  gtk_window_set_child (GTK_WINDOW (window), button);

  gtk_window_present (GTK_WINDOW (window));
}

int
main (int    argc,
      char **argv)
{
  GtkApplication *app;
  int status;

  app = gtk_application_new ("org.gtk.example", G_APPLICATION_DEFAULT_FLAGS);
  g_signal_connect (app, "activate", G_CALLBACK (activate), NULL);
  status = g_application_run (G_APPLICATION (app), argc, argv);
  g_object_unref (app);

  return status;
}

```
7.编译文件
```
 gcc `pkg-config --cflags gtk4` hello.c -o hello `pkg-config --libs gtk4`
 ```
去除黑窗口的编译方式
```
 gcc -mwindows `pkg-config --cflags gtk4` hello.c -o hello `pkg-config --libs gtk4`
```

8.增加依赖的库文件
```
cp /usr/bin/msys-2.0.dll ./
cp /mingw64/bin/*.dll ./
```
