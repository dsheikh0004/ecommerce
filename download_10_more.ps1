$images = @{
    "product-53.jpg" = "https://images.unsplash.com/photo-1614726365723-49cfaa6979e4?q=80&w=800"; # Solar System
    "product-54.jpg" = "https://images.unsplash.com/photo-1516035069371-29a1b244cc32?q=80&w=800"; # Camera
    "product-55.jpg" = "https://images.unsplash.com/photo-1583337130417-3346a1be7dee?q=80&w=800"; # Puppy/Dog
    "product-56.jpg" = "https://images.unsplash.com/photo-1513364776144-60967b0f800f?q=80&w=800"; # Paint/Art
    "product-57.jpg" = "https://images.unsplash.com/photo-1549830500-1c5c56d78772?q=80&w=800"; # Wooden toy
    "product-58.jpg" = "https://images.unsplash.com/photo-1533228100845-08145b01de14?q=80&w=800"; # Marble/Toy
    "product-59.jpg" = "https://images.unsplash.com/photo-1557960309-86ec00220c36?q=80&w=800"; # Plush/Soft
    "product-60.jpg" = "https://images.unsplash.com/photo-1565013000626-444498328c0b?q=80&w=800"; # Hero/Action
    "product-61.jpg" = "https://images.unsplash.com/photo-1507525428034-b723cf961d3e?q=80&w=800"; # Sand/Beach
    "product-62.jpg" = "https://images.unsplash.com/photo-1542642598-a28d752f9540?q=80&w=800"; # Golf/Sport
}

$destDir = "images"
if (!(Test-Path -Path $destDir)) { New-Item -ItemType Directory -Path $destDir }

foreach ($key in $images.Keys) {
    Write-Output "Downloading $key..."
    try {
        Invoke-WebRequest -Uri $images[$key] -OutFile "$destDir\$key"
    }
    catch {
        Write-Output "Failed to download $key"
    }
}
