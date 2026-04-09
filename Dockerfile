FROM runpod/worker-comfyui:5.8.5-base

# Custom nodes
RUN comfy-node-install comfyui_controlnet_aux comfyui-kjnodes

# Ensure model directories exist
RUN mkdir -p /comfyui/models/diffusion_models \
    /comfyui/models/text_encoders \
    /comfyui/models/clip_vision \
    /comfyui/models/vae \
    /comfyui/models/loras

# Wan2.2 Animate 14B fp8
RUN curl -L -o /comfyui/models/diffusion_models/Wan2_2-Animate-14B_fp8_e4m3fn_scaled_KJ.safetensors \
    "https://huggingface.co/kijai/WanVideo_comfy/resolve/main/Wan2_2-Animate-14B_fp8_e4m3fn_scaled_KJ.safetensors"

# CLIP text encoder
RUN curl -L -o /comfyui/models/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors \
    "https://huggingface.co/kijai/WanVideo_comfy/resolve/main/umt5_xxl_fp8_e4m3fn_scaled.safetensors"

# CLIP Vision
RUN curl -L -o /comfyui/models/clip_vision/clip_vision_h.safetensors \
    "https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/clip_vision/clip_vision_h.safetensors"

# VAE
RUN curl -L -o /comfyui/models/vae/Wan2_1_VAE_fp32.safetensors \
    "https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/vae/Wan2_1_VAE_fp32.safetensors"

# LoRA
RUN curl -L -o /comfyui/models/loras/lightx2v_I2V_14B_480p_cfg_step_distill_rank128_bf16.safetensors \
    "https://huggingface.co/kijai/WanVideo_comfy/resolve/main/lightx2v_I2V_14B_480p_cfg_step_distill_rank128_bf16.safetensors"

# DWPose models
RUN mkdir -p /comfyui/custom_nodes/comfyui_controlnet_aux/ckpts/yzd-v/DWPose \
    "/comfyui/custom_nodes/comfyui_controlnet_aux/ckpts/hr16/DWPose-TorchScript-BatchSize5" && \
    curl -L -o /comfyui/custom_nodes/comfyui_controlnet_aux/ckpts/yzd-v/DWPose/yolox_l.onnx \
    "https://huggingface.co/yzd-v/DWPose/resolve/main/yolox_l.onnx" && \
    curl -L -o "/comfyui/custom_nodes/comfyui_controlnet_aux/ckpts/hr16/DWPose-TorchScript-BatchSize5/dw-ll_ucoco_384_bs5.torchscript.pt" \
    "https://huggingface.co/hr16/DWPose-TorchScript-BatchSize5/resolve/main/dw-ll_ucoco_384_bs5.torchscript.pt"

# Workflow
COPY workflow_api.json /comfyui/workflow_api.json
