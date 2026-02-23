Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82DC34AB01
	for <linux-rt-devel@lists.linux.dev>; Mon, 23 Feb 2026 08:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771834993; cv=none; b=GBgDzOZUOz8sCktCbg+0anT2q7k6BNGnjnoHp1bGoX/pqYcBBSXuZBxzScad15/kGgB5h5egK88YU3/UJaVo5teRaf938mdf/QclybGBx9mM+HvqAeeWTIwTyO9dnPg4lEs4L3zNhi9h+Bt+ufBo7phDPX1/b3OpogQSWugAjB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771834993; c=relaxed/simple;
	bh=EU8i9QBfwsUMNHFeFxO63qU8YXBcS3pxny0rK3Gx+hI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sKKiXtyTD3BszJPjaVg1L8lPScwsJ9Fs4h5SPFzQyaBf5VOjDGO02RliyH/CpRsw4YUS1YXmIrvtpYhkgpogTPTjn1d4JF0OaNdb15q0mbvG8Wc3FHaRVuQqiOdJkvWShHummPNruOPp4zvtNkWAzIyJAW1K3hLiuY5NVW1CzNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 0707A1A0813;
	Mon, 23 Feb 2026 08:23:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 6752E20014;
	Mon, 23 Feb 2026 08:23:01 +0000 (UTC)
Date: Mon, 23 Feb 2026 03:22:57 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Bert Karwatzki <spasswolf@web.de>
Cc: Calvin Owens <calvin@wbinvd.org>, Tejun Heo <tj@kernel.org>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner
 <tglx@linutronix.de>, dschatzberg@meta.com, peterz@infradead.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: ~90s shutdown delay with v6.19 and PREEMPT_RT
Message-ID: <20260223032257.4e6db467@fedora>
In-Reply-To: <ba582a2511d8cd4cda5a186ec48263076ac885cc.camel@web.de>
References: <aQufmyZ7X7NdfiCL@slm.duckdns.org>
	<20260219164648.3014-1-spasswolf@web.de>
	<aZd4YCNTAHZNpTfh@mozart.vkv.me>
	<594b9094ab76acf9e73cad8fca9c9efd6f75a980.camel@web.de>
	<20260219195851.7a7bd1b2@fedora>
	<1d56c93ee93334b9d320c93d255d7548f4497836.camel@web.de>
	<20260220104420.54610b04@gandalf.local.home>
	<ba582a2511d8cd4cda5a186ec48263076ac885cc.camel@web.de>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 6ko3cihughryo1ifmq6yxoxnbbbwfdpj
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 6752E20014
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+LBVeR0ORAs0qlpk21GQbSQMQtK1CFO4U=
X-HE-Tag: 1771834981-433130
X-HE-Meta: U2FsdGVkX1+y+D7edhI/4QL8pglANvRAYC9c6ueOnFOoJ082NKv18lggheSBu+8Cm1Xizxkicl6Pu9hYNMbcX97BqWECfK6PSJXM+gz5N/w1UaQmJzjXfdUrF4GRE6Au2zmszcwwrrz1X0wHlYrXmlOKbZXYjPfbAdeqzl49hUo90IgUbpM4Fra1dmxRZ3a7iH2MR6zxfnFjiIhLfCifYDyw+V8V327Amx5bL2G65gZ8zRl6ChMyWgJoOTZyowESrH9/z7Tjxp8KdyPNUZH6D4NaNGWht60pKmzhMHRYuyu3o79y/ZfED0jf9sRIXbti

On Mon, 23 Feb 2026 01:35:36 +0100
Bert Karwatzki <spasswolf@web.de> wrote:

> So the time to was is ~120s with PREEMPT_RT and 7s without.
> 
> The interesting difference between these two traces is that the second one only
> contains messages with "status" d..2. while the first also contains some with different status
> (191 of 265126). Could these be the reason for the delay.
> 
> $ grep -v d..2. trace.txt
> 
> # tracer: nop
> #
> # entries-in-buffer/entries-written: 265126/265126   #P:16
> #
> #                                _-----=> irqs-off/BH-disabled
> #                               / _----=> need-resched
> #                              | / _---=> hardirq/softirq
> #                              || / _--=> preempt-depth
> #                              ||| / _-=> migrate-disable
> #                              |||| /     delay
> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> #              | |         |   |||||     |         |
>            <...>-1584    [011] D..22    62.779670: sched_switch: prev_comm=ntpd prev_pid=0x630 (1584) prev_prio=0x78 (120) prev_state=0x100 (256)
> next_comm=mt76-tx phy0 next_pid=0x5fb (1531) next_prio=0x62 (98)

The 'D' means both interrupts 'd' and softirqs 'b' are disabled.

The last number is migrate disable which means the task is pinned to a
CPU. That may be an issue if the system is trying to take down a CPU
and there's a task pinned to it.

Now that we know that the persistent ring buffer works, we can add even
more debugging. We could see where things are stuck...

  cd /sys/kernel/tracing/instances/boot_map
  echo 'stacktrace if prev_state & 3' > events/sched/sched_switch/trigger

That will do a stacktrace at every location that schedules out in a
non-running state. That way we can see what is waiting for something to
finish.

Then in a separate boot, we may want to see where things are pinned.

  echo 'stacktrace if common_flags & 0xf00' > events/sched/sched_switch/trigger

That will do a stacktrace every time a task schedules out with
migration disabled.

-- Steve
