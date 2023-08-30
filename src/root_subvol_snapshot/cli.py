"""
Provide CLI

This module provides the CLI to enter the program.
"""
from typer import Typer

app = Typer()

app.command()(lambda: None)

if __name__ == "__main__":
    app()
