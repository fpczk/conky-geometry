# conky-geomatry

Lua functions for conky, inpired by [dailyminimal.com](http://www.dailyminimal.com/)

## Usage

Arguments:

* *x, y*: Coordinates
* *perc*: Percentage value between 0 and 100
* *size*: Scale factor, for default size use 1.0
* *label*: String to display

```
${lua geo_slicedtriangle x y perc1 perc2 perc3 ...}
${lua geo_clock x y}
${lua geo_dotspiral x y perc1 perc2 perc3 ...}
${lua geo_exclusivesquares x y perc}
${lua geo_cropped_triangle x y size perc label}
```