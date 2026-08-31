Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE903A48D9
	for <linux-rt-devel@lists.linux.dev>; Mon, 31 Aug 2026 21:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788212661; cv=none; b=JyiZL8Tc/ulgMIw809+QR/7Dnh2Y4Dw8O9sBbIXCVbj7o/kSDKICquHkQfTZh8II4QAdSv0VdiBHLGdWuhL/ItRKpLlDYh2iq0PVfZkh/uM2AzDL/xlX4An0S6dXdPyqPLPRdliuFGWvO24/0MJ5NVoLQlovk2rMDBIUZKdS+Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788212661; c=relaxed/simple;
	bh=tbvMjlu2nUXQUFmCFvtfm2sb9MCvvq1DHBiU/6r4VAs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nve9gn+yD+Y3AYIq9Rs+SUQvdG4lJBzsOIdSlpZXuUUVWhz/nr0ZY+hQLa7m6JiLR4kFBxZMRlJZgBj/PHvSkl/wn1++uVDPOctdaoGKS/ucSncOEDI0vQhzEzQcvFal4INZwRevQU8fjIMevczUC5HUjbgadK46FRYZIhYUcCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Bdip5acJ; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Bdip5acJ"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 00C91408DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1788212659; bh=ejVfa5VA9hdX/MMipqy6XJUI7HG3QYWAT2JDm/+1jw4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Bdip5acJBFyCC+OISgVyzZ7LDpuqqJ5thWnoK9qygnWegT7c1btFNFrkh6vBAnW5k
	 ZKnPOZLs2ds4c7iljeR+j5IJOh/f+5FSi7wPKazyrORg19qx0z1bq4s9rWJbkGJ5+9
	 1czNBSOoAA2922jJBffVaxCNMk+alCliIU0gUD8dVRBf+0oZJV37Y8lklLFEOYfd2l
	 l0CjadDYKClrvjdKUYszFcQZUoNYh2oSS7KkOgmRCDCKnUL50YJa6nYaFMz6f+LZxT
	 75y++dyrSDYqI/TGl72kpeB03QX3nR+RZij9AmBXTt0zIUwC6aQAW0nU/g8pUmKhmC
	 KUEhWkLHWkqHQ==
Received: from localhost (unknown [IPv6:2601:280:4600:814::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 00C91408DB;
	Mon, 31 Aug 2026 21:44:18 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Liang Hao <haohlliang@gmail.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Shuah Khan
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Clark
 Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, Liang Hao <haohlliang@gmail.com>
Subject: Re: [PATCH v6] docs: real-time: mention the hrtimer sleeper HARD path
In-Reply-To: <20260820163858.27984-1-haohlliang@gmail.com>
References: <20260820144655.22492-1-haohlliang@gmail.com>
 <20260820163858.27984-1-haohlliang@gmail.com>
Date: Mon, 31 Aug 2026 15:44:16 -0600
Message-ID: <87wlt6ezin.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Liang Hao <haohlliang@gmail.com> writes:

> The Timers section documents the PREEMPT_RT softirq default and
> HRTIMER_MODE_HARD, but not the sleeper helper used by userspace sleeps.
> Describe that path, and rename "ktimersd" to "ktimers" to match
> ksoftirqd naming in this document.
>
> No code or behaviour change.
>
> Signed-off-by: Liang Hao <haohlliang@gmail.com>
> ---
> v5 -> v6:
> - clarify soft delivery for non-RT sleepers (softirq context, not
>   HRTIMER_MODE_SOFT)
>
>  Documentation/core-api/real-time/differences.rst | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/core-api/real-time/differences.rst b/Documentation/core-api/real-time/differences.rst
> index a129570dab5a..6f5be9f0da2e 100644
> --- a/Documentation/core-api/real-time/differences.rst
> +++ b/Documentation/core-api/real-time/differences.rst
> @@ -119,12 +119,20 @@ timers initialized with the HRTIMER_MODE_SOFT flag, which are executed in
>  softirq context.
>  
>  On a PREEMPT_RT kernel, this behavior is reversed: hrtimers are executed in
> -softirq context by default, typically within the ktimersd thread. This thread
> +softirq context by default, typically within the ktimers thread. This thread
>  runs at the lowest real-time priority, ensuring it executes before any
>  SCHED_OTHER tasks but does not interfere with higher-priority real-time
>  threads. To explicitly request execution in hard interrupt context on
>  PREEMPT_RT, the timer must be marked with the HRTIMER_MODE_HARD flag.
>  
> +Userland sleepers usually deploy a hrtimer to guarantee a precise wakeup
> +time. The timer is initialized with hrtimer_setup_sleeper_on_stack(), which
> +distinguishes between real-time and regular tasks. The hrtimer of a task
> +without a real-time priority is handled in soft interrupt context, but for
> +real-time priorities HRTIMER_MODE_HARD is used. This ensures that real-time
> +tasks are woken up as soon as possible while ordinary tasks cannot block the
> +CPU with a thundering herd of wakeups.
> +
>  Memory allocation
>  -----------------

Applied, thanks.

jon
