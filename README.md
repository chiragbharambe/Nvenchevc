Alpha release.

# Video Processor Script

This repository contains a bash script that processes video files in a specified folder using the FFmpeg tool with `hevc_nvenc` encoding support. The script ensures that FFmpeg with `hevc_nvenc` is available, and it processes `.mkv` and `.mp4` files by re-encoding them. The script provides a progress bar and an estimated time of arrival (ETA) for the entire processing.

## Prerequisites

- **FFmpeg with NVIDIA GPU support (hevc_nvenc)**: Ensure that FFmpeg is installed and supports the `hevc_nvenc` encoder.
  
  ```bash
  ffmpeg -encoders | grep hevc_nvenc
  ```

- **Bash Shell**: This script is written in Bash and should be run in a Unix-like environment (Linux, macOS).

## Usage

1. **Clone the repository**:

   ```bash
   git clone https://github.com/yourusername/video-processor.git
   cd video-processor
   ```

2. **Make the script executable**:

   ```bash
   chmod +x process_videos.sh
   ```

3. **Run the script**:

   Place the script in the directory containing the video files you want to process and then execute it:

   ```bash
   ./process_videos.sh
   ```

   Alternatively, you can specify the folder containing the videos:

   ```bash
   folder_path="/path/to/your/video/files" ./process_videos.sh
   ```

## Script Details

- **Check FFmpeg and hevc_nvenc**:
  The script first checks if FFmpeg with `hevc_nvenc` support is available. If not, it exits with an error message.

- **Process Video File**:
  It processes each video file by re-encoding it using the `hevc_nvenc` encoder with quality preset `-qp 28`.

- **Progress Bar and ETA**:
  The script features a progress bar with an estimated time of arrival (ETA) that updates as each video file is processed.

- **File Validation**:
  It validates the input file to ensure it is a proper video file before attempting to process it.

- **File Size Assessment**:
  The script can assess the quality and size of the file to avoid re-encoding videos that are already small.

## Future Plans and Goals

1. **Text User Interface (TUI)**:
   - Integrate a TUI similar to `dua` for an interactive and user-friendly experience.

2. **File Quality Assessment**:
   - Implement functionality to assess the quality and size of each video file.
   - Skip re-encoding for videos that are already small to save processing time.

3. **Phone Automation**:
   - Set up automation with your mobile phone to streamline video processing:
     - When connected to a specified Wi-Fi network, the phone will automatically send captured videos to the computer.
     - The computer will process the videos, save the original, and send the processed video back to the phone.
     - The original video will be deleted from the phone, but both original and processed versions will be saved on the computer.
     - This setup aims to save significant storage space on the phone as videos captured by phones are typically large in size.
