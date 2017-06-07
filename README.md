# transcoder-cli

Hello,

I'm [Liviu Balan](http://www.liviubalan.com/) and here is transcoder-cli project based on
[FFmpeg](https://en.wikipedia.org/wiki/FFmpeg). This tool allows you to convert multimedia files to other format using
[Linux](https://en.wikipedia.org/wiki/Linux)
[Command-line interface](https://en.wikipedia.org/wiki/Command-line_interface).

## Requirements

In order to run this project on your machine you have to install the following packages:

* A [Linux](https://en.wikipedia.org/wiki/Linux) [operating system](https://en.wikipedia.org/wiki/Operating_system)
* A [Linux](https://en.wikipedia.org/wiki/Linux)
[Command-line interface](https://en.wikipedia.org/wiki/Command-line_interface) (it may be installed by default)
* [FFmpeg](https://ffmpeg.org/) package

## Installation

After the Requirements section is checked, open a [console](https://en.wikipedia.org/wiki/Command-line_interface) and
follow this steps:

1. Clone the GitHub project repository:

 ```bash
 git clone git@github.com:liviubalan/transcoder-cli.git
 ```

2. Change the current directory to `transcoder-cli`:

 ```bash
 cd transcoder-cli/
 ```

3. Convert the file by using the [console](https://en.wikipedia.org/wiki/Command-line_interface):

 ```bash
 input_dir='/home/liviu/Documents/Multimedia/' input_extension='wav' output_dir='/home/liviu/Documents/Multimedia/convert/' output_extension='mp3' ./audio-transcoder.sh
 ```

## Recommended configuration

This project was tested using the following configuration:

1. [Linux Mint](https://en.wikipedia.org/wiki/Linux_Mint) 18.1 Cinnamon 64-bit (based on
[Ubuntu](https://en.wikipedia.org/wiki/Ubuntu_(operating_system)) 16.04)

2. [GNOME Terminal](https://en.wikipedia.org/wiki/GNOME_Terminal)

3. [ffmpeg](https://packages.ubuntu.com/search?keywords=ffmpeg) package. In order to install `ffmpeg` package use:

 ```bash
 sudo apt-get install ffmpeg
 ```

Thank you for cloning!  
Bye bye!
