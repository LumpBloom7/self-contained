# USB over IP (for MacOS and Windows)

[Follow the steps here](https://docs.docker.com/desktop/features/usbip/)



## Quick start

### In USBIP local repo
cargo run --example host && docker run --rm -it --pid=host --privileged alpine

> nsenter -t 1 -m
> >  usbip attach -r host.docker.internal -d 1-7-4
