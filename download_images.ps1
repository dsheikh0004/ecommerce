$images = @{
    "product-2.jpg" = "https://images.unsplash.com/photo-1532330393533-443990a51d10?q=80&w=800&auto=format&fit=crop";
    "product-3.jpg" = "https://images.unsplash.com/photo-1556384236-444f6f7093db?q=80&w=800&auto=format&fit=crop";
    "product-4.jpg" = "https://images.unsplash.com/photo-1588636906233-1ecdc35d642b?q=80&w=800&auto=format&fit=crop";
    "product-5.jpg" = "https://images.unsplash.com/photo-1579829366248-204fe8413f31?q=80&w=800&auto=format&fit=crop";
    "product-6.jpg" = "https://images.unsplash.com/photo-1608889175123-8ee362201f81?q=80&w=800&auto=format&fit=crop";
    "product-7.jpg" = "https://images.unsplash.com/photo-1560057279-dff19bedd37e?q=80&w=800&auto=format&fit=crop";
    "product-8.jpg" = "https://images.unsplash.com/photo-1532094349884-543bc11b234d?q=80&w=800&auto=format&fit=crop";
    "product-9.jpg" = "https://images.unsplash.com/photo-1522816966144-cb729f52f30b?q=80&w=800&auto=format&fit=crop";
    "product-10.jpg" = "https://images.unsplash.com/photo-1596461404969-9ae70f2830c1?q=80&w=800&auto=format&fit=crop";
    "product-11.jpg" = "https://images.unsplash.com/photo-1567690187548-f1711322b519?q=80&w=800&auto=format&fit=crop";
    "product-12.jpg" = "https://images.unsplash.com/photo-1550989460-0adf9ea622e2?q=80&w=800&auto=format&fit=crop";
    "product-13.jpg" = "https://images.unsplash.com/photo-1517433670267-08bbd4be890f?q=80&w=800&auto=format&fit=crop";
    "product-14.jpg" = "https://images.unsplash.com/photo-1519750783826-e2420f4d687f?q=80&w=800&auto=format&fit=crop";
    "product-15.jpg" = "https://images.unsplash.com/photo-1513151280442-259507a5d105?q=80&w=800&auto=format&fit=crop";
    "product-16.jpg" = "https://images.unsplash.com/photo-1536411396596-af7ca8c102a1?q=80&w=800&auto=format&fit=crop";
    "product-17.jpg" = "https://images.unsplash.com/photo-1520523839897-bd0b52f945a0?q=80&w=800&auto=format&fit=crop";
    "product-18.jpg" = "https://images.unsplash.com/photo-1516924962500-2b4b3b99ea02?q=80&w=800&auto=format&fit=crop";
    "product-19.jpg" = "https://images.unsplash.com/photo-1565193566173-7a0ee3dbe261?q=80&w=800&auto=format&fit=crop";
    "product-20.jpg" = "https://images.unsplash.com/photo-1596541530962-d98c25db5429?q=80&w=800&auto=format&fit=crop";
    "product-21.jpg" = "https://images.unsplash.com/photo-1620404494435-9b5521447021?q=80&w=800&auto=format&fit=crop";
    "product-22.jpg" = "https://images.unsplash.com/photo-1551416410-6101c51322fa?q=80&w=800&auto=format&fit=crop";
}

$destDir = "images"
if (!(Test-Path -Path $destDir)) { New-Item -ItemType Directory -Path $destDir }

foreach ($key in $images.Keys) {
    echo "Downloading $key..."
    Invoke-WebRequest -Uri $images[$key] -OutFile "$destDir\$key"
}
