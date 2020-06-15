
# PHP

## CamelCase

### CamelCase to Underscore–
//example: parseServerInfo to parse_server_info
$string = preg_replace('/(?<=\\w)(?=[A-Z])/',"_$1", $string); $string = strtolower($string);

### CamelCase to Spaces–
//example:BachJS to Bach J S
$string = preg_replace('/(?<=\\w)(?=[A-Z])/'," $1", $string); $string = trim($string); 
