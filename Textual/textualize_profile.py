from datetime import datetime
from pyfiglet import Figlet
from rich import pretty, inspect, print

from textual.app import App
from textual.widget import Widget

from rich.align import Align
from rich.console import Console
from rich.padding import Padding
from rich.text import Text

console = Console()


class Clock(Widget):
    def on_mount(self):
        self.set_interval(1, self.refresh)

    def render(self):
        day = datetime.now().strftime("%a")
        time = datetime.now().strftime("%I : %M")
        ascii_image = r"""
              _oo0oo_
             o8888888o
             8`" . `"8
             (| -_- |)
             0\  =  /0
           ___/`----'\___
         .' \\|     |// '.
        / \\|||  :  |||// \\
       / _||||| -:- |||||- \\
      |   | \\\  -  /// |   |
      | \_|  ''\---/''  |_/ |
      \  .-\__  '-'  ___/-. /
    ___'._.'__/--.--\__`._.'___"""

        return Align.center(Padding(Text.assemble(
                                (Figlet(font='standard').renderText(time), "cyan"),
                                (ascii_image, "yellow"),
                            ), (0, 1)
        ))


class ClockApp(App):
    async def on_mount(self):
        clock = Clock()
        await self.view.dock(clock)


ClockApp.run()
