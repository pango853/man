
```time.x
/*
 * time.x: Remote time protocol
 */
program TIMEPROG {
	version TIMEVERS {
			unsigned int TIMEGET() = 1;
	} = 1;
} = 0x20000044;

#ifdef RPC_SVC
%int *
%timeget_1()
%{
%	static int thetime;
%
%	thetime = time(0);
%	return (&thetime);
%}
#endif
```

> rpcgen -a -C time.x
> make -f Makefile.time

> sudo ./time_server &
> sudo ./time_client localhost
