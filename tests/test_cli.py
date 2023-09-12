from root_subvol_snapshot.cli import app
from typer.testing import CliRunner

runner = CliRunner()


def test_cli():
    result = runner.invoke(app, ["--help"])
    assert result.exit_code == 0
    assert "Show this message and exit." in result.output


def test_open():
    result = runner.invoke(app, ["open"])
    assert result.exit_code == 0
    assert result.output.startswith("Opening")


def test_open_with_argument(tmp_path):
    result = runner.invoke(app, ["open", str(tmp_path)])
    assert result.exit_code == 0
    assert result.output.endswith(f"{tmp_path}...\n")


def test_close():
    result = runner.invoke(app, ["close"])
    assert result.exit_code == 0
    assert result.output.startswith("Closing")


def test_close_with_argument(tmp_path):
    result = runner.invoke(app, ["close", str(tmp_path)])
    assert result.exit_code == 0
    assert result.output.endswith(f"{tmp_path}...\n")


def test_snapshot():
    result = runner.invoke(app, ["snapshot"])
    assert result.exit_code == 0
    assert result.output.startswith("Making a snapshot of the root subvolume...")
