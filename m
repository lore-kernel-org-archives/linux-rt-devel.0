Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15472FD7C3
	for <linux-rt-devel@lists.linux.dev>; Wed, 11 Mar 2026 17:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773248539; cv=none; b=GAI3+77xo3fjI1DPoW3B39GYecYsI1ents2c8xZTi+fTPjL8Fc5ZZC3u/v/SYClKcV/BJ0nc/mA9uwvOoXkUStl/l4uztI7Px4QELhxdjOCc4HX3Q8mwWGR0vav8EoL9reA6u+kpZVug5IjGPej5MEsmxMBFCpstQExKZc0i4O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773248539; c=relaxed/simple;
	bh=LijHuE8zyYYVTYoD84HIsvuqWgN2WXbB1OQSEPRppzM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g7QF6HVFjqcvfRfp5hQ7bzSwqz8yI+5mn2wnjFMwLWLkWzWEN8y0Z8hbIYpUAOdhwbrvdBZf59MZYhqFFR4F0vJ14VXmgIX4ZDBsamTE8jfDbKod9yRKqH43B+0nBrkuDTH9KrZYqT7qtSU7GBYq8hOauDqtQonZCMqnOyFVE84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YWzFSNPX; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YWzFSNPX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=U1nVIj+03TEpzv0TZHfoP6w0b68dA1Wh6NUcNE1Xo10=;
	b=YWzFSNPXRoCW/qqEJBF074K+X3g/JFKXWZ1ZD+iJfbumjAZGkabFyV2H8H3MNp
	Y0uH0+9wTjNQdQpooHrcRUS7G6JFceEaDv+PO1uOZzKAAAIiHdl0FpCQKyqZf9Wj
	rcZ1xPbbnbAVQkySuNPtIS5/4+UwIfJQBkF6uGCjaqztQ=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgBXL+rbn7Fp6HP6SA--.14S2;
	Thu, 12 Mar 2026 01:01:18 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: bigeasy@linutronix.de
Cc: boqun@kernel.org,
	clrkwllms@kernel.org,
	jackzxcui1989@163.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	longman@redhat.com,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	will@kernel.org
Subject: Re: [PATCH] softirq: WARN_ON !preemptible() not check softirq cnt in bh disable on RT
Date: Thu, 12 Mar 2026 01:01:15 +0800
Message-Id: <20260311170115.279041-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311160910.yoU_8pQ7@linutronix.de>
References: <20260311160910.yoU_8pQ7@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgBXL+rbn7Fp6HP6SA--.14S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFy5Cr4xur43tFyfKry8Krg_yoW5CFyxpF
	Z7Ka4UKr4kXa4Ivry7Z3WxXr17Zws5XFWUGrn5C342yrs8Jrn5ur4xKF4Y9FW7uwsavw42
	vr1jv393u34DZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRFzutUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/xtbC5x7l72mxn94ryAAA3J

hi, Sebastian

On 2026-03-11 16:09 UTC, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> > Indeed, it will trigger this warning; it just reduces the probability of it being
> > reported.
> Yes

As you said, the current implementation is good enough. :)
If you think it’s appropriate to change it to (system_state != SYSTEM_BOOTING), you can make
that change later when you git rid of CONFIG_PREEMPT_RT_NEEDS_BH_LOCK. :)

> Funny story: I did a grep for the pattern you described and this s390
> driver was the only thing that popped up.

I'm actually curious why the users of _local_bh_enable, specifically those using the s390
driver, haven't raised the issue that this interface cannot be used in RT-linux. Could it be
that s390 users have never run on RT-linux?

> > Since you also mentioned that later CONFIG_PREEMPT_RT_NEEDS_BH_LOCK will no longer be
> > enabled, at that point, local_bh_disable almost loses its significance. I think it
> > should either be removed or implemented as a no-op, as it no longer achieves our
> > expected effect, and it would be better to save some instruction execution time.
> 
> We can't nop it entirely. local_bh_disable() needs remain a RCU read
> section and it needs to ensure that the context does not wonder off to
> another CPU. Also we need to count the disable/enable because once we go
> back to zero, we need to run callbacks which may have queued up.

I did overlook that local_bh_disable() is also considered an RCU critical section and is
used in conjunction with rcu_read_lock_bh(). Although I saw comments in the code like
"/* Required to meet the RCU bottomhalf requirements. */", I don't fully understand why
local_bh_disable must be treated as an RCU read critical section. Is it simply because the
implementation of rcu_read_lock_bh does not directly call __rcu_read_lock and instead relies
on local_bh_disable to proxy this call? I haven't figured this out, and it seems a bit
strange to me.

> And if we queue the softirq on per-task basis rather then per-CPU then
> we don't have the problem that one task completes softirqs queued by
> another one.

Are you suggesting that the future implementation of soft interrupts might be optimized to
use a per-task approach for queuing and processing soft interrupts? I think this is a very
good attempt, as the current handling of soft interrupts is a bit chaotic. High-priority
tasks often end up passively dealing with many low-priority soft interrupt tasks during
local_bh_disable(), effectively acting as 'ksoftirqd'. This seems unreasonable to me, as
it elevates the priority of low-priority tasks for processing.

If soft interrupt handling could be implemented in a per-task manner, it could even lead to
priority inheritance in the future, and possibly work in conjunction with BH workqueues to
thoroughly resolve the long-standing issues of soft interrupts in RT-linux. In my project,
performance problems are often related to __local_bh_disable_ip and various sporadic
latency spikes caused by migrate_disable(). This is quite frustrating.

Xin Zhao

