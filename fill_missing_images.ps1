$source = "images\product-13.jpg" # Using a good image as fallback
$missing = @(24, 32, 34, 48, 49, 28, 29, 40, 27, 45, 51, 41)

foreach ($id in $missing) {
    if (!(Test-Path "images\product-$id.jpg")) {
        Write-Output "Filling missing image for ID $id..."
        Copy-Item $source "images\product-$id.jpg"
    }
}
