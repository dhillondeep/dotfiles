-- Ctrl + ` to open and close kitty terminal
hs.hotkey.bind({"ctrl"}, "`", function()
  local app = hs.application.get("Alacritty")

  if app then
      if not app:mainWindow() then
          app:mainWindow():moveToUnit'[100,50,0,0]'
          app:selectMenuItem({"Alacritty", "Alacritty"})
      elseif app:isFrontmost() then
          app:hide()
      else
          app:activate()
      end
  else
      hs.application.launchOrFocus("Alacritty")
      app = hs.application.get("Alacritty")
  end

  app:mainWindow():moveToUnit'[100,50,0,0]'
  app:mainWindow().setShadows(false)
end)
