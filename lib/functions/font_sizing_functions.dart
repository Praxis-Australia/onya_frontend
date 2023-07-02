


double getFontSize(double scale, double heightOfDevice, double widthOFDevice) {
    if (heightOfDevice > widthOFDevice) {
        return widthOFDevice*scale;
    } else {
        return heightOfDevice*scale;
    }
}