# Install packages if needed
install.packages(c("magick", "glue"))
library(magick)
library(glue)

# Folders
img_dir <- "images"       # original images
thumb_dir <- "thumbs"     # thumbnails folder

# Create thumbnails folder if it doesn't exist
if(!dir.exists(thumb_dir)) dir.create(thumb_dir)

# List all image files
imgs <- list.files(img_dir, pattern = "\\.jpg$|\\.png$|\\.jpeg$", ignore.case = TRUE)

# Generate thumbnails
for (img in imgs) {
  image_read(file.path(img_dir, img)) |>
    image_scale("300") |>  # width 300px
    image_write(file.path(thumb_dir, img))
}

# Build HTML gallery code
html_code <- ""
for (img in imgs) {
  full_path <- file.path(img_dir, img)
  thumb_path <- file.path(thumb_dir, img)
  
  html_code <- paste0(html_code, 
                      glue('<a href="{full_path}" data-lightbox="gallery" data-title="{img}">
           <img src="{thumb_path}" alt="{img}" style="margin:5px; border:1px solid #ccc;">
         </a>\n')
  )
}

# Save HTML snippet
writeLines(html_code, "gallery.html")

cat("✅ Gallery HTML saved to gallery.html — paste it into your QMD file!\n")
