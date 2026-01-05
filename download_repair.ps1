$images = @{
    "product-24.jpg" = "https://images.unsplash.com/photo-1551730459-92db2a308d6b?q=80&w=800"; # Parrot -> Bird toy
    "product-25.jpg" = "https://images.unsplash.com/photo-1505144808419-1957a94ca61e?q=80&w=800"; # Telescope -> Nature/Sky
    "product-27.jpg" = "https://images.unsplash.com/photo-1542833180-fc099085dfc3?q=80&w=800"; # Sand -> Playful
    "product-28.jpg" = "https://images.unsplash.com/photo-1587573088714-fe751a082f64?q=80&w=800"; # Train -> Toy train
    "product-29.jpg" = "https://images.unsplash.com/photo-1549488344-c7079f856fdd?q=80&w=800"; # Mic -> Music
    "product-32.jpg" = "https://images.unsplash.com/photo-1513151280442-259507a5d105?q=80&w=800"; # Pram -> Doll stuff
    "product-34.jpg" = "https://images.unsplash.com/photo-1584036561566-b93a5a89ae71?q=80&w=800"; # Medical -> (Retry) or generic toy
    "product-35.jpg" = "https://images.unsplash.com/photo-1502920917128-1aa500764cbd?q=80&w=800"; # Tools -> Construction
    "product-37.jpg" = "https://images.unsplash.com/photo-1533228100845-08145b01de14?q=80&w=800"; # Alien -> Plush
    "product-39.jpg" = "https://images.unsplash.com/photo-1543599538-a6c4f6cc5c05?q=80&w=800"; # Cube -> Puzzle
    "product-40.jpg" = "https://images.unsplash.com/photo-1508098682722-e99c43a406b2?q=80&w=800"; # Soccer -> Sports
    "product-41.jpg" = "https://images.unsplash.com/photo-1582234568910-c49b6b907106?q=80&w=800"; # Blaster -> Toy gun/fun
    "product-42.jpg" = "https://images.unsplash.com/photo-1585338107529-13afc5f02586?q=80&w=800"; # Slime -> Gooey
    "product-45.jpg" = "https://images.unsplash.com/photo-1453005510660-8f6a9c72df34?q=80&w=800"; # Dino -> Dinosaur
    "product-48.jpg" = "https://images.unsplash.com/photo-1521780516625-add98126b914?q=80&w=800"; # Basketball -> Hoop
    "product-49.jpg" = "https://images.unsplash.com/photo-1555449363-1f91b6e51e18?q=80&w=800"; # Robot -> Tech
    "product-51.jpg" = "https://images.unsplash.com/photo-1557962458-16e61298c582?q=80&w=800"; # Tricycle -> Bike
}

$destDir = "images"
if (!(Test-Path -Path $destDir)) { New-Item -ItemType Directory -Path $destDir }

foreach ($key in $images.Keys) {
    Write-Output "Repairing $key..."
    try {
        Invoke-WebRequest -Uri $images[$key] -OutFile "$destDir\$key"
    }
    catch {
        Write-Output "Failed to download $key again."
    }
}
