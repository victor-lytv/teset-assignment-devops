<?php

if (str_starts_with('/healtz', $_SERVER['REQUEST_URI'])) {
   echo json_encode([
        "status" => http_response_code() < 300 ? 'ok' : 'not ok',
        "service" => "nginx",
        "env" => getenv('APP_ENV')
   ]);
}

