Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793964616;
	b=e9iJ4R8nINX5HcC4T2Zi+rQNl/i0ahJ/0ofcdT/nYeo1tv60luO8wy+LFIQZSxt62KMy
	 2D2hjUQmvqW0sp1eho4mnlOZa+n+u6Dqx9vwFhHbgXxHMn7y/75hJhwzmuDlMVkXsRIpu
	 nkP0lQQ4blxSl2hvOunrLBmstAHE3oPBYkpda0mJGGhJoK6m5POXzKIY+5jgL5aUCpDKm
	 NnvsTeK4RJzyZ9OVJffwwyqWw0FI76s+Yo2amn92cwiy+8GLogGiCYA6DckW8f7X5RtJ9
	 kTjkrK4wr7IQ8S63x0P0H9cWlt5UW9nQV0zshHRCFzgVAe0xwJggDCV2xMQdV+bZ7Ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793964616;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=I9u+1gPJ7RC1FD5Cq1A3nqgz7H8YeuGoMr0x60qRtl4=;
	b=2RI1IH1K0o+MvkL8m4MGvNjL12Qxr/U5U0ODwUcPlhRSyZWgb+VZdZTgvxzcJVRvbpDn
	 fLU6HkP04qDnh7yxtBPypdbPFnl71rE3GF+WX3IOipz/wL3ASs+F04Ph45nZ8Xtz+uFLC
	 hTs6IkQZn4YDosh+kDUVGSP7jYPOGj119GUO+Z9Og60UrX4oRYxdGAQYydSUXTmUMl+CT
	 cY/ftgUFibuS5UbSy6ZC7bfMZGD0Q7IkKFbM9Rnn306Gmtg5wjPrVjKBg0bmywGCrb/DD
	 qDiURzCbWFNBdCBMRdPf+VAut8ObkI/cdnhKQGxd1a3dFT9OoAjxGPRGHzYTqBZ0osw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=VMFFsHQy;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=FWeHtxUB;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13F7606D81C
	for <linux-rt-devel@lists.linux.dev>; Fri,  6 Nov 2026 11:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D13F7606D81C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=VMFFsHQy;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=FWeHtxUB
Date: Fri, 6 Nov 2026 12:30:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793964613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I9u+1gPJ7RC1FD5Cq1A3nqgz7H8YeuGoMr0x60qRtl4=;
	b=VMFFsHQytI6ikZVFcZNI7JeYZPL1Gs9ZpQtcJowxramnxFu/cG+jJ8c3ozvb/sKTm6LqVn
	SGYXzIheDlRepx0gYXWH48Ph3hVMMx27dmjb1bgxgjqVXKvy93GIC3VgAIkCIXmUS/bE4A
	xuqnqwqEXwp1Y9bpWWM65qe5LszYubnZ8WrEKkh1Q+ZibH6iToqQlGnI6eAS3YPPuGrfOH
	+zl0PqELSOsn8W7k/KPccuNmNJM5+/iZiRsxFgSVtT24uA/zJc1adC4MFH+lORezLxNt75
	SwUMLB9RdnBgjiiHClTqdaSRxTJHOkfdiNgg/lib2H9m089uUrvwdSxTcma2OA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793964613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I9u+1gPJ7RC1FD5Cq1A3nqgz7H8YeuGoMr0x60qRtl4=;
	b=FWeHtxUBwziq1HFhfkWljmCdgpXsG7hw77f3rCpr8DJRqvVjpfkbaAk1Lk+JbN4kdf+FFY
	Z836C5qhZA6/+zDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, linux-rt-devel@lists.linux.dev,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
	John Ogness <john.ogness@linutronix.de>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	luca abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yurand2000@gmail.com>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
Subject: Re: [PATCH] sched: Remove CONFIG_RT_GROUP_SCHED
Message-ID: <20261106113011.B7YxCMJS@linutronix.de>
References: <20261105164724.yxONBd03@linutronix.de>
 <auy6nyTUuHBlgrV_@slm.duckdns.org>
 <20261105193010.tXUDDu2w@linutronix.de>
 <20261106105003.GU1813469@noisy.programming.kicks-ass.net>
 <20261106110435.5MWA_4Hw@linutronix.de>
 <20261106111213.GG1779021@noisy.programming.kicks-ass.net>
 <20261106112158.-VI88lZb@linutronix.de>
 <20261106112454.GI1779021@noisy.programming.kicks-ass.net>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261106112454.GI1779021@noisy.programming.kicks-ass.net>

On 2026-11-06 12:24:54 [+0100], Peter Zijlstra wrote:
> We can try marking it broken; see who screams this time ;-)

okay. Let me try that then. Which reminds me of something=E2=80=A6

Sebastian
