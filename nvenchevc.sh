#!/bin/bash

# Define the folder path
folder_path="$(dirname "$0")"

# Check if FFmpeg is installed and supports hevc_nvenc
if ! ffmpeg -hide_banner -encoders | grep -q hevc_nvenc; then
    echo "FFmpeg with hevc_nvenc support is not available."
    exit 1
fi

# Start time of the script
script_start_time=$(date +%s)

# Function to process a single video file
process_video_file() {
  local input_file="$1"
  local extension="${input_file##*.}"
  local temp_file="${input_file%.*}_temp.${extension}"
  echo -n "Processing: ${input_file}..."

  local file_start_time=$(date +%s)

  # Check if the input file is valid
  if ! ffmpeg -v error -i "${input_file}" -f null -; then
    echo " Invalid file. Skipping."
    return
  fi

  # Processing the video file
  if ffmpeg -i "${input_file}" -c:v hevc_nvenc -rc constqp -qp 28 -look_ahead 1 -c:a copy -c:s copy -loglevel error "${temp_file}"; then
    if [ -s "${temp_file}" ]; then
      mv "${temp_file}" "${input_file}"
      echo " Done"
      ((processed_files++))
    else
      echo " Processing resulted in an empty file. Skipping."
      rm -f "${temp_file}"
    fi
  else
    echo " Error during processing. Skipping."
    rm -f "${temp_file}"
  fi

  local file_end_time=$(date +%s)
  local total_time=$((file_end_time - file_start_time))
 # update_progress_bar_and_eta "$total_time"
}

# Function to update progress bar and ETA
update_progress_bar_and_eta() {
  local processing_time=$1
  time_per_file=$(( (time_per_file * (processed_files - 1) + processing_time) / processed_files ))
  time_per_file=${time_per_file:-0} # Prevent division by zero

  if [ $total_files -gt 0 ]; then
    local percentage=$((processed_files * 100 / total_files))
    local bar=$(printf '%*s' "$((percentage / 10))" | tr ' ' '#')
    local eta=$((time_per_file * (total_files - processed_files) / 60))
    printf "\rProgress: [%-10s] %d%% (%d/%d) - ETA: ~%d min" "$bar" "$percentage" "$processed_files" "$total_files" "$eta"
  fi
}

# Count total files to process
total_files=$(find "${folder_path}" -type f \( -iname "*.mkv" -o -iname "*.mp4" \) | wc -l)
processed_files=0
time_per_file=0

echo "Total files to process: ${total_files}"

# Process each file
export -f process_video_file
find "${folder_path}" -type f \( -iname "*.mkv" -o -iname "*.mp4" \) -exec bash -c 'process_video_file "$0"' {} \;

# End time of the script
script_end_time=$(date +%s)
total_script_time=$((script_end_time - script_start_time))
echo -e "\nAll files processed in ~$((total_script_time / 60)) min."
