Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794584940;
	b=Uk5oGdzNQh0kQI7DdrTGK9w5xK1i4/i6+p50orCU0DCfMYBdXo6hqh/MJVw5YnxUHmUL
	 e+ddgXFX4Q2YtWZhWTZh9LQwkyjWM4L0SQLmOgdTWr5wbqgyXus1iRLF3cW+yCIu9kn6P
	 1u7iatxm8bqAYtYa7Ka5xLOtt2IgLc/3x06lYlZzK7b7B2WGuSk1i8gkSCneMoi6tuGNU
	 bBhX2B2O6Sh6C+RSlWrUaigbYapfpOEzbgCcql/SIHpyWkuQ0facnhgFN+LbSyi1lGfOS
	 hnGCTwtdFbxWgeAmFB5B0rNpStTW8I7IIAU0W5Uf3Ov2t4Wiodq9+TWoUtPHS+zfQfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794584940;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=cH9e8a66/fPrQXh1VXaCN026KUPqZYcbPtWpdmcGZiQ=;
	b=3jCg4th10QpBEy66ofjUKmkJ+l1mPkCddoOdvHRRsUe3UFh/eIuQ0PCSaVBBJ+2wCjjt
	 Nq7AlJiOAp4g9TTBLQoOT9wp5qIlMiYpTa1w8zE9qFOVMPdg6ND6lMRckWSkbSQLDvQei
	 r+aP6yyLF24yWY6d+CN7Xv6HrJYei0fX8caFoL2wJKb1r0pg+k93WrwQergUOA9bKT834
	 ePgWxrAKRZQzRAruiwsXWlESWU05JLf3ww3IIJwrZqWft5DDeOszoMN2rH6YtwOjY2c82
	 kZhLM2oaHIeCaSeUEzyaP1ZFwdvz6JnQMx6j0sDNQm6AG6yVaKqjk5ix8ji9n4vOAiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jFVBGDNc;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D122C606A337
	for <linux-rt-devel@lists.linux.dev>; Fri, 13 Nov 2026 15:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D122C606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jFVBGDNc
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48e10a70540so530900f8f.1
        for <linux-rt-devel@lists.linux.dev>; Fri, 13 Nov 2026 07:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794584938; x=1795189738; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cH9e8a66/fPrQXh1VXaCN026KUPqZYcbPtWpdmcGZiQ=;
        b=jFVBGDNcwGHggC5ZjTmJD6PXaR7ZtwzCWHWXa3X+ju+ZKgkTi6NRnwEXpBW7FegW+n
         V68jJkUgflouSTaIaLL1SFgzf/8FcgwAhe/YBKyNFAlziig7Wf/7Rmd1j6nOQTA1SK0Y
         5LLEE5FHQQWFGVzLSEy4Ce3HSHa+Mwdup2Jn3Ew1FZL5oMiQTtsXjf+4ndBVGiebascS
         rMlzLsL8U4n902yjepDYF/yUBOqHIiiCitIgad/SoNG+VrtJBWYjkvJTDeAv0KTX5vB7
         5VsP1fJT1qloK98Fv+66ClPykgM+E77LUeWiBBA/asOnVp0W+JMmWQ16uKdcyDl0e+z9
         I45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794584938; x=1795189738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cH9e8a66/fPrQXh1VXaCN026KUPqZYcbPtWpdmcGZiQ=;
        b=WTZEiNRRVq+Zd/YgZ/u8rhNsTbRU5T+3ihyWdsj3sMPTxbhgcgCs/671lHSYvSQsd/
         XFiLBNKqCTp5ARFK2uoGe6fIde7QOO+la1pVOlIYvfE4KFfl3b3WqEk2U4rT1lHHLznJ
         P1oyJGNCCpgTWuingbvbVbYSYQAFgNN3+918UY7NgXygveVCROcWww8G45zw8Q6XOW1P
         z3RyiHaJl4kSDcJqGb3z4rz4ka9Klv2WDnJ8YScSjTH5ebugdjB8RLO6su5kQz4Y2vYF
         H7eKxD+Z8fWhwky2LBQh7pi+jze5ZXd4gaFzfqnYS3V7uqaMuGuFvB36z4plmWHbGtYU
         zysg==
X-Forwarded-Encrypted: i=1; AL+hErGHIlCo9moonryAZsMUWVgv0RD0WJCdKWzLCqABRUIQ21iO+l13FDkRx10xxs9i/RyGp6rUl1DK7zdICblpww==@lists.linux.dev
X-Gm-Message-State: APuU4Z9tCCejwnB+swazZPoErHyQOKnmnDutmn36Xjiv0RnpUAxkG8jA
	tbnQJ7cBbHASH/llsGVFwrwaDkZCqelphK6sxuHBOuCFwZnx6rwVlvIYr5ZySX+g
X-Gm-Gg: AYBFou2Ucpx/0slMSyr4zoHMS1zqOBQ5NT2pfO9JpOtbN39BB2p46bJebu8+px5lz+X
	1ZLOCbXPLkaqAwasFJVJVHX3q4t5JMMrQ5lYNGLGmbi+Itlz4EefyXPg4EhPEuqnPV01VCWExGg
	TVmSVrzdN3FrdodYNw4HJSqUh77ktwd7eitYAp5I+Eim8T6LLyWVRp1B8BMooaF96MCYqYZGba/
	lwbASLD6am5nnYh5/El+BkY8c1U8PjbO5m6i90BA6ul935+UfK9e2uJx0Q15z8oeWp0/6NFzqwc
	22uleadjBZKBks8fLmyW22/Z5piO1GDLDCuYNmuXCJiaAZLtiHxLlNYiMcIJMJviAbDshJKxlW/
	pK8tqwul7qk0ALxkvnh0Ykul4SQ4gWDklJcw9Rk20Q3Xumol30m4DKLaxFKgFa7Jhs12Ewxg5uc
	n4O9PwkAqZYj5Pqf8IQqiPutEIERdCwZIjvW1AL6lzZJhHsqR0gv6JML+pciJFcLdl3L9QahLmb
	S7NNoZK5U8C6wtHhZ122JDWyihvqZqzCiDbhEv9ZgadK/fQz1UbQxoVZ5bVuiTdSoBdBtKuH2Tq
	omJPrEqu7iMUmjzLKHbhadVZl93JGX/KanRTbZwYvRfBUIwJzfrj5h1CYoI0Wiq5rZTObONcr5v
	p9A==
X-Received: by 2002:a05:6000:3102:b0:48e:4300:c6d4 with SMTP id ffacd0b85a97d-49c747700e5mr7815205f8f.53.1794584938107;
        Fri, 13 Nov 2026 07:48:58 -0800 (PST)
Received: from andreayoga.wind3.hub ([31.189.56.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5fb58fefsm6638119f8f.26.2026.11.13.07.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 07:48:57 -0800 (PST)
From: Andrea Parri <parri.andrea@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Dario Faggioli <raistlin@linux.it>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] sched/deadline: Check SCHED_DEADLINE affinity under the rq lock
Date: Fri, 13 Nov 2026 16:48:52 +0100
Message-ID: <20261113154853.14393-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113153549.Z8XPohWU@linutronix.de>
References: <20261105164856.29698-1-parri.andrea@gmail.com> <20261113153549.Z8XPohWU@linutronix.de>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Nov 13, 2026 at 04:35:49PM +0100, Sebastian Andrzej Siewior wrote:

[...]

> You could keep the check in __sched_setaffinity() so it bails out early
> if it is not possible right away. The check under the RQ ist just due to
> the race window that we have. But I don't have a strong opinion on that.

I'd rather keep a single check: the early one would only make a request
that fails anyway fail before taking the rq lock, and two copies of the
same test can drift apart.

> Anyway. The reported problem looks solved to me:
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Thanks for the review!

  Andrea
