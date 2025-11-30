import json
from fastapi import FastAPI, Form, File, UploadFile
from fastapi.middleware.cors import CORSMiddleware
from typing import Optional
import uvicorn
import asyncio
import re

# 1. ADMIN MODE CONSTANTS
# Keywords that trigger Admin/Safely Browse mode
ADMIN_KEYS = [
    "KSU SHALOM", 
    "KSU RAIN", 
    "KSU PG", 
    "SHALOM AZUWIKE", 
    "PRAISEGOD CLEMENT", 
    "RAIN KALUDGAN"
]

app = FastAPI()

# Add Middleware to allow communication from Flutter (necessary for cross-origin local calls)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)


def is_admin_mode(text_command: str) -> bool:
    """Checks the text for Admin keywords (case-insensitive)."""
    text = text_command.upper()
    return any(key in text for key in ADMIN_KEYS)

# 2. CORE STREAMING COMMAND ENDPOINT
@app.post("/stream_command/")
async def stream_command(
    command: str = Form(...),
    file_name: Optional[str] = Form(None),
    is_multimodal: bool = Form(False) 
):
    """
    Receives a command (and optional file metadata) and streams the response 
    back to simulate real-time typing.
    """
    is_admin = is_admin_mode(command)
    
    # --- Response Generation Logic ---
    if is_admin:
        intro = (
            "Admin Mode Activated. Welcome, Founder! Full online browsing and cloud features "
            "are now safely enabled for system review. What high-level directive do you have?"
        )
    elif "test" in command.lower():
        intro = "Connection confirmed. FastAPI is streaming data to Flutter in real-time. This pipeline is functional!"
    else:
        intro = "Understood. Running command in Offline-First Mode. Processing with locally tuned LLAMA models."

    if is_multimodal and file_name:
        intro += f"\n\n**File Detected:** Analyzing uploaded file **'{file_name}'**. I'll perform local data extraction and prepare an offline summary based on its contents."

    # Split the response by spaces to simulate word-by-word streaming
    response_chunks = [chunk for chunk in re.split(r'(\s+)', intro)] 
    
    # --- FastAPI Streaming Implementation ---
    async def response_stream():
        for chunk in response_chunks:
            if chunk.strip():
                # Simulate typing speed for realism
                await asyncio.sleep(0.03) 
            
            # Yield JSON chunk for Flutter to append
            yield json.dumps({"text_chunk": chunk, "end_of_stream": False}) + '\n'
        
        # Final chunk signal to end the stream
        await asyncio.sleep(0.1)
        yield json.dumps({"text_chunk": "", "end_of_stream": True}) + '\n'

    from fastapi.responses import StreamingResponse
    # Ensure the correct media type for JSON streaming
    return StreamingResponse(response_stream(), media_type="application/json")


# 3. FILE UPLOAD ENDPOINT (Placeholder for future direct binary upload)
@app.post("/upload_binary_file/")
async def upload_binary_file(file: UploadFile = File(...)):
    """
    This endpoint demonstrates how to accept the raw file data itself.
    """
    # For now, we only confirm receipt. You would add LLAMA processing here.
    content = await file.read()
    return {"message": f"Received binary file {file.filename} (Size: {len(content)} bytes). Ready for local LLAMA parsing."}

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)