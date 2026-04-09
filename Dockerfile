FROM runpod/worker-comfyui:latest-base

# Only custom nodes — models come from Network Volume at runtime
RUN comfy-node-install comfyui_controlnet_aux comfyui-kjnodes
