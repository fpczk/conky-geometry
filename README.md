# conky-geometry

__Work in Progress__

Lua functions for conky, inpired by [dailyminimal.com](http://www.dailyminimal.com/)

## Setup

Just copy *conky_geometry.lua* to *~/.conky/conky_geometry.lua*.

## Usage

There is an example config file, *geometry.conky*, which can be used with the following command:

```
conky -c geometry.conky
```

### Arguments

* *x, y*: Coordinates
* *perc*: Percentage value between 0 and 100
* *size*: Scale factor, for default size use 1.0
* *label*: String to display

### Functions

```
${lua geo_slicedtriangle x y perc1 perc2 perc3 ...}
${lua geo_clock x y}
${lua geo_dotspiral x y perc1 perc2 perc3 ...}
${lua geo_exclusivesquares x y perc}
${lua geo_cropped_triangle x y size perc label}
```