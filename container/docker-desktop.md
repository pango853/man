
# Installation

## Install Docker for Windows

	https://docs.docker.com/docker-for-windows/install/
	Get Docker CE for Windows (stable)

powershell
> docker --version

All binaries are in
C:\Program Files\Docker\Docker\resources\bin

> docker run --rm busybox echo hello_world
> docker run --rm --platform linux busybox echo hello_world

## Install Kitematic

Kitematic-Windows.zip
to
C:\Program Files\Docker\Kitematic


# Troubleshooting

## エラー”could not read CA certificate”が表示された時の対処方法

「Docker Tool」をインストールした後に「Docker for WIndows」をインストールすると以下のエラーが発生します。

> [Environment]::SetEnvironmentVariable("DOCKER_CERT_PATH", $null, "User")
> [Environment]::SetEnvironmentVariable("DOCKER_HOST", $null, "User")
> [Environment]::SetEnvironmentVariable("DOCKER_MACHINE_NAME", $null, "User")
> [Environment]::SetEnvironmentVariable("DOCKER_TLS_VERIFY", $null, "User")
> [Environment]::SetEnvironmentVariable("DOCKER_TOOLBOX_INSTALL_PATH", $null, "User")
上記のコマンド実行後に、「DockerTool」、「Docer for Window」を削除して、再度インストールしなおしましょう。