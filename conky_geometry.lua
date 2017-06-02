require 'cairo'

COLOR_ACCENT_R = 0.784
COLOR_ACCENT_G = 0.431
COLOR_ACCENT_B = 0.276
COLOR_ACCENT_A = 0.0

COLOR_SECONDARY_R = 0.9
COLOR_SECONDARY_G = 0.9
COLOR_SECONDARY_B = 0.9
COLOR_SECONDARY_A = 1.0

function init_cairo()
  if conky_window == nil then
    return false
  end

  cs = cairo_xlib_surface_create(
    conky_window.display,
    conky_window.drawable,
    conky_window.visual,
    conky_window.width,
    conky_window.height)

  cr = cairo_create(cs)

  font = "Mono"
  cairo_select_font_face(cr, font, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL)
  cairo_set_source_rgba(cr, COLOR_FONT_R, COLOR_FONT_G, COLOR_FONT_B, 1)

  return true
end

function conky_main()
  if (not init_cairo()) then
    return
  end

end

function conky_geo_clock(cx_str, cy_str)
    local cx = tonumber(cx_str)
    local cy = tonumber(cy_str)
    local segmentsH = 45
    local segmentsM = 50
    local segmentsS = 60
    local radius = 120.0
    local accent_segment = 1
    local seconds = tonumber(os.date("%S"))
    local minutes = tonumber(os.date("%M")) + seconds/60.0
    local hour = tonumber(os.date("%I")) + minutes/60.0
    local tauH = hour / 12 * 2 * math.pi - 0.15 
    local tauM = minutes / 60 * 2 * math.pi - 0.15 
    local tauS = seconds / 60 * 2 * math.pi - 0.15 
    for i = 1, segmentsH do
      if i == accent_segment then
        cairo_set_source_rgba(cr, COLOR_ACCENT_R, COLOR_ACCENT_G, COLOR_ACCENT_B, COLOR_ACCENT_A)
      else
        cairo_set_source_rgba(cr, COLOR_SECONDARY_R, COLOR_SECONDARY_G, COLOR_SECONDARY_B, COLOR_SECONDARY_A)
      end
      local angle0 = i / segmentsH * 2 * math.pi
      local angle1 = (i + 0.8) / segmentsH * 2 * math.pi
      local radius0 = radius * 0.67
      local radius1 = radius * 0.76
      cairo_move_to(cr, cx + radius0 * math.sin(angle0 + tauH), cy - radius0 * math.cos(angle0 + tauH))
      cairo_line_to(cr, cx + radius1 * math.sin(angle0 + tauH), cy - radius1 * math.cos(angle0 + tauH))
      cairo_line_to(cr, cx + radius1 * math.sin(angle1 + tauH), cy - radius1 * math.cos(angle1 + tauH))
      cairo_line_to(cr, cx + radius0 * math.sin(angle1 + tauH), cy - radius0 * math.cos(angle1 + tauH))
      cairo_fill(cr)
    end
    for i = 1, segmentsM do
      if i == accent_segment then
        cairo_set_source_rgba(cr, COLOR_ACCENT_R, COLOR_ACCENT_G, COLOR_ACCENT_B, COLOR_ACCENT_A)
      else
        cairo_set_source_rgba(cr, COLOR_SECONDARY_R, COLOR_SECONDARY_G, COLOR_SECONDARY_B, COLOR_SECONDARY_A)
      end
      local angle0 = i / segmentsM * 2 * math.pi
      local angle1 = (i + 0.8) / segmentsM * 2 * math.pi
      local radius0 = radius * 0.79
      local radius1 = radius * 0.88
      cairo_move_to(cr, cx + radius0 * math.sin(angle0 + tauM), cy - radius0 * math.cos(angle0 + tauM))
      cairo_line_to(cr, cx + radius1 * math.sin(angle0 + tauM), cy - radius1 * math.cos(angle0 + tauM))
      cairo_line_to(cr, cx + radius1 * math.sin(angle1 + tauM), cy - radius1 * math.cos(angle1 + tauM))
      cairo_line_to(cr, cx + radius0 * math.sin(angle1 + tauM), cy - radius0 * math.cos(angle1 + tauM))
      cairo_fill(cr)
    end
    for i = 1, segmentsS do
      if i == accent_segment then
        cairo_set_source_rgba(cr, COLOR_ACCENT_R, COLOR_ACCENT_G, COLOR_ACCENT_B, COLOR_ACCENT_A)
      else
        cairo_set_source_rgba(cr, COLOR_SECONDARY_R, COLOR_SECONDARY_G, COLOR_SECONDARY_B, COLOR_SECONDARY_A)
      end
      local angle0 = i / segmentsS * 2 * math.pi
      local angle1 = (i + 0.8) / segmentsS * 2 * math.pi
      local radius0 = radius * 0.91
      local radius1 = radius * 1.0
      cairo_move_to(cr, cx + radius0 * math.sin(angle0 + tauS), cy - radius0 * math.cos(angle0 + tauS))
      cairo_line_to(cr, cx + radius1 * math.sin(angle0 + tauS), cy - radius1 * math.cos(angle0 + tauS))
      cairo_line_to(cr, cx + radius1 * math.sin(angle1 + tauS), cy - radius1 * math.cos(angle1 + tauS))
      cairo_line_to(cr, cx + radius0 * math.sin(angle1 + tauS), cy - radius0 * math.cos(angle1 + tauS))
      cairo_fill(cr)
    end
end

function conky_geo_cropped_triangle(cx_str, cy_str, size_str, percent_str, label_str)
  local cx = tonumber(cx_str)
  local cy = tonumber(cy_str)
  local size = tonumber(size_str)
  local percent = tonumber(conky_parse(percent_str))
  local label = ""
  if label_str ~= nil then
    label = conky_parse(label_str)
  end

  cairo_set_source_rgba(cr, COLOR_SECONDARY_R, COLOR_SECONDARY_G, COLOR_SECONDARY_B, COLOR_SECONDARY_A)

  -- line
  cairo_move_to(cr, cx, cy - size * percent)
  cairo_rel_line_to(cr, size * 350, 0)
  cairo_stroke(cr)

  -- triangle
  cairo_move_to(cr, cx + size * 220, cy)
  cairo_rel_line_to(cr, size * 115.47, 0)
  cairo_rel_line_to(cr, -size * 57.735, -size * 100)
  cairo_close_path(cr);
  cairo_stroke(cr)

  -- filled area
  cairo_move_to(cr, cx + size * 220, cy)
  cairo_rel_line_to(cr, size * 115.47, 0)
  cairo_rel_line_to(cr, -size * 57.735 * percent / 100, -size * percent)
  cairo_rel_line_to(cr, -size * 115.47 * (100-percent) / 100, 0)
  cairo_fill(cr)

  cairo_set_font_size(cr, size * 25)
  cairo_move_to(cr, cx + size * 6, cy - size * percent - 6)
  cairo_show_text(cr, label)
  cairo_stroke(cr)
end

function conky_geo_dotspiral(cx_str, cy_str, ...)
  local cx = tonumber(cx_str)
  local cy = tonumber(cy_str)
  local arms = math.ceil(24 / table.getn(arg)) * table.getn(arg)
  local rows = 10
  local radius0, radius1 = 50, 140
  local dotradius = 4
  for i,v_str in ipairs(arg) do
    v = tonumber(conky_parse(v_str))
    for j = i-1, arms - 1, table.getn(arg) do
      local p = j / arms
      for k = 0, v / rows  do
        local dx = cx + (radius0 + (radius1-radius0) * k/rows) * math.cos(p * 2*math.pi + k * math.pi/arms)
        local dy = cy + (radius0 + (radius1-radius0) * k/rows) * math.sin(p * 2*math.pi + k * math.pi/arms)
        cairo_arc (cr, dx, dy, dotradius, 0, 2 * math.pi)
        cairo_fill(cr)
      end
    end
  end
end

function conky_geo_exclusivesquares(cx_str, cy_str, percent_str)
  local cx = tonumber(cx_str)
  local cy = tonumber(cy_str)
  local p = tonumber(conky_parse(percent_str)) / 100
  local half_diagonal = 50

  cairo_move_to(cr, cx, cy + half_diagonal * p)
  cairo_rel_line_to(cr, half_diagonal * (1-p), half_diagonal * (1-p))
  cairo_rel_line_to(cr, half_diagonal, -half_diagonal)
  cairo_rel_line_to(cr, -half_diagonal, -half_diagonal)
  cairo_rel_line_to(cr, -half_diagonal * (1-p), half_diagonal * (1-p))
  cairo_rel_line_to(cr, half_diagonal * p, half_diagonal * p)
  cairo_move_to(cr, cx, cy + half_diagonal * p)
  cairo_rel_line_to(cr, -half_diagonal * (1-p), half_diagonal * (1-p))
  cairo_rel_line_to(cr, -half_diagonal, -half_diagonal)
  cairo_rel_line_to(cr, half_diagonal, -half_diagonal)
  cairo_rel_line_to(cr, half_diagonal * (1-p), half_diagonal * (1-p))
  cairo_rel_line_to(cr, -half_diagonal * p, half_diagonal * p)

  cairo_fill(cr)
end

function conky_geo_slicedtriangle(cx_str, cy_str, ...)
  local cx = tonumber(cx_str)
  local cy = tonumber(cy_str)
  local size = 1.0
  local n = table.getn(arg)
  local width, height = 115.47, 100
  local slicefraction = 0.05
  local sidefraction = (1 - n * slicefraction) / (n+1)

  cairo_set_source_rgba(cr, COLOR_SECONDARY_R, COLOR_SECONDARY_G, COLOR_SECONDARY_B, COLOR_SECONDARY_A)

  cairo_move_to(cr, cx, cy)
  cairo_rel_line_to(cr, 57.735 * sidefraction , -100 * sidefraction)
  for i, v_str in ipairs(arg) do
    local p = tonumber(conky_parse(v_str)) / 100.0
    local partwidthlow = width * (1 - (i * sidefraction + (i-1) * slicefraction))
    local partwidthhigh = partwidthlow - slicefraction * 115.47
    cairo_rel_line_to(cr, p * partwidthlow, 0)
    cairo_rel_line_to(cr, -slicefraction * 57.735, -slicefraction * 100)
    cairo_rel_line_to(cr, -partwidthhigh, 0)
    cairo_rel_line_to(cr, -slicefraction * 57.735, slicefraction * 100)
    cairo_rel_line_to(cr, (1-p) * partwidthlow, 0)
    cairo_rel_line_to(cr, 57.735 * (sidefraction + slicefraction) , -100 * (sidefraction + slicefraction))
  end
  cairo_rel_line_to(cr, 57.735, 100)
  cairo_fill(cr)
end
