#!/bin/bash

# Output file
OUTPUT_FILE="gallery.html"

# Start HTML
cat <<EOF > "$OUTPUT_FILE"
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Quokka Gallery</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- LightGallery CSS -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/lightgallery@2.7.1/css/lightgallery-bundle.min.css">
  <style>
    body { font-family: sans-serif; margin: 0; padding: 20px; background: #f9f9f9; }
    h1 { text-align: center; }
    .gallery { display: flex; flex-wrap: wrap; gap: 10px; justify-content: center; }
    .gallery a { width: 200px; }
    .gallery img { width: 100%; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); }
  </style>
</head>
<body>
  <h1>Quokka Gallery</h1>
  <div id="lightgallery" class="gallery">
EOF

# Add images to HTML
find . -maxdepth 1 -type f \( -iname "*.png" -o -iname "*.webp" \) | sort | while read -r image; do
  clean_name=$(echo "$image" | sed 's|^\./||')
  cat <<EOF >> "$OUTPUT_FILE"
    <a href="${clean_name}" data-lg-size="1400-800">
      <img src="${clean_name}" alt="${clean_name}">
    </a>
EOF
done

# End HTML
cat <<EOF >> "$OUTPUT_FILE"
  </div>

  <!-- LightGallery JS -->
  <script src="https://cdn.jsdelivr.net/npm/lightgallery@2.7.1/lightgallery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/lightgallery@2.7.1/plugins/zoom/lg-zoom.min.js"></script>
  <script>
    lightGallery(document.getElementById('lightgallery'), {
      plugins: [lgZoom],
      speed: 500
    });
  </script>
</body>
</html>
EOF

echo "gallery.html generated with LightGallery support."

