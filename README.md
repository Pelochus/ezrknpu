# ezrknpu
Easy usage of Rockchip's NPU found in RK3588 and similar chips. This includes ChatGPT-like LLMs and models like YoloV5. 
This repo is divided in two submodules:
- https://github.com/Pelochus/ezrknn-llm
- https://github.com/Pelochus/ezrknn-toolkit2

Currently, `ezrknn-llm` is based on version 1.2.1 of `rknn-llm`. 

`ezrknn-toolkit2` is based on version 2.3.2 of `rknn-toolkit2`.



You can find LLMs converted to `.rkllm` format on HuggingFace. Keep in mind that different `rknn-llm` versions differ in
which converted LLMs are compatible. For example, LLMs converted before 1.1.0 are not compatible with the ones converted in version 1.1.x.

Below some users that have converted many LLMs and uploaded them on HuggingFace:
- https://huggingface.co/imkebe (possibly best option for current version: 1.2.0)
- https://huggingface.co/c01zaut
- https://huggingface.co/macrae
- https://huggingface.co/Pelochus/ezrkllm-collection (the ones I converted. Many are not updated, better go for the other options!)

Currently focusing only on RK3588 and RK3588S

## Demo Videos
Check out these links to see some LLMs in action:
- Llama 2 7B on the NPU: https://www.reddit.com/r/RockchipNPU/comments/1ci7p72/rk3588_running_llama2_7b/
- Qwen 1.8B on the NPU: https://www.reddit.com/r/RockchipNPU/comments/1c0x7c2/first_llm_running_on_rk3588_npu/
- **(OUTDATED)** Tutorial for Llama 2 7B on the NPU: https://www.youtube.com/watch?v=KB9qRwj1pnU

## Tutorial from scratch
You can check this XDA article on how to use this from scratch to run LLMs on an Orange Pi 5 Pro.
It is slightly outdated, so you might need to download other LLMs:

https://www.xda-developers.com/how-i-used-the-npu-on-my-orange-pi-5-pro-to-run-llms/

## Requirements
For now, I'm avoiding Android and other SoCs that are not RK3588, so the requirements are:
- Installing what's needed for Linux and running on the SBC directly
- Rockchip RK3588 and RK3588S
- Using NPU driver 0.9.6 or higher. **Current and recommended driver is 0.9.8**. Check it with `dmesg | grep -i rknpu`
- You are running either Debian 11 or Ubuntu 22.04 or later versions. Derivatives should possibly work fine too
- **Python 3.12**. Most recent OSes ship with this version by default, but if you want to use another version you are on your own

### Recommended OS
I recommend using [Armbian](https://www.armbian.com/)
which has the NPU driver updated to latest (as of writing, 0.9.8).

If you do not use Armbian you risk not having the updated NPU driver and have a different, incompatible Python version.

## Quick Install
This will install required dependencies, packages, libraries and install both RKNN Toolkit 2 and RKNN LLM.

Run: 
```bash
curl https://raw.githubusercontent.com/Pelochus/ezrknpu/main/install.sh | sudo bash
```

## Custom install
You can download the `install.sh` script in this repo and run it with:
- `-llm`: for installing only RKNN LLM
- `-toolkit`: for installing only RKNN Toolkit 2

## Running
Depending on what you want to run, please refer to these links:

### Test Run
Currently, easiest model to run is DeepSeek-R1-Distill-Qwen-1.5B. To run it:

```bash
GIT_LFS_SKIP_SMUDGE=1 git clone https://huggingface.co/Pelochus/deepseek-R1-distill-qwen-1.5B # Running git lfs pull after is usually better
cd deepseek-R1-distill-qwen-1.5B && git lfs pull # Pull model
rkllm DeepSeek-R1-Distill-Qwen-1.5B_W8A8_RK3588.rkllm 1024 1024 # Run!

# Note: You can change the Max New Tokens and Max Context Length in the last command!
# It will use more RAM though, but responses can be longer
```

Wait before the model loads. Keep in mind this is a reasoning model. It also DOES NOT have memory between messages (can be changed on `llm_demo.cpp` and recompiled if you desire)

### Running and using the RKNN-Toolkit for NN applications
https://github.com/Pelochus/ezrknn-toolkit2/?tab=readme-ov-file#test

<hr>

## Checking NPU info
### NPU usage
You have 3 options for checking usage:
- rknputop (graphical option, works on OSes without GUI): https://github.com/ramonbroox/rknputop
- Running `ntop.sh`, from this repo which runs the command from next point every 0.5 s
- Running `sudo cat /sys/kernel/debug/rknpu/load`

### NPU driver
Run `dmesg | grep -i rknpu` and it should output something like:

```bash
[    7.648610] RKNPU fdab0000.npu: Adding to iommu group 0
[    7.648747] RKNPU fdab0000.npu: RKNPU: rknpu iommu is enabled, using iommu mode
[    7.648893] RKNPU fdab0000.npu: Looking up rknpu-supply from device tree
[    7.650056] RKNPU fdab0000.npu: Looking up mem-supply from device tree
[    7.652808] RKNPU fdab0000.npu: can't request region for resource [mem 0xfdab0000-0xfdabffff]
[    7.652838] RKNPU fdab0000.npu: can't request region for resource [mem 0xfdac0000-0xfdacffff]
[    7.652859] RKNPU fdab0000.npu: can't request region for resource [mem 0xfdad0000-0xfdadffff]
[    7.653197] [drm] Initialized rknpu 0.9.5 20240226 for fdab0000.npu on minor 1
```

## Useful Links
- Dedicated subreddit. I **strongly recommend** taking a look at the wiki and various posts there: https://www.reddit.com/r/RockchipNPU/
- LLM submodule for this repo: https://github.com/Pelochus/ezrknn-llm
- NN submodule for this repo: https://github.com/Pelochus/ezrknn-toolkit2

## Contributing
Please open an issue or PR on the corresponding submodule repo. If unsure, open it on this repo:
- For RKLLM related: https://github.com/Pelochus/ezrknn-llm
- For RKNN related: https://github.com/Pelochus/ezrknn-toolkit2

Currently (and mainly) there are the following contributions to be made:
- [ ] Other Rockchip SoCs support. Check their documentation to see which are capable.
- [ ] Android support
- [x] Conversion of other compatible LLMs
- [ ] Improve documentation
- [x] Other general improvements to installation scripts, Docker containers, support for other Linux distros like Arch, submitting issues, adding more error checking...

## Credits
To the r/RockchipNPU subreddit, which helped me tremendously with testing and discovering why things failed and how to solve many issues.
