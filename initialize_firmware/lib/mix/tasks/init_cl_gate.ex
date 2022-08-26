defmodule Mix.Tasks.InitClGate do
  @moduledoc "Initializa a CompuLogic Gateway with a bootloader and firmware"
  @shortdoc "Initialize CL Gateway"

  use Mix.Task

  @impl Mix.Task
  def run(_args) do
    # Call "mix firmware" to ensure that the firmware bundle is up-to-date
    Mix.Task.run("firmware", [])

    Mix.shell().info("Initialize CL Gateway")

    system_path = Nerves.Env.system_path()
    bootloader_path = Path.join([system_path, "images", "imx8-boot-sd.bin"])

    Mix.shell().info("Bootloader: #{bootloader_path}")

    app_name = Mix.Project.config()[:app]
    images_path = Nerves.Env.images_path()
    firmware_path = Path.join([images_path, "#{app_name}.fw"])
    img_path = Path.join([images_path, "#{app_name}.img"])

    Mix.shell().info("Firmware: #{firmware_path}")

    :os.cmd('fwup -a -d #{img_path} -i #{firmware_path} -t complete')
    Mix.shell().info("""
    Run the following command to deploy:

    sudo uuu -v -b emmc_all #{bootloader_path} #{img_path}

    """)
  end
end
