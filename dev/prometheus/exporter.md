

## metric types

- Counter
	monitonical
	MUST start at 0
	MUST have
		inc()
		inc(double v)
	ENCOURAGED to have
		count_exceptions
- Gauge
	go up and down
	MUST start at 0 ??? really?
	MUST have
		inc()
		inc(double v)
		dec()
		dec(double v)
		set(double v)
	SHOULD have
		set_to_current_time()
	ENCOURAGED to have
		track_inprogress()
		time()
		set()??
		observe()??
- Summary
	samples observations
	MUST have
		observe(double v)
	SHOULD have
		time()
	ENCOURAGED to
		offer quantiles as exports
- Histogram
	aggregatable distributions of events, such as request latencies.
	MUST have
		linear(start, width, count)
		exponential(start, factor, count)
	SHOULD
		...


