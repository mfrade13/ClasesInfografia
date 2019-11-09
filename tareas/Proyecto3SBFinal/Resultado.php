<?php
if(isset($_FILES['image'])){
$file_name = $_FILES['image']['name'];
$file_tmp =$_FILES['image']['tmp_name'];
move_uploaded_file($file_tmp,"fotos/".$file_name);
echo "<h3>Imagen cargada</h3>";
echo '<img src="fotos/'.$file_name.'" style="width:45%">';
//Esta ruta varia segun donde instales el Tesseract-OCR verificar rutas
shell_exec('"C:\\Program Files (x86)\\Tesseract-OCR\\tesseract" "C:\\Apache24\\htdocs\\fotos\\'.$file_name.'" visto');

echo "<br><h3>Lo que pudo ver</h3><br><pre>";

$myfile = fopen("visto.txt", "r") or die("Unable to open file!");
echo fread($myfile,filesize("visto.txt"));
fclose($myfile);
echo "</pre>";
}
?>