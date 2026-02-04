# NVIDIA Specific notes

In order for NVIDIA functionality to be present in containers the following prerequisites must be satisfied
1. NVIDIA drivers are installed on the host (Refer to your distro's recommendation)
2. [Nvidia-container-toolkit is installed and configured](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html)

## Optimus / Multi-GPU
For CUDA/Compute, this is generally sufficient.
However, if you want to use the nvidia GPU for rendering **_AND_** the nvidia GPU isn't the primary GPU of your computer, also do the following.

1. Create an overlay/override for the nvidia-cdi-refresh.path trigger
```sh 
sudo systemctl edit nvidia-cdi-refresh.path
```
2. Type the following in the designated area

```ini
[Path]
PathChanged=/dev/nvidia-modeset
```

> Normally `nvidia-cdi-refresh.service` activates early in the boot process, which under normal circumstances is sufficient. However, for dual-GPU setups, `nvidia-modeset` is created later as it isn't essential for display. This procedure adds an extra trigger to watch for the eventual existence of the `nvidia-modeset` device file, and re-triggers the service so that the container would have access to rendering capabilities.

> [`nvidia-drm.modeset` is covered _somewhat_ in the ArchLinux wiki.](https://wiki.archlinux.org/title/NVIDIA#DRM_kernel_mode_setting) [You can choose to eagerly load the modules by placing them in the `initramfs`](https://wiki.archlinux.org/title/NVIDIA#Early_loading), but I (derrick) do not recommend such an invasive measure for the sake of long-term system stability/anti-hysterisis.

> Normally this is harmless, and should not affect systems unaffected by this quirk. However, if you wish to revert all overrides, you may run the following command
> ```sh
systemctl revert unit
```