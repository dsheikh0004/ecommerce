$images = @{
    "product-23.jpg" = "https://images.unsplash.com/photo-1579829366248-204fe8413f31?q=80&w=800";
    "product-24.jpg" = "https://images.unsplash.com/photo-1535581652167-3d6d9353a99b?q=80&w=800";
    "product-25.jpg" = "https://images.unsplash.com/photo-1528822081517-842c676d9006?q=80&w=800";
    "product-26.jpg" = "https://images.unsplash.com/photo-1473968512647-3e447244af8f?q=80&w=800";
    "product-27.jpg" = "https://images.unsplash.com/photo-1596464716127-f9a8f4604d53?q=80&w=800";
    "product-28.jpg" = "https://images.unsplash.com/photo-1510660600003-8bf64db424f1?q=80&w=800";
    "product-29.jpg" = "https://images.unsplash.com/photo-1516280440614-6697288d5d38?q=80&w=800";
    "product-30.jpg" = "https://images.unsplash.com/photo-1534447677768-be436bb09401?q=80&w=800";
    "product-31.jpg" = "https://images.unsplash.com/photo-1608889476561-6242cfdbf622?q=80&w=800";
    "product-32.jpg" = "https://images.unsplash.com/photo-1515488042361-25f4682ea839?q=80&w=800";
    "product-33.jpg" = "https://images.unsplash.com/photo-1556910602-38f53e68e15d?q=80&w=800";
    "product-34.jpg" = "https://images.unsplash.com/photo-1584036561566-b93a5a89ae71?q=80&w=800";
    "product-35.jpg" = "https://images.unsplash.com/photo-1581092921461-eab62e97a78e?q=80&w=800";
    "product-36.jpg" = "https://images.unsplash.com/photo-1594787318286-3d835c1d207f?q=80&w=800";
    "product-37.jpg" = "https://images.unsplash.com/photo-1596727147705-0172e27b686b?q=80&w=800";
    "product-38.jpg" = "https://images.unsplash.com/photo-1529699211952-734e80c4d42b?q=80&w=800";
    "product-39.jpg" = "https://images.unsplash.com/photo-1594910243176-7caaf298e722?q=80&w=800";
    "product-40.jpg" = "https://images.unsplash.com/photo-1516567727245-207d72967664?q=80&w=800";
    "product-41.jpg" = "https://images.unsplash.com/photo-1595152345037-1833055d648b?q=80&w=800";
    "product-42.jpg" = "https://images.unsplash.com/photo-1629898086036-791ee5c3f9a7?q=80&w=800";
    "product-43.jpg" = "https://images.unsplash.com/photo-1513364776144-60967b0f800f?q=80&w=800";
    "product-44.jpg" = "https://images.unsplash.com/photo-1523995462485-3d171b5c8fa9?q=80&w=800";
    "product-45.jpg" = "https://images.unsplash.com/photo-1569966183335-51978253108c?q=80&w=800";
    "product-46.jpg" = "https://images.unsplash.com/photo-1596461404969-9ae70f2830c1?q=80&w=800";
    "product-47.jpg" = "https://images.unsplash.com/photo-1562771242-a02d9090c90c?q=80&w=800";
    "product-48.jpg" = "https://images.unsplash.com/photo-1519861531473-920026393112?q=80&w=800";
    "product-49.jpg" = "https://images.unsplash.com/photo-1485827404703-89955f326c5b?q=80&w=800";
    "product-50.jpg" = "https://images.unsplash.com/photo-1519689680058-324335c77eba?q=80&w=800";
    "product-51.jpg" = "https://images.unsplash.com/photo-1563297121-665b1633513a?q=80&w=800";
    "product-52.jpg" = "https://images.unsplash.com/photo-1523906834658-6e24ef2386f9?q=80&w=800";
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
