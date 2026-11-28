Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795866904;
	b=tL9LGdEUsJb0BGRVFZN+FlrpKV9lKIqBRjyQwkKluuwaikmuPo0Syg8A+iznNKm5RvEq
	 xIE679bCZXq/hXz7455WPaK//rDByLYAS6bhYOGESOvXiHFSviNd1i/3xHUR9kFQb1bWs
	 tdP/yrnRDmCY2o75rPFxhw+oda/N/3NrTIc3BGQkGcAxmIJHJgwpeRynKug7JAFCgHu8C
	 u4n2RPCMSXKFTC/TBon7itJJ5V9f1s6ujsH1KguyJiWbAR5N6T8iAJ8x/CgadxHcFaerT
	 UFEqNx2H/lLtWB2nFqMOTOHkilexGSV6HxnTE1kwaSLn5MGe6kZwufFSnm/u6r/C2Cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795866904;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=aYcr/Vbck1ztUmS15ZTJlw73vVEYDKhMroKfUy1hlew=;
	b=Nd8QXNUAZbGH8qZPKrNFaawROAOiK0DKet51toCN9lwtpxGjtH2QzBj+FoN22G98S6aK
	 bElkdw5nLR3FkZZaoICXhAeFTeLr8qnQHvI+wK1YqVhrTVWe0TJWgtUZrRjWqoVLszSId
	 NO/nlcbMwG8FUCqJjzdqWdWKQcBrEIW0pQI/PTH2RYnFnTpG751qyBMRELmHfsHwvkzt2
	 MXgDbEzso8X6irtmkR7fr3teDb3r7pfWjVMPuY4HZJ7CUlHgAAGnIV1TyaxRJXfdVE9o6
	 00KxVRbIL4n0pE5f3s7fikP3Akg2+sa99Pg+BI6r7OGViwe8vuZZ0pWz90fVcUuAuAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PUNjSxrv;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DB4606A321
	for <linux-rt-devel@lists.linux.dev>; Sat, 28 Nov 2026 11:55:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78DB4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PUNjSxrv
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4bb6886d30aso84916705e9.3
        for <linux-rt-devel@lists.linux.dev>; Sat, 28 Nov 2026 03:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795866903; x=1796471703; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aYcr/Vbck1ztUmS15ZTJlw73vVEYDKhMroKfUy1hlew=;
        b=PUNjSxrvtzGni9Ddlr01jyNvevg1BkLiGxQaBBgjEgsksqnKEDAYSXVIfocuFkl8aq
         6czGsbFWI1DsOOl9AXVVMGdVHopYOC2nTnY0zX6GzGg00D05Qd2ceW9dZQl7fSbvNuij
         KgqFmQ0xRUIAyDgUWBMY0f7iA+1G1rNSiKTpYGNna/ymqtvSEawrpiCjE1R7WM7bOliK
         gbrDM1thodToEOpIn5f2k44N8aNKsUCWnGnuRtQTpP4WqAI3FUp7+csOEL48BzWwnHur
         oXIFQCtZRoXAwUZ47UIIpVtKX7DD+5otRnCOkfB6XLTCX8an+0YqITX9J1Cf356AdwSG
         mkDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795866903; x=1796471703;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aYcr/Vbck1ztUmS15ZTJlw73vVEYDKhMroKfUy1hlew=;
        b=q9RxI3GBAPOzQIDcM4oTJWkZJRv4EM6iZFeOL3jCi1YYpmU5lzRRVxCOSRgmAGITDL
         Y9LK51DKCOSRCAvULGK5E6Ctv/0nIOXXfqvHfIZ7DmvXbAYa85m6Bm+bN3XfHbQ2pBHA
         uv2VBu+y6RdTnY8qd8LjiLPRgUIGmGNQB6Xej3eiUpVCNDjEqJ0g7uf/ArQQQsKXNBKd
         3pLc5CyWbWRDvmJv7qwxNXoNrdRgn3ZBbib3/paiBlI1gFBBUa/rEmDFtwVck8fmvMFS
         XNbx1Mc8U3M0YZkKpNSrnoQ8ztMryeCjnL+E9kAcgzTCeKgdBPAYzkiJLqvMXU2qqWP7
         wPFQ==
X-Forwarded-Encrypted: i=1; AL+hErEUiGgwwtjIaqEADRYMG4jGvPEATIfq2pz9OE7yDFRLDZise+XpExAOvjHGlRr1gPro+R0hkaVlrHEEZc7z/g==@lists.linux.dev
X-Gm-Message-State: APuU4Z+6dKT6zkOIq/0+9ehN+Q1AcIve1W9ssW6RSw3rrYUjFTIrPpVh
	iDcle7/niemGR5mY6Oj0CwzpqP5IW3bFTbaJzm2rIqhLT5kRVLTiRgwO
X-Gm-Gg: AZFdTZfqp4Cxxu5pURTXwUKfWmxANcpogL/cACAcoxyzPxjEO80ydolXJdoinvxR6XN
	vChG8DvrbOjO21ho+Wvz24RGYX7fn0Vvxx7DW7d+1LiH/1FBSLWsPFTHah3Srbd+ymmtMBQZ6mc
	RGqkvYjXmQp5Ds5jjQ/3bB4D8S33tq44sQ+yNGFSdg/nqa+mVi+6yRuZrfOF7vqsqPnfpdFItcb
	zN3Zs+jCDlWFWVKaFE5yxP6CKMI9NBIjpFJCb5PkUtYa2+bI0YiLrsb5EMpa5IzBuO34LOpv8Un
	xtKzd/qUVY0HDHD0ZdVmnOb43fHs2305nNa3E13Y5U3zLon6IbockDd3awO7q3akhQDVlE/BHjQ
	ZA/wGizbgAamJMfGBd6gYfV52zocOsHWhrPfUhhONNSqwGJ+YZ0/+nKpiXc5ugYb2uArHQD3v4c
	drMcDjrWEdfb7JPQsrlzvklLQ6MMs9CatG6wIJgFScuOzPRe4qB8G53Q46LVlXznxEeyL8tRhZZ
	7UUN+PpbhNYQ3QA9jcP1Jf9xNKJicKpGKPJextyjiRAcIArLmnwY1dMneu9ZAWupXcafhJcSXSK
	yPOQtIhbhtuJYF51UABDh6662GuMJTeQt2ZlTQ7HCydHDhXW5KqB0AvH8NxZ6F5NtUOJEHAn65e
	z82dZhHH3qTEO/uD2PDloGwgCTILs2mGJtTr9gnUQkQVdMw55lzqs6/WA9AQbypJJ
X-Received: by 2002:a05:600c:1da9:b0:4b1:2026:6b41 with SMTP id 5b1f17b1804b1-4bb88819294mr573223175e9.30.1795866902705;
        Sat, 28 Nov 2026 03:55:02 -0800 (PST)
Received: from unknown748F3CBA5068 (dynamic-095-117-034-170.95.117.pool.telefonica.de. [95.117.34.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853a1e8bsm634936515e9.9.2026.11.28.03.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 03:55:02 -0800 (PST)
Date: Sat, 28 Nov 2026 12:54:31 +0100
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Thomas Gleixner <tglx@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Wen Yang <wen.yang@linux.dev>, 
	linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/9] rv: Verify generic IRQ context transitions
Message-ID: <awq_lh1x7P6NQrx8@gmail.com>
References: <20261107171252.25090-1-kmehltretter@gmail.com>
 <9419fa94de8acc8f1ae445004b77d20d0be3e98e.camel@redhat.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9419fa94de8acc8f1ae445004b77d20d0be3e98e.camel@redhat.com>

On Sat, Nov 21, 2026 at 03:23:08PM +0100, Gabriele Monaco wrote:
> Maybe, you could somehow reuse the __schedule() tracepoints and understand you
> came from interrupt context, but that would obviously not match the
> interrupt/preemption counts, although they are (now) guarded by a BUG so you
> don't really need them.
> The loop should work fairly well anyway.
> 

Good point. With the BUG_ON() in preempt_schedule_irq(), every irqexit
check is already enforced elsewhere.

It seems dropping irqexit and its scheduler tracepoints is best.

For irqstate, I injected faults on arm64 and x86_64, with and without
lockdep, and went through past IRQ context fixes:

- Its only unique catch was an injected traced entry paired with a raw
  exit.
- A leaked PREEMPT_RT serving-softirq bit was reported first by RCU or
  lockdep, even with lockdep compiled out.
- It would not have caught any of the past bugs I looked at. Most were
  preempt_count disagreeing with lockdep, irqtime or nohz.
- On a Raspberry Pi 500+, it added about 73 ns to each
  irq_enter_rcu()/irq_exit_rcu() pair and had no measurable effect on
  hackbench or locktorture. PROVE_LOCKING added only 12 ns to the pair
  but made hackbench eight times slower.

How do you see it? The results above only measure detection beyond the
existing checks. Is irqstate worth a v3 for other reasons, such as
running a model of the IRQ context rules on production kernels, or is
there something you would like me to investigate first?

Thanks,
Karl
