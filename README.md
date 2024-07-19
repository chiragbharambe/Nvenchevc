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

## Example

The script will look for `.mkv` and `.mp4` files in the directory it is placed in and re-encode them. If successful, the original file is replaced with the processed file.
