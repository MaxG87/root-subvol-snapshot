from root_subvol_snapshot.cli import app
from typer.testing import CliRunner

runner = CliRunner()


def test_cli():
    result = runner.invoke(app, ["--help"])
    assert result.exit_code == 0
    assert "Show this message and exit." in result.output
