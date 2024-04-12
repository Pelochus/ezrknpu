# ezrknpu
Easy usage of Rockchip's NPU found in RK3588 and similar chips. This includes ChatGPT-like LLMs and Neural Networks programs like YoloV5. 
This repo is divided in two submodules:
- https://github.com/Pelochus/ezrknn-llm
- https://github.com/Pelochus/ezrknn-toolkit2

Apart from that, you can find converted LLMs (and how to download them) here:
- https://huggingface.co/Pelochus/ezrkllm-collection

Currently focusing only on RK3588 and RK3588S.

## Requirements
Keep in mind this repo is focused for:
- Installing what's needed for Linux and running on the SBC directly.
- Rockchip RK3588, but I accept contributions for running on other compatible Rockchip SoCs.
- You are running either Debian 11 or Ubuntu 22.04 or later versions. Derivatives should possibly work fine too.

## Quick Install
TODO SCRIPT

## Running
Depending on what you want to run, please refer to these links:

### Downloading and running a LLM on your NPU
For downloading:
- https://huggingface.co/Pelochus/ezrkllm-collection

For running an already downloaded model:
- https://github.com/Pelochus/ezrknn-llm?tab=readme-ov-file#test

Converting a compatible model to RKLLM format (check previously Rockchip's docs on rknn-llm repo):
- https://github.com/Pelochus/ezrknn-llm?tab=readme-ov-file#converting-llms-for-rockchips-npus

### Running and using the RKNN-Toolkit for NN applications
https://github.com/Pelochus/ezrknn-toolkit2/?tab=readme-ov-file#test

## How to know NPU usage
You have 3 options:
- rknputop with a graphical option: https://github.com/ramonbroox/rknputop
- Running `ntop.sh`, from this repo which runs the command from next point every 0.5 s
- Running `sudo cat /sys/kernel/debug/rknpu/load`

## Contributing
Please open an issue or PR on the corresponding submodule repo:
- For RKLLM related: https://github.com/Pelochus/ezrknn-llm
- For RKNN related: https://github.com/Pelochus/ezrknn-toolkit2

Currently (and mainly) there are the following contributions to be made:
- [ ] Other Rockchip SoCs support. Check their documentation to see which are capable.
- [ ] Android support
- [ ] Conversion of other compatible LLMs (Llama 2 mainly, since I'm low on RAM)
- [ ] Improve documentation
- [ ] Other general improvements to installation scripts, Docker containers, support for other Linux distros like Arch, submitting issues, adding more error checking...

## Useful Links
- Dedicated subreddit. I **strongly recommend** taking a look at the wiki and various posts there: https://www.reddit.com/r/RockchipNPU/
- LLM submodule for this repo: https://github.com/Pelochus/ezrknn-llm
- NN submodule for this repo: https://github.com/Pelochus/ezrknn-toolkit2
