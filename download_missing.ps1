$images = @{
    "product-3.jpg"  = "https://images.unsplash.com/photo-1559715541-5daf8a0296d0?q=80&w=800";
    "product-4.jpg"  = "https://images.unsplash.com/photo-1560114928-40f1f1eb26a0?q=80&w=800"; 
    "product-7.jpg"  = "https://images.unsplash.com/photo-1534224039826-c7a4eda63787?q=80&w=800";
    "product-9.jpg"  = "https://images.unsplash.com/photo-1570533036814-2c7c5ed24c04?q=80&w=800";
    "product-11.jpg" = "https://images.unsplash.com/photo-1517329782550-97561652a695?q=80&w=800";
    "product-15.jpg" = "https://images.unsplash.com/photo-1558882224-dda166733046?q=80&w=800";
    "product-16.jpg" = "https://images.unsplash.com/photo-1608231387042-66d1773070a5?q=80&w=800";
    "product-20.jpg" = "https://images.unsplash.com/photo-1533228100845-08145b01de14?q=80&w=800";
    "product-21.jpg" = "https://images.unsplash.com/photo-1585338107529-13afc5f02586?q=80&w=800";
    "product-22.jpg" = "https://images.unsplash.com/photo-1453005510660-8f6a9c72df34?q=80&w=800";
}

$destDir = "images"
if (!(Test-Path -Path $destDir)) { New-Item -ItemType Directory -Path $destDir }

foreach ($key in $images.Keys) {
    echo "Downloading $key..."
    try {
        Invoke-WebRequest -Uri $images[$key] -OutFile "$destDir\$key"
    }
    catch {
        echo "Failed to download $key"
    }
}
