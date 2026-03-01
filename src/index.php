<?php

$conn = oci_connect(
    "UCENTER_USER",
    "UCenterPassword123",
    "oracle-db:1521/FREEPDB1"
);

if (!$conn) {
    $e = oci_error();
    die("Connection failed: " . $e['message']);
}

echo "<h2>Connected to Oracle FREEPDB1 ✅</h2>";

$sql = "SELECT * FROM TEST_TABLE";
$stid = oci_parse($conn, $sql);
oci_execute($stid);

echo "<table border='1'>";
while ($row = oci_fetch_assoc($stid)) {
    echo "<tr><td>{$row['ID']}</td><td>{$row['NAME']}</td></tr>";
}
echo "</table>";

oci_free_statement($stid);
oci_close($conn);