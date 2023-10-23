namespace go demo.greeting

struct GreetingReq {
    1: string Name (api.query="name");
}

struct GreetingResp {
    1: string code;
    2: string data;
    3: string msg;
    4: i64 timestamp;
}


service GreetingService {
    GreetingResp Greeting(1: GreetingReq request) (api.get="/greeting");
}
