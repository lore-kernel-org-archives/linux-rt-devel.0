Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795787334;
	b=GcoQ2pIgP8EIWTJafq3N+dQHZQV8dnu9ooqz5d9wwEIMsiqknOzzg0KWgL+Q/Zdew5Es
	 9lkFmDfnKz0sAV4EZdBikFTXTgHtwvLicqRT+LjCveq5EeyaKZuc26vLcMawuqt5SOvfO
	 ++oRSWrQjRjxtP4XOe3/Bjj7aS/hpk0lATBxgDhOSVQ71Sv85LD3o0eChf2rJ/lTvxOzw
	 xlAfHTzlgRhHSOOWhWwJjYJAUTqGni8qH4wommSQ7TNRBSupXA//W1bpH4bWLRD1ES7jq
	 vGxKk+0rxJKhu0TjpuErYXHzoCKyLQD76CX7dw5B97bH3EuPExNnUPXRma4LS+Qy1cA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795787334;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Lk8ZuJXiqRaUs9Q5T68CHc4Ig5vBrvK1cLShrLcSGF8=;
	b=XDOOCAE7ZCjuFGzYhkvPyhTqBW5wIGXT4gY5jxlsEH3Wy3fqV/stzOcuhRF9RrP9rtd7
	 3JrKYhYA2XwC3QKuLhsW7HR5BG32HINoVYY8H47u+wLCQhwN+39Xq1+r0Mpya6tQTUCeS
	 T0lE4GDVp0e2mdVQM8pG8UOsOfFydfJFEtQLCzPzStpfaYotlY1L5btcABIp1rWhHb6Vn
	 /wRvbsM7vAn1i23Vz+hsPvZ6HaEkWNKiNhI324WwvFWirjw89kg2ECvG6/NuVHF/gQCMp
	 cxurPw1ox9qVSzulVSJ6Elq7a/tOQICueO5WdB11tt3bBhKZj54eMmwo8yo8IU7fbkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=rJr8rZBw;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E8B606A695;
	Fri, 27 Nov 2026 13:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75E8B606A695
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=rJr8rZBw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1795787326;
	bh=Lk8ZuJXiqRaUs9Q5T68CHc4Ig5vBrvK1cLShrLcSGF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rJr8rZBwrXiKM7yRlt3lUnE9+vDbQc9FxRpaUOF079VtnfKNzy+92SOhR+xN7RtMb
	 5oO1tQmGThcHIgxuaCVg6o9yBI5JTkbmp9wdXIR1wiYEJpP4uCCH/4DVjn3RrZDhCI
	 dE9NJFXGHi26YtEgjheYcIiz0YCt3LUJJO6eI7RLRPVOOqutBb/Jd4Sx238q8dfge+
	 bcelCDnmLhZqhglWfq8MuKB83Y1iLpWSlEhtWC5934n7wi7bGR9Kjrd+0zVLkSm0aB
	 tObUndj/1hfhNcwe1cT0jfXdnh7XT6Q5uwLqgTK7ta/HqXCHgJ642n5IuyKwXHnSqv
	 JKufbRx60ntiw==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jbZWf6CfyzXFR;
	Fri, 27 Nov 2026 08:48:46 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 26/43] sched/deadline: Keep a departing constrained task until its next period
Date: Fri, 27 Nov 2026 08:48:34 -0500
Message-ID: <20261127134846.114774-6-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-234581@kernel.org>
References: <06ad8ff186e425049082d0ee9b6518f85406257d.1795646914.git.mathieu.desnoyers@efficios.com> <sashiko-outbox-234581@kernel.org>
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

> Can dl_task_timer() advance dl_se->deadline before inactive_task_timer()
> computes dl_next_period(dl_se), holding the departed task's bandwidth for
> an extra period?

Yes, but this errs on the safe side. The refill starts the next period
of the task, with runtime. If the task comes back during that period,
it runs in it. So admission control must count it until then. v12 will
leave it as it is.

Lifting the throttle without the refill would not work. It forgives the
overrun of a task that comes back after its next period starts.

> Can returning HRTIMER_RESTART after task_rq_unlock() race with
> cancel_inactive_timer() in switched_to_dl() and leave inactive_timer
> queued after the task returns to SCHED_DEADLINE?

Yes. In v12, task_non_contending() will cancel such a timer before it
tests hrtimer_active(). A queued timer with dl_non_contending clear can
only be one left this way. The hrtimer_active() test then sees only a
handler that is running. That is the case the test is for.

Thanks,

Mathieu
